Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B391C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 22:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5272086C
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 22:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545260276;
	bh=Ar9N/3E1tCiCaUMTwCxveylKapCn4hoJWyrSuuORkVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T8ZEMMDoubWnIePsjvrJDw/21HRZ87aHq3KjduPpmYwdbmWnk4MkF5fawhXjZaGCy
	 9T2bPy3lJDibhoFVUyN6lTGErH2LTPKk5k55O69jCsj6fbXGUfyN5uruhsq0oen1kL
	 0VqKlytTMPExmu8PJXxp8BgLhDt8GPtbFAM5s4w0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeLSW5z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:57:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44930 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeLSW5z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 17:57:55 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so24148779qte.11
        for <linux-block@vger.kernel.org>; Wed, 19 Dec 2018 14:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wmAGOAjw3tQlXESD0bsZG4pz+VXvejjgUDCT5iz69Pw=;
        b=VUlUxiKn3GmIu8XKRAeDIZc7xpQtDtXpX9DBf5BUgXcN2UznZHBDoU9lc5UOY2iQgs
         CAEKMSMxc2Pg87WCb/w5EWuG3fsgDKsvC84G8yQ2RTmDtxphBjUPBrfIMYtUOTpgKo/4
         3eMSqZkk+QKGs3DIO+5CNozw4gYLgdlTXX6qtRrhObslTzdznqf1F437eGIqIpW0uJpN
         aTjpod1VdDQ7zaFATZFZRtp3GSW82uhxGxFsyARv7x+9az/KNAe29HcHShoKRrp9pDDI
         SCzxYGOZhr2chwd8BbI7fyMVD890Z1ml5kj/5V44EeWxscaycBrXuKRLEnTVbwg84gLv
         5qeA==
X-Gm-Message-State: AA+aEWZDQQ6JKITQROTSjO10+8VcKSSavrJLaeupCrcDC9G8q1pnjB7d
        zYH6B1M6bWiiCvKZsiMprBs=
X-Google-Smtp-Source: AFSGD/WazdcuOQfZ1ag/bmq7wCyT40vDu6ZRRCV4WbUaIPYJFzZjqHdNjBTbihr1Imh7w6YhsfCrVA==
X-Received: by 2002:ac8:18fa:: with SMTP id o55mr24399210qtk.256.1545260274085;
        Wed, 19 Dec 2018 14:57:54 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:180::1:5938])
        by smtp.gmail.com with ESMTPSA id q42sm3954595qkh.56.2018.12.19.14.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 14:57:53 -0800 (PST)
Date:   Wed, 19 Dec 2018 16:57:49 -0600
From:   Dennis Zhou <dennis@kernel.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Omar Sandoval <osandov@fb.com>,
        Ming Lei <ming.lei@redhat.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH blktests v2 2/2] blktests: add Ming Lei's
 scsi-stress-remove
Message-ID: <20181219225749.GA33939@dennisz-mbp.dhcp.thefacebook.com>
References: <20181212230959.69975-3-dennis@kernel.org>
 <20181213182844.97512-1-dennis@kernel.org>
 <20181219224942.GB11852@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219224942.GB11852@vader>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 19, 2018 at 02:49:42PM -0800, Omar Sandoval wrote:
> On Thu, Dec 13, 2018 at 01:28:44PM -0500, Dennis Zhou wrote:
> > This test exposed a race condition with shutting down a request_queue
> > and the new blkg association. The issue ended up being that while the
> > request_queue will just start failing requests, blkg destruction sets
> > the q->root_blkg to %NULL. This caused a NPE when trying to reference
> > it. So to help prevent this from happening again, integrate Ming's test
> > into blktests so that it can more easily be ran.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > Cc: Ming Lei <ming.lei@redhat.com>
> > ---
> > v2:
> > - Change scheduler retrieving logic based on Ming's comment
> > 
> >  tests/block/022     | 90 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/block/022.out |  2 +
> >  2 files changed, 92 insertions(+)
> >  create mode 100755 tests/block/022
> >  create mode 100644 tests/block/022.out
> > 
> > diff --git a/tests/block/022 b/tests/block/022
> > new file mode 100755
> > index 0000000..84336e0
> > --- /dev/null
> > +++ b/tests/block/022
> > @@ -0,0 +1,90 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-3.0+
> > +# Copyright (C) 2018 Ming Lei
> > +#
> > +# Regression test for patch "blkcg: handle dying request_queue when associating
> > +# a blkg"
> > +#
> > +# This tries to expose the race condition between blkg association and
> > +# request_queue shutdown. When a request_queue is shutdown, the corresponding
> > +# blkgs are destroyed. Any further associations should fail gracefully and not
> > +# cause a kernel panic.
> > +
> > +. tests/block/rc
> > +. common/scsi_debug
> > +. common/cgroup
> > +
> > +DESCRIPTION="test graceful shutdown of scsi_debug devices with running fio jobs"
> > +QUICK=1
> > +
> > +requires() {
> > +	_have_cgroup2_controller io && _have_scsi_debug && _have_fio
> > +}
> > +
> > +scsi_debug_stress_remove() {
> > +	scsi_debug_path="/sys/bus/pseudo/drivers/scsi_debug"
> > +	count=21
> > +
> > +	runtime=12
> > +	nr_fio_jobs=8
> > +	scsi_dbg_ndelay=10000
> > +
> > +	# set higher aio limit
> > +	echo 524288 > /proc/sys/fs/aio-max-nr
> > +
> > +	#figure out the CAN_QUEUE
> > +	can_queue=$(((count + 1) * (count / 2) / 2))
> > +
> > +	rmmod scsi_debug > /dev/null 2>&1
> > +	modprobe scsi_debug virtual_gb=128 max_luns=$count \
> > +		ndelay=$scsi_dbg_ndelay max_queue=$can_queue
> > +
> > +	# figure out scsi_debug disks
> > +	hosts=$(ls -d /sys/bus/pseudo/drivers/scsi_debug/adapter0/host*)
> > +	hostname=$(basename "$hosts")
> > +	host=$(echo "$hostname" | grep -o -E '[0-9]+')
> > +
> > +	sdisks=$(ls -d $scsi_debug_path/adapter*/"$hostname"/target*/*/block/*)
> > +	disks=""
> > +	for sd in $sdisks; do
> > +		disks+="/dev/"$(basename "$sd")
> > +		disks+=" "
> > +	done
> 
> blktests has _init_scsi_debug which does all of this for you. And,
> block/001 is very similar to this test, just without the fio workload or
> changing schedulers. Could you please rework this to be based on
> block/001?

Yeah I can do that. Sorry for not looking at block/001 more closely.

Thanks,
Dennis
