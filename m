Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1108C35242
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 22:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D7B20714
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 22:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Nn6Q+Q9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgBKWAG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:00:06 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40430 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgBKWAF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 17:00:05 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so90451plp.7
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2020 14:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5z04d/7QYXumo3rw61Z10oa4qSG/Keet1HCis3VcD3w=;
        b=Nn6Q+Q9B4/Gh6yJdcQvXoERyjS5R/tEYzIv4Ma7KhC3awte2DBVS3MvvNwzzyn37WI
         m0OmBc2gYWi6qo5pmvcO4vm4Aj1H3oPaIDzG6KMgnsPVapN4QKchJRX+mTJxdA9wqoES
         w6v91+2HkcqmxLHMpCc7YaBK7DiNCqdUvHrUBN/79cqA6TgkeaSEi7Pt++r7h8O/URXW
         sqIedqlVMgMBZEU2LrKVPLxJditw2DXZHN55bdFjhO+x2pKW/3HNopHUUFy+Zlm6XVrE
         lgMHpZmF/A4YjtaPDg1TNuRm4kudmxzFq0WSRmV6XFlz/PCZ66JU5bq1x7KUHGNoKqz8
         9vTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5z04d/7QYXumo3rw61Z10oa4qSG/Keet1HCis3VcD3w=;
        b=jzRwaOfMbBGe8FmCUjZF4mmM1yfUOLhxFYohQ00WzU9Z9ik0O43YFHvxF2Qun+ehGC
         Nuu+0GH7uBinutX73VGlt/nUaB5QaJgSaohEFJxbWF/FDhaueCXeC21eSvEfvTMhlM8w
         gMZqDTXMwyIPrDaS8DC2QSBFCAqlBqOWveVLz2694cvl+5UKx6dKuVOxfUOu61saypDV
         1HOiYOx6Rl7EdNDZ7nEUN2qA79YWrbayQAyPMH+TaIAeUcSd6nsM7b0dB2Ci8QRFEJxS
         tGQpzsaQ7uJncpVFskeITceqQ+mHbl4tVcaEiO1zOlO5p4obYPoZDo5Hm42SpzVBHi4p
         n10w==
X-Gm-Message-State: APjAAAVPprbwWQiwqFKXUHkeYrGvDLTrSLFYf1uUFd0/n1hspDBoi7RW
        Aq3kvQwSkuivi9dpjX/4mcXIEw==
X-Google-Smtp-Source: APXvYqw/yOxnUL1nCMjno4b8EaPU9LEX6QiqVuOEEjCYgojww1T1x7XQikzbA7Y5zj3T3S5ZKSla0w==
X-Received: by 2002:a17:90a:26e1:: with SMTP id m88mr6031311pje.101.1581458405067;
        Tue, 11 Feb 2020 14:00:05 -0800 (PST)
Received: from vader ([2620:10d:c090:200::1:80ca])
        by smtp.gmail.com with ESMTPSA id q21sm5230684pff.105.2020.02.11.14.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 14:00:04 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:00:03 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/5 blktests] nvme: allow target subsys set model
Message-ID: <20200211220003.GD100751@vader>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <20200129232921.11771-4-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129232921.11771-4-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 29, 2020 at 03:29:19PM -0800, Chaitanya Kulkarni wrote:
> This patch updates helper function create_nvmet_subsystem() to handle
> newly introduced model attribute.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  tests/nvme/rc | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index d1fa796..377c7f7 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -123,6 +123,7 @@ _create_nvmet_subsystem() {
>  	local uuid=$3
>  	local cntlid_min=$4
>  	local cntlid_max=$5
> +	local model=$6
>  	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>  
>  	mkdir -p "${cfs_path}"
> @@ -133,6 +134,9 @@ _create_nvmet_subsystem() {
>  		echo ${cntlid_min} > ${cfs_path}/attr_cntlid_min
>  		echo ${cntlid_max} > ${cfs_path}/attr_cntlid_max
>  	fi

It's not in the git diff context, but the line above is

	if [ $# -eq 5 ] && [ -f ${cfs_path}/attr_cntlid_min ]; then

So if we pass 6 arguments, the cntlid arguments are ignored? These
checks should probably be -ge

> +	if [ $# -eq 6 ] && [ -f ${cfs_path}/attr_model ]; then
> +		echo ${model} > ${cfs_path}/attr_model
> +	fi

More shellcheck warnings about unquoted variables.

>  }
>  
>  _remove_nvmet_ns() {
> -- 
> 2.22.1
> 
