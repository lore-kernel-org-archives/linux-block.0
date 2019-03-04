Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1EAC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 22:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9BF20830
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 22:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="xAsC0paz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfCDWy4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:54:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37056 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCDWy4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 17:54:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id s22so4078602pfh.4
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 14:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nWRRFMRxACwmyHpYNIDcTgaPUxWh4lr4c6EtNjAoTl4=;
        b=xAsC0pazlkmgk+twX8CGJ2aPABAis1DSzZAjpjWDJAV6VcbMhU1fJgTku6csSa1Y2t
         ZeKI59Y4jyyG5HyxKHM0tudpDpvZUDUIRet6JNJS74OsYIPfAtVhXruPWJ9yEpHxgVIq
         vlepXEVMDmtRStZJsa0xZobiczm54g1WKxvZwafi+u1l1VYBEm5cYl6xj2+ADC3/Uk7C
         4DI11XFViwQ8V1XSJ3HeCFs8r/PqqdKyizL+qCcd+RfBfhDM5Wj8n+UdMfR6bYwT9UBG
         TjXZ4dzen0kAyY1sge0h5Q4YfHZzF9llq/RlxLC2XxNK0xZA1GOp22oJy40nRstjufzR
         W3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nWRRFMRxACwmyHpYNIDcTgaPUxWh4lr4c6EtNjAoTl4=;
        b=XnbbtNQqYCEVWhtKg8JK0robB8xTGIqAEXfRaYe7sz6Ayr/CdEt7IfCovLB8nm5pIj
         55MoGXy+JbLVPG04ugO5A+IKnvLI0Nfwlj0Tw3/SWsukq2X/iMv7vtvZAM1YMxdO7MND
         k/1Isru4iXZou5J8meeToi/F2QVh2vZ3tdk/l3ulcLNLbVYnW5Z7zPhWgpjBGU7CBeyB
         NSifSxG1L92GqXuUsGsO73aV73jmU08PPYiy4Oy9zOMDZ0u/4dQRUZxgueCI6q9xIArn
         aqPeTmTAfng0qDP550XGUwyWbXIRaKBrb2wYb9mQm1bY00XW4/bbZRYEaNNWF5zqmSJV
         fpmQ==
X-Gm-Message-State: APjAAAX3SOCNv4cSVFF5K6l+FHWwTM2oGULC7w+4vt8dVBficc8vu5nJ
        ZXKIHNFS99D+Tb5P0Erct+isTQ==
X-Google-Smtp-Source: APXvYqwHgTxgbRXLupiTQHpDfRKh4AXl/CtkVnLrsvvMaTor4jdJig+b69XU6TQHTZMVcl1PeiN/xw==
X-Received: by 2002:a63:104e:: with SMTP id 14mr20510783pgq.185.1551740095595;
        Mon, 04 Mar 2019 14:54:55 -0800 (PST)
Received: from vader ([2620:10d:c090:200::3:9d2c])
        by smtp.gmail.com with ESMTPSA id s1sm8584963pgv.30.2019.03.04.14.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 14:54:55 -0800 (PST)
Date:   Mon, 4 Mar 2019 14:54:54 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] blktests: add userspace IO test
Message-ID: <20190304225454.GF5450@vader>
References: <20190304081501.3068-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304081501.3068-1-ming.lei@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 04, 2019 at 04:15:01PM +0800, Ming Lei wrote:
> Add one test to cover changes on block passthrough IO interface,
> such as blk_rq_map_user(), blk_rq_map_user_iov(), blk_rq_unmap_user()
> and blk_rq_map_kern().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tests/block/029     | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/029.out |   5 +++
>  2 files changed, 116 insertions(+)
>  create mode 100755 tests/block/029
>  create mode 100644 tests/block/029.out
> 
> diff --git a/tests/block/029 b/tests/block/029
> new file mode 100755
> index 000000000000..89d2de70833a
> --- /dev/null
> +++ b/tests/block/029
> @@ -0,0 +1,111 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (c) 2019 Ming Lei <ming.lei@redhat.com>
> +#
> +# Test userspace IO on NVMe loop device

Is this a regression test for one of your recent patches?

> +. tests/nvme/rc
> +
> +DESCRIPTION="test userspace IO via nvme-cli read/write interface"
> +QUICK=1
> +
> +requires() {
> +	_have_program nvme && _have_modules loop nvme-loop nvmet && \
> +		_have_configfs
> +}
> +
> +__test_user_io()
> +{
> +	DISK=$1
> +	START=$2
> +	CNT=$3
> +
> +	BS=`blockdev --getss $DISK`

$() instead of `` here and everywhere else, please. Also, $DISK needs to
quoted, as do several other variables. Please run `make check`.

> +	SIZE=$(($CNT * $BS))
> +
> +	IMG=`mktemp /tmp/blk_img_XXXXXX`
> +	IMG1=`mktemp /tmp/blk_img_XXXXXX`

Please make all of these variables local and lowercase.

> +	dd if=/dev/urandom of=$IMG bs=$BS count=$CNT status=none
> +
> +	let CNT--

$((CNT--))

> +	nvme write --start-block=$START --block-count=$CNT --data-size=$SIZE --data=$IMG $DISK
> +	[ $? -ne 0 ] && return -1
> +	nvme read --start-block=$START --block-count=$CNT --data-size=$SIZE --data=$IMG1 $DISK
> +	[ $? -ne 0 ] && return -1
> +
> +	diff -q -u $IMG $IMG1
> +	RES=$?
> +
> +	rm -f $IMG $IMG1
> +	return $RES
> +}
> +
> +test_user_io()
> +{
> +	DEV=$1
> +
> +	__test_user_io $DEV 1 512  > /dev/null 2>&1
> +	[ -$? -ne 0 ] && echo "FAIL"
> +
> +	__test_user_io $DEV 1 511  > /dev/null 2>&1
> +	[ -$? -ne 0 ] && echo "FAIL"
> +
> +	__test_user_io $DEV 1 513  > /dev/null 2>&1
> +	[ -$? -ne 0 ] && echo "FAIL"
> +
> +	__test_user_io $DEV 511 1024  > /dev/null 2>&1
> +	[ -$? -ne 0 ] && echo "FAIL"
> +
> +	__test_user_io $DEV 511 1023  > /dev/null 2>&1
> +	[ -$? -ne 0 ] && echo "FAIL"
> +
> +	__test_user_io $DEV 511 1025  > /dev/null 2>&1
> +	[ -$? -ne 0 ] && echo "FAIL"
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	modprobe nvmet
> +	modprobe nvme-loop
> +
> +	local port
> +	local nvmedev
> +	local loop_dev
> +	local file_path="$TMPDIR/img"
> +	local subsys_name="blktests-subsystem-1"
> +
> +	truncate -s 1G "${file_path}"
> +
> +	loop_dev="$(losetup -f --show "${file_path}")"
> +
> +	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
> +		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> +	port="$(_create_nvmet_port "loop")"
> +	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
> +
> +	nvme connect -t loop -n "${subsys_name}"
> +
> +	nvmedev="$(_find_nvme_loop_dev)"
> +	cat "/sys/block/${nvmedev}n1/uuid"
> +	cat "/sys/block/${nvmedev}n1/wwid"
> +
> +	test_user_io "/dev/${nvmedev}n1"
> +
> +	nvme disconnect -n "${subsys_name}"

We just changed the other nvme tests to redirect the output of
disconnect like so:

	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1

Let's do that for this one, too.

Thanks for the test!
