Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4A2C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 03:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F2864E2E
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 03:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhBKDId (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 22:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhBKDI0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 22:08:26 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0460DC06174A
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 19:07:46 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b8so2487629plh.12
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 19:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3mhBJs7OoyfS2zcVrbQAP79xwHQs56wVRNi/BY1bbvY=;
        b=zWdzLtxtpSIzvCC92tWtiO8n8oojDUA7anDSZzkEE4lkpolIANyXBag5Fmb/HGhQXb
         51RfYqW84ZIIY9q5iK6XVAvOxC3KBHEhDeDRUdYytDRk1P5/NxCqs9Bu/mxKU510V1t2
         o3nhicKcHDi+EGf2cASP5264ruoQlNnSgkmCTTQtNKMNejvYZc6CnyN44tzcPoNIliI7
         XO4pOcOOsOWs57gS9dbEMbzQMb4kxrj2AUdpjOzREo65XYPi/td+jcf8M93/GGLTt5/D
         bg4+O9zgy8/rOXJ/TJvDfaNPwkvPRyzRbHG6X9pks0Tf7DMt5xddNWG7gOieZFU704MH
         WQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3mhBJs7OoyfS2zcVrbQAP79xwHQs56wVRNi/BY1bbvY=;
        b=sMyrNjyJlu66p0c6Yt8juzXG5NjOftffquxjWTdQXeR8eoF5apgJjnbnIP7y6fTgUe
         DvdZ10MoWn6IWpOqVV22+jTg/1DsfdSywoovoA75YAJy69ZITL4Tbkm1HhHZvggGi+cQ
         eURbsMg8dVhJP4bqtv0uEygrRR7Lb0t5A1L5W1ws9i1Oc+54SUlLRlMqiJWdNPXz9KWd
         cXw1AFLmkpvdm3FyhfKeSkb5ad2z/2IRrhUwNOu2uu05TPs7H6cxa5EvNDQdlYf+77mj
         1512sJcIyA5RhZkVBDGeovnBbJGHKJKPI3sRZb4SfoHIXJ98MKQIQCGqBZ+sM6NEWUPq
         hleQ==
X-Gm-Message-State: AOAM533hRktrSVZwr/SB0qdeT60BR7HqtaPw/bydUnP3Vw35MeXZMcB0
        /dR4/tcSgEdbJCJ72AnlHSrXp1haKO2LzQ==
X-Google-Smtp-Source: ABdhPJyS3EIC1/0cxujchAyzsIFrMFqk/EK4Apvf/tfm5JIYYCsOoMqnVgrUU8+L9AA6Vl2lzq8YOQ==
X-Received: by 2002:a17:90a:ca8d:: with SMTP id y13mr1992054pjt.76.1613012865254;
        Wed, 10 Feb 2021 19:07:45 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21e1::11c9? ([2620:10d:c090:400::5:9df6])
        by smtp.gmail.com with ESMTPSA id p8sm3778200pgh.0.2021.02.10.19.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 19:07:44 -0800 (PST)
Subject: Re: [PATCH] block: Replace lkml.org links with lore
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>, Justin Sanders <justin@coraid.com>,
        linux-block@vger.kernel.org
References: <20210210235159.3190756-1-keescook@chromium.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8cdd00cd-c17f-fe69-fa07-b144a64c55e5@kernel.dk>
Date:   Wed, 10 Feb 2021 20:07:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210235159.3190756-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/21 4:51 PM, Kees Cook wrote:
> As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
> links with lore"), replace lkml.org links with lore to better use a
> single source that's more likely to stay available long-term.

Applied, thanks.

-- 
Jens Axboe

