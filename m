Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDF4C433E0
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 23:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA4302224D
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 23:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qRsKkp7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgHFXYp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFXYo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 19:24:44 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC030C061574
        for <linux-block@vger.kernel.org>; Thu,  6 Aug 2020 16:24:44 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d19so4225877pgl.10
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2020 16:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lK7x+vwxMeuJFEw2ruixPitn0YTbrsLBJ6zzrFpBnqk=;
        b=qRsKkp7qNam1R5lzmtSdTptoAf4IX1JfxfPmN03ggD5qvlkRWmgea59yd05XIBb8nT
         aqwODd6vNsJxMTo8Wdzh3hShdKW5xOM95u8qInN4Smr3S2BOHm1OZ2NdsKx3iHBvx5xZ
         OutjneOleDB6SQIx9XlS4Ol6C/4/tzfM/bZRKjap4Bg9f/7G8SVP1TMPr2Yn8J0Zmf+9
         Vl6mV3o7DkHEnqxl3zK5RsXKbAE/dm0geirH6MZwfheg/fUMHG3w97mBXUhWisVn4tQw
         v5rupIqu2wdc0aS6TVgyZk4M7PCMMaSxvkeM498Yzpe9zIt8VhjP/OEQkbu6CyVrH09j
         27Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lK7x+vwxMeuJFEw2ruixPitn0YTbrsLBJ6zzrFpBnqk=;
        b=Jq6JI/mAVGI+nFNFTlViQbEwSeNLd26uDAQ6jnLqTHghDcbSUkblo6RLliAkWClEFb
         XEp13fS7qlr4xtuuB5q77OpDPcuksA/85mTH9epKrA8EqfYHbZ5yhu20/186qbOhteKr
         ti0TVyPT4UBe/9cHQabTs3h3Uywjp3s9gnmb4wfesOVUhMhkB6S3aIgjoDAu/syzw5ZK
         CxYxkHeXuBnVffr+RIfbXhtp5IHnI2SHpZkWtbrn02AUOOiaWnYu9xqNVAvWrUFJZgV2
         S6PlwLxQARwm1YR3LTjdBXa3sU51cAWTvAuXzs7+ffzl8ZoE8Be5bmi23X4Tz5FtzkTa
         g73Q==
X-Gm-Message-State: AOAM531a+MkMxD+oLMMmKGPZQhVqODSaZLrTCpUB4aRwrJGuzxWXSmBn
        zEkOxj7d8PbszC8g9sYJBRDFWQ==
X-Google-Smtp-Source: ABdhPJyZF73gOuhGjuaZJ69at5KH1ohOhOCoAdVuYkRquHBcGbm23TGYZ/laNVplOIbLjLWNzttAIQ==
X-Received: by 2002:a63:df10:: with SMTP id u16mr9578007pgg.437.1596756283803;
        Thu, 06 Aug 2020 16:24:43 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f27sm9486241pfk.217.2020.08.06.16.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 16:24:43 -0700 (PDT)
Subject: Re: [PATCH] block: fix get_max_io_size()
To:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org
Cc:     Eric Deal <eric.deal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, stable@vger.kernel.org
References: <20200806215837.3968445-1-kbusch@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b9c7c3ff-a8c8-75fc-4abd-38a67dc41f35@kernel.dk>
Date:   Thu, 6 Aug 2020 17:24:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806215837.3968445-1-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/20 3:58 PM, Keith Busch wrote:
> A previous commit aligning splits to physical block sizes inadvertently
> modified one return case such that that it now returns 0 length splits
> when the number of sectors doesn't exceed the physical offset. This
> later hits a BUG in bio_split(). Restore the previous working behavior.

Yikes! I wonder how that lived so long... Applied.

-- 
Jens Axboe

