Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA42C04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 22:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102EC2081F
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 22:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lLhMuQX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102EC2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeLJWAh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:00:37 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:42976 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLJWAh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 17:00:37 -0500
Received: by mail-pf1-f172.google.com with SMTP id 64so6042905pfr.9
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 14:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kfuD2sIHbfWKdlShx1vQBjeV+wdwElilGNAVg+XNjkM=;
        b=lLhMuQX2f+mUOTg3MorbiQfu75YuoVav5qvM38mXIbJyNVXGQXTYNe6ksJIzGmdC7v
         d2RwInd+tV6wvaT4gxl7+dt2StJzU19at/hq7xDMc4txslPpZt3lZFqCACrQgjomKO7j
         A0P7biylgPGEESAdZaSaS2azsy6LT5MSOdmLsledymTvj0dlAic0UwkclKLFj16Rc9Hv
         wofsTRxFiRirX3JDM44F6JcLjId6kMPuLgVV5aWD5IXGHt9+wUoH/NWTFyhLDKusgZyA
         TkKCzj/qdEXp7A+GCDgGjLJDV/mGJAkUg6y1FGpZc8aDIEO6fenBpWEackjyogKEJChJ
         xagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kfuD2sIHbfWKdlShx1vQBjeV+wdwElilGNAVg+XNjkM=;
        b=BWZ2ojvxyXPI01cP94h9sif8ATGlVcQ3HWyalz+1hlrOpONiJIaza0uvPrbdS5c81y
         IHsEnQZB3zCv4BToM5k6rtFOKoxaHmE5+jyLnA7nBwATb8kniEXDfru9gKC2RLxjx/J1
         OPUQcBovjB1xIFvN0Ue2CXZpefejUti9eBR/Wg9+zp2WFczWv7WAfNB7e6NH5QWIyQmU
         aTj6T0lbzKV/ewIJMmAcuiTuk6xx/Tb5TxlHxhNZ+bjXXTBUVQb1qdcY6qAJqDEBphuY
         D6cF0YsB7joTykuX7ASJwUn2a5Z5uD3W1stEhBDwHzzRXS0AKHM6srC7e1fdS3F6lObj
         NgYQ==
X-Gm-Message-State: AA+aEWbk/A+yu96kjdoswPdxUSk4WYgPA9gHBZTwN6AwIr+NnMfMTPvi
        Ij5vPkyFN317Wof68zSLGZtkDw==
X-Google-Smtp-Source: AFSGD/UqNO1t6WOZtQL4chC41IXteidQKqaVQgTSbn9iyb6ipf8KT2/dE7UWOrOrQMZG1X+OZOWgqQ==
X-Received: by 2002:a63:64c:: with SMTP id 73mr12265596pgg.373.1544479236362;
        Mon, 10 Dec 2018 14:00:36 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id l22sm22211892pfj.179.2018.12.10.14.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 14:00:35 -0800 (PST)
Subject: Re: xfstests generic/347 seems unhappy on todays block for-next tree
To:     Christoph Hellwig <hch@infradead.org>
Cc:     snitzer@redhat.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com
References: <20181210213724.GA27905@infradead.org>
 <f7854d23-cba0-d5ce-e136-6cacd052a6da@kernel.dk>
 <20181210215356.GA20174@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <695940bb-3783-c8f6-6747-dfd548df7ca7@kernel.dk>
Date:   Mon, 10 Dec 2018 15:00:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210215356.GA20174@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/10/18 2:53 PM, Christoph Hellwig wrote:
> On Mon, Dec 10, 2018 at 02:39:39PM -0700, Jens Axboe wrote:
>> On 12/10/18 2:37 PM, Christoph Hellwig wrote:
>>> This test is described as:
>>>
>>> # Test very basic thin device usage, exhaustion, and growth
>>
>> Does that tree have:
>>
>> commit c616cbee97aed4bc6178f148a7240206dcdb85a6
>> Author: Jens Axboe <axboe@kernel.dk>
>> Date:   Thu Dec 6 22:17:44 2018 -0700
>>
>>     blk-mq: punt failed direct issue to dispatch list
>>
>> ?
> 
> yes.
> 
> The latest commit is 6f75723190d88e1319bea623bfe0292bf3917965

Reproduces here, guessing it's the inflight counters... Trying without.

-- 
Jens Axboe

