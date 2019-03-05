Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92155C43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 01:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6E5206B6
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 01:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfCEBxW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:53:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCEBxW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Mar 2019 20:53:22 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 493DC356C4;
        Tue,  5 Mar 2019 01:53:22 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 307E21753C;
        Tue,  5 Mar 2019 01:53:16 +0000 (UTC)
Date:   Tue, 5 Mar 2019 09:53:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] blktests: add userspace IO test
Message-ID: <20190305015310.GA9116@ming.t460p>
References: <20190304081501.3068-1-ming.lei@redhat.com>
 <20190304225454.GF5450@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304225454.GF5450@vader>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 05 Mar 2019 01:53:22 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 04, 2019 at 02:54:54PM -0800, Omar Sandoval wrote:
> On Mon, Mar 04, 2019 at 04:15:01PM +0800, Ming Lei wrote:
> > Add one test to cover changes on block passthrough IO interface,
> > such as blk_rq_map_user(), blk_rq_map_user_iov(), blk_rq_unmap_user()
> > and blk_rq_map_kern().
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  tests/block/029     | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/block/029.out |   5 +++
> >  2 files changed, 116 insertions(+)
> >  create mode 100755 tests/block/029
> >  create mode 100644 tests/block/029.out
> > 
> > diff --git a/tests/block/029 b/tests/block/029
> > new file mode 100755
> > index 000000000000..89d2de70833a
> > --- /dev/null
> > +++ b/tests/block/029
> > @@ -0,0 +1,111 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0+
> > +# Copyright (c) 2019 Ming Lei <ming.lei@redhat.com>
> > +#
> > +# Test userspace IO on NVMe loop device
> 
> Is this a regression test for one of your recent patches?

Yeah, it is for the following patch:

	https://marc.info/?l=linux-block&m=155161907811128&w=2

Also it will serve regression test for the following(not posted yet) patch
of 'enabling multi-bvec for passthrough IO'.

> 
> > +. tests/nvme/rc
> > +
> > +DESCRIPTION="test userspace IO via nvme-cli read/write interface"
> > +QUICK=1
> > +
> > +requires() {
> > +	_have_program nvme && _have_modules loop nvme-loop nvmet && \
> > +		_have_configfs
> > +}
> > +
> > +__test_user_io()
> > +{
> > +	DISK=$1
> > +	START=$2
> > +	CNT=$3
> > +
> > +	BS=`blockdev --getss $DISK`
> 
> $() instead of `` here and everywhere else, please. Also, $DISK needs to
> quoted, as do several other variables. Please run `make check`.
> 
> > +	SIZE=$(($CNT * $BS))
> > +
> > +	IMG=`mktemp /tmp/blk_img_XXXXXX`
> > +	IMG1=`mktemp /tmp/blk_img_XXXXXX`
> 
> Please make all of these variables local and lowercase.
> 
> > +	dd if=/dev/urandom of=$IMG bs=$BS count=$CNT status=none
> > +
> > +	let CNT--
> 
> $((CNT--))
> 
> > +	nvme write --start-block=$START --block-count=$CNT --data-size=$SIZE --data=$IMG $DISK
> > +	[ $? -ne 0 ] && return -1
> > +	nvme read --start-block=$START --block-count=$CNT --data-size=$SIZE --data=$IMG1 $DISK
> > +	[ $? -ne 0 ] && return -1
> > +
> > +	diff -q -u $IMG $IMG1
> > +	RES=$?
> > +
> > +	rm -f $IMG $IMG1
> > +	return $RES
> > +}
> > +
> > +test_user_io()
> > +{
> > +	DEV=$1
> > +
> > +	__test_user_io $DEV 1 512  > /dev/null 2>&1
> > +	[ -$? -ne 0 ] && echo "FAIL"
> > +
> > +	__test_user_io $DEV 1 511  > /dev/null 2>&1
> > +	[ -$? -ne 0 ] && echo "FAIL"
> > +
> > +	__test_user_io $DEV 1 513  > /dev/null 2>&1
> > +	[ -$? -ne 0 ] && echo "FAIL"
> > +
> > +	__test_user_io $DEV 511 1024  > /dev/null 2>&1
> > +	[ -$? -ne 0 ] && echo "FAIL"
> > +
> > +	__test_user_io $DEV 511 1023  > /dev/null 2>&1
> > +	[ -$? -ne 0 ] && echo "FAIL"
> > +
> > +	__test_user_io $DEV 511 1025  > /dev/null 2>&1
> > +	[ -$? -ne 0 ] && echo "FAIL"
> > +}
> > +
> > +test() {
> > +	echo "Running ${TEST_NAME}"
> > +
> > +	modprobe nvmet
> > +	modprobe nvme-loop
> > +
> > +	local port
> > +	local nvmedev
> > +	local loop_dev
> > +	local file_path="$TMPDIR/img"
> > +	local subsys_name="blktests-subsystem-1"
> > +
> > +	truncate -s 1G "${file_path}"
> > +
> > +	loop_dev="$(losetup -f --show "${file_path}")"
> > +
> > +	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
> > +		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> > +	port="$(_create_nvmet_port "loop")"
> > +	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
> > +
> > +	nvme connect -t loop -n "${subsys_name}"
> > +
> > +	nvmedev="$(_find_nvme_loop_dev)"
> > +	cat "/sys/block/${nvmedev}n1/uuid"
> > +	cat "/sys/block/${nvmedev}n1/wwid"
> > +
> > +	test_user_io "/dev/${nvmedev}n1"
> > +
> > +	nvme disconnect -n "${subsys_name}"
> 
> We just changed the other nvme tests to redirect the output of
> disconnect like so:
> 
> 	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
> 
> Let's do that for this one, too.
> 
> Thanks for the test!

All have been addressed in V2.

Thanks,
Ming
