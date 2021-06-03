Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3D7C47082
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 15:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B1B1613DC
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 15:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFCP4f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 11:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhFCP4d (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 11:56:33 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6D9C06174A
        for <linux-block@vger.kernel.org>; Thu,  3 Jun 2021 08:54:47 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id r4so6811436iol.6
        for <linux-block@vger.kernel.org>; Thu, 03 Jun 2021 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OQ8/izGugLT2mg1DaIwELKOTXax/WeIQBPj5/sAmtrM=;
        b=sWRObvHAN4uM8PnmujHncknfBPxl21ZOniXu3Dux67+WGcu23NMh3W6RrJOkoxB8QA
         2OU+0KkLfMZIVPk1kNPOPv7swr00MTbUX6ZKkP/YEFnc/WK+mf58qnArZuxOspM88n0y
         LpTS5ZXOO2bJ7nVweslbdch4xpF6+GL+r+TVUGMoXsRIw7N1rJM0wvnJabdSSjXtkRnc
         g4LnDYFI35vBVCcwun/cXvfB+zOKM9jMUBIZnA2+uZFzKEZzUn2jJ/EdPb4vo6PjTHw9
         N9HUkRZU6hA2vXjjzTFurjLEkd6gbsPzExUJazanOQoj3bVj3VlB/VnM3okLFx+MtMq1
         /Lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OQ8/izGugLT2mg1DaIwELKOTXax/WeIQBPj5/sAmtrM=;
        b=oW9uC9A2ApilZTxuIZFbWOonK4/rSs35cz/neJC7IfQ4483RdYARFLzYOw00L71kja
         cext0cBXXFykih83hvaRpZcNVPjag1kYObGUMk4m4mNQ7edaojihrao8UQVCaF9uCv8t
         y172NN8o165pF5bNs4yBLohtFbv+dhoctKe6fCaqnDHUwlS2CPolhzne2ZhmffPHX/z1
         ll01Mw7ubdPCmba6tdoeUFEFhCIdAbvplSxIP+O/A1K/lK54bV3dLbmEIJz+y8uuolzQ
         1qo4YbQ73eX1UXCEEt/5WRZJUhnf2HReogK1H80Q4rEZYcUZIVxvEqYEzalNGfAGY+6o
         ajWQ==
X-Gm-Message-State: AOAM533PRI4rF7eYsaepwYRG0fFGXPTjcBIs/tdFuHTYmLGI8i/ilkEG
        LFUul2w9TnhJ0AGnzH+ui5tw6w==
X-Google-Smtp-Source: ABdhPJzaVvt+H2s1I25emL3iM4LnUpQGECU4+1p6n6DiGlCBOlOcFHd7oP51g1mmEsRRfRUYZSP7rA==
X-Received: by 2002:a6b:7b0a:: with SMTP id l10mr6024iop.120.1622735686716;
        Thu, 03 Jun 2021 08:54:46 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x6sm2002769ilg.87.2021.06.03.08.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 08:54:46 -0700 (PDT)
Subject: Re: [PATCH][next] null_blk: Fix null pointer dereference on
 nullb->disk on blk_cleanup_disk call
To:     Colin King <colin.king@canonical.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210602100659.11058-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ce16729c-01c6-7ce8-6c06-c43439186683@kernel.dk>
Date:   Thu, 3 Jun 2021 09:54:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210602100659.11058-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/2/21 4:06 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The error handling on a nullb->disk allocation currently jumps to
> out_cleanup_disk that calls blk_cleanup_disk with a null pointer causing
> a null pointer dereference issue. Fix this by jumping to out_cleanup_tags
> instead.

Applied, thanks.

-- 
Jens Axboe

