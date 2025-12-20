Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6951FC8
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766189131; cv=none; b=W/tBTztJeEBYA7iuICk/LMBXQnAMkpFhlv3P7mTMmVL6SdgArf+REekYMLv1ZeSwUhkttQlFyrFbz/75ZsTThyhKEKKd26IhG2ziPGAdk1ZYdaosRbO7DQMqZdCwYXT6QSEffXpGkrtpRvXeky0qD7TBBnnWnaBSSsNpe4CetFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766189131; c=relaxed/simple;
	bh=DHYtOjNzy3eBHAtmW1uYWjhjDKZ7cTMfkNRmOYczYlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OESSNJUfJz5H5U9mUPTdVPpmLjKnHxM6cCSSecGYsrN+Xye5RgbfFBq+90l1QrcHpSHjwKMa3q+exE+/xfW8342yjxlU+inV18RfjXgia/bdKM5MwdD3VQrbnTH1OO4L7kJU/PKKQNCW7crve4TF3ksVB8GkZ6Q4d5kAoB1wfh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS3Der2o; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS3Der2o"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29efd139227so30113055ad.1
        for <linux-block@vger.kernel.org>; Fri, 19 Dec 2025 16:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766189129; x=1766793929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fszDsH7M6WI1L2IR47y+E3YL7X4tFcHpI5uqo91tN4=;
        b=gS3Der2o4o6yE+D2H1UypWizCLeJllzxpz4/4gXlRzML+BJgAc4I8JmCyTwMBk2j0m
         9RjT0918F6n/hswwMdqfSaXu+2M99IG4ivKdUA+clKJ15PgfFKFFKnNJixpkC2pbdwWy
         /chPwwhwXN5SpqA9MnXXRB7oyrkJght9p1yK7PxT+iuauy+z5EWP0iJ5YxBzMf673b47
         ve0bVG84bdRX4AYw3DZAWKMAoOj2dr0Qbn2u3h/zC/vvxxciJy4C33wcaWFo6t3UZgan
         2dJSm59Yi54ohi7QlVBuvqXvYlir6OyEi7b/7WSLfRRggIoqm5Tgrw9rOI2Lo3hZLbZh
         Si9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766189129; x=1766793929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fszDsH7M6WI1L2IR47y+E3YL7X4tFcHpI5uqo91tN4=;
        b=VAewNKa9S7ndswbeI8jiu1yD30zIzd2taOouRF4IRijawEqE9zsIiAK84DADgA49l3
         Sc0N//lj9LsIigkle/8dJHcbzRYCKUswI0cgJdeYK9LdxwPU4HgkbuPlARPZNH5UU9/t
         /zH25FVe3Cqi/nU7pF/HM0sP5cHknrahp2H/1Hn42bWhpqP7D8QEKVxy6tg/JFYRHrYW
         YFD28xi4vJ5fTK/RM0HMk2y/sMKUirs3ZLF7NM8TscV/yBV0uJj81pqWnQA7rdaj65A2
         OXZn+eCsOJd+ppxMZ23OCHGlSwYR7BjNEOwj+zOJiOVX0LMZB2hPzgdz7c4DfVnJCMT/
         ovEg==
X-Forwarded-Encrypted: i=1; AJvYcCV9KBVhNnMHdrM2ofgpvsq3zUqE6NhQ4thyEPJ+qRMUsQzkBOpj7HVcwMe60gfJV9ubFdJbbcIAtSkC9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMQ7pcW6DTCOwKTLAHAzVtthfmnjd4qCegIhtbVmCBtConPP0m
	QL1G/7RdBZglKjosQZzi3dAYM0Ls4lzSRmNKE2xxJ3d44w+vwF7lJSOi
X-Gm-Gg: AY/fxX4qgHL/RnK6xqpRgu2CnXpaXJK4iBsRHxaQntZQb7SEYwuGoa9xLI5x7wZdLrD
	Y2XmNlIpPgc2W2JD5fFN5PzcVhQJWo1T14ye43IiSBaFPShzl8jbeCONa5mKHj7t3flwK508vFF
	8wz4RW1hWqJaQHbdQEU9jWOCj0ffSl6yNmWtMimIbdkBaeqDUVnRm/afJWNT1ppdm2CsZnCMLtS
	eujZbvELeQoclitI1iDvGIL3bEz2fDbCCGkqIEDDElSzS5MUcYQPC0GblHP374A4ILK/D893JWd
	7uGv7BqIjfGsHx6YsMi4BhthIaufxFR2RVWYlgBdaCsv/3d7kzfWsa3TOkbzLVoajj1hvNgvEP4
	l187FRAmjvs5QGh8ELQagALPeRu1GzWGhRFKS0hfIhY/FdYBqYBXFgTt/Y4kEaIQb/iDJg8kEZM
	39pym9lNNoWl42DHBD4y9n4djWdK6t7FKphiOCOnnPd3Z+1erKd1PuCh12JuRIwiab7eXi9LUdx
	O0MwDtSAV5IZ5IMF5cR0vsMdthymZKxVYZO9ZVAaQsx
X-Google-Smtp-Source: AGHT+IFqZXzMq97UtLhwZ68/9PyK5v2d/rDCXYQKm3T9+VHPCh/2PFZEf7OWn/oRRUV0AJC9PNc/5w==
X-Received: by 2002:a05:7022:213:b0:11a:4016:44a5 with SMTP id a92af1059eb24-121722de1e1mr6241495c88.24.1766189128839;
        Fri, 19 Dec 2025 16:05:28 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254d369sm14089306c88.16.2025.12.19.16.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 16:05:28 -0800 (PST)
Message-ID: <ddf72e7a-a5a0-48d0-8714-9f3caa4345bb@gmail.com>
Date: Fri, 19 Dec 2025 16:05:21 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] scsi: core: Improve IOPS in case of host-wide tags
To: Damien Le Moal <dlemoal@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <20251216223052.350366-1-bvanassche@acm.org>
 <20251216223052.350366-7-bvanassche@acm.org>
 <ac537693-ec0c-4c50-8ee9-a02975f0e18c@kernel.org>
 <dba8da69-1f14-48a5-a540-01e8659b7d3a@acm.org>
 <074e472e-4320-4d42-b4ac-a1fa7585e2b6@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <074e472e-4320-4d42-b4ac-a1fa7585e2b6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 3:06 PM, Damien Le Moal wrote:
> On 12/20/25 02:35, Bart Van Assche wrote:
>> On 12/16/25 7:24 PM, Damien Le Moal wrote:
>>> On 12/17/25 07:30, Bart Van Assche wrote:
>>>> The SCSI core uses the budget map to restrict the number of commands
>>>> that are in flight per logical unit. That limit check can be left out if
>>>> host->cmd_per_lun >= host->can_queue and if the host tag set is shared
>>>> across all hardware queues or if there is only one hardware queue  Since
>>>
>>> Missing a period at the end of the sentence (before Since). But more
>>> importantly, this does not explain why the above is true, and frankly, I do not
>>> see it...
>> Hi Damien,
>>
>> The purpose of the SCSI device budget map is to prevent that the queue
>> depth limit for that SCSI device is exceeded. If there is only a single
>> hardware queue or there is a host-wide tag set and host->cmd_per_lun is
>> identical to host->can_queue, it is not possible that the queue depth
>> for a single SCSI device is exceeded and hence the SCSI device budget
>> map is not needed.
> 
> Still very confusing because as far as I understand things, a host is not
> necessarily a LUN/block device (you can have several devices/LUNs on the same
> host). So in general host->can_queue != device max queue depth. Also, I am not
> entirely sure if host->cmd_per_lun and max queue depth of the LUN are the same
> thing, given that SCSI does not define a maximum device queue depth...

Hi Damien,

There are important use cases, e.g. the UFS driver, where
host->can_queue is identical to the maximum queue depth per logical
unit. A single UFS device typically supports multiple logical units.

>> Please help with reviewing the ATA patch in this series.
> 
> For AHCI, we are dealing with single queue devices, always. For this case, I do
> not think that the scsi budget is needed since we will always have scsi tag ==
> ATA tag, between 0 and 31. So if you can allocate a tag, you can always submit
> the command.
> 
> But for libsas HBAs, I am not sure at all if what you did is solid/works,
> because I still do not understand it. Please provide more detailed explanations
> in your code (comments) and commit messages to better explain what you are doing
> is safe.

I plan to modify scsi_needs_budget_map() in patch 6/6 such that SCSI
hosts that define a .change_queue_depth method and/or that set
.track_queue_depth. This will prevent that this optimization applies to
libsas HBAs. From include/scsi/libsas.h:

#define __LIBSAS_SHT_BASE						\
	[ ... ]
	.change_queue_depth		= sas_change_queue_depth,	\
	[ ... ]

Thanks,

Bart.
