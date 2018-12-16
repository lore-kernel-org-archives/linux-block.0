Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9010AC43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEDE217F9
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Y1bX361P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbeLPQn7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:43:59 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:44047 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbeLPQn7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 11:43:59 -0500
Received: by mail-pg1-f172.google.com with SMTP id t13so4930622pgr.11
        for <linux-block@vger.kernel.org>; Sun, 16 Dec 2018 08:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LIkIyeEcXQhiW0PaQuL81VwDRPUMx+it4Yi8SiyNafY=;
        b=Y1bX361PgiR3NnQh135MKgHOV0rW5bKvaaDt7qNfKVUMvSmaPKhcedzYu9SVXqYNmT
         rYpVlXef27HsbAI2oA8WRaRkGzpZRDijZ2g4N+iYmqC5eKbpzroLGl7cHPQPgrSqgheD
         8VLuxOkZUPjWPNtnuiEXM0jLX0sPT4G2o9qfeswhS6QgZCTX68x7jQqBNXsAZg8wFoGO
         B3J+faXoLaOewLNc1BQi5m3wpDGlWcIqxZVX3KhynCQGHFz7jB/mpBx1WX+ep6AvnuwO
         0Bh1s+KyeT055rlN2+HT1dxh3Oeree9U2vj4zYmflbibP+S3vCgKL/9m3D+lCqcUHFRy
         Jmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LIkIyeEcXQhiW0PaQuL81VwDRPUMx+it4Yi8SiyNafY=;
        b=c8tZZp3SVm2aFn5j5y4qYZrw9OreCwa0ZDFvHzJKaiLRSEkdttet/Ngd2udYgfeMPq
         cS/tW71tFKYz5xFJuZQ/pujJi6o7igUrEO96HNMPWtepILNmVpObyttwlxyubbv2iA2u
         pmKnSJrvErEdJiYlUzZJUkJIwkCUMiMJaZ/3XtjKpA/UxUHwE8B+rTl1n99fNTgr5K28
         H3AW+OVpmmkTEKif1rf+lY3+Yw2mQlVIDCjxMETFAaePu18QJ4wFJ5TMaTps2lLpiTNN
         067j74Kemn7Io0rdNgelVk14/VPo3wA4YYeKSNdBgfSodLQAcFlVrj/Cr4gbRFdAIpWc
         l5lQ==
X-Gm-Message-State: AA+aEWb884p5lWUn+kpgh9a7jUrqspsDlUrBPWNCIMNYm5mV10djWZrs
        IDb1jNRHzBLbwJHVU446jUyjtQ==
X-Google-Smtp-Source: AFSGD/Vk2dnzCLZ2LunDjZU9uNy7uJ4mmYaWAXe9Qupfrmdszum5Uo7UJEQDcbqFn1UZQ6cuFCYdjQ==
X-Received: by 2002:a63:5d14:: with SMTP id r20mr9410712pgb.329.1544978638189;
        Sun, 16 Dec 2018 08:43:58 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id n22sm19827479pfh.166.2018.12.16.08.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 08:43:57 -0800 (PST)
Subject: Re: [PATCHSET v8] Support for polled and buffered aio (and more)
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, jmoyer@redhat.com, clm@fb.com
References: <20181213175645.22181-1-axboe@kernel.dk>
 <20181216163405.GA13234@lst.de>
 <2c38c940-414f-519a-c938-8d94c249e477@kernel.dk>
 <20181216164221.GA13930@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <df8e29e3-cee5-de6a-0d6d-f880d9503ca5@kernel.dk>
Date:   Sun, 16 Dec 2018 09:43:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181216164221.GA13930@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/16/18 9:42 AM, Christoph Hellwig wrote:
> On Sun, Dec 16, 2018 at 09:37:25AM -0700, Jens Axboe wrote:
>> On 12/16/18 9:34 AM, Christoph Hellwig wrote:
>>> Any chance you could send the series that just optimize the existing
>>> aio code and don't need new interface as an initial prep series?
>>>
>>> Batching things up should make it a little easier to review, and with
>>> a little luck those "simple" patches might still make 4.21.  Make
>>> sure to include Al on the series, please.
>>
>> Sure, I can do that. So basically all of the optimizations, but none of
>> the features (like polling)? Would require serious refactoring though,
>> but not impossible.
>>
>> Or do you mean everything up to polled IO for old style aio, just
>> excluding the new ring interfaces?
> 
> No, just the various little optimizations and cleanups towards the
> beginning of the series.  Shouldn't really require any refactoring.

OK, that'd be trivial enough. I'll do that and send it out separately.

-- 
Jens Axboe

