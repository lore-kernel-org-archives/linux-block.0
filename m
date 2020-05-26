Return-Path: <SRS0=PnPs=7I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A56C433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 23:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA110206F1
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 23:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JauNAD2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgEZX1h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 May 2020 19:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgEZX1c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 May 2020 19:27:32 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D22C03E96E
        for <linux-block@vger.kernel.org>; Tue, 26 May 2020 16:27:31 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q16so9352508plr.2
        for <linux-block@vger.kernel.org>; Tue, 26 May 2020 16:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BDU5QxHKfnniQjXMdNd8leB2OBRpea7hzh8IAFTe8mU=;
        b=JauNAD2t8UpfMd0AfJM6AP+1DoGowd7xydgMPaSmjV+fLvAy9vodadIFD7PfYMESGS
         43shPgE6gcLYWiC+Yqur4CdnHGtq9zSnYu6Uc5C9S1C0+feG2ccRpr7QXTaprCPMF/ku
         wqXWHDvfsGYQ/8qD/83YfNFBXkRosntbpscIyJg6upEH0L3wk/kbN3H/orwZeRHXr7eQ
         sLaB/gZUuhH1qd14FW9p8u2MjP3d8f++qtdHhK5lecoNGcHCtL3u+mFN4U4mh4c1t+JN
         H8jFLSnK8QGB3kE6GeerKBoSP4cHbf/0wlbrPqkRmt7E9gb/Ejrr3uUN11gLzQqcLPUd
         lrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BDU5QxHKfnniQjXMdNd8leB2OBRpea7hzh8IAFTe8mU=;
        b=YiS+gtji6NLNxToEXBbdQQ5flSZ1MyP8+bMuCDx/FR0d2eNH8jtviTI77s08UwQTQE
         v9ivdHzLb9gE28EDB6zL5a1rtXmAlC0YrMQbmnPS1Zd/vyarYtfqAJpvC8h9cxaIZFv6
         JA2rXfMQZjVkKOh331tP5H8nRGvtUCkk1By/R6viHsqDasISMerCGfdGZa6+7gos6+kb
         Pl+zCSlAO/uTHgyV7iUu7N4zFrEWe9tUd8a3P5jjgOAQ39fMCxiG9uL92ReIo3Z0r1DA
         Nj0xMC65DcsIzDslkYgMR4JBWCnHxCthBYJ+Hqoqes3bNhWHrtFA3Q0zVatUAP7SfahX
         rAUA==
X-Gm-Message-State: AOAM532CaRkgzUb6JhhnhvONkvDCOmK7SkKzhVSDOgElKlnjENEibeX0
        bIb9O8W8BTW+EGQbd8l1RLCdIw==
X-Google-Smtp-Source: ABdhPJzh/Y4lO8y3LbQ4vMbMOwF9wg80Ql+Tf/HfqKoSCDQt7lQYN6Fx9BcM4qcFibWghFVP7jsykg==
X-Received: by 2002:a17:90a:2e08:: with SMTP id q8mr1736397pjd.153.1590535650405;
        Tue, 26 May 2020 16:27:30 -0700 (PDT)
Received: from google.com (240.242.82.34.bc.googleusercontent.com. [34.82.242.240])
        by smtp.gmail.com with ESMTPSA id h7sm586267pgg.17.2020.05.26.16.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 16:27:29 -0700 (PDT)
Date:   Tue, 26 May 2020 23:27:25 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] block: blk-crypto-fallback: remove redundant
 initialization of variable err'
Message-ID: <20200526232725.GA41114@google.com>
References: <20200526224902.63975-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526224902.63975-1-colin.king@canonical.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 26, 2020 at 11:49:02PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable err is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  block/blk-crypto-fallback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
> index 74ab137ae3ba..6e49688a2d80 100644
> --- a/block/blk-crypto-fallback.c
> +++ b/block/blk-crypto-fallback.c
> @@ -529,7 +529,7 @@ static bool blk_crypto_fallback_inited;
>  static int blk_crypto_fallback_init(void)
>  {
>  	int i;
> -	int err = -ENOMEM;
> +	int err;
>  
>  	if (blk_crypto_fallback_inited)
>  		return 0;
> -- 
Looks good to me - you can add:

Reviewed-by: Satya Tangirala <satyat@google.com>

Thanks!
> 2.25.1
> 
