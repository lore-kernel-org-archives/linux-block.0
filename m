Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20826C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 02:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CC020657
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 02:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Ji0zB20u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfAQCSt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 21:18:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34386 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfAQCSt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 21:18:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so3711584pga.1
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 18:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cEuFYPPChTg6RDaXDcAx83jvd3iDLdxLoA1x0fo7+Pk=;
        b=Ji0zB20u7flyGf1elrFvfRnGtJCncSGYE8dHDAouNE2d0opT+0CaOpCwvwPERb5WFi
         XkVr7Z6OaHJUs0lo5wv16jbMgnbFv3UKuFubdNGucAAxH/avtdTVFHKu15770YG5byux
         Jv+9kX30Ju66JRJtiSow5ks5WWxkYGxNesatyBynsC3rgMMg0kZzcDgsPHRm2Lz6JhWM
         u0SfNTnRx/U+VpKfnQt2pZPlz16B4lB1iti+KjLXFlP0NeMqQf6e1WxmohIWo1WBEg52
         pcxRXKtoEjKm7nB4mdv5UWe75qRvEo/Q8WERxSahRGzhZE1MQmKvP8nxUdf6tKujnUwq
         404g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cEuFYPPChTg6RDaXDcAx83jvd3iDLdxLoA1x0fo7+Pk=;
        b=NgCv5AjtpAG/izXJOtT9ioWeHzkxx7kQ/+PePcKDJ3CIQaGCKTrc6f7R1LfAcwOuKc
         9WxmB3yha/lLwtDbTV/Kt5uwBu5hqgxBg7bSCBXcGPpqZprbtses4rc0QsKHluICPk5X
         Y+qLf4mFTSEdbwUNCU1NhdJ9QPVXBxT6ZaQ42MpelCXossdRje9pTA2mgSBjUsWvp+Vm
         91lB4RlzCQnaVkup4r5sakhFS7V3BlkUoVICR2EM4LzIUyOQeLZmt20VEa1D0MK4YkL9
         78xjhQwAM7KHESoPplnIRjkU+YuM8tmxbOolJVMG0Lecp+A/2nC2bvLPNg7Ff3S/hdz9
         PtFw==
X-Gm-Message-State: AJcUukeN3EoZI48zF18CrqeaoZIUOzxTQqsobKz1LG0Noc5Em6x32ktG
        n9vti1WSUJLLSHiWtk6/ndONYg==
X-Google-Smtp-Source: ALg8bN7XbBZbkG8VJep0A680MrjQ+IErGNkeTtEHrEx6z6+X8tOycLxlVkXFjiPmo5kyvMeVEnPhHQ==
X-Received: by 2002:a65:50c1:: with SMTP id s1mr11476865pgp.350.1547691527748;
        Wed, 16 Jan 2019 18:18:47 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id c23sm146316pfi.83.2019.01.16.18.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 18:18:47 -0800 (PST)
Date:   Wed, 16 Jan 2019 18:18:45 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests v2 03/16] common: Move set_scheduler() function
 definition
Message-ID: <20190117021845.GC25494@vader>
References: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
 <20190110093725.32675-4-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110093725.32675-4-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 10, 2019 at 06:37:12PM +0900, Shin'ichiro Kawasaki wrote:
> set_scheduler() function defined in common/multipath-over-rdma is useful
> to set up a specific IO scheduler not only for multipath tests but also
> for zoned block device tests. Move this function to common/rc to allow
> its use in test groups other than multipath.

The preferred way to set the scheduler is:

_test_dev_queue_set scheduler "$scheduler"

This function is in the multipath tests because it was a preexisting
test suite which was merged into blktests.

> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  common/multipath-over-rdma | 24 ------------------------
>  common/rc                  | 24 ++++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
> index 308c9b5..6bea8e4 100644
> --- a/common/multipath-over-rdma
> +++ b/common/multipath-over-rdma
> @@ -275,30 +275,6 @@ mount_configfs() {
>  	fi
>  }
>  
> -# Set scheduler of block device $1 to $2.
> -set_scheduler() {
> -	local b=$1 p s=$2
> -
> -	p=/sys/class/block/$b/queue/scheduler
> -	if [ -e "/sys/block/$b/mq" ]; then
> -		case "$s" in
> -			noop)        s=none;;
> -			deadline)    s=mq-deadline;;
> -			bfq)         s=bfq;;
> -		esac
> -	else
> -		case "$s" in
> -			none)        s=noop;;
> -			mq-deadline) s=deadline;;
> -			bfq-mq)      s=bfq;;
> -		esac
> -	fi
> -	if ! echo "$s" > "$p"; then
> -		echo "Changing scheduler of $b from $(<"$p") into $s failed"
> -		return 1
> -	fi
> -}
> -
>  # Get a /dev/... path that points at dm device number $1. Set its I/O scheduler
>  # to $2 and its timeout to $3. The shell script that includes this file must
>  # define a function get_bdev_path() that translates device number $1 into a
> diff --git a/common/rc b/common/rc
> index e628f96..0b99e84 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -222,3 +222,27 @@ _test_dev_is_zoned() {
>  	fi
>  	return 0
>  }
> +
> +# Set scheduler of block device $1 to $2.
> +set_scheduler() {
> +	local b=$1 p s=$2
> +
> +	p=/sys/class/block/$b/queue/scheduler
> +	if [ -e "/sys/block/$b/mq" ]; then
> +		case "$s" in
> +			noop)        s=none;;
> +			deadline)    s=mq-deadline;;
> +			bfq)         s=bfq;;
> +		esac
> +	else
> +		case "$s" in
> +			none)        s=noop;;
> +			mq-deadline) s=deadline;;
> +			bfq-mq)      s=bfq;;
> +		esac
> +	fi
> +	if ! echo "$s" > "$p"; then
> +		echo "Changing scheduler of $b from $(<"$p") into $s failed"
> +		return 1
> +	fi
> +}
> -- 
> 2.20.1
> 
