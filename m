Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7528E309F08;
	Mon, 21 Sep 2026 02:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789956465; cv=none; b=JYFBc/9xlzjIeZWWnnjR30ovrzouqQIiazoI5+Ma65Q86nMZTHJ73lCS/jGnLZDf5HHp7CFteBIaZAfHN910Xg9N1b00MJoYQFFrk7t8stsOhjWEGYJnlfu4j7qbsSuqtEam4o570m23liNSBaoMxTFUR9cLsk7PPg/5IuMydSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789956465; c=relaxed/simple;
	bh=Ju/cTloKSN64KyZCRJUcn1dqvuAsHGPLKIg3Vp9ppcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1eq7+HjC0qcwQCX1Jxek02DJQiqywXEKqxayhQXdYwpfTJiDHSV2ROJYM2cL4SGD9lwiTlgREjtSNujbYZ6gKTeyCly1M89FvQKLma3Vg+/hzKwdKmvHvTUDHqtniIGp9aV4qbOGykr0Na+lwRQZoiV0eGEs5wpb6j2D/qD/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwDKTTQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwDKTTQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD261F000FF;
	Mon, 21 Sep 2026 02:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789956462;
	bh=Yle/84uMloMl4i1MCYKaQMDXWcs+X0GhI+Tf9bq4uOc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IwDKTTQCuxTr1EsNM8BoFbvxsvzzmTevaxa/stOLnovjSY5bHcgFyyeMMywAUlGzl
	 Z3LONS2yItV24JXpq4iJJ+tPyLufKYVh0q/KPFzxxXwvKBGU+IHXuBUBJi4EO4/zHj
	 wohVTZB2bLVD2jH70bOf3C74PrZLe8RXotzmcaqw+fiDhPJj0+oRslI3WysEWTjuKS
	 5gAa9XzNx1ToXXxoUYAjyQztRJrh+6cX1ScRgzXUtQjwEP2mrWMETpns5CI1q+7YH/
	 U/25QkwFH/+QRXG30eoBC+tFCQEuPlYR/v7ewhgdtmg9nIh1BnwKHTgrAQYCH7jUW7
	 1cbYKADzUQ7sw==
Message-ID: <f5d8703a-466f-4fe9-9aa8-492970483018@kernel.org>
Date: Mon, 21 Sep 2026 11:07:39 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20260917 and next-20260918: merge of the block tree breaks
 all zoned devices
To: Tao Cui <cui.tao@linux.dev>, Mark Brown <broonie@kernel.org>
Cc: linux-next@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, cuitao@kylinos.cn
References: <20260920125846.1806521-1-cui.tao@linux.dev>
 <20260920231226.771a0e21@canb.auug.org.au> <aq_5QycDLgQGCc86@sirena.org.uk>
 <d97685b3-f22c-4a27-a7d7-24b2ac7dfbe6@kernel.org>
 <7141040b-5a15-471f-9bbf-9a18bed864e7@linux.dev>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <7141040b-5a15-471f-9bbf-9a18bed864e7@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/21/26 09:49, Tao Cui wrote:
> Hi Mark, Damien,
> 
> 在 2026/9/21 06:37, Damien Le Moal 写道:
>> On 9/21/26 00:18, Mark Brown wrote:
>>> I did say when I did that merge that I had no confidence in it but
>>> nobody responded.  Can you please send me a commit on top of current
>>> -next which fixes up the resolution appropriately?  I can drop extra
>>> fixups in relatively easily, it's probably safer to take something that
>>> you have tested.
>>
>> Mark,
>>
>> My apologies for not replying, but I was traveling. I had looked at your
>> resolution but only quickly and I did not notice the incorrect comparison
>> causing the issue.
>>
>> I am attaching a diff that cleans up the conflict resolution.
>>
> 
> I tested Damien's patch on top of next-20260918.
> 
> It restores the zoned null_blk here: nullb0 is created again, reports
> host-managed, and the queue chunk size is back to 131072 sectors
> (CONFIG_BLK_DEV_NULL_BLK=y, "null_blk.zoned=1 null_blk.gb=1
> null_blk.zone_size=64" on the kernel command line).  So this looks
> good to me.
> 
> Tested-by: Tao Cui <cuitao@kylinos.cn>
> 
> One question for Damien while looking through the merged code: both
> parents had the power-of-two check for zone_sectors, but that check
> also disappears in the merged result.  Was that removal intentional,
> or should it be restored as well?

Doh! Yes, you are absolutely correct.
I am going to do a manual merge to generate a proper conflict resolution.

> 
> Thanks.
> 
>> Thanks!
>>
> 


-- 
Damien Le Moal
Western Digital Research
