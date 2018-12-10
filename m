Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C06BC04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 21:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2738F2084E
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 21:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="afEbStCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2738F2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbeLJVjm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:39:42 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:43403 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeLJVjm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 16:39:42 -0500
Received: by mail-pg1-f170.google.com with SMTP id v28so5576450pgk.10
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 13:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FgkGwlE8GXgsgQMrlUpryBGy8HysYWOMQCQIgwuIjf8=;
        b=afEbStCm+Urz60nMJWWkjV95tf99/GsLSZwPRgQKMzZhOQcZab+6pxGWR2qGzc0Svv
         S2U002kpgbpmad8GXgOdqCMF2N+znR1TOULuq3FoqFFq3yNysd7C/ngnltEZB/2XWWKZ
         LZALZXYOm1+BS4+nYThfJxQa5dHqHqgsUYj8359mk9HflsQbcHKamrGi2KfbRoW19pz1
         S3Qq5b3CjSe7HfFHqRPU+j/KwjGXCXXvmDYToGdj5aQIuDokQvvrf290IvR8HbsA7cqK
         q17gYnYLjtnQ+JF2lLRqrzQV17FNvmp315m1uKr6Ciwy7hTUbIn/Cd6o8haO/WCr7Uk5
         SIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FgkGwlE8GXgsgQMrlUpryBGy8HysYWOMQCQIgwuIjf8=;
        b=euaLtGt5nTBEDeiUSZ7Hh4EsAQqWLVVa+btOuzzkjD9Jv1B5FAJ9pJ0REWWFB2aHJl
         G/WVGa15qGT7KkcuszgJvNMcXUuTW3FM3Qa2HVPLKTdKg1zjQDwfBkLsXJIJwUELsM6c
         nQi1s3WKMS3zfAvOfi7TnfY49DcrOixXu/BnszIcGgyVqhqiSqQVbo81v+dYf0DYVC7c
         nACxsYDpu1KjH+Jpg0fIEU2cuZNfyV/86qYxubrs7ZxcsUnfbb5x/xuPllbjE9Tm+9QV
         jcY4Ok4kdRJQ9rL+p8hJiFH7c7YDD2B1vEQ5P11RPhyRwNZHL6lLCUg4CbMk7F0Jckb4
         CVMg==
X-Gm-Message-State: AA+aEWbuXwiY8/AskLaEayd3tYbJellC7lWEldYvcBRd5bCiJU1LfqUf
        sb36WQfwJtqq9RuFB4uMNE1KDA==
X-Google-Smtp-Source: AFSGD/Wd/pAExgUiAFwxGbfC08dS2h2B64qCFSh0DIp1l0fRTFvetvPCbsf+lRkvPsEa25yz3fzFBg==
X-Received: by 2002:a63:504d:: with SMTP id q13mr12499439pgl.319.1544477981637;
        Mon, 10 Dec 2018 13:39:41 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id x7sm14391033pga.68.2018.12.10.13.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 13:39:40 -0800 (PST)
Subject: Re: xfstests generic/347 seems unhappy on todays block for-next tree
To:     Christoph Hellwig <hch@infradead.org>, snitzer@redhat.com
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
References: <20181210213724.GA27905@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f7854d23-cba0-d5ce-e136-6cacd052a6da@kernel.dk>
Date:   Mon, 10 Dec 2018 14:39:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210213724.GA27905@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/10/18 2:37 PM, Christoph Hellwig wrote:
> This test is described as:
> 
> # Test very basic thin device usage, exhaustion, and growth

Does that tree have:

commit c616cbee97aed4bc6178f148a7240206dcdb85a6
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Dec 6 22:17:44 2018 -0700

    blk-mq: punt failed direct issue to dispatch list

?

-- 
Jens Axboe

