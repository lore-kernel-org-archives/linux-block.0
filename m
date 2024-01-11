Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863004CB3C
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aa6w/dCV"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso47394839f.1
        for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 08:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704989804; x=1705594604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SpO93iW41WoRi9/ZFyVouzDbg6XWa+4zXQ/9lXcVpow=;
        b=aa6w/dCVXEq5ysUqUAcCfKlcvDTpsDlj8DE2nH6YLdzS/Gr2b0YnnUu9eN38v27ZcI
         5YYqDpO3SwSR0smwtGWnQZaH8FJztl/pdjfPpVVkQn+Jkkj6niU41OtqXJJCm3RbG+Tm
         flBmn5hTVHtK4Wss78o7owtTygT4cTDzQFsrZwo4IwqrbGHo8b30/pR6jExG7lQyisBC
         f1r9LUp5YR5j4Duw2Ydv2nFKA1KbDQX7lmVje6F6qmBwwBS4Ayv5KsUQ/wlkfRBmnsvp
         KaVWQ4Q6xIQEen1roexNK1Pumlf8cJPhJ4ruvvWQhXMoHUARxbvC11rrcfCNRmGc6KT6
         sGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704989804; x=1705594604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpO93iW41WoRi9/ZFyVouzDbg6XWa+4zXQ/9lXcVpow=;
        b=BCwZA0mlwBIgcUdzGZ4TRUcgc4zdYNrjQUcSUgGlJrRDG+lqJDrI8OWVonaO3pmFBX
         +MwEXmicWyaJFnXD+4e/Pyf37zohllK+L2CPeeEnmqDaRkAmUgxyWH0A9djXEJeQTp6p
         yTuTAPFbJH10Zb4LbCscyjpB4WfE6pKUZGLFIUeRMrmjDjqvVSikCgvyc4WE5nqiOoxL
         TMYGCj2UE/fMjtlg0dBCVAwsxlJjbbveatHQhgzcoKPY0MbvdRdOkheQBoM61VBQ0vzw
         YW6a5x3LaEd0t4jz6ISMMlalU/tZIe9qUamlq2TF0odAhkkKu8BOAOP+sVR9OQEYeCkt
         ssZA==
X-Gm-Message-State: AOJu0YzukD35C7Dt4arxfWk3+pJ3P2X91h4lqwPY7gBfuiRfL4Dic0Ef
	7yEy3TDustsXC6RRQhZWt/u1jhcfXH0ohg==
X-Google-Smtp-Source: AGHT+IGDMIsLpff5kobKKGusoQRbtE2d+4gmf7jaC/sHI6Ljb7AWaaJb+rrtJNzJ4GMVhL+HZ7H6Nw==
X-Received: by 2002:a6b:f415:0:b0:7bc:2603:575f with SMTP id i21-20020a6bf415000000b007bc2603575fmr2597809iog.0.1704989804533;
        Thu, 11 Jan 2024 08:16:44 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id eh3-20020a056638298300b0046e578ed0aasm224566jab.96.2024.01.11.08.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 08:16:43 -0800 (PST)
Message-ID: <ebfb6dc2-79e6-46a8-9dd6-7adfae0603f0@kernel.dk>
Date: Thu, 11 Jan 2024 09:16:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block/integrity: flag the queue if it has an
 integrity profile
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com
References: <20240111160226.1936351-1-axboe@kernel.dk>
 <20240111160226.1936351-3-axboe@kernel.dk> <ZaASADP4js2Oboqx@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZaASADP4js2Oboqx@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 9:06 AM, Christoph Hellwig wrote:
> On Thu, Jan 11, 2024 at 09:00:20AM -0700, Jens Axboe wrote:
>> Now that we don't set a dummy profile, if someone registers and actual
>> profile, flag the queue as such.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/blk-integrity.c  | 14 +++++++++-----
>>  include/linux/blkdev.h |  1 +
>>  2 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/blk-integrity.c b/block/blk-integrity.c
>> index a1ea1794c7c8..974af93de2da 100644
>> --- a/block/blk-integrity.c
>> +++ b/block/blk-integrity.c
>> @@ -339,22 +339,25 @@ const struct attribute_group blk_integrity_attr_group = {
>>   */
>>  void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template)
>>  {
>> -	struct blk_integrity *bi = &disk->queue->integrity;
>> +	struct request_queue *q = disk->queue;
>> +	struct blk_integrity *bi = &q->integrity;
>>  
>>  	bi->flags = BLK_INTEGRITY_VERIFY | BLK_INTEGRITY_GENERATE |
>>  		template->flags;
>>  	bi->interval_exp = template->interval_exp ? :
>> -		ilog2(queue_logical_block_size(disk->queue));
>> +		ilog2(queue_logical_block_size(q));
>>  	bi->profile = template->profile;
>> +	if (bi->profile)
>> +		blk_queue_flag_set(QUEUE_FLAG_INTG_PROFILE, q);
> 
> Is this really so much better vs just checking for bi->profile
> being non-NULL?

Before we can check that, we have to load
bio->bi_bdev->bd_disk->queue->integrity, and we have to call in to
bio_integrity_prep() as well needlessly. We could do that in patch 3 and
then we just need to load q->integrity->profile, and while queue_flags
is certainly hot, it's probably not a huge deal to load that cacheline.
I think if we do that, we stick integrity before limits.

I can make that change, and then we can drop the flag.

-- 
Jens Axboe

