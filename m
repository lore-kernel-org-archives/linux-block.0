Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79202C4332F
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B9EE60231
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhJLSjE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:39:04 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:46719 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbhJLSjD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:39:03 -0400
Received: by mail-il1-f177.google.com with SMTP id w10so38550ilc.13
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dJK3by92bvpJ1AX4uD0MPaBxpOJed2insfOVD1h06tg=;
        b=0aHz06LEMixm14fucU6J1hGqq8Vo+j0QPfnUHiIREleOCGSYflCwM2p6SONErNIkGv
         rPFWPyPWdUtkkz9LphM8rEq1aYXxUCo06g+cARMEMIrfMEe9AT6afmjKHSPNpZhIS5EK
         rFz4YSjQi1lImVapNj/fHCyks6Fga0FIO3VSXxSn/OzAWuNH9puErT0wcZXugqxJljP1
         Ouv9O0nDYIkJaLjLLJcwvyIM1bP2FWqfgqfLH1g4EzqgBb7kTk0OqXbb9lD5iY1liSZV
         oWZb++/1pRTmfB47AHIz++ro9WTexHmwZ1sDA6pxPyizI7ZAZbfAfxToAW1WhenaheY3
         NMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dJK3by92bvpJ1AX4uD0MPaBxpOJed2insfOVD1h06tg=;
        b=cAVX8Zg/XhsvDUevezaeKsle/5VwfrkxPCbOQJL05GvTNf1WI41wajpxh59gx+5PpB
         ehwx68YB3EiO6QTxRIcJSQIABqspyEfJWbMZ5/WJOoJKrDT5x/N3XiG5T8DjHpEScGDB
         rKg7ECg8SZkROJ7yaqC+aiOaLrDF5CjtvMrcWOwc/C1x7VvIEmp+6jWm3sv/i0CGGCQ9
         N/t4WrVcX16AUSqJZHq71eZ+cJ7RtJ3ohheBPRLR7I5nsG6lJ2V+/OWr/fsbo7Q17Th2
         OwcM2JB/zkZLBU4zF+hDP2Ya//AzWU0amE12OBVqti9b3+Fr+MP4Hk7SBrczdIgWom/L
         SccQ==
X-Gm-Message-State: AOAM533d8qmOtaIvJ55DyJZa3PmRUOk152VnCy76ZUDZK9Zmg9YZLnpu
        leqkf0ENgmdRokY/LktFusP0cfdBfZPQQw==
X-Google-Smtp-Source: ABdhPJyhPWUmErFdgTFqYgkZFX66INnYishxq/rH8JwYFxIiXzqtYfsy6TBvdHm6+SS/5Twni+58yA==
X-Received: by 2002:a05:6e02:1baf:: with SMTP id n15mr6242232ili.249.1634063670269;
        Tue, 12 Oct 2021 11:34:30 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v15sm2125008ilg.87.2021.10.12.11.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 11:34:29 -0700 (PDT)
Subject: Re: [PATCH 2/9] sbitmap: add helper to clear a batch of tags
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-3-axboe@kernel.dk>
 <f7532d88-74a2-9f3e-2a95-29e6508e889f@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8f7f3314-3cd6-5d30-6bed-b7ed119b1e6b@kernel.dk>
Date:   Tue, 12 Oct 2021 12:34:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f7532d88-74a2-9f3e-2a95-29e6508e889f@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/21 12:29 PM, Bart Van Assche wrote:
> On 10/12/21 11:17 AM, Jens Axboe wrote:
>> +void sbitmap_queue_clear_batch(struct sbitmap_queue *sbq, int offset,
>> +				int *tags, int nr_tags)
>> +{
>> +	struct sbitmap *sb = &sbq->sb;
>> +	unsigned long *addr = NULL;
>> +	unsigned long mask = 0;
>> +	int i;
>> +
>> +	smp_mb__before_atomic();
>> +	for (i = 0; i < nr_tags; i++) {
>> +		const int tag = tags[i] - offset;
>> +		unsigned long *this_addr;
>> +
>> +		/* since we're clearing a batch, skip the deferred map */
>> +		this_addr = &sb->map[SB_NR_TO_INDEX(sb, tag)].word;
>> +		if (!addr) {
>> +			addr = this_addr;
>> +		} else if (addr != this_addr) {
>> +			atomic_long_andnot(mask, (atomic_long_t *) addr);
>> +			mask = 0;
>> +			addr = this_addr;
>> +		}
>> +		mask |= (1UL << SB_NR_TO_BIT(sb, tag));
>> +	}
>> +
>> +	if (mask)
>> +		atomic_long_andnot(mask, (atomic_long_t *) addr);
>> +
>> +	smp_mb__after_atomic();
>> +	sbitmap_queue_wake_up(sbq);
>> +	sbitmap_update_cpu_hint(&sbq->sb, raw_smp_processor_id(),
>> +					tags[nr_tags - 1] - offset);
>> +}
>> +
>>   void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
>>   			 unsigned int cpu)
>>   {
> 
> How does replacing the sbitmap_queue_clear() implementation by calling 
> sbitmap_queue_clear_batch() affect performance? I'm wondering whether it 
> is possible to prevent code duplication without affecting performance 
> negatively.

Good question, I'd rather defer that to a followup though if it ends up
making sense. It's not that simple, as we play some tricks for the usual
clear path by inserting a deferred mask to avoid hitting the cacheline
repeatedly. That doesn't make sense to do for batched clears, obviously,
so they work in slightly different ways where the single bit clear has
an extra step to increase the efficiency.

-- 
Jens Axboe

