Return-Path: <SRS0=lYHe=AP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47EBC433DF
	for <linux-block@archiver.kernel.org>; Sat,  4 Jul 2020 14:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 867CC207CD
	for <linux-block@archiver.kernel.org>; Sat,  4 Jul 2020 14:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="o1r5vWX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgGDOZf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Jul 2020 10:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGDOZf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Jul 2020 10:25:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42475C061794
        for <linux-block@vger.kernel.org>; Sat,  4 Jul 2020 07:25:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x3so9566087pfo.9
        for <linux-block@vger.kernel.org>; Sat, 04 Jul 2020 07:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bonV9lqc6J6a0nZgeeGxa+83b8+hl9OcR8Wa/VCq8tM=;
        b=o1r5vWX9MAJGE/id2/vJlnRwnCFtxRrkLYOrq0tx6uIIWtGxi5Ugv8n1MbX6+ImK3y
         gdGVHigbHVYQxrp2Y0ASha7fy6XkFHnbrS8J/ZxU/aJJuhhqV+EM4OwtPFLtKYU6BpqH
         +7atSTW71DI7qksOe2ebTWysLtimQ59OjK+olU+EMQzscKvQ9v8DpJZbfDWtx3ox2AVK
         VCTEnEj7hg46BkYmdrp/ec17FuKD8648KW/l+vkvu1zpoG9V2WBG572mIHYBUfdZIanA
         K+eVCkMEUtRenDmaCY7z4vi8yUFWZLscCjHBJl8Vydkoa3cV/HKQE0WhKJ2C6jSSu6Y3
         EB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bonV9lqc6J6a0nZgeeGxa+83b8+hl9OcR8Wa/VCq8tM=;
        b=ZhO4Ge9koDATGaB2GR/2c0Bj67vN9mno/AcPDuYmF87W4Ao3+cSoXSJlBeBR/XkFWM
         ynxQK9QlDr227n/cHHFH/80H0KBUyzTH4GntRacUTLApC8fPnV1D57gFboAJHMXrRPhg
         ukMib4sZ0iXl8db0kneuMaSKQg4hWkgUHgZuQBFhJk1DlgHeLnI3XZpyaDvz4w1glHT4
         wbgu5XoWlqkto8F52XXo4TS0m2s/U/q1POOg18GjS5Ys2T+YeaYlMnMM4vTlGZmZY4AV
         0OyTy8btAQsbXjKVOOG06FSahFcKeYq0PaHA86LZF/fVpMwhO9q8YbcfsJuZ2Anqx0am
         zsrA==
X-Gm-Message-State: AOAM5325iJgeUIvgWkugGwgTUnKJsy/Y9LFQl4aHd6gTJT04VjPzlUyZ
        R0CVnPFoxX4OxUtYw3DTfvTN4g==
X-Google-Smtp-Source: ABdhPJzq+GqQI/UMescL2+euv57g+aZqpEwQcobWy287BAZOLuEHI/kkKzIiUbLK3nIKKkM1cb4MZQ==
X-Received: by 2002:a63:1119:: with SMTP id g25mr32374289pgl.126.1593872734572;
        Sat, 04 Jul 2020 07:25:34 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id io3sm7942177pjb.22.2020.07.04.07.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2020 07:25:33 -0700 (PDT)
Subject: Re: regression with commit "null_blk: add helper for deleting the
 nullb_list"
To:     Yi Zhang <yi.zhang@redhat.com>, chaitanya.kulkarni@wdc.com
Cc:     CKI Project <cki-project@redhat.com>, linux-block@vger.kernel.org,
        Rachel Sibley <rasibley@redhat.com>
References: <cki.3B19A2362B.9VSYF9B2I1@redhat.com>
 <44170938.33551884.1593862676831.JavaMail.zimbra@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1b60cae2-c135-5aa1-1127-2ef89c320f43@kernel.dk>
Date:   Sat, 4 Jul 2020 08:25:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <44170938.33551884.1593862676831.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/4/20 5:37 AM, Yi Zhang wrote:
> Hello
> 
> commit[1] on linux-block/for-next introduced one regression which lead kernel panic, could you help check it?
> 
> [1]
> commit a65dee60e5384a648bc49c4ffbd3960d3fa354b0 (origin/for-5.9/drivers)
> Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Date:   Thu Jul 2 18:31:30 2020 -0700
> 
>     null_blk: add helper for deleting the nullb_list

Chaitanya, did you even test your patch?

+ nullb = list_first_entry(nullb_list.next, struct nullb, list);

I'm guessing no... Dropped it.

-- 
Jens Axboe

