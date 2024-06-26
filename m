Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EFE18EFE4
	for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433398; cv=none; b=iLu+e/hTusF/oBehxtMUh2HNMXHASZQfxH6skXAa9z0MTz4NQdD6LutZsmnHuHuXKQyQukqAC7IWRvzp6Uazd7W7TXk3e00c41tUGHtRZfzoEZpBEBo4Ij8bVJqjHuQPmPlmijVEFZNwVn+GT0o5vjl3WeJyOFVDxH4ON8GK89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433398; c=relaxed/simple;
	bh=pjaYCE9P3KcLxKQVApYlU5lmhCHt4CpxTxocoZolkXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsLGWR5srL8pi9Oysf7bbYvc0D3eKZSfqRxQNQd1VO9RD5n4xuynE+RtaJNsa5KEOUWFzz3i/VpBbvJNdbEOPloa4Ukk3aNOLuEVtzhN2kr9OeS++m7CRYCt8zLZmnCy2DgUMvMPRGVQ6UoMHSWtxhzyakzJ9NNMSmFIfYohYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GQ2a9n5E; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GQ2a9n5E"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c8b5a236daso372510a91.1
        for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 13:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719433396; x=1720038196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iIcm1wgz2PYFRvSTmfKBCviM4vc4rUoi0KEFtYyxgkk=;
        b=GQ2a9n5E14Rox3b1vGNF9B9BApqx6cRB2VqEgOBQdL98y0JowbptMH6W0WW8g/je4K
         upUhgi4PV1n1Qe1hFULEGF33J8B3rbBe/oq3HjYpxWmbtG0V+RnXxPv/GS0QcgVnDEmK
         QkxS3/Mja24xc95yzlkWp+FUAb29hHXjduHrz/wKPbGK4OXERit8GwHz56d+iBsXDYJY
         YXBIojPq5zjFTsEGS2QSgWOYIikfTDG+p/OaPBRqhDv9pFauIZjMiBqd0sED6M0XOgNi
         5/0a00JTHyBsInXQ+Y25VZ+lrMb6c3GTjI4jhrYVLYnxF4QXNHpciW9F8Xw8EYfGN4Vb
         W1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719433396; x=1720038196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIcm1wgz2PYFRvSTmfKBCviM4vc4rUoi0KEFtYyxgkk=;
        b=XUXiw6U0vel5sd5JFoeQFdhNZ2PSWEOiSLk9BRn3+Y7f+iSac6Z+rlSvN4PmACT9w4
         LmMhxxvk1xnycwIEYQf2sEYg50evwFG0lGfi/UifQ9kYmrOWsKER0NwkmgDQhQVJRxZl
         HeP4TfasiytojJw4VG+7CD6PfNuo4tfuF0CQHd0RoYzCXZU3QrRy+5Z+uw1kDn95k01p
         MRDW6uOAWL6J/USuZDwPW++s5gWGo8UWhCZ0s2izr95YTSYnahKdRRiMl/7ttnxx90nV
         vA3lpbPJW/2XJLuEuJsM/MjuptKRxmlYb7gZm8coZSTrfv6rf7i8E98zl3TAnyrwvzWh
         GtOw==
X-Forwarded-Encrypted: i=1; AJvYcCUhZyDENtbAEVT3SqJA6R4+Td8xAmg2qvjRSQtAlOSfOaS/sbCMQXMdDta2naLXCHCM17kEON4LBrNsP1eDIiWUInUrmSsqEdEtsH4=
X-Gm-Message-State: AOJu0Yyuc58gpeGswtFAS6KLhC/rBzD8381Gx8Xy8DeOcx6KTEFfk9vv
	kHTskJXAfx9tQUJeYfpT/cfEysqvW1B06Sq9C+Jdc6SQlGLBNYQOkg8VqWS1edQ=
X-Google-Smtp-Source: AGHT+IFUV/CC3j75a0T0PXjx4ENsuqkALCaXlO0FPDNbASuOiUQMX2EszVxk+ODevu1oCp9dGOE/SQ==
X-Received: by 2002:a17:90b:e90:b0:2bf:eddc:590b with SMTP id 98e67ed59e1d1-2c84599bf83mr12008481a91.1.1719433396219;
        Wed, 26 Jun 2024 13:23:16 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d808f874sm2095000a91.50.2024.06.26.13.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 13:23:15 -0700 (PDT)
Message-ID: <f533a5d6-94da-4ede-8d9f-e40df2425698@kernel.dk>
Date: Wed, 26 Jun 2024 14:23:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] block: add support for notifications
To: Daniel Golle <daniel@makrotopia.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Hauke Mehrtens <hauke@hauke-m.de>, Felix Fietkau <nbd@nbd.name>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Al Viro <viro@zeniv.linux.org.uk>, Li Lingfeng <lilingfeng3@huawei.com>,
 Christian Heusel <christian@heusel.eu>, Min Li <min15.li@samsung.com>,
 Avri Altman <avri.altman@wdc.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Hannes Reinecke <hare@suse.de>, Mikko Rapeli <mikko.rapeli@linaro.org>,
 Yeqi Fu <asuk4.q@gmail.com>, Victor Shih <victor.shih@genesyslogic.com.tw>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Li Zhijian <lizhijian@fujitsu.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-block@vger.kernel.org
References: <cover.1719368448.git.daniel@makrotopia.org>
 <609f654800583feb016d96d9c3fc2f029f0f460a.1719368448.git.daniel@makrotopia.org>
 <58cc9e3a-bb69-4205-9f11-d262f811ea9a@kernel.dk>
 <ZnxyQgYyM31Xq2xV@makrotopia.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZnxyQgYyM31Xq2xV@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/24 1:55 PM, Daniel Golle wrote:
> Hi Jens,
> 
> thanks a lot for the review!
> 
> On Wed, Jun 26, 2024 at 01:46:50PM -0600, Jens Axboe wrote:
>> On 6/25/24 8:51 PM, Daniel Golle wrote:
>>> +static int blk_call_notifier_add(struct device *dev)
>>> +{
>>> +	struct blk_device_list *new_blkdev;
>>> +
>>> +	new_blkdev = kmalloc(sizeof(*new_blkdev), GFP_KERNEL);
>>> +	if (!new_blkdev)
>>> +		return -ENOMEM;
>>> +
>>> +	new_blkdev->dev = dev;
>>> +	mutex_lock(&blk_notifier_lock);
>>> +	list_add_tail(&new_blkdev->list, &blk_devices);
>>> +	raw_notifier_call_chain(&blk_notifier_list, BLK_DEVICE_ADD, dev);
>>> +	mutex_unlock(&blk_notifier_lock);
>>> +
>>> +	return 0;
>>> +}
>>
>> Nit: redundant newline.
> 
> I'll remove the newline before the 'return' statement then, right?

Yup

>>> +device_initcall(blk_notifications_init);
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index b2f1362c4681..8d22ba03e3e1 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -1687,4 +1687,12 @@ static inline bool bdev_can_atomic_write(struct block_device *bdev)
>>>  
>>>  #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
>>>  
>>> +
>>> +#ifdef CONFIG_BLOCK_NOTIFIERS
>>
>> #if defined(CONFIG_BLOCK_NOTIFIERS)
>>
>>> +#define BLK_DEVICE_ADD		1
>>> +#define BLK_DEVICE_REMOVE	2
>>> +void blk_register_notify(struct notifier_block *nb);
>>> +void blk_unregister_notify(struct notifier_block *nb);
>>> +#endif
>>
>> Surely these helpers should have a !CONFIG_BLOCK_NOTIFIERS failure case
>> definition? Either that, or dummies. As it stands, any caller would need
>> to check if it's enabled or not.
> 
> Makes sense. I'll add dummies to the header and always define
> the macros for notification types.

Exactly

> Note that what I'm planning to do is to have the block nvmem provider
> select CONFIG_BLOCK_NOTIFIERS in Kconfig, as without that it simply
> won't work at all.

Right, but then someone else uses them for something else, and then
we'll need it anyway.

-- 
Jens Axboe

