Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AE3C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 18:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378A120811
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 18:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544725268;
	bh=eXAd1d3ZsLLgFq2eRgp4oE5By5f8ggPv5Gj1jGMrQVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0ijamlTUgRu7hZIafT6AQVt0LMLtCbBzcjCSjNDCokKGWqMIGOt88Bslz+sAIdomJ
	 gxFk9MxnUCRJfKyMZdb+vq6sMnHKckC46bBjdHfsTBqxmGJoqc/B0EOu7gMyXjejJ5
	 TFJFNTyERTnQ4zWJvpia7IaJeESaznyZwPdiBBpE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378A120811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeLMSVH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:21:07 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40337 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbeLMSVH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 13:21:07 -0500
Received: by mail-yw1-f67.google.com with SMTP id r130so1200500ywg.7
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 10:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tOZ2+WjrUDsKFW7i4byblOpwvUEB2NxSmiSuxrY8N9M=;
        b=nfa4WX/0lsWh6ri9a7soNASNdcOFgGLbmUDNHv/gzZnn8Y60ak/R5bBHD1fhxnja1v
         nJMQ+xMueWOFWuo0m9FCnSvFDBECGsqrMdR0XbMQBUzzlJpPCgofxHtlSLtwX+446OEL
         gZT1hlnlL6CLDyzpNMWg2ZNbZsgN/n6k4x+iylfdgqOJhvin4+s+mJupIQo8Mrv1VYOB
         atizr0Ue1nKiEriji6hyDuLzVBMST9jZ0QUjZ05iB83KRqC5pTWa9WGivwocurbVMjZn
         K17SqWKduL8AnWTQzWhhUSfAcwyfUzsF4g82k9gPqX/ZXEgqG83jQ3p2tf968Uvzt+sC
         tS0w==
X-Gm-Message-State: AA+aEWb9zF4x0/OaxOrlajYEyiCiH0xo+Pqwgm145jeGQXtL6VlPWbAE
        G8tv7M/uV+kBnYIU5YpgtF0=
X-Google-Smtp-Source: AFSGD/VmEqQMHhVvueqaJEOX+nfugevDeSv0myHCkPQcsNNEhvU5P/cCgUzwMLvp/oTsNgZS1imhvQ==
X-Received: by 2002:a81:2e0b:: with SMTP id u11mr26831516ywu.412.1544725265073;
        Thu, 13 Dec 2018 10:21:05 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::6:d393])
        by smtp.gmail.com with ESMTPSA id r188sm719018ywb.30.2018.12.13.10.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 10:21:03 -0800 (PST)
Date:   Thu, 13 Dec 2018 13:21:01 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Omar Sandoval <osandov@fb.com>,
        kernel-team@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests 2/2] blktests: add Ming Lei's scsi-stress-remove
Message-ID: <20181213182101.GA96577@dennisz-mbp.dhcp.thefacebook.com>
References: <20181212230959.69975-1-dennis@kernel.org>
 <20181212230959.69975-3-dennis@kernel.org>
 <20181213012407.GA7881@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213012407.GA7881@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 13, 2018 at 09:24:09AM +0800, Ming Lei wrote:
> On Wed, Dec 12, 2018 at 06:09:59PM -0500, Dennis Zhou wrote:
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
> >  tests/block/022     | 96 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/block/022.out |  2 +
> >  2 files changed, 98 insertions(+)
> >  create mode 100755 tests/block/022
> >  create mode 100644 tests/block/022.out
> > 
> > diff --git a/tests/block/022 b/tests/block/022
> > new file mode 100755
> > index 0000000..45bfff7
> > --- /dev/null
> > +++ b/tests/block/022
> > @@ -0,0 +1,96 @@
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
> > +
> > +	use_mq=$(cat /sys/module/scsi_mod/parameters/use_blk_mq)
> > +	if [[ $use_mq = "Y" ]]; then
> > +		scheds=("none" "mq-deadline" "kyber")
> > +	else
> > +		scheds=("noop" "deadline" "cfq")
> > +	fi
> 
> You may use the following to figure out all supported io schedulers,
> especially we have removed all legacy io schedulers.
> 
> IOSCHEDS=`sed 's/[][]//g' $Q_PATH/scheduler`
> 
> 
> Thanks,
> Ming

Thanks Ming! I'll post a v2 update for this patch.

Thanks,
Dennis
