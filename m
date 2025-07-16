Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D064243969
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 01:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629982; cv=none; b=H7Hngwou3MR0N8vlRel0XGdNgqGcstuhHlRury6AsrKcG5BRv9jbLEGCIk67y1uyIlFL/1gXwt2icWLg1lfp++3tRlOQGDPIBPIBIz/bny3zyj2szEw1LykpBdJav6RwwYEGXOjBdrTIrpbB6XH5Zxm1mNi21dFWRRzjekU1+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629982; c=relaxed/simple;
	bh=s88Bx9r33u53955d7WA7N8FNaSp1ZTh3oDWAXJH1h2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GawRq+B5FswJhKHEeyII1hxI9Wq9Ati9k2zMWyx1TkaEmvhVrbeP11E3KPStOrVO+CqpRrsOrQkJM5Z15OLE/v/4sjH4/jIwDdMr42edLfsv68r0jfM9WGfkX5FKociZDELatlruxY64yurmIuS/F8BuhoE0zG6l9/D1P+bHgsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t84H+nYh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t84H+nYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CBEC4CEE3;
	Wed, 16 Jul 2025 01:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752629980;
	bh=s88Bx9r33u53955d7WA7N8FNaSp1ZTh3oDWAXJH1h2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t84H+nYhEmx+SN9Wyn5EuGOJ5we6YpCJlebg/xvzA/1akAvatC51DWaN5K3V2lf+w
	 3L+16dSroSpgHuVYmGedOlFlJBhrksJFcNLm/UTEtMLT9KNaRF6DLZ8WdK+qiollp1
	 CTAmaHpejJlHFGb+laN+vrtccIwGQ9S7jdnjUVdxT7pVj/3F9Hn3tdbcAclFNIVdXs
	 qXPNrhqwhlntvc/Wqul6pvnGIyNRGUTVwHaOB5jcWR8vHHVHYKNy5QoK7YcTFBdwM0
	 RuXamFkfDDP88NBKSMgog2Y3c+4x1/4r4+JEIX/xcvpxrkb5gagwlYcSD65LBYcm8R
	 xv8O0A6/q5IwQ==
Message-ID: <553da2c7-3c6c-4fd7-aac4-743577447f19@kernel.org>
Date: Wed, 16 Jul 2025 10:39:38 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] block: Rework splitting of encrypted bios
To: Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20250711171853.68596-1-bvanassche@acm.org>
 <20250711171853.68596-3-bvanassche@acm.org>
 <20250715021810.GA426229@google.com> <20250715053735.GA18120@lst.de>
 <20250715061117.GA595531@sol> <20250715062112.GC18672@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250715062112.GC18672@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 15:21, Christoph Hellwig wrote:
> On Mon, Jul 14, 2025 at 11:11:17PM -0700, Eric Biggers wrote:
>> I've actually been thinking of going in the other direction: dropping
>> the support for fs-layer file contents encryption from ext4 and f2fs,
>> and instead just relying on blk-crypto.  That would simplify ext4 and
>> f2fs quite a bit, as they'd then have just one file contents encryption
>> code path to support.  Also, blk-crypto "just works" with large folios,
>> whereas the fs-layer code doesn't support large folios yet.
>>
>> But that will only work if blk-crypto-fallback continues to support all
>> block devices.
>>
>> So, effectively you are advocating for keeping the fs-layer file
>> contents encryption code in ext4 and f2fs forever?
> 
> I think those two concerns are almost unrelated.
> 
> Dropping the fscrypt code and relying on blk-crypto is a good idea and
> should be done.
> 
> But at the same time we should stop pretend that the block layer will
> handle the fallback, and instead require drivers to explicitly support
> blk-crypto either natively or the fallback, and else fscrypt or other
> blk-crypto users simply aren't supported at all.
> 
> Note that with something like this series from Bart all drivers that call
> bio_split_to_limits will just support blk-crypto, and that includes all
> blk-mq drivers and device mapper.  So without further work you'll just be
> left with a few random drivers that almost no one cares about left
> uncovered.  If someone wants to run fscrypt on those they can wire it up
> to manually call into the blk-crypto fallback, which should not be hard.

Hmmm. Device mapper does not call bio_split_to_limits() in general. Exception is
for zoned devices (patches queued up in block-next). But it should be trivial to
add such call for all IOs if blk-crypto is enabled on the dm-device.


-- 
Damien Le Moal
Western Digital Research
