Received: from mta-201a.earthlink-vadesecure.net (mta-201b.earthlink-vadesecure.net [51.81.229.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54924503B;
	Fri, 18 Jul 2025 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.229.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859465; cv=none; b=FqbBD240OE2Yrjr7nqZhiHWGYbi+3wZXJ+JR1u310KXk4Ilnx1nWilC3NqD4FW7xyE+PILHjpzKcxModvwRpFO8y/RPJTs2gKkJsR+xo8aUJuXQFlSdOdjgoXT2NfIBHDdap9SOue7nbkC480RyF8jFwzKt8tRtpWQHbePiks20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859465; c=relaxed/simple;
	bh=otYy1UEiVgHf4LIkzboerdXtBrlHV0PWRH/XrvpCLFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DwWN+51JtdtvKdQPWWccqkO0cTBVDL3+/LJOHdRX3+bjHFePynEBp8Bq0aoG5tNzuEBpO6motDkIUd6fN0n71cJmWFZtQe4O8a4hIiJ9LBet7Vq5zQIC4TvE9NPecc2pSKLyAcB7Fof/120Svsanax6riOfjMM3oC/Usv7g/ke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com; spf=pass smtp.mailfrom=onemain.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=amSJp3bZ; arc=none smtp.client-ip=51.81.229.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onemain.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="amSJp3bZ"
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=svnelson@teleport.com smtp.mailfrom=sln@onemain.com;
DKIM-Signature: v=1; a=rsa-sha256; bh=twYr9tRj/eoAzQJKd8YiYgLFQ6ZpKavDsDx8C+
 bNt9Q=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1752858544; x=1753463344; b=amSJp3bZhnpUrxsHCIE2Of8bWii
 iepbZSqOgSjEHmCTNufrZfF7HYidLklFsMupwh/EkpJzHU9GkMNEdgBN4rT4MpQvFHOViBD
 PdxxAQqH3E71xYna3cYlwOqqNbWP4/fAukXQyAwU0MOwUkNYSpUs5aPZWL0iuOaFaEwd2DB
 IUkgc0pFZOiS63+geH1aD6prX82xve801DNK8MBJhRW/yWK/sTWWMCRYub7r92iEOsf6jdl
 L1ppyRm6aAsp/mnkiv+weKovir8wZdzbzAZg+OFsOJD3vgRs/karzoPpsoM9Lxu/JlixrCw
 ko0GHzAqPSN23clwg0KmV98KxJR0oAw==
Received: from [192.168.0.23] ([50.47.159.51])
 by vsel2nmtao01p.internal.vadesecure.com with ngmta
 id 1028f515-1853678ea2cc4994; Fri, 18 Jul 2025 17:09:04 +0000
Message-ID: <20af2368-beb4-4b99-bf53-a773aee92744@onemain.com>
Date: Fri, 18 Jul 2025 10:09:01 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sunvdc: Balance device refcount in vdc_port_mpgroup_check
To: Ma Ke <make24@iscas.ac.cn>, axboe@kernel.dk, Jim.Quigley@oracle.com,
 liam.merwick@oracle.com, aaron.young@oracle.com, alexandre.chartre@oracle.com
Cc: akpm@linux-foundation.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250718082236.3400483-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Shannon Nelson <sln@onemain.com>
In-Reply-To: <20250718082236.3400483-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/18/25 1:22 AM, Ma Ke wrote:
> Using device_find_child() to locate a probed virtual-device-port node
> causes a device refcount imbalance, as device_find_child() internally
> calls get_device() to increment the device’s reference count before
> returning its pointer. vdc_port_mpgroup_check() directly returns true
> upon finding a matching device without releasing the reference via
> put_device(). We should call put_device() to decrement refcount.
>
> As comment of device_find_child() says, 'NOTE: you will need to drop
> the reference with put_device() after use'.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: 3ee70591d6c4 ("sunvdc: prevent sunvdc panic when mpgroup disk added to guest domain")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>   drivers/block/sunvdc.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
> index b5727dea15bd..b6dbd5dd2723 100644
> --- a/drivers/block/sunvdc.c
> +++ b/drivers/block/sunvdc.c
> @@ -950,6 +950,7 @@ static bool vdc_port_mpgroup_check(struct vio_dev *vdev)
>   {
>   	struct vdc_check_port_data port_data;
>   	struct device *dev;
> +	bool found = false;
>   
>   	port_data.dev_no = vdev->dev_no;
>   	port_data.type = (char *)&vdev->type;
> @@ -957,10 +958,12 @@ static bool vdc_port_mpgroup_check(struct vio_dev *vdev)
>   	dev = device_find_child(vdev->dev.parent, &port_data,
>   				vdc_device_probed);
>   
> -	if (dev)
> -		return true;
> +	if (dev) {
> +		found = true;
> +		put_device(dev);
> +	}
>   
> -	return false;
> +	return found;

Don't bother with adding the extra bits just to get a single point of 
exit: keep with the existing style and keep the change simple.

if (dev) {
     put_device(dev);
     return true;
}

(and why am I getting copied on a block device change?)

sln



>   }
>   
>   static int vdc_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)

