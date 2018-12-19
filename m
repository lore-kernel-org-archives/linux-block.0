Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7C5C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 22:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064A320869
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 22:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="nZV8aVf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeLSWtq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:49:46 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45619 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbeLSWtq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 17:49:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so10083625pgc.12
        for <linux-block@vger.kernel.org>; Wed, 19 Dec 2018 14:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HfSwz3o+tXbszukyUFeY64HXqCQIrAxrdtzkZVBurV4=;
        b=nZV8aVf0Z8jr5TtgBLvPReaQtDogT+YQlHEzpnWDxP1M63Mak3Nm5lwiIvETfDjtvT
         +q3c7XYWPJ1yGLkTHm8b6zkwW8yQfW4zxgng097Sus2oR81XrIsWlUx5/Sa6cEmXM3YD
         /sroP/qiomBGni/gWrJTiPlOPKS2kwShgFFu7iSYjYyCwnmKIAqMTKtU8j3G1sYl2p6R
         coI6WoDpdEwIoyWfwF3rVgywHP4VB8YchBcIkrkz9nLLGFRJiOYM2K7teYlNTb3L/6vs
         Wru/jnz9ecNaWPoSmw9aVSJWc7J4wK4nYjQbxnMpTMSn8C2+VVFgchDtN9U40CRpJw2J
         ImEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HfSwz3o+tXbszukyUFeY64HXqCQIrAxrdtzkZVBurV4=;
        b=JwZhTN8I87puEMwa3IlKwVgwOhi+VYWc83YbMt7YuE4Xosr4zGEhAlYgrsedfMXpaT
         1k2YQ2FQupnFVTQug+8QFQ2PnG/0c38SacmHGFEjZL+iCcnuEsI3ByG7kuQjIur8G9S2
         BSExq34e92tn9CafcMVkDpdlZk6ISVWie95ZeqoTwioEHB6Rka2IvTVlH1Ws3fyW+4bI
         gPR+QpmYv0me1FFFjJTOFQ73L9BV+N/v1xsrG3DyIzU1sn3l7SPt8Sx+JedNMttnB4fq
         UDrAjiOUmU0oOD3eDGGhA0PEcurV9kY8diQXlcdK8qXJfK7raiaY3mAzFJRx7uMZ3fm8
         T8OA==
X-Gm-Message-State: AA+aEWZAltvtvLUJ4HRUKG1WZyJZF4hn/Dvn70BGfJlm2OsExF2OM/A0
        7qKRwnJ5nmz+cq7dPVCVLcLR8w==
X-Google-Smtp-Source: AFSGD/V4b+itTwU1w4zK7t6vJc2/mQYaUrOoegUre6y4JHWqH51kJLWlp5MZeFAQZJM6KqTicyav7Q==
X-Received: by 2002:a62:31c1:: with SMTP id x184mr22846290pfx.204.1545259784548;
        Wed, 19 Dec 2018 14:49:44 -0800 (PST)
Received: from vader ([2620:10d:c090:180::1:75aa])
        by smtp.gmail.com with ESMTPSA id l22sm33586876pfj.179.2018.12.19.14.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 14:49:43 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:49:42 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        kernel-team@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests v2 2/2] blktests: add Ming Lei's
 scsi-stress-remove
Message-ID: <20181219224942.GB11852@vader>
References: <20181212230959.69975-3-dennis@kernel.org>
 <20181213182844.97512-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213182844.97512-1-dennis@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 13, 2018 at 01:28:44PM -0500, Dennis Zhou wrote:
> This test exposed a race condition with shutting down a request_queue
> and the new blkg association. The issue ended up being that while the
> request_queue will just start failing requests, blkg destruction sets
> the q->root_blkg to %NULL. This caused a NPE when trying to reference
> it. So to help prevent this from happening again, integrate Ming's test
> into blktests so that it can more easily be ran.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
> v2:
> - Change scheduler retrieving logic based on Ming's comment
> 
>  tests/block/022     | 90 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/022.out |  2 +
>  2 files changed, 92 insertions(+)
>  create mode 100755 tests/block/022
>  create mode 100644 tests/block/022.out
> 
> diff --git a/tests/block/022 b/tests/block/022
> new file mode 100755
> index 0000000..84336e0
> --- /dev/null
> +++ b/tests/block/022
> @@ -0,0 +1,90 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2018 Ming Lei
> +#
> +# Regression test for patch "blkcg: handle dying request_queue when associating
> +# a blkg"
> +#
> +# This tries to expose the race condition between blkg association and
> +# request_queue shutdown. When a request_queue is shutdown, the corresponding
> +# blkgs are destroyed. Any further associations should fail gracefully and not
> +# cause a kernel panic.
> +
> +. tests/block/rc
> +. common/scsi_debug
> +. common/cgroup
> +
> +DESCRIPTION="test graceful shutdown of scsi_debug devices with running fio jobs"
> +QUICK=1
> +
> +requires() {
> +	_have_cgroup2_controller io && _have_scsi_debug && _have_fio
> +}
> +
> +scsi_debug_stress_remove() {
> +	scsi_debug_path="/sys/bus/pseudo/drivers/scsi_debug"
> +	count=21
> +
> +	runtime=12
> +	nr_fio_jobs=8
> +	scsi_dbg_ndelay=10000
> +
> +	# set higher aio limit
> +	echo 524288 > /proc/sys/fs/aio-max-nr
> +
> +	#figure out the CAN_QUEUE
> +	can_queue=$(((count + 1) * (count / 2) / 2))
> +
> +	rmmod scsi_debug > /dev/null 2>&1
> +	modprobe scsi_debug virtual_gb=128 max_luns=$count \
> +		ndelay=$scsi_dbg_ndelay max_queue=$can_queue
> +
> +	# figure out scsi_debug disks
> +	hosts=$(ls -d /sys/bus/pseudo/drivers/scsi_debug/adapter0/host*)
> +	hostname=$(basename "$hosts")
> +	host=$(echo "$hostname" | grep -o -E '[0-9]+')
> +
> +	sdisks=$(ls -d $scsi_debug_path/adapter*/"$hostname"/target*/*/block/*)
> +	disks=""
> +	for sd in $sdisks; do
> +		disks+="/dev/"$(basename "$sd")
> +		disks+=" "
> +	done

blktests has _init_scsi_debug which does all of this for you. And,
block/001 is very similar to this test, just without the fio workload or
changing schedulers. Could you please rework this to be based on
block/001?
