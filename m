Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90AAC4363D
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 15:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9254D21D43
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 15:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="i0FGPy10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgIWPTG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgIWPTF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 11:19:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D13C0613CE
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 08:19:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g29so14603976pgl.2
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JxMbv0bKZur8W2kgZao1ChaI90AFzrPU3hLq2OR4FJs=;
        b=i0FGPy10wNZUK6rDF/WoX7aMiyYHtcPoSp15TZ1GxDBEeFBXpk1BEq5AhmMWtNe/rD
         e+IBI27sWrn3syjkZi6cmjcMvSjWVNP3ncr8RCJI0pf2YM+6UeJNfEsPnP8Q8KKmWbnK
         L1Au+EuYL/XMB/bQk272JNmmJ8irST9bSY0g9SWUzby+DnNGdSL0vnheHw0RKZoRBhe7
         ptpBhqWPYM8QgQAN3OiQ0EaYCQaFLn8ZvfqSMC56DFwiPCt3VPz4BRzQJ0jqVpEujn5F
         /pOwSvuSFnF90nh0yXOif5Hf+0UfVswgeXrhFnxJEGOicxqCvXeB1/xpQf7awQYP2Jiv
         7dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JxMbv0bKZur8W2kgZao1ChaI90AFzrPU3hLq2OR4FJs=;
        b=Hr0RaMIbs2QFay4r5tzHKhHwfmXnU8s2wcXlUTLjc9eFd6pn3lb2e3OjFZ2wVYcaqo
         kA3hj6q/64aXwNBomMneakIVIfRR3Vcs1t5Sz6/SlGjlRW2HOIM+7w9dEKhHU8c9kwwk
         RdzoyPrXKf7WXWh9Thwt3BKtHtUWXqchOrUX3r35rEZWPy+08EwSUlAAF9Pq+D/7HD2q
         qUuT9bTl5eF2pzRUC9v5/AwVXnZx9YSxIUNkQIyIGV0f0ArTrU3lqLUXdF0N+dg+3Jue
         rWGElYZALTr4WNBpTzZaQ1zX9JzDT7y+BrHMfQOSL1DphyAytC4lxtfFx8xOb16ipXFB
         lYgA==
X-Gm-Message-State: AOAM531UhrtFwALeyPlZBxHFHGJb4u0QOusyAQlDb54KwM9p/ivQ+sKK
        3HKhGE9nTEd+H6xaBLF2CjmgygAgdjw7Zg==
X-Google-Smtp-Source: ABdhPJy6F2wYauSNMevS7UB5eHpBDtBn8/bYNiKyb+RgxAP29/EHmvHXR5YxJmFnFYMhtWIhhY7Ahw==
X-Received: by 2002:a63:c1e:: with SMTP id b30mr189963pgl.345.1600874345007;
        Wed, 23 Sep 2020 08:19:05 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f3sm242236pgf.32.2020.09.23.08.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 08:19:04 -0700 (PDT)
Subject: Re: [PATCH] block: fix bmd->is_null_mapped initialization
To:     Christoph Hellwig <hch@lst.de>
Cc:     mhartmay@linux.ibm.com, linux-block@vger.kernel.org
References: <20200923150713.416286-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9fbcf981-7cbb-00d3-2534-2b9d597e22cb@kernel.dk>
Date:   Wed, 23 Sep 2020 09:19:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923150713.416286-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/23/20 9:07 AM, Christoph Hellwig wrote:
> bmd is allocated using kmalloc in bio_alloc_map_data, so make sure
> is_null_mapped is properly initialized to false for the !null_mapped
> case.

Applied, thanks.

-- 
Jens Axboe

