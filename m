Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39C6135
	for <linux-block@vger.kernel.org>; Wed, 20 Dec 2023 00:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1f055438492so3730741fac.3
        for <linux-block@vger.kernel.org>; Tue, 19 Dec 2023 16:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703033307; x=1703638107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOiCC52Xo31zF/ra/Kovtg1qm+6ItH5nVOh/zb9zNL0=;
        b=hK6oZgOQ+qZftwd305Rol9IT9i0zFikqhoaBmvI9D5q9y4xiOfJkZ/79kIEJXcTX6p
         OA0xVR2VpTydcb61gAiUhkJT7KIlLviexLkDzqJX6u9bHsfyA6o8e4lkajkAwsMZSz2b
         iufDD9pgcrvO1eoKdEOJBhzS8BY0zX5s8lsVSrMnoijhvfT0QdM3V9Ozd2356MWoXmWW
         ouO6IQMqq/2DHZe9MUO8SUz+3KEppMM0RjDaBhAH9BB5sjrqKOEcQTTSdVNuxXCdL6Y5
         upWXoCxan6Nnwk7Ss7H11NrDvb6GjLUHmAcO6efizwCNE/j+27+JYHBolzQgJX+pb2/O
         vguQ==
X-Gm-Message-State: AOJu0YydiaQFtfUpJPv8a+OWQw/nFlPuYNOXXZTagZY6RMKc/eBQ01EI
	lTpcWXyzwnQ10nfN0KR4v2M=
X-Google-Smtp-Source: AGHT+IEbhSL+g58qSRGhu+Eyh/X55yEDsjgo6twCMW0YFWuxoDb0dfCxbXe5BgUJzB32F4NFLt/Zrg==
X-Received: by 2002:a05:6870:180d:b0:203:d088:6594 with SMTP id t13-20020a056870180d00b00203d0886594mr4050631oaf.50.1703033307536;
        Tue, 19 Dec 2023 16:48:27 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id u2-20020a63df02000000b005c60ad6c4absm20319551pgg.4.2023.12.19.16.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 16:48:27 -0800 (PST)
Message-ID: <2e475db5-fd09-483c-9c34-d9bf9e64d273@acm.org>
Date: Tue, 19 Dec 2023 16:48:25 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] block/mq-deadline: Prevent zoned write reordering
 due to I/O prioritization
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20231218211342.2179689-1-bvanassche@acm.org>
 <20231218211342.2179689-5-bvanassche@acm.org> <20231219121010.GA21240@lst.de>
 <54a920d3-08e3-4810-806d-2961110d876d@acm.org>
 <6d2e8aaa-3e0e-4f8e-8295-0f74b65f23ae@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6d2e8aaa-3e0e-4f8e-8295-0f74b65f23ae@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/23 16:05, Damien Le Moal wrote:
> On 12/20/23 02:42, Bart Van Assche wrote:
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index c11c97afa0bc..668888103a47 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2922,6 +2922,13 @@ static bool blk_mq_can_use_cached_rq(struct request *rq, struct blk_plug *plug,
>>
>>    static void bio_set_ioprio(struct bio *bio)
>>    {
>> +	/*
>> +	 * Do not set the I/O priority of sequential zoned write bios because
>> +	 * this could lead to reordering and hence to unaligned write errors.
>> +	 */
>> +	if (blk_bio_is_seq_zoned_write(bio))
>> +		return;
> 
> That is not acceptable as that will ignore priorities passed for async direct
> IOs through aio->aio_reqprio. That one is a perfectly acceptable use case and we
> should not ignore it.

Hi Damien,

What you wrote is wrong. bio_set_ioprio() applies the I/O priority set
by ionice or by the blk-ioprio cgroup policy. The above patch does not
affect the priorities set via aio_reqprio. aio_reqprio is still copied
in ki_ioprio and ki_ioprio is still copied into bi_ioprio by the direct
I/O code.

Bart.

