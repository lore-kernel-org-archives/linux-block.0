Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.90
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795260471;
	b=bP3J4OM6PyyOtfq6QxvYd8mjWtKvJO+WAtfWJF8kyiXdPt4lEcXJWO4Py85hZHquSsJe
	 pgAvkX9JoJsggqSBaSw6z+583JlxD3BRB6v1LYbSzg5j/RxbbKhFiyFJctfLfvuhdT/8j
	 u+F+53Q8yRGUrFr2IqXfUOvAOEe2rW5diEMyHsBJRqdqLCdO/Aa8YDB/LKNgvmhtEn04/
	 7r4Db5KK0Ucd9YnSk0GaFuO/wRFtbaSnIbS3YxDPc/yfkEy5BJ8tBGz+FXT0xYjKtCDW1
	 8ANyDbEB1FYaDhhq3pQMTc/Gmiq5U8+ThGi8FjDapE2yfsejzL9l3rU2d+TC5F74XOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260471;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=zWbeHAaU9PSKfsLTHzffi5B4XV2cAowGCcU8h7Q3pis=;
	b=IgZGJ0i/Be9rS6OxRe3m5fpfkTPL6SCHslUUJTqYEbQDbrAvRfFq+utncsX+m7dwJuce
	 GpoKn4SfJhUts8IUi/sVljU6u5YOzlbJSUMOnWN+9lnB6yXHYP/fzdjeYj5nZG+ho5pb+
	 M/vxF8YJw8Tqo1v6IZrURLlz5F+W3hiuL8JVuQVje2V5L+8DV+WoREfnJ3tJzJhEJCt5U
	 H1vlel+GzIJWNULMYqbEeACn7cCBTXeYm7kWbb7gRuj68GVdNfa35N7gUnQJboe9SlqBq
	 BVXOwWcRIbESwhfDJPVxhkkhGpagtNJnzZWI1Xi/0l0PSzt0yrSeWdukPdANn6omTGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.90
Received: from mta1.migadu.com (out-90.mta1.migadu.com [95.215.58.90])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF4E606A325
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 11:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DF4E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fvBF6/+ij8xwF+iLXx8bSG1XL2OxGVsMqLATzmvR4MI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795260468; v=1; x=1795865268;
 b=eA6XC8N7w8n6rG3EcyNd6SeDscaN4tXzB/yTtsTLbhPKM1eqn+9R6rt2FpQ3TtkCc7LKVfLt
 WMPPvctvB8FXvxPR+imly3gdB19SIJrkreqQlDRDyDk6dzOgHunr4uzJrZg0ArOi+0nL75Ox/aa
 fQjXeTP1KHHwETXhFIjICcww=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 99df8f76e236daff;
	Sat, 21 Nov 2026 11:27:48 +0000
X-Mizu-Trace-ID: 99df8f76e236daff
X-Migadu-Flow: FLOW_OUT
Message-ID: <edb8249a-7bc3-430e-bbb7-243e1881a0b8@linux.dev>
Date: Sat, 21 Nov 2026 12:27:47 +0100
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
Subject: Re: [v4 0/3] block: delay support for error injection
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
References: <20261111215838.103356-1-haris.iqbal@linux.dev>
 <179501806989.17649.3138860274842922761.b4-ty@b4>
 <20261120164416.GA32719@lst.de>
Content-Language: en-US
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <20261120164416.GA32719@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/20/26 17:44, Christoph Hellwig wrote:
> On Wed, Nov 18, 2026 at 09:07:49AM -0700, Jens Axboe wrote:
>>
>> On Wed, 11 Nov 2026 22:58:35 +0100, Md Haris Iqbal wrote:
>>> Error injection can only fail a bio today.  This adds a delay_us option so
>>> that a rule can hold a bio back first, to model a slow device.  The delay
>>> happens above the driver, so it tests the code waiting above the block
>>> layer, not the blk-mq timeout handler.
>>>
>>> A delayed bio is marked with a new BIO_ERROR_INJECTED flag so the rules
>>> are not applied to it again, even after a split.  Christoph asked on v2
>>> to avoid the flag by allowing a delay only together with an error.  I kept
>>> delay-only rules, as a slow device that succeeds is the more useful case,
>>> so the flag question is still open.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
> 
> Hmm.  This still has rela issues as pointed out by Sashiko.  I'd very
> much expect a resend to address them.

I can resend with the fix, or send just the fix to be patched above 
this, since these are already picked. Let me know whats preferable.

