Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A058AC433E2
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 01:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56EA7212CC
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 01:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sjaMq31l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgIOBlR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 21:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIOBlP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 21:41:15 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47698C061788
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2020 18:41:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c3so485569plz.5
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2020 18:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yDZSPGcbAWhnWXgnJkMwrrVMrUS1MAAeaub02b2a/Cs=;
        b=sjaMq31lDCTtBi2xCdrCYcc5Q4TPeIEK/WcS4vMtbiPe/N3axCOA70PZ7MAgVE9Qbq
         fdo3F6Aq534fuc5UUrwkEVOhjR7omgR00Wlp/TflPUfxWdPgPz0AbFopflssDnP4d1zd
         aoyalB8rgPBy6xengBzWxkwrX6TWa72BXtcfGymG+EmDOZ/X2XorXD7Cpj48W5bIYlgS
         IimK/Ciqvvev26qW1jZj7Sq3V+i20byWZdNzmOYPA+nBg8Rn8o3t0qf36wYJAi5OUDwZ
         w/Vu7Kg5u3cRvyXYkIg9YHcr4ODj7ejSjZaXBZZXaZ1Gfd5EXKfzimBEj/6PqpVJJqtu
         hrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yDZSPGcbAWhnWXgnJkMwrrVMrUS1MAAeaub02b2a/Cs=;
        b=SV2WziM4JnalhIPs/mGUnfi/CS1bnYyp9EJatI2laWYi1HKg3K+QZxuKC7eVc3pzr8
         tOPTAsKONxOfKEtoovr1+oyd5vamh6/G+rIzz0ixT8JIL3iHJh2V7/KIN7j25qL494/e
         rdiCQzpErx+iEWC26oTJ3jF386UlwDf7jWR40mTNvQpPyPtxHcgxTgIMScmQYGl+dj+l
         iXpTqIBIwchHtpEKz/SKT14nBW/r4yz9mS/x7abXFgDg/iwxkjf+QEJqBDMEdKAdP99V
         Att7Y6Kk7xizIg9JBRMIpziylgvyZjuTV2YG1lH1Bf1SGjN2hYUnB8PL2UUErbvauaGv
         qkag==
X-Gm-Message-State: AOAM530fm2GFMpWmul+p/0ANRSGVVf1lLAncv/LwEEbfeHBlLz5p667v
        tMzvD5pesQ7hmQU0VWCNZypwoQ==
X-Google-Smtp-Source: ABdhPJyiJh8JmGd2EliIIIyVMdYRblzxZvUYZbyKH83ACOSvDCExGAClXwXoYTCyKjODsiJhGBBUsA==
X-Received: by 2002:a17:90b:a51:: with SMTP id gw17mr2029405pjb.118.1600134074807;
        Mon, 14 Sep 2020 18:41:14 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e10sm8433163pgb.45.2020.09.14.18.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 18:41:14 -0700 (PDT)
Subject: Re: [PATCH 0/1] DASD: fix discard for FBA devices
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20200914115647.94062-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8c3ae063-8e19-d2ab-f0cb-88014df65e66@kernel.dk>
Date:   Mon, 14 Sep 2020 19:41:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914115647.94062-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/14/20 5:56 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please see the following patch that fixes zero writes for DASD FBA devices under certain conditions.
> 
> Do you mind to take this for 5.9?

Applied, thanks.

-- 
Jens Axboe

