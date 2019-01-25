Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE51FC282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 21:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7506C218B0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 21:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="ypdBPBq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAYVRT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:17:19 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38275 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfAYVRS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 16:17:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so4702568pgc.5
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 13:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=usPGV8KWmjt+wueZpQFQ4Hp8jbsn1dUei+FsAPu9a58=;
        b=ypdBPBq/v1p85FVFdMpifZB/Y5b3GaH7h1hFcu9RR6SnFHgXOuNG0lKtbpF0jSg+Bu
         eUID27XkDBJ00aWozXTdWS1sKKeBPOBZTEKlgGrZl5wuOaootq99spiqvpNiet6tag/O
         AO9wzVFqq9SjLHw4mtQQEWWqSHTgwUTGYnTtkF5GtBh/YbysEc4W1R73tkx1pYNCaUGQ
         qOdpZpoCKaS6Q9WkBnj6iGgCRqU6KbM1CNHKunndZ/c/ay+dL8IO27Yq1GokEbKFiZkn
         rILTocmjzFuaVHx0lEAl+Z+cyq9re+I1wWoTG4ZxWQkZBdERgkkT9s9aqR0Q1Gr9lGNf
         sEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=usPGV8KWmjt+wueZpQFQ4Hp8jbsn1dUei+FsAPu9a58=;
        b=ExI89MAOvsGGF/jt6ad+2mVwzVP2kMH36RNUv6PqdUF8zBONwxLt/owu6aGBju9LD9
         m4O56fM5yZTI8t7vykNFip0N4vyPWqNz6fBht9mgblQBSXT0LRr8MAHTk0nWXyPwcm1u
         FpRxvLJ8/wKs4sYcxtncwLNFEruCRWUmrZl5hXLaGrrSpo1v1HqJBG4Io0EgTfpC+wbm
         nrv1MioQUgtZYAVOrDH1KfXlsVSqgic/dneGju3QG1WuCIyL4WmCQSPEMOQYIQKFpTxK
         sshwhGPRDS0VISTYdpfB+7f8H66iL1PS/NFDPV+lpDgV/cBmQy4rIOZPaoP9/i26lj8T
         /vLQ==
X-Gm-Message-State: AJcUuke+VCoFeMkiCxE/cfv/D1R6OYMnkxbiEAj0qac84pw2xHvqUD6J
        C6qjLUsldsameskqeMruBTMjag==
X-Google-Smtp-Source: ALg8bN7Dk9rw3uY8IL283bQz2u3Gi2EFnpZuGBCHtgk6q/zy91gpUdtIq47mALKDTLo8Ooa9waCQNQ==
X-Received: by 2002:a63:193:: with SMTP id 141mr11508919pgb.136.1548451037780;
        Fri, 25 Jan 2019 13:17:17 -0800 (PST)
Received: from vader ([2620:10d:c090:200::6:f0e2])
        by smtp.gmail.com with ESMTPSA id a195sm47586394pfa.7.2019.01.25.13.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 13:17:17 -0800 (PST)
Date:   Fri, 25 Jan 2019 13:17:16 -0800
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
Subject: Re: [PATCH blktests v3 06/13] common: Introduce _dd() helper function
Message-ID: <20190125211716.GE26739@vader>
References: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
 <20190118094453.13773-7-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118094453.13773-7-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 18, 2019 at 06:44:46PM +0900, Shin'ichiro Kawasaki wrote:
> To analyze dd command failures found by blktests, need to confirm dd
> command options. Introduce the helper function which executes dd and
> records dd command options in FULL file for quick analysis.
> 
> Reviewed-by: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  common/rc | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 153a323..fe0e5d8 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -214,3 +214,34 @@ _test_dev_in_hotplug_slot() {
>  _filter_xfs_io_error() {
>  	sed -e 's/^\(.*\)64\(: .*$\)/\1\2/'
>  }
> +
> +# Issue dd command with five arguments and record command line in FULL file.
> +# args: target device, r/w, start sector, sector len, block size in bytes
> +_dd() {
> +	local target_dev=${1}
> +	local rw=${2}
> +	local -i start_sector=${3}
> +	local -i start_byte=$(( start_sector * 512 ))
> +	local -i sector_count=${4}
> +	local -i bs=${5}
> +	local -i block_count=$(( sector_count * 512 / bs ))
> +
> +	local _cmd="dd bs=${bs} count=${block_count}"
> +
> +	if [[ ${rw} = "read" ]]; then
> +		_cmd="${_cmd} if=${target_dev} of=/dev/null"
> +		_cmd="${_cmd} iflag=skip_bytes skip=${start_byte}"
> +	elif [[ ${rw} = "write" ]]; then
> +		_cmd="${_cmd} if=/dev/zero of=${target_dev}"
> +		_cmd="${_cmd} oflag=seek_bytes,direct seek=${start_byte}"
> +	fi

This doesn't seem to be abstracting away anything too complicated. I'd
rather you remove the layer of indirection and open-code calls to dd.

> +	echo "${_cmd}" >> "$FULL" 2>&1
> +
> +	if ! eval "${_cmd}" >> "$FULL" 2>&1 ; then
> +		echo "dd command failed"
> +		return 1
> +	fi
> +
> +	sync
> +}
> -- 
> 2.20.1
> 
