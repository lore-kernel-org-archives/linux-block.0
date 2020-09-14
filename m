Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE04C433E2
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 21:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6BF2208DB
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 21:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="UolNJ2Qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgINVvw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 17:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgINVvt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 17:51:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC94BC06174A
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2020 14:51:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q4so622995pjh.5
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2020 14:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U4dxBL5lsmUkAnRogiSWrIkPaB8LDdppIlQGHsnDf3s=;
        b=UolNJ2QrHl5bJzfiY97waQhgIfmDggCUlurXebJZfDpv5AU1uECOQW4XpejtQi+a4c
         NR74FPUqE9dJce1uJdRvJHFCUFu6CHm/Af+pIWojCVSB2HwQghpQlXxF7Rje0s1V3h1g
         1zdXeG05lfMDZuVmrr1CYvVNbMSr5FDfeSzxSWj2Qu5bDtEbiJXpxl4pT/h7zkfG78nN
         YbgDX7ho1nr7gBUMJA3jronPFskeO1JvRZkeOQd/r7SPe1dwFNuRUZ2Ls/bcRE3nhWrA
         ezruUgESaChPH/FzgByPzkliX3RsDQ5Na2I/2Ovm9aEigLrOsOjqESrbBz/770rUqKWX
         fpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U4dxBL5lsmUkAnRogiSWrIkPaB8LDdppIlQGHsnDf3s=;
        b=d7EDfHAwrjfCH+CSzcbIApSkFmwMwiZCknQ5SUPzr9TaLVSUGZAsHp7cdzlELf4UCq
         PUjFRJJENMvMZf63rEeuicNPzPygxKMEjp321Rv2Q2abUQlIzL2rQj0Ht5wkobAHFfes
         yCTtUZMlKEySprynoxdQM+ko1H65n0j1yHMdIT7NtTM/nFmFlRus38djqSvyHaZBpsAA
         o1Uy9FZYd7IdslrS/5n9+yDUwnbMFQK55AL4JpDRPLb7mbvT2JnMYJQZfzVF/oBC6gAo
         38f5MFuRWJZz2MjYkkns7ZJW6IP3Encc8VgM3m5i1LeSzXfXU1fmNz0wV+hc07c1e9CZ
         mBeQ==
X-Gm-Message-State: AOAM531JAkBZknerc56jxouycLIvycWJaFqbmMmWK1wOLJeK2uTWORWz
        ew0/p/qx0L1v1aD1AUfN6Hz35A==
X-Google-Smtp-Source: ABdhPJyP+D4YKKuBg6KbuMnPfeL7dQy3WoAqrudqf1dGVbBlzm33dC0AmOwaIIbSl+HpX+r9+vat9Q==
X-Received: by 2002:a17:902:9f84:b029:d1:cc21:9a49 with SMTP id g4-20020a1709029f84b02900d1cc219a49mr5097477plq.9.1600120308225;
        Mon, 14 Sep 2020 14:51:48 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:1687])
        by smtp.gmail.com with ESMTPSA id z22sm11496450pjq.2.2020.09.14.14.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 14:51:47 -0700 (PDT)
Date:   Mon, 14 Sep 2020 14:51:45 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 1/7] nvme: consolidate nvme requirements based on
 transport type
Message-ID: <20200914215145.GA148663@relinquished.localdomain>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903235337.527880-2-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 03, 2020 at 04:53:31PM -0700, Sagi Grimberg wrote:
> Right now, only pci and loop have tests, hence these are
> the only ones that are allowed. The user can pass an env
> variable nvme_trtype and check for the necessary modules.
> 
> This allows prepares us to support other transport types.
> 
> Note that test 031 is designed to run only with nvme, hence
> it overrides the environment variable to nvme_trtype=pci.

Thanks, Sagi, this is a nice cleanup. Some comments below, though.

> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  tests/nvme/002 |  3 ++-
>  tests/nvme/003 |  3 ++-
>  tests/nvme/004 |  3 ++-
>  tests/nvme/005 |  6 +++---
>  tests/nvme/006 |  4 ++--
>  tests/nvme/007 |  2 +-
>  tests/nvme/008 |  4 ++--
>  tests/nvme/009 |  2 +-
>  tests/nvme/010 |  4 ++--
>  tests/nvme/011 |  4 ++--
>  tests/nvme/012 |  5 +++--
>  tests/nvme/013 |  4 ++--
>  tests/nvme/014 |  4 ++--
>  tests/nvme/015 |  3 ++-
>  tests/nvme/016 |  2 +-
>  tests/nvme/017 |  2 +-
>  tests/nvme/018 |  4 ++--
>  tests/nvme/019 |  4 ++--
>  tests/nvme/020 |  2 +-
>  tests/nvme/021 |  4 ++--
>  tests/nvme/022 |  4 ++--
>  tests/nvme/023 |  4 ++--
>  tests/nvme/024 |  4 ++--
>  tests/nvme/025 |  4 ++--
>  tests/nvme/026 |  4 ++--
>  tests/nvme/027 |  4 ++--
>  tests/nvme/028 |  4 ++--
>  tests/nvme/029 |  4 ++--
>  tests/nvme/030 |  5 ++---
>  tests/nvme/031 |  5 ++---
>  tests/nvme/032 |  4 ++++
>  tests/nvme/rc  | 19 +++++++++++++++++++
>  32 files changed, 80 insertions(+), 54 deletions(-)
> 
> diff --git a/tests/nvme/002 b/tests/nvme/002
> index 07b7fdae2d39..aaa5ec4d729a 100755
> --- a/tests/nvme/002
> +++ b/tests/nvme/002
> @@ -10,7 +10,8 @@
>  DESCRIPTION="create many subsystems and test discovery"
>  
>  requires() {
> -	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
> +	_nvme_requires
> +	_have_modules loop

Bash functions return the status of the last executed command, and the
requires function needs to return 0 on success and 1 on failure. So,
this is losing the return value of _nvme_requires. Just chain multiple
checks with && to fix this (here and the other places _nvme_requires was
added with other checks):

requires() {
	_nvme_requires && _have_modules loop
}

> diff --git a/tests/nvme/010 b/tests/nvme/010
> index 2ed0f4871a30..53b97484615f 100755
> --- a/tests/nvme/010
> +++ b/tests/nvme/010
> @@ -10,8 +10,8 @@ DESCRIPTION="run data verification fio job on NVMeOF block device-backed ns"
>  TIMED=1
>  
>  requires() {
> -	_have_program nvme && _have_fio && \
> -		_have_modules loop nvme-loop nvmet && _have_configfs
> +	_nvme_requires
> +	_have_fio _have_modules loop

Looks like these two got squashed into one command. It should be
_nvme_requires && _have_fio && _have_modules loop

>  test() {
> diff --git a/tests/nvme/032 b/tests/nvme/032
> index 0d0d53b325e6..017d4a339971 100755
> --- a/tests/nvme/032
> +++ b/tests/nvme/032
> @@ -11,11 +11,15 @@
>  
>  . tests/nvme/rc
>  
> +#restrict test to nvme-pci only
> +nvme_trtype=pci
> +
>  DESCRIPTION="test nvme pci adapter rescan/reset/remove during I/O"
>  QUICK=1
>  CAN_BE_ZONED=1
>  
>  requires() {
> +	_nvme_requires
>  	_have_fio
>  }
>  
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 6ffa971b4308..320aa4b2b475 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -6,6 +6,25 @@
>  
>  . common/rc
>  
> +nvme_trtype=${nvme_trtype:-"loop"}
> +
> +_nvme_requires() {
> +	_have_program nvme
> +	case ${nvme_trtype} in
> +	loop)
> +		_have_modules nvmet nvme-core nvme-loop
> +		_have_configfs

Same here, _have_modules nvmet nvme-core nvme-loop && _have_configfs.

> +		;;
> +	pci)
> +		_have_modules nvme nvme-core
> +		;;
> +	*)
> +		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
> +		return 1
> +	esac
> +	return 0

This return swallows the return value of the checks. You can drop it.

> +}
> +
>  group_requires() {
>  	_have_root
>  }
> -- 
> 2.25.1
> 
