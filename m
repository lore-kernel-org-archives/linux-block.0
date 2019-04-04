Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E1CC4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 18:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DC020820
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 18:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="bkwZgaxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfDDSC1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:02:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36458 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDDSC1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 14:02:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id z5so1746403pfn.3
        for <linux-block@vger.kernel.org>; Thu, 04 Apr 2019 11:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Di6CAON9Z7uSEbcJxQWi71TfI9P+rvaygzn75B4Mh4M=;
        b=bkwZgaxnpZ8f0XoFX3ZXSTuvQ9mhgjxaFdtQ5S4dDBTF35MOCXl7n4NW3A+OJwHMgJ
         jx0UDu8Gg2RVHWhxhaGrTZodQdGwkqEXoOTOCNOVhPvBZmt8EjslsfsKegfVy3fu5aHd
         CN1tMnv7MzzUG4d4qmr9sfUDUmZk0ptkJHleYolap41Fy9e2tJDKTXx3ip4D9Bqq7eaX
         iIakn40cs3KyZlWrZQi8PrciaW/54EukOmn7TxMtky4ItWn3hva4yxvwC0bAkmfIiC6f
         iGYxXId3ixK2OEvStyqfhoFVrwBOVcwETrK6r2qkdU8/Lms3bEUdr1JNkD+ArXz5hsKS
         +Eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Di6CAON9Z7uSEbcJxQWi71TfI9P+rvaygzn75B4Mh4M=;
        b=SApSEbU4OxpGRRrDBn+HTywgJCBfSF3j3xte+WLFcO/wvfqvC02+kwUrQtfpLdsv4B
         Euk/Wi/eqOWEP3QnWaqYRGfT734PLeL38dL4QGN7dYkelqyrG9jz0AjxnuJjZ99sFwye
         8brdIyE7nGUCwND+rncYLjKtDAUEFdx9uhC3dYpP78FuaKo3YJ7IFnji311+E0vPsnFt
         OTrnI0JkPRhm/SSpvjh40QV2TzvxScFo4RjjJLc77DcAyqVNe8FTsIKqkor7fdcJTgjh
         BJQio6+C/SUv/vGabz17jOQE/HMuIfOtn8rv9BegpIN2Dv1AHQk/dBP8E6z879GyojNb
         TuAQ==
X-Gm-Message-State: APjAAAV6w3Lh65RFYcsUC6VewbSQQRX7yyZH05jZsmTKDT8DbNRtXW4S
        UfaKHLi52WgZFLI21FdgX+JhgYVdVDI=
X-Google-Smtp-Source: APXvYqwCvmFB+xfR3Gg1ulkYt9tFXr9qntkSa8uYPmTcGkhDMhUHLb8EtE8UKx3bOHVS9kxr/6F6nw==
X-Received: by 2002:a63:5b24:: with SMTP id p36mr7489258pgb.84.1554400945926;
        Thu, 04 Apr 2019 11:02:25 -0700 (PDT)
Received: from vader ([2620:10d:c090:180::3f62])
        by smtp.gmail.com with ESMTPSA id p2sm10566887pfb.80.2019.04.04.11.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 11:02:25 -0700 (PDT)
Date:   Thu, 4 Apr 2019 11:02:24 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix fio jobs for 027 and add cgroup support
Message-ID: <20190404180224.GA25741@vader>
References: <20190329221432.38726-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329221432.38726-1-dennis@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 29, 2019 at 03:14:32PM -0700, Dennis Zhou wrote:
> Previously, the test was broken as "$fio_jobs" was considered as a
> string instead of additional parameters. This is fixed here.
> 
> Second, there was an issue with earlier kernels when request lists
> existed such that request_queues were never being cleaned up because
> non-root blkgs took a reference on the queue. However, blkgs were being
> cleaned up after the last reference to the request_queue was put back.
> This creates a blktest cgroup for the fio jobs to utilize and should be
> useful for catching this scenario in the future.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Would it be valuable to test this both in a cgroup and not in a cgroup?

>  tests/block/027 | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/block/027 b/tests/block/027
> index b480016..36e88b4 100755
> --- a/tests/block/027
> +++ b/tests/block/027
> @@ -26,6 +26,13 @@ scsi_debug_stress_remove() {
>  		return
>  	fi
>  
> +	_init_cgroup2
> +
> +	# setup cgroups
> +	echo "+io" > "/sys/fs/cgroup/cgroup.subtree_control"
> +	echo "+io" > "$CGROUP2_DIR/cgroup.subtree_control"
> +	mkdir "$CGROUP2_DIR/fast"
> +

Why is this called "fast"?

>  	# set higher aio limit
>  	echo 524288 > /proc/sys/fs/aio-max-nr
>  
> @@ -45,13 +52,13 @@ scsi_debug_stress_remove() {
>  		((cnt++))
>  	done
>  
> -	local num_jobs=4 runtime=21
> +	local num_jobs=4 runtime=12
>  	fio --rw=randread --size=128G --direct=1 --ioengine=libaio \
>  		--iodepth=2048 --numjobs=$num_jobs --bs=4k \
>  		--group_reporting=1 --group_reporting=1 --runtime=$runtime \
> -		--loops=10000 "$fio_jobs" > "$FULL" 2>&1 &
> +		--loops=10000 --cgroup=blktests/fast $fio_jobs > "$FULL" 2>&1 &
>  
> -	sleep 7
> +	sleep 6

Is there any particular reason you changed the run time and sleep time
and added the sleep at the end?

>  	local device_path
>  	for dev in "${SCSI_DEBUG_DEVICES[@]}"; do
>  		# shutdown devices in progress
> @@ -61,6 +68,10 @@ scsi_debug_stress_remove() {
>  
>  	wait
>  
> +	sleep 10
> +
> +	_exit_cgroup2
> +
>  	_exit_scsi_debug
>  }
>  
> -- 
> 2.17.1
> 
