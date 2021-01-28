Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9010C433DB
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 14:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6063A64DDD
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 14:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhA1OgX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 09:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhA1OgW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 09:36:22 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7127EC061786
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 06:35:26 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id e9so3433891plh.3
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 06:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+iw74D6kwkV2/01b/gOAeHsEBAoEbZ0PHlHz6VLO6IE=;
        b=V9XDxIHAdMoU5T5MKAy4pizmltrUjWIvT2qlTEzrPOxHOgWfPSRhmY2tMcQ7tUpdtX
         yymXutlkvUKbAxH0w2JrfQr6sy3LgXuFEXxDM3gPCZgPayDMKKVlyonUOM11S+CcZ1Jh
         xACbeHRvhDHemi4qeDFmUDHNe/cbDKKirvrJqKZbH5Q1hd6FdjnkHN85/2zYjvzRRUVq
         x41HPic7uLmIHzaew0lEqoeSZiGe7CqwdW3C6lmhgruSkPrxhqqC0FvuOrpet6ESV0xT
         gURukbksXMTruI6CmD8h8IAD+gNJ6Lgm/wVkuc+jVbkNge+H5+v8p1ybxK1dQJANQRdn
         bdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+iw74D6kwkV2/01b/gOAeHsEBAoEbZ0PHlHz6VLO6IE=;
        b=ijZXH2aiHjP/No6leaUeLLiRI8CTuFUf6G0JxGSRibjzis8T/tlEcFk8d6xhYnjILz
         +2gHL8dtUq3Dtn0WqNX+JSzJvfZEfeTPLLvhsgHdCHTZMDB2yRDOqJ4Sml81RmDq/1HJ
         DFJnvOqDcXLoso//CvQ2uRqoJ5aUVj+j1POq2JPbhw0E4SX52ek0phvJexvdh2Pttpwn
         DGEk88rsr3sH/y4evyUcd7Pi1z4XdaDu/CiFa7iUqn4RT3dEFnyW7koZgpNOzWcdtQIV
         3VIA+l+I9OKX/mqPDo+Vi2VMlrRU/8/LUh8p6xrC962E6jXE2jrFOiNwDsHRHq2545Qf
         dp4w==
X-Gm-Message-State: AOAM533HlqQkrcft69r08eJ09hNDPKjRVU2T791R73HYQLzqsy83S/BY
        foVYQMuF9R7f2NvkBqvKwLnHjg==
X-Google-Smtp-Source: ABdhPJx0UHo847QBEMRkQRZakA65Owwf8bw4LgeF+4QcdcUSFYrREWCyzM2UMARkbl3yyG4l8Sf3ww==
X-Received: by 2002:a17:90a:de10:: with SMTP id m16mr11642090pjv.6.1611844525983;
        Thu, 28 Jan 2021 06:35:25 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id w14sm5353718pjl.38.2021.01.28.06.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 06:35:25 -0800 (PST)
Subject: Re: [PATCH] bcache: only check feature sets when sb->version >=
 BCACHE_SB_VERSION_CDEV_WITH_FEATURES
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        stable@vger.kernel.org,
        Bockholdt Arne <a.bockholdt@precitec-optronik.de>
References: <20210128104847.22773-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f7ca907e-abe4-d103-d818-c62dffa04987@kernel.dk>
Date:   Thu, 28 Jan 2021 07:35:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128104847.22773-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/21 3:48 AM, Coly Li wrote:
> For super block version < BCACHE_SB_VERSION_CDEV_WITH_FEATURES, it
> doesn't make sense to check the feature sets. This patch checks
> super block version in bch_has_feature_* routines, if the version
> doesn't have feature sets yet, returns 0 (false) to the caller.

Applied, thanks.

-- 
Jens Axboe

