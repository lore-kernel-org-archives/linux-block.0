Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7500FC04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 22:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380052081F
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 22:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="U2ufrl0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380052081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbeLJWg5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:36:57 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:42889 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbeLJWg5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 17:36:57 -0500
Received: by mail-pg1-f169.google.com with SMTP id d72so5644986pga.9
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 14:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5YU5v3gYlPoUEUfRYFT7F22ASN9cGgu1p3IFSmZL7TY=;
        b=U2ufrl0VJJWm0LGhCyALWcNvJN348XawtawCAgJpw3QpeG41Q8RN4tasS+uZFUpc5a
         ejV2u/horDjtxQCnAIu2Qha80mQRkh5TDsR/bCpiiiRF0H+2/WivpftNLxuz6p5filtR
         8p47+PfnugRibo0dwRqjSscXK3AJUSjNwKU2sJdjRgfo8kJi+X/FwwaMWyEiEBopqXRv
         W5PwP5OD/QIvCPKxs9RBQo36pgpWBdOcmgdFZPDxjpv45qG9Ub7nIeeAmGYx2fG1ECf+
         wt6ElYImuZ5WdZaTp5Tk+ecwevJmrolOeVuXI7nvSPUb5yWds9xKWUHzS4SQN9TPcfMa
         OHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5YU5v3gYlPoUEUfRYFT7F22ASN9cGgu1p3IFSmZL7TY=;
        b=G0qgjOj6tvEPDq4GtRTuPFesiS60Xe2q2DA0JniBUn/7pP3YzZ9jlT0iDcMPPeTUwH
         Y56hF4e2DTspUYKLZPn2U5L13kuCcJfwy21bVT6wfxV4C0dNIFMRNf6iyKJioFZPvbps
         y4DHMJWOh+9lfCPjGdpOoacLDVZ/7bAKzwobDuf9Mhbdw7JhAT3FWhW8l7LhrSnX3TnF
         etWP4FFyP2FDYKEXfriBff42vb6zQ+mTXVtncq685PkVJyjnYvdk5919QFmp2uW4Pj9l
         EczpgMcnfbDLHPqxl4IAsauHZFLhL11eC62q01bfgyTI2PXDLT9YK2sUqc4cMAHi0Wva
         4KAQ==
X-Gm-Message-State: AA+aEWanJWXhb0Fb0acDiqvIPWhxij6INjN6UOilnCRYePyX8DjLfKQ+
        3VkADPCDOmn4eLnUvmwSN5M0SQ==
X-Google-Smtp-Source: AFSGD/XDxhWWipRDmOle1Fo3PzYw/KywCmVb7x8Jr9qoWnuzUW7vXm1NcoDRVA4h9eM6KZbG44Bu3w==
X-Received: by 2002:a65:4142:: with SMTP id x2mr12179495pgp.356.1544481416213;
        Mon, 10 Dec 2018 14:36:56 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id k26sm31004182pgf.65.2018.12.10.14.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 14:36:55 -0800 (PST)
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
Message-ID: <0742acda-f5eb-9d1a-a368-a30c43c56c13@kernel.dk>
Date:   Mon, 10 Dec 2018 15:36:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d3939eed-d2cc-d247-ffbc-117fbae74118@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/10/18 3:09 PM, Jens Axboe wrote:
> On 12/10/18 3:00 PM, Jens Axboe wrote:
>> On 12/10/18 2:53 PM, Christoph Hellwig wrote:
>>> On Mon, Dec 10, 2018 at 02:39:39PM -0700, Jens Axboe wrote:
>>>> On 12/10/18 2:37 PM, Christoph Hellwig wrote:
>>>>> This test is described as:
>>>>>
>>>>> # Test very basic thin device usage, exhaustion, and growth
>>>>
>>>> Does that tree have:
>>>>
>>>> commit c616cbee97aed4bc6178f148a7240206dcdb85a6
>>>> Author: Jens Axboe <axboe@kernel.dk>
>>>> Date:   Thu Dec 6 22:17:44 2018 -0700
>>>>
>>>>     blk-mq: punt failed direct issue to dispatch list
>>>>
>>>> ?
>>>
>>> yes.
>>>
>>> The latest commit is 6f75723190d88e1319bea623bfe0292bf3917965
>>
>> Reproduces here, guessing it's the inflight counters... Trying without.
> 
> Yep, works without the inflight changes. Deferring to Mike to sort
> this one out.

I think this should work much better...


diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 70568f8b6c53..1389a467ab63 100644
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

-- 
Jens Axboe

