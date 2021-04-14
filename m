Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41662C433B4
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 18:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5D861177
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 18:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhDNSkS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 14:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbhDNSkR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 14:40:17 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9A1C061574
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 11:39:56 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id i16-20020a9d68d00000b0290286edfdfe9eso9634296oto.3
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1+4MUlIuCDK0l2u7N45jWNza1w9n4n6zXLvgMREvQHM=;
        b=sCRAIjJhh6x66I/Gy/k9vRf076ks5R0349QTfRrBaE7V403uB022V3xztHT4T/NH7X
         7N1tB7lQbNwY51vbpGeg6M6AGfD4qhIBkoxkKqaZaZZVhDtDvgnnnZooDCvY02ApIIPd
         g+qzI0KwfYT9eQyEw13OmXUrOdm4IzSC7UpAEXr/oo54DDRlL293TbvgnFdkVJL1I/JU
         ErCI5jjAE280f/RiSvqaQVBsiNwP/4OzsNJR/3zthtsNj7WwuP1Zwl/Rlii8mpS1tHfm
         WRrB3pKAj1aW3FGL/hfZQfAMsmKYnus8ftXq/0m5EB3aujBXyYASx4TzXhjNnC/KQZDj
         iLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1+4MUlIuCDK0l2u7N45jWNza1w9n4n6zXLvgMREvQHM=;
        b=i49RATZ7A+50237ZuL6WWoWaICJzfIqahuvFHqLRLTgdfqjlzqooO0mnwskBDln/z2
         iq+1gLSClRF4sIm78zLO1LjxpSk/TnJvXlbo7iJY5pCP6wM45k8GMfoqV1cZwIem9dG/
         CRPMoLnA5LdIrdSKcZdkq4XZrHQxGdEuHMZRpLX+i+Gdh4spDuTELeryjpIi3mtBD436
         hBXIk+oWKU/H/yKIYCdps1NkqQl5ljxMq2B5jTmcoQUdNtg6MaofPzsbxauZb+D92aal
         zFD0WRa4KfPBcvRkjESiqPdK13AiqmDorNHkonysPz33CTwU4/19R79J96NnbHFFHxNU
         Qs/A==
X-Gm-Message-State: AOAM5339c6WCgQ69EK5gbnxGJFInkmrBpcjYstEB/+LN8rNbaq6hqMbD
        3PT5UxcEzUb1mo29BWG2ZZGOku+ULyClNA==
X-Google-Smtp-Source: ABdhPJwfK9Z1fpylcZ6ZYSfzRC4cy09Az+40fJBAcctBwmeTcnzDgb0GMsNscrMckRmbMhj5PBV4nA==
X-Received: by 2002:a9d:5a7:: with SMTP id 36mr14282368otd.321.1618425594744;
        Wed, 14 Apr 2021 11:39:54 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id n15sm85315oos.1.2021.04.14.11.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 11:39:54 -0700 (PDT)
Subject: Re: [PATCH] ata: Fix several kernel-doc headers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210414182814.18065-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5ef175ae-9ff4-dba3-25c7-a27bf745b5f1@kernel.dk>
Date:   Wed, 14 Apr 2021 12:39:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210414182814.18065-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/14/21 12:28 PM, Bart Van Assche wrote:
> Fix the kernel-doc warnings that are reported when building the ATA code
> with W=1. This patch only modifies source code comments.

If you check for-5.13/libata, I think you'll find most/all of these
already fixed.

-- 
Jens Axboe

