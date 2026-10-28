Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199107;
	b=nU+UThLVdiPCwEoQZmWRzRpIigUkKWFVo8woS/rIJBzYtVvT1g4RkUsnmrpd/zhjW6fl
	 OYs4LAnWTzHEsl3yW+1t7eT4u76o36b+eWEd/F+qARWVgB7CVEK/8jbk+1K9OT6ehpxYg
	 5R0I2ASrvq0hbDrteeVTBV8mzpQngppEfzxpO1kT04b45Dpfm7wqoimuFCRJvrQ31KgTi
	 83YRU4wXsvwc9cRLj/xOk0a2pYhF91/ZEERnPohqBxgthjBgS+Uo+TD3vNK/5beH8rNmi
	 UDO/y6J5CtQGXqPmOpmr5jHf2X0a1Gg0e3Wfpieuvy1tYGcn1X+HL4w66ekSI4n68jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199107;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=kLMSlG7Ym7zEigXRP151VRg5FF7XyebPDkv4apgI5Bk=;
	b=SuPfCbFVeYtaB9qz3X3v/5TMx2ruBYKI2bQvIYUtOFrwNtdu8X0R5AbpY4jIJQXke1Ij
	 2BM5kRwLomdAf5XoPrwJLAfnwTXNYN0Z6qy0rI217oUUpSDgmC2A8+MJy6JYAvYz00lG1
	 ZUN/mFnjegct3uW/J0O2DEUD7DhF5axRKt2KXrAc9IcMnuOlHMzQXCbSzaDPqWSTwwFlY
	 qq9nZNt1nKF/qtmTK6VPOXXs6nfwf4N3oC2TJH5o5fwPvlV/EprpIazLGqoIKQANbzTsb
	 q4OmFm5KGxOZ4maCdWFio6H0jibcRa8zjGhBExVLzOZ7EwmQEBAOiqINNNDZISkpZ+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LrTsfsLq;
	arc=none smtp.remote-ip=95.215.58.142
Received: from mta1.migadu.com (out-142.mta1.migadu.com [95.215.58.142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA93E606A31A
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 14:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA93E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LrTsfsLq
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8capDLTMz6rNDC3kBcTMj3L1XI50zZhlLuOVH6yaAbo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793199103; v=1; x=1793803903;
 b=LrTsfsLqPYR0gPFepT11vf8NPZYoyA7HTbuQF+enDE55w8z9WCiY0jJPk4cTDJAgU8sXsXBj
 yC1iLd+5QREWKR404i44U5MOGafZJtkfa8Vf1hLvTUN/yOcC/aw9Q4KyH1Jq7MD3orMi4jtjLpH
 zz3b5iDHiaJXloZmWt0SKCqM=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4c573ac9549fa244;
	Wed, 28 Oct 2026 14:51:43 +0000
X-Mizu-Trace-ID: 4c573ac9549fa244
X-Migadu-Flow: FLOW_OUT
Message-ID: <7efb1e79-f4a3-48a1-a08c-20eeb6369bbd@linux.dev>
Date: Wed, 28 Oct 2026 15:51:38 +0100
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 for-next 0/3] block: delay support for error injection
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20260928221634.43239-1-haris.iqbal@linux.dev>
 <20261022202326.GB2931-mkhalfella@purestorage.com>
Content-Language: en-US
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <20261022202326.GB2931-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/22/26 22:23, Mohamed Khalfella wrote:
> Hello,
> 
> I wanted to use the delay injection for a test case that I am currently
> working on [1]. Are you still working on these changes?

Hello,

Yes. But currently I am moving houses and hence did not get a chance to 
look at the comments. I plan to send a v4 with changes based on the 
comments next week.

> 
> 1- https://lore.kernel.org/all/20261022185920.GA2931-mkhalfella@purestorage.com/
> 
> 
> On Tue 2026-09-29 00:16:31 +0200, Md Haris Iqbal wrote:
>> Error injection can only fail a bio today.  This adds a delay_us option so
>> that a rule can hold a bio back first, to model a slow device.  The delay
>> happens above the driver, so it tests the code waiting above the block
>> layer, not the blk-mq timeout handler.
>>
>> A delayed bio is marked with a new BIO_ERROR_INJECTED flag so the rules
>> are not applied to it again, even after a split.  Christoph asked on v2
>> to avoid the flag by allowing a delay only together with an error.  I kept
>> delay-only rules, as a slow device that succeeds is the more useful case,
>> so the flag question is still open.
>>
>> Holding a bio back reorders it against bios submitted later, which breaks
>> sequential write ordering on zoned devices.
>>
>> Patch 1 is a prep cleanup.  It moves the rejection of an unknown status
>> tag into the parser, because patch 2 makes a rule without a status valid.
>>
>> Tested in a VM.
>>
>> v1: https://lore.kernel.org/linux-block/20260827000115.128093-1-haris.iqbal@linux.dev/
>> v2: https://lore.kernel.org/linux-block/20260830012002.80275-1-haris.iqbal@linux.dev/
>>
>> Changes since v2:
>>
>>   - Patch 1: return bool, rewrite the commit message.
>>
>>   - Patch 2: drop __submit_bio_noacct_nocheck(); the flag alone stops the
>>     rules being applied again.  Log the error when a delayed bio is failed.
>>
>>   - Patch 3: trim the documentation.
>>
>> Changes since v1:
>>
>>   - Add the BIO_ERROR_INJECTED bio flag.  v1 only resubmitted a delayed bio
>>     below the injection hook, which left the remainder of a split going
>>     through the hook and matching the same rule again, so a bio was held
>>     once per split instead of once.
>>
>>   - Patch 1: tag_to_blk_status() returns an error and passes the status back
>>     through a pointer, instead of returning BLK_STS_OK for both the "OK" tag
>>     and an unknown one.  A delay-only rule has no status, so the two have to
>>     be told apart.
>>
>>   - Documentation: a delayed bio is held once rather than once per split.
>>
>> Md Haris Iqbal (3):
>>    block: Reject unknown status tags in error injection rules
>>    block: allow error injection rules to delay bios
>>    Documentation: block: document error injection delay feature
>>
>>   Documentation/block/error-injection.rst |  39 +++++-
>>   block/blk-core.c                        |  14 +-
>>   block/blk.h                             |   2 +-
>>   block/error-injection.c                 | 167 +++++++++++++++++++++---
>>   block/error-injection.h                 |   1 +
>>   include/linux/blk_types.h               |   1 +
>>   6 files changed, 192 insertions(+), 32 deletions(-)
>>
>> -- 
>> 2.53.0
>>

