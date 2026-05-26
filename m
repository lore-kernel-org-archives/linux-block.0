Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DBF3C060E
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821659; cv=none; b=QavA5HygPsTKAZGkDT2oMvWi6hDMxQeYTY8VLNCmDT4TeeIeJO2bSqBZ7Z8WhpL5d1+9Wsbd7torsPoEC0kuRaucQS0nQgpcq15ShTpH2VO6/rda9KWFkN9YqWviwVhM9sv8O/zYbsIeVHimpczAJGwgWTG2rgQWvMKnoCZSdzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821659; c=relaxed/simple;
	bh=FGzY0YZgR8w2b7dguwl2gBPZNAvUDtOzbOTH4ScfDGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfEuDia7SfLIXkIzY5r1K9DXlabZK7t1eKJWtZDqzW27X2CEIewXXbX8EXy3yaAWh/xBRPShWosmzY72CW3BZ73GK4HoTX44P7Maw0wfEZw6xK174JRTsJW6lnFwHEFca8qDD4VFvvx2q8eV272GgvWWwffeCKt+gqPjRgh5v3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oqsssk50; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oqsssk50"
Message-ID: <d8be2a57-c950-46c2-b9d8-120b6e53da91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779821645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3Yznr35imLD78iltYGodRDSkRLN1y+2M8xTF22MycQ=;
	b=oqsssk50FituQxco+7g6Pay5nenbdkws/tioe59bGvqYH3CpgNFF7mxxyVB9myqiIHjfQj
	1VwHS93IJPStk2MRBix+/PazEeLyM6rfx9ArxiX68Rzm4pJifqwTAqKbIIgVLG8z+uPvWn
	xLpXd2s1XaQvsvv2xZ+mTu8K7ruOGE0=
Date: Tue, 26 May 2026 20:54:02 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] block: blk-zoned: fix zwplug refcount leak on write error
 path
To: Wentao Liang <vulab@iscas.ac.cn>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260526141824.2293025-1-vulab@iscas.ac.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <20260526141824.2293025-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/26/26 16:18, Wentao Liang wrote:
> blk_zone_wplug_handle_write() increments zwplug->ref via kref_get()
> when preparing to handle a zone write. On the error path where
> blk_zone_wplug_handle_write_noalloc() fails, the function returns
> without calling kref_put() on zwplug->ref, leaking the reference.
> 
> Add kref_put(&zwplug->ref, ...) on the error path to properly release
> the reference.
> 
> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   block/blk-zoned.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 42ef830054dc..24b899663a48 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1503,6 +1503,7 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
>   
>   	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
>   		spin_unlock_irqrestore(&zwplug->lock, flags);
> +		disk_put_zone_wplug(zwplug);

I am not sure if this is needed. The code above adds the 
BIO_ZONE_WRITE_PLUGGING flag to the bio, which means the 
blk_zone_write_plug_bio_endio would be called which should then call 
disk_put_zone_wplug.

I do wonder if there are special cases when blk_zone_bio_endio is not 
called.

>   		bio_io_error(bio);
>   		return true;
>   	}
> @@ -1511,6 +1512,7 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
>   	zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
>   
>   	spin_unlock_irqrestore(&zwplug->lock, flags);
> +	disk_put_zone_wplug(zwplug);
>   
>   	return false;
>   

