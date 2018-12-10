Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57534C04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 22:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABEF2081F
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 22:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CWdR7SRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABEF2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbeLJWkI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:40:08 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:37090 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeLJWkI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 17:40:08 -0500
Received: by mail-pl1-f179.google.com with SMTP id b5so5930610plr.4
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 14:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BRhh43J0mcM8W60Fn75DSvPbOuUGAdgs5wKvJQeQGVw=;
        b=CWdR7SRiIsImR5RwtnPDtPzI4qNIs22GpqC7rF7cv+S6wDdq+57sc6gClc10QviXVM
         vayW8t5bR31PfG9R1koR04gkshMXyqoVKlD7c1fGLkxRhAoJzAfJ+cE4/0C3PNdBsRRO
         VRa6J/UawT6N5UYhwZsAELs1nLmTEzjhu9+79eSiFiXJwktOoAZwGqt2S8cX5p6QxaT+
         ApTdA30aKxsc1dqB6hTHywIOfbpJHxEbKP0970iIQkzFHxADPHa9yDL1Ow1gv6B7UPQ0
         2JXocwmXrTenU9uwnnpesyoyAxXdrtN/XImI9MfyEF1PRRmUI6lEHZHdURQOOhPLWwcf
         9YdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BRhh43J0mcM8W60Fn75DSvPbOuUGAdgs5wKvJQeQGVw=;
        b=GEAOAcSKwXMVFtTU37ebO3MfwBh8GJDcfGgvhNcv34IGHxMkd5py7N8OIC6OTqvYx4
         /5ga6b5UF+dHW+2w7bDB3Kng0fQsatkchsjXez/piSRXLLKmoLUO0uI4F9LDphiLpPvP
         VvHe6wh+CyZl1+dVCBMVRCc5As+BPlYUkAMlqcw60lJ7geqjg1Kk8jGVszsxGIirmN8s
         JvLBtjOvnTxOO5cpo0gtHD0t3jwzmdOjRQ5FrpynDtoYTdzOhvw1quyxjo8mPImfPnDI
         Es/88h82NSkm9OncrM5HAqE6WqJncEsjISzIylije59ulNrPCz/zAGg0ExJyLa8UvxNG
         HcUg==
X-Gm-Message-State: AA+aEWbfaBCIlelAcEvs+51hCHXDSyKrb/5BFdAFUtjRdAgbp4Wt6YPb
        G0YCVS8zogUX0MzsY2x40DtRJ7AxxicHrA==
X-Google-Smtp-Source: AFSGD/UtaKTPEvJ7+g4up6ZJhGu5Y0bFQDTRMazeo3xT7g1r0RcQTvotPclWurwRSObj+1DW2yBEnQ==
X-Received: by 2002:a17:902:9305:: with SMTP id bc5mr13638929plb.86.1544481607495;
        Mon, 10 Dec 2018 14:40:07 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e16sm15188277pfn.46.2018.12.10.14.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 14:40:06 -0800 (PST)
Subject: Re: xfstests generic/347 seems unhappy on todays block for-next tree
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     snitzer@redhat.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com
References: <20181210213724.GA27905@infradead.org>
 <f7854d23-cba0-d5ce-e136-6cacd052a6da@kernel.dk>
 <20181210215356.GA20174@infradead.org>
 <695940bb-3783-c8f6-6747-dfd548df7ca7@kernel.dk>
 <d3939eed-d2cc-d247-ffbc-117fbae74118@kernel.dk>
 <0742acda-f5eb-9d1a-a368-a30c43c56c13@kernel.dk>
Message-ID: <36632a47-3bc6-2d71-d7f5-3de5ea64b151@kernel.dk>
Date:   Mon, 10 Dec 2018 15:40:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0742acda-f5eb-9d1a-a368-a30c43c56c13@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/10/18 3:36 PM, Jens Axboe wrote:
> On 12/10/18 3:09 PM, Jens Axboe wrote:
>> On 12/10/18 3:00 PM, Jens Axboe wrote:
>>> On 12/10/18 2:53 PM, Christoph Hellwig wrote:
>>>> On Mon, Dec 10, 2018 at 02:39:39PM -0700, Jens Axboe wrote:
>>>>> On 12/10/18 2:37 PM, Christoph Hellwig wrote:
>>>>>> This test is described as:
>>>>>>
>>>>>> # Test very basic thin device usage, exhaustion, and growth
>>>>>
>>>>> Does that tree have:
>>>>>
>>>>> commit c616cbee97aed4bc6178f148a7240206dcdb85a6
>>>>> Author: Jens Axboe <axboe@kernel.dk>
>>>>> Date:   Thu Dec 6 22:17:44 2018 -0700
>>>>>
>>>>>     blk-mq: punt failed direct issue to dispatch list
>>>>>
>>>>> ?
>>>>
>>>> yes.
>>>>
>>>> The latest commit is 6f75723190d88e1319bea623bfe0292bf3917965
>>>
>>> Reproduces here, guessing it's the inflight counters... Trying without.
>>
>> Yep, works without the inflight changes. Deferring to Mike to sort
>> this one out.
> 
> I think this should work much better...

We can improve upon that, we don't need to ever read the inflight
counter from IO completion. Testing this one now.


diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 70568f8b6c53..79ad4b3d215c 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -650,14 +650,14 @@ static bool md_in_flight(struct mapped_device *md)
 {
 	int cpu;
 	struct hd_struct *part = &dm_disk(md)->part0;
+	long sum = 0;
 
 	for_each_possible_cpu(cpu) {
-		if (part_stat_local_read_cpu(part, in_flight[0], cpu) ||
-		    part_stat_local_read_cpu(part, in_flight[1], cpu))
-			return true;
+		sum += part_stat_local_read_cpu(part, in_flight[0], cpu);
+		sum += part_stat_local_read_cpu(part, in_flight[1], cpu);
 	}
 
-	return false;
+	return sum != 0;
 }
 
 static void start_io_acct(struct dm_io *io)
@@ -691,10 +691,8 @@ static void end_io_acct(struct dm_io *io)
 				    true, duration, &io->stats_aux);
 
 	/* nudge anyone waiting on suspend queue */
-	if (unlikely(waitqueue_active(&md->wait))) {
-		if (!md_in_flight(md))
-			wake_up(&md->wait);
-	}
+	if (unlikely(waitqueue_active(&md->wait)))
+		wake_up(&md->wait);
 }
 
 /*

-- 
Jens Axboe

