Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD08FC282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 21:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F9B218B0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 21:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="FEo6eRyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAYVLE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:11:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46712 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYVLD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 16:11:03 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so5077749ply.13
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 13:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P4nac1jmgxjmGySZcL0eD1HPLYkJxMy4kpwl6mTzHPQ=;
        b=FEo6eRyQqbSKkaI5Ku53UE6zgTPoceGeEfRses8xkkjU0ycatyp+vBVG8hds64ADZI
         TLPohgbfvR5vQrkAY8jAv2/Kb4Cw3j4cbcbpbfDeZ3puoKMCyJZ6a0ia0AMUzBtYW4aa
         Ynpkyu8trJLdc3eE44VHVWbBnJuarNyLsSO2MmmP2XPkBwC5J3ND7/8cAimGSv8pWHyO
         oSEtdXVc6EIwcAddJ2QyEF8Ri1/40hIosn52giwoeEM1i0b8g4dyyV9Kh8fClzP4s59J
         p/f+j5LA/C9FebjpJAiubk1rpFJAfPXtoHqPxXv1uMp/mFaR01DxgL+aEih+Fg/kFihh
         Ij3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P4nac1jmgxjmGySZcL0eD1HPLYkJxMy4kpwl6mTzHPQ=;
        b=k71zs2cr0fDDLcIFyVBJGot9ezsDNRTTX3VV0mJqq3syu6AhABkSAp3VVuiNtoCibk
         CdQitUNqDpnxB0w39KBE0udxGm8/ekqpbaqw/PtWfdhUTnzW68KY3bp17H5ejbX8yThH
         ZNiPuUrWE90NsVZQXKbOo4jUXZRY92NrI3q1MAKLROyCneL2YVPPm4W6Gr7Zznd66ves
         0pa/eLFA2JxYU0By2b3uQ9vAfOUWx9x/KseILJtbJy+EFcn3ptKm2QiN0ViA4q5W06/r
         of8XvZBi9PEDczvgvwk+yyyE2iqo2dANFnVA9gPIpo9tnn35WNvSSPMXDaV8v5IO3ZAg
         zDYA==
X-Gm-Message-State: AJcUukfH1C75IVti3PmGg1dgJ79ieH5aKQWD7EnRvbOxARH1Hnp2uz+4
        TWTWq/N+657RTqsMaCE19JgXYGiMrKY=
X-Google-Smtp-Source: ALg8bN7hwTs8t6Zjvk14W+m/pWc/wYL4XYkfaYCc2IeFOxy8mKuwarB6Oe6eQe6K/YeiqyVh2G1E1w==
X-Received: by 2002:a17:902:4503:: with SMTP id m3mr12798246pld.23.1548450662693;
        Fri, 25 Jan 2019 13:11:02 -0800 (PST)
Received: from vader ([2620:10d:c090:200::6:f0e2])
        by smtp.gmail.com with ESMTPSA id f67sm40451014pfc.141.2019.01.25.13.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 13:11:02 -0800 (PST)
Date:   Fri, 25 Jan 2019 13:11:01 -0800
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
Subject: Re: [PATCH blktests v3 04/13] block: Whitelist tests supporting
 zoned block devices
Message-ID: <20190125211101.GC26739@vader>
References: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
 <20190118094453.13773-5-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118094453.13773-5-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 18, 2019 at 06:44:44PM +0900, Shin'ichiro Kawasaki wrote:
> Define CAN_BE_ZONED=1 in block/005, block/006, block/010, block/011,
> block/016, block/017, block/020, block/021 and block/023 as all these
> tests should execute without any problem against null_blk with zoned
> mode enabled or zoned block devices specified in TEST_DEVS.

Several of these tests do random I/O, did I miss a change that makes fio
use zonemode=zbd or something?

> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  tests/block/005 | 1 +
>  tests/block/006 | 1 +
>  tests/block/010 | 1 +
>  tests/block/011 | 1 +
>  tests/block/016 | 1 +
>  tests/block/017 | 1 +
>  tests/block/020 | 1 +
>  tests/block/021 | 1 +
>  tests/block/023 | 1 +
>  9 files changed, 9 insertions(+)
> 
> diff --git a/tests/block/005 b/tests/block/005
> index 65eba22..8ab6791 100755
> --- a/tests/block/005
> +++ b/tests/block/005
> @@ -8,6 +8,7 @@
>  
>  DESCRIPTION="switch schedulers while doing IO"
>  TIMED=1
> +CAN_BE_ZONED=1
>  
>  requires() {
>  	_have_fio
> diff --git a/tests/block/006 b/tests/block/006
> index 630d478..0b8a3c0 100755
> --- a/tests/block/006
> +++ b/tests/block/006
> @@ -12,6 +12,7 @@
>  
>  DESCRIPTION="run null-blk in blocking mode"
>  TIMED=1
> +CAN_BE_ZONED=1
>  
>  requires() {
>  	_have_null_blk && _have_module_param null_blk blocking && _have_fio
> diff --git a/tests/block/010 b/tests/block/010
> index 76b301f..b81208e 100644
> --- a/tests/block/010
> +++ b/tests/block/010
> @@ -12,6 +12,7 @@
>  
>  DESCRIPTION="run I/O on null_blk with shared and non-shared tags"
>  TIMED=1
> +CAN_BE_ZONED=1
>  
>  requires() {
>  	_have_null_blk && _have_module_param null_blk shared_tags && _have_fio
> diff --git a/tests/block/011 b/tests/block/011
> index 8e10900..c3432a6 100755
> --- a/tests/block/011
> +++ b/tests/block/011
> @@ -8,6 +8,7 @@
>  
>  DESCRIPTION="disable PCI device while doing I/O"
>  TIMED=1
> +CAN_BE_ZONED=1
>  
>  requires() {
>  	_have_fio && _have_program setpci
> diff --git a/tests/block/016 b/tests/block/016
> index 10ec4ba..c70b7d0 100755
> --- a/tests/block/016
> +++ b/tests/block/016
> @@ -11,6 +11,7 @@
>  
>  DESCRIPTION="send a signal to a process waiting on a frozen queue"
>  QUICK=1
> +CAN_BE_ZONED=1
>  
>  requires() {
>  	_have_null_blk
> diff --git a/tests/block/017 b/tests/block/017
> index cea29be..e4a9259 100755
> --- a/tests/block/017
> +++ b/tests/block/017
> @@ -11,6 +11,7 @@
>  
>  DESCRIPTION="do I/O and check the inflight counter"
>  QUICK=1
> +CAN_BE_ZONED=1
>  
>  requires() {
>  	_have_null_blk
> diff --git a/tests/block/020 b/tests/block/020
> index a377ea2..39dde66 100755
> --- a/tests/block/020
> +++ b/tests/block/020
> @@ -11,6 +11,7 @@
>  
>  DESCRIPTION="run null-blk on different schedulers with only one hardware tag"
>  QUICK=1
> +CAN_BE_ZONED=1
>  
>  requires() {
>  	_have_null_blk && _have_fio
> diff --git a/tests/block/021 b/tests/block/021
> index 0ca5a17..a1bbf45 100755
> --- a/tests/block/021
> +++ b/tests/block/021
> @@ -11,6 +11,7 @@
>  
>  DESCRIPTION="read/write nr_requests on null-blk with different schedulers"
>  QUICK=1
> +CAN_BE_ZONED=1
>  
>  requires() {
>  	_have_null_blk
> diff --git a/tests/block/023 b/tests/block/023
> index b0739f7..0f20f4a 100755
> --- a/tests/block/023
> +++ b/tests/block/023
> @@ -10,6 +10,7 @@
>  
>  DESCRIPTION="do I/O on all null_blk queue modes"
>  QUICK=1
> +CAN_BE_ZONED=1
>  
>  requires() {
>  	_have_null_blk
> -- 
> 2.20.1
> 
