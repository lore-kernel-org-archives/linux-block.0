Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43586C433DB
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 15:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E182423105
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 15:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgLVPnS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Dec 2020 10:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgLVPnS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Dec 2020 10:43:18 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F88C0613D3
        for <linux-block@vger.kernel.org>; Tue, 22 Dec 2020 07:42:37 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id f14so1484314pju.4
        for <linux-block@vger.kernel.org>; Tue, 22 Dec 2020 07:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c1JssyEtbLPosJPKnrIEGV8w8nXFwiGKude6k8tPHSY=;
        b=TQr3UG2UI0Hg4/Tc+joQ9An6R4OINqkVHL5LFWtSwg1cOBDhIhpHRR6dqbpLPoguJU
         RI4hzOZJ/TUNCi0RSSnRtaQ3yJNNnRK8RJ9d7OQmTLuFUtv7IArHfvkLEn7dDW257/mo
         CuEEGLIa8LMifAa3nZ5Uu24cBKLlleuKMQpz1g+B0W/iFhk2O2qSO9pnb9s0jpHrwR/4
         3uLVCuCTP3nSqv+Hf/AzyyzdzIYFO8kG8h8cp5cs9JEwiMdp2LvZmOjGD5ZIpuDtnLgH
         JP6RE875sepTqgmjm4sjH3LX8p7BhwbqPQAze0FmIlrPIWF21rgu+GG2w24B5cGiw/U9
         31HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c1JssyEtbLPosJPKnrIEGV8w8nXFwiGKude6k8tPHSY=;
        b=RZY3HYC+pf0mV8Hqxrk4bNFZZsO/0sb13ygZBMNKE6XG6NGlh0iv6wAI3bwJsSy/WZ
         glUUfgT2DQC+qwfHpKgEH9bFpHtNMuvjnggJwZqftwCPpn8rxfTY/H9ht1n4QSuo1dBQ
         9YITMHB7cbDyO82Qwlpy/zzB8pg6IpQEMmQ7v7gBZXlz8sGZ3+KlLKRIvn4GRGhVmc/m
         YOnmmZPSmdUChOAhJ967E487Bb5QkeEMOCvYS111obuoNcQE/pzd3YTE62jK/GunV3I4
         uh2FU9LfTEuwH6B55GBIVvGIaeXrKSukVADa7R9B+rxeImZcmc8oF17fkw+l0SO1pGSn
         TWUA==
X-Gm-Message-State: AOAM530C5U1o0QObTadxDMLBoPYM+z5JnySCH/TxvO5vDaR5qnzzdmj5
        2M6vKw7LJafX9FPuDKRMsv7sWUoo8mjmKA==
X-Google-Smtp-Source: ABdhPJz1Mc4fOB98bi9o1dG206CiL8KRSS5IB3Qdt3BsUImU1pLoZe27AySWl/a/zTsc+h9ySfBYow==
X-Received: by 2002:a17:90a:6f01:: with SMTP id d1mr21307665pjk.155.1608651757188;
        Tue, 22 Dec 2020 07:42:37 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b26sm21234754pgm.25.2020.12.22.07.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 07:42:36 -0800 (PST)
Subject: Re: small MAINTAINERS and copyright updates
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20201210075544.2715861-1-hch@lst.de>
 <20201222131620.GA30137@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3fb39ba0-5a79-263d-8d30-963769342da8@kernel.dk>
Date:   Tue, 22 Dec 2020 08:42:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201222131620.GA30137@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/22/20 6:16 AM, Christoph Hellwig wrote:
> Jens,
> 
> can you please still pick this up?

Yep, added for 5.11 pending.

-- 
Jens Axboe

