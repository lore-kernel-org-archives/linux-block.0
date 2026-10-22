Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792654983;
	b=Dlf3hwT3w1h99lkvik3TJk9MA4+mdEDMpS+Mxn+zJHKCfhYjR1VyOduV7foL/3JQU8Ej
	 2I20chtIEI7Bz2Gz1LmVigaeUyxlw8EHPYBFkn8gieBr1C33F3xw09oQwN1/vmga4S1my
	 c3EahINhbhiY2n+pPJ/2bR437tfPHLo6XwjQ3duLJBf/IEd7Mt+uMH4pzc1E2gXiAuELE
	 bd0jD4S8OgH0DQwKZ4NKEGnQgLDp/sVpoAkU7p7re8S5tfpNhEX5xRG6CJGusYFmpBwgX
	 +N8yuMVG+dlSi/jKyuZQyZTZDKifyZkU19YEaHWbc1MwH/CNBNuy87Uxf9SD9Wa7K5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792654983;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=6THKd9HmRQnvPxQbrVq+IetUTLWhZDS28kybs5BXIGo=;
	b=1tNXqQ3cmXzOQOW1KSs52ALzaSCkTgNowJ/HdhdpwtHWggXrvZr8i7jVLrEjpGVx9SQR
	 MF4tB0B3jWZVQb5pzL4tJzmStzwgULBSYt66BZdocAIPgQXRPEHwgNCwW4A5wBwvrcxJI
	 6b3Gl799VcO9L3vpe3oQQRiJ+nf71kiUmHjlz8kgpHa/VuJld/bD71TJxhy4moHnN3a8i
	 sx+gdlABULZsQr9r3SjCBJvmdR7/AM0ZzUtmYf2g+jMf2bFGK5/QbyTtvVHTEP4O8smKD
	 zmZqG+GwoeAymRJu8/hza4uxdf2D2mS3Coy4VGbJmZCIrrPDcVBBb0OvmHytyxR8bKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aheEnjUn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D1F606A319
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aheEnjUn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFFD1F000C1;
	Thu, 22 Oct 2026 07:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792654982;
	bh=6THKd9HmRQnvPxQbrVq+IetUTLWhZDS28kybs5BXIGo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aheEnjUn/SeFxdRwwk0Es9LA66A9OYXwnBs874f9Ga/pmmTgzi4bbpvZxM2cAjh3k
	 SxKhjErV23WU4Q295AaQHABVG7lUBIo0wkKs9qGwF3NKveV7rKYcX8h0sLEeTbVnHx
	 a9Y2LJY0RN4lNysBQ41rtTv3qtopxufpXHNWalSFRR4SRdAo7cQF1o5M5yBoq7zizH
	 1ttJC/5ADjZG+FUi+5k7ctWTZ/O1XkOpeU+xpOW0sW8ExKdO3jG475I1ZGlwZEK8ge
	 r/rrXo17T3CYHGUfd7RZEA94zni9YuuiHbkdieZNveHgm8c43442uVccJ8BOFybT7C
	 rhuxgz73mINfg==
Message-ID: <7e115ae2-37ae-4d95-b9e8-fa4c59b1b09c@kernel.org>
Date: Thu, 22 Oct 2026 09:42:59 +0200
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
Subject: Re: [PATCH 2/2] null_blk: don't finish zones to set them read-only or
 offline
To: Niklas Cassel <cassel@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, linux-block@vger.kernel.org
References: <20261021202100.2017938-4-cassel@kernel.org>
 <20261021202100.2017938-6-cassel@kernel.org>
 <3222f1e8-07a8-4948-bd95-3d816fd1d71e@kernel.org> <atm9FQQIkyEp-RBp@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <atm9FQQIkyEp-RBp@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/22 9:36, Niklas Cassel wrote:
> On Thu, Oct 22, 2026 at 09:15:32AM +0200, Damien Le Moal wrote:
>> On 2026/10/21 22:21, Niklas Cassel wrote:
>>> null_set_zone_cond() calls null_finish_zone() to release the zone
>>> resources held by a zone before setting it read-only or offline.
>>>
>>> For an empty or closed zone, null_finish_zone() first runs the zone
>>> resource checks, which can close an unrelated implicitly open zone, or
>>> fail. As the error is ignored, a failure for a closed zone leaks
>>> nr_zones_closed, permanently lowering the effective active zone limit.
>>>
>>> Setting a zone read-only or offline requires no zone resources, so
>>> release the zone resources held by the zone directly instead, using a
>>> new helper, null_release_zone_resources().
>>>
>>> Fixes: d3a5738849e0 ("null_blk: support read-only and offline zone conditions")
>>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>>
>> Looks good, modulo one nit below.
>>
>> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> (snip)
> 
>>> @@ -768,9 +795,7 @@ static void null_set_zone_cond(struct nullb_device *dev,
>>
>> This function is called only from zone_cond_store() with cond either
>> BLK_ZONE_COND_READONLY or BLK_ZONE_COND_OFFLINE. Since your change is valid only
>> for these 2 conditions, we really should check that cond is either of the
>> already used values and add a comment, to avoid invalid use of
>> null_set_zone_cond() in the future (without tweaking it).
> 
> Could you clarify with code what you mean?
> 
> 
> For a comment, there is one already:
> https://github.com/torvalds/linux/blob/v7.3/drivers/block/null_blk/zoned.c#L746
> 
> For a check that cond is either read-only or offline, there such a check
> already:
> https://github.com/torvalds/linux/blob/v7.3/drivers/block/null_blk/zoned.c#L751-L752

Ah! I missed that! So please ignore my nit comment.

That said, adding a cleanup patch that changes null_set_zone_cond() to something
like:

static void null_set_zone_readonly_or_offline(struct nullb_device *dev,
			       		      struct nullb_zone *zone,
					      bool set_offline)

would make things a lot clearer :)


-- 
Damien Le Moal
Western Digital Research
