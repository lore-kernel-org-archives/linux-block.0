Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2762BB12;
	Sun, 23 Jun 2024 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719126233; cv=none; b=mAO5fdlFOu4KIwYxPhhNv1zwjjbkLceJkpb5aPq1019bkWoMUhy1VanuMMQs2UciY5xWa4pgjD5x61T7udjUsgQ1ABmh50rC0eNM8aUtu0hgpVClBHNLttQe/eLDFXp+xW+rmPQ6up79xWquqgiKYg9xvjKdcuVesI0HUZT1F1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719126233; c=relaxed/simple;
	bh=/5BmjUa7LwamVshyhd8I9KJHh/+blm0Ja3Sr9jm7QWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p31rSQnaXq62co+rvflfm7bB/0l9+yLHss0Y+cyRqGa7vY22c9pGoIYXtu12jArtXSW6bhb993pEpwMMsY2ZEP6ioVTct/UKYFzod9kWc6zcuKTZSn15T2qEp/uz7U1dQUkfAQeXUw0mF1C5EfN1g859aHeiCZgiV2yECwAldkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42479dece93so4893785e9.0;
        Sun, 23 Jun 2024 00:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719126230; x=1719731030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv+nb63jc8RX+XM579eAzoR3ORtF5l0kMJ0jYedplWM=;
        b=VB6IV84nS3cbN60gN1NQMYu+Gizwr4sg7m2QhdMOsKTYy190jnMTAL7/eVyFDJW1rx
         ci0UfVSxkHxD/yp9UrW5C75vSl11QH/BVJwlupCTv1AR7WrvvSpTnuuif5GqXQubrUIp
         0fadkCJn0fLd4yg/2RXhXF5XHAkGYl82QVjlmmIdvu8m2v4py1RXX8W01mVcpXNmIMtV
         wuymMKeFQBDuUyM5UGGDmJtEXuP0Ktkwmfi2fHLYO319Fa9EpIPalv5yA9x7BNJc4YYB
         8dLxX0feUOeVM6eto5zTtVOZmQKhzZ2Je2nTY0P4Gxe/mSBuEiUGsoZDLsJOsV4ibAgA
         veGg==
X-Forwarded-Encrypted: i=1; AJvYcCVlheAs45sZBr6ALCTUlEAvhW38oKdByritPxi2AwIzW+h/U8X4sw26cK+JapV+ixhdxvA9q9hNI6P5kJTndauP6n/CcM1gMl2jm62aj23HqkI/VTzS/8cA/LZGD6PzX+iCP5dYCmqfBU8=
X-Gm-Message-State: AOJu0YwSFGcFZeQQ3UkMOjElTqBnw/G4J/gYpHMG6/yiX/5Bi1lW2kEp
	PhutLNZfDT1C8idk7Uff8hR2L4ylpNKO9cy53CrSLvSNU7KoylwX
X-Google-Smtp-Source: AGHT+IEFnKUhu/I1x5TTgU8A64wWsdGchv2Vq9HTIBSF0tK7sTEaqtJeSsf2sJNzJFpypmhL2ozVZw==
X-Received: by 2002:a05:6000:2a7:b0:366:eb60:bd12 with SMTP id ffacd0b85a97d-366eb60beb4mr559833f8f.3.1719126229676;
        Sun, 23 Jun 2024 00:03:49 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm6575582f8f.96.2024.06.23.00.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 00:03:49 -0700 (PDT)
Message-ID: <e1e35796-2d9e-41ac-a515-a39dc1866070@grimberg.me>
Date: Sun, 23 Jun 2024 10:03:47 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-pci: limit queue count to housekeeping cpus
To: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbecker@suse.com>, Mel Gorman <mgorman@suse.de>,
 Hannes Reinecke <hare@suse.de>,
 Sridhar Balaraman <sbalaraman@parallelwireless.com>,
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
 <20240621-isolcpus-io-queues-v1-2-8b169bf41083@suse.de>
 <20240622051420.GC11303@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240622051420.GC11303@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/06/2024 8:14, Christoph Hellwig wrote:
>> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
>> index 9638b25fd521..43c039900ef6 100644
>> --- a/block/blk-mq-cpumap.c
>> +++ b/block/blk-mq-cpumap.c
>> @@ -11,10 +11,23 @@
>>   #include <linux/smp.h>
>>   #include <linux/cpu.h>
>>   #include <linux/group_cpus.h>
>> +#include <linux/sched/isolation.h>
>>   
>>   #include "blk.h"
>>   #include "blk-mq.h"
>>   
>> +unsigned int blk_mq_num_possible_queues(void)
>> +{
>> +	const struct cpumask *io_queue_mask;
>> +
>> +	io_queue_mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
>> +	if (!cpumask_empty(io_queue_mask))
>> +		return cpumask_weight(io_queue_mask);
>> +
>> +	return num_possible_cpus();
>> +}
>> +EXPORT_SYMBOL_GPL(blk_mq_num_possible_queues);
> This should be split into a separate patch.  And it could really use
> a kerneldoc comment.

Agree.

Other than that, looks good.
