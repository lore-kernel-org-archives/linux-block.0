Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06599C433B4
	for <linux-block@archiver.kernel.org>; Sun, 11 Apr 2021 14:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9580610E9
	for <linux-block@archiver.kernel.org>; Sun, 11 Apr 2021 14:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhDKOkZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Apr 2021 10:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbhDKOkY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Apr 2021 10:40:24 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32064C06138B
        for <linux-block@vger.kernel.org>; Sun, 11 Apr 2021 07:40:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id h20so4994084plr.4
        for <linux-block@vger.kernel.org>; Sun, 11 Apr 2021 07:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m17AOPqVR6H1nou/0rvMoe5RDzG1G5/2y1vVSE1r4bM=;
        b=r1Pus7AU/F5XIh+fUqxWCF29vIv+Fqn3wWBcFbXcRpPzNFGxJ3kpxbHhro1PYGKTAt
         dIECFnOvty6Hor2rC+xNpxQwubjU0I4zFYH/8JTnLYnPTMzlypz/DDA2FOAYkB1WVx8+
         Ej2qddKaICB9a2NJrgZLgFMRO7JbJs5hmjKCUqhUxIiIWhK5N0LVSBivYU83O3bAaU4o
         DEbBXy4zVYP8L3L1drcgE+WQLbzkAyEwMCi1cR4SRrqUMdrI73vDZBXL0j11Ml0fmyBr
         spJEjXfPBwWAIu8mXcnICMHHkkKSJJthBOJLiWxjsI+blsIzMyehaJVk341cw9+BsXQT
         E62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m17AOPqVR6H1nou/0rvMoe5RDzG1G5/2y1vVSE1r4bM=;
        b=BdDaL79DbqjdqEI26kn9FLQ2akQp+DptdoVetK7NbXkOy5iHcCelh5tuF/B59mOXby
         7tZo7Th5+5U6wwRW4Sal0rMqC9O6Id8I8roy6VThIX9RJdsuHdGFYG4Qulo91JTdHWNE
         5l5DxoEqEA1qqc/oW3xMZ7fczGDqMC3tdGWJgYytq6psgPSye5nIzoarpDmTemWdLaF9
         beS0ncEyG70yRRTLT/hOuwukgI6gofHHa9Ez0f6uyObSztRCI1JPl6Rp/8PYmzZ7hM8v
         7AZkGyT+ldFw2HuY1e2aXrBP21moG7HRRrFeywFvnnDQRSVNNgyJBIwGXjWgA7RpvG80
         Ndnw==
X-Gm-Message-State: AOAM533vWSQWe3E7NuX1Q1Z+/CPeHfRs3zxyJ7fhaWIUGIWsa9IREL+W
        5PEcn3EJ5SGWGP3TwWCvXrDOVEgofvV15w==
X-Google-Smtp-Source: ABdhPJw/hTbZAvhUtGLcXbO1ELe7BXNqt3l8+3yY49eWVaM3f6hq59KU0HZhuyGjzvbDGqSPPDq3vQ==
X-Received: by 2002:a17:902:6544:b029:ea:f94e:9d4e with SMTP id d4-20020a1709026544b02900eaf94e9d4emr746959pln.16.1618152007255;
        Sun, 11 Apr 2021 07:40:07 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b23sm1706601pju.0.2021.04.11.07.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Apr 2021 07:40:06 -0700 (PDT)
Subject: Re: [PATCH 0/7] bcache patches for Linux 5.13 -- 1st wave
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20210411134316.80274-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6808c615-b25c-6ccc-1291-752b42917a2a@kernel.dk>
Date:   Sun, 11 Apr 2021 08:40:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210411134316.80274-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/21 7:43 AM, Coly Li wrote:
> Hi Jens,
> 
> This is the 1st wave of bcache for Linux v5.13.
> All the patches in this submission are all about code cleanup or
> minor fixes.
> 
> The 2nd wave patches are about the NVDIMM support on bcache which were
> held in previous merge window. The refined patches work as expected, and
> I am waiting Intel developers to post the update version with the fixes
> of the integration testing. Then I will post out the 2nd wave bcache
> patches for 5.13 merge window.
> 
> Thanks in advance for taking the 1st wave patches.

Applied, thanks.

-- 
Jens Axboe

