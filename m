Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5222C4A23
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470715; cv=none; b=DyxBHL9Id2qemyyRNt0/S751piY69KoOSk42p5KebaCY9IL1wqtSAuL4G/ihXOqQ+MXl07N2Wce65m3h1Fn5ba0xUK596ukGrsLEnLtNbxSPufrllFNlQgE3dozVZrxyehxETbNEfnoHlC108YfgZPXhpwSIzv0JeFtqGRy+ZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470715; c=relaxed/simple;
	bh=PFr7UsUyr2TAMzcqgqVoGnvByQCOk9dWGLtWPFu546M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClWZLFzROMi7/pZH2xKQx60u3CTda7bxXkUrDPPvN6zHmrt7pmcF2dlzAhiouWUo8063YOe66JQPc/CzG2m9ktbSpnfToxpx6o4gKf5WbBad9vF3uKbPeo//VFSX3bUik9rn9Jvuc24dEvc442bw5PLvPEPDI7NeSJjcsj8C4FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PZVAYFOt; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PZVAYFOt"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-844de072603so497232839f.0
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 13:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734470711; x=1735075511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PojFNCMau820oCeLSGubCfiroShMAMnTT3fazSIGivo=;
        b=PZVAYFOt2Bx3s5RLHSw/s+DS6cwzAe8HehNNaJOHOfHubShNIW1Jxemaftu/0JsPhd
         nFgl3zEE8CnfTbqi62BfnlZ5oW6bnpVHlHVW9WFhOkOaJ8mcnZduT0w8zsB+Y5xEG4ZY
         nZ13uvMcYtdOr8FtoaMzDbdtiYMl8AQHhhE8z4x7NrjRUnigzoeJPxebnNCS7wcwetUn
         caNd6R+SmKMXDnNJsHaLodLCftDERkTPUjsemXS9hCp31yx/JVCb/OXYltX96xkyTM53
         wsZg3V6wQZ5mayLFPW5FXqxBqxQUKKaMPdCRz208igRIlgVHlu1IUzqwrDSNXN6pboyt
         u/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734470711; x=1735075511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PojFNCMau820oCeLSGubCfiroShMAMnTT3fazSIGivo=;
        b=g3k6LKnf+/2k2EFKFtVlSNfsZPWvMI0TxilGAegYl2aQcaxhc/4zcX8xzMg8paMrBA
         0dLLVSK5cLWSwKn+16G2YJ1EOVa8MAENoDTI5dblaoVe58YJ8KWJNyd/0sHf4+mI2Ron
         qYn8cmSq5Kdyr7UG0Zhv5Nd1bQe5hrXZN5brx/Jor7pj/JVGi9vGmApA3Ejw1fVYyOBY
         i2LuK1ezTfJr+54AJBSlusp8t3my0JaT7jNuy6A8/6O8SupQGMZryCw1bcEirximEMxC
         z2tsTTTYkFjVx5s2K8Eo4kzQxypKnSZQXpCVMj9utWJo2j7C6CYQwueySjm3FPlbaplg
         C/wQ==
X-Gm-Message-State: AOJu0YxQRdTOPa7maDuYtaGQN/o2nnPWKdqqDZbZTw9kRQZb5BDQxbO8
	vuMUsl1OaMl7JSsc/PDQW5YriuRxfS0EnPnPoh3CPh5p0d1IYCpdxCiqPTuWm98=
X-Gm-Gg: ASbGncvoKJj2ZEp479ibPfKaJtIVDYUvZs5WLwrUZAGkqY9FZwE2irkYdqwP/ej0CUk
	i1jwFxv4n3/LrwrlSyHzqILqCqmmJWuIVnvhifQv9U9auF2liUpkEnk/xuTtZX8GBTWZ9xFyErD
	o2z6naNLgj51qhyOgq1WKiYZyCGNVJ3FFcJwvrx9FOqr5Z82KQKdalqp5Pg7KMDXGnSOGyWoRQT
	kTSsXrKl9LWj788CjsT8uIVGRJumfe5DozxtHLDJ2Ff77P/BjEH
X-Google-Smtp-Source: AGHT+IE+3Lg/xZ76L5EkaACHWcZVeERPGnuBwQ/cMeSdEAQK/ZfXVgaRLtlpKPsYgQHFfd2qvPJjkg==
X-Received: by 2002:a05:6602:1645:b0:841:a678:de40 with SMTP id ca18e2360f4ac-84758314defmr58251539f.0.1734470711461;
        Tue, 17 Dec 2024 13:25:11 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e0367d29sm1881126173.19.2024.12.17.13.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 13:25:10 -0800 (PST)
Message-ID: <7c65513d-740d-4cfd-a02f-ddbd840ebb3d@kernel.dk>
Date: Tue, 17 Dec 2024 14:25:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche
 <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <20241217041515.GA15100@lst.de>
 <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
 <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk>
 <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org>
 <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk>
 <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org>
 <63aae174-a478-48ea-8a74-ab348e21ab65@acm.org>
 <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org>
 <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk>
 <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org>
 <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk>
 <f41ffec1-9d05-47ed-bb0e-2c66136298b6@kernel.org>
 <e299e652-2904-417c-9f76-b7aec5fd066b@kernel.dk>
 <fb292dc8-7092-45c1-ae8a-fca1d61c6c9a@kernel.dk>
 <9e8e2410-53b5-4dad-8b54-b7e72647703b@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <9e8e2410-53b5-4dad-8b54-b7e72647703b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/24 1:59 PM, Damien Le Moal wrote:
> On 2024/12/17 11:58, Jens Axboe wrote:
>> On 12/17/24 12:54 PM, Jens Axboe wrote:
>>> io_uring does support ordering writes - not because of zoning, but to
>>> avoid buffered writes being spread over a bunch of threads and hence
>>> just hammering the inode mutex rather than doing actual useful work. You
>>> could potentially use that. Then all pending writes for that inode would
>>> be ordered, even if punted to io-wq.
>>
>> See io_uring/io_uring.c:io_prep_async_work(), which is called when an IO
>> is added for io-wq execution, io_wq_hash_work() makes sure it'll be
>> ordered. However, this will still not work if you're driving beyond the
>> limit of the device queue depth, or if you're doing IOs that may trigger
>> -EAGAIN spuriously for -EAGAIN as you can still have two issuers - the
>> task itself submitting IO, and the one io-wq worker tasked with doing
>> blocking writes on this zoned device.
> 
> Thanks for the pointer. Will have a look. It may be as simple as
> always using the io-wq worker for zone writes and have these ordered
> (__WQ_ORDERED). Maybe.

Right, that should work if you force everything to be served by io-wq
and ensure it's hashed.

-- 
Jens Axboe
