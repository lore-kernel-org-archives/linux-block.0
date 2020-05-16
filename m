Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052A4C433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 20:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08662076A
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 20:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SrKbebpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgEPUYX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 16:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726422AbgEPUYW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 16:24:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD62FC061A0C
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 13:24:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q16so2415863plr.2
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 13:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DNJcJKZw6+8/Hp8QaLvXGfwEtfVV/GiRXE2ZcP1ygxw=;
        b=SrKbebpcrKbYYynjLmHA0kAVE1YZ5u+czbjz3yND31a+p5se6LRGi0tNGiuFccDiLR
         Yg5Os+GYGVGCwx41BPr4GR1rh3KfyqUBTVc9XV43RWiTsBCZ39KD0dJKcCPgTztSQFDT
         oWGycBqTkzKRDyDtc7KTzqq73y+YBjZQxeHrvKiXjghBMk/79F9HBelJrYsUaXhjCdPH
         kS1MxRcghjfmxR3moeWY1jeDb49Xjo75xZyooNZJ+2FFnlUCCHho1pz2B28NUOnRvmZr
         23svLmTumHO0/nTHC/o3JJyCCvNDUgKw/GCvRmBXG1WrWcCSX94P6BFOswvmzLFUNx7J
         NgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DNJcJKZw6+8/Hp8QaLvXGfwEtfVV/GiRXE2ZcP1ygxw=;
        b=nQBv0EvSwTBQrQ8vd4fE8KQ5oFIi+NqhlS8cOi4deM/I0/ZQN60eoB4KLrTslnI2cK
         heqH2XeOppepUh3KdNzKXzOVlmT+IJvwdRhMZXCjqDAoKqRrRUnSi/db3jYr+RxprhU+
         CPjNUlaIOt6g+GGCG2FmMvrNmgiBZ5K2v09uCVO70fmks8MjffQ7W9vUvVz39CNoDWcA
         Xq5t/xv5mcCS4seA0Rs4/uZFaVjVUuF5fsQ7Ee6GoSDXL3+ExmToAV5PJg9WGXs832qc
         hTyLm0l767Ag9Nr59vlkvUia3OJyYAWGXCe+Q4V5B8pq4WMbDoGezsrtg8AIG0oAdgaj
         b8kg==
X-Gm-Message-State: AOAM530xFpAVOa7OtPpoT3Au6QZNWDZb4Id9aEoSjuy5sI75h4dgg6qT
        8hqGotx5GauF8TUGz4/I1v9X+HxMyoA=
X-Google-Smtp-Source: ABdhPJyPpjabU9/7H5OVlM1xM+lt8w81eDEvJL925sqPhZgu2DLlJBlPM+Bvmcc4HupEFxLAJ9u6tQ==
X-Received: by 2002:a17:902:7b92:: with SMTP id w18mr8995502pll.273.1589660662050;
        Sat, 16 May 2020 13:24:22 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:41fd:9201:9a30:5f75? ([2605:e000:100e:8c61:41fd:9201:9a30:5f75])
        by smtp.gmail.com with ESMTPSA id d2sm4814488pfa.164.2020.05.16.13.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 13:24:21 -0700 (PDT)
Subject: Re: [PATCH] block: remove the REQ_NOWAIT_INLINE flag
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20200504161005.2841033-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3a85feab-1648-e552-61e2-ad706244a63d@kernel.dk>
Date:   Sat, 16 May 2020 14:24:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504161005.2841033-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/4/20 10:10 AM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied, thanks.

-- 
Jens Axboe

