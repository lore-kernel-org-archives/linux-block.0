Received: from smtp.smtpout.orange.fr (smtp-72.smtpout.orange.fr [80.12.242.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48E633CEB3;
	Tue, 16 Dec 2025 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765908152; cv=none; b=nuXKw8V/v+10XAxTE1RT9w4e8bVGYx7KQb8IR7rNF8bNm1ecZXfPob28EdcD2EY/ypUHK7YLBZD6wXQ/he/mSKoCflJBIzWuAb96nx25zlgRwJb7ZpTrnZ0CyWN13Y4DigN4eEOfx8WUNPvAeahLRQQnZCtLk6Yb1O9CoZskCWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765908152; c=relaxed/simple;
	bh=u9Hesz0/mm0oSbfTyG3DQXeTJarLNKxQpPAUof4suac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjWLAty9zmAs1uj3uct9n/Nzircs8fqJDQSZC7FtwwMXVoBSLTPBrS1Ct6xFUzhRW853PsQiE9phWu6+05572yHXJ5mLWFX0rbB6VHbcDnI3Sze2PzZpJ6RvmifL+8sUIE4XMe0YTmD2pIMqqyZ6ot0GbbXuifzfyZzW2YvjIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=I+B6nR6+; arc=none smtp.client-ip=80.12.242.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="I+B6nR6+"
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id VZNJvItZVud1nVZNJviOup; Tue, 16 Dec 2025 19:02:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1765908138;
	bh=RYEpVeX59LNjXn70ptAhez7KKcVcWKxgwFC7yPzE55g=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=I+B6nR6+2nBkuNsIe1KZYZnACsSH7uyU9E2Gznm8h95fO/EXvJe0E7PNGpuM8PGyh
	 SxCZxHRb1QQ0W56Ebdz5Cw9Nq+VITINQxdcBhwmpdaPI/HEuSXvHrDhyD0CVd0/FR4
	 R9iMxRD0oN4nQE6na3tp38rNy7BkJIA+AQAm6fnb8te3HpL5ITXHcAmXXA+HiNhLvm
	 AVtk4mIN44GRKPB8iI1gw4Hgl9L22RfaCunD3LIt7Jv0qlhfFY69dKxYbOqnF8gC7D
	 iO+QgQjEo6ZqiejEDODARuNJwJ9I6sJWCW+demHKFUotlyQliLZy9Nghda/xCRus26
	 9rWAokxz111eg==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 16 Dec 2025 19:02:18 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <4d7c06fe-9905-4872-8e78-08c7423dd1cb@wanadoo.fr>
Date: Tue, 16 Dec 2025 19:02:16 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: rnbd-clt: Fix leaked ID in init_dev()
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>,
 Lutz Pogrell <lutz.pogrell@cloud.ionos.com>,
 Md Haris Iqbal <haris.iqbal@cloud.ionos.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251216172203.48947-2-fourier.thomas@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20251216172203.48947-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/12/2025 à 18:22, Thomas Fourier a écrit :
> If kstrdup() fails in init_dev(), then the newly allocated ID is lost.
> 
> Fixes: 64e8a6ece1a5 ("block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>   drivers/block/rnbd/rnbd-clt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index f1409e54010a..d33698eb428d 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1434,7 +1434,7 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
>   	dev->pathname = kstrdup(pathname, GFP_KERNEL);
>   	if (!dev->pathname) {
>   		ret = -ENOMEM;

                  ^_______ here

> -		goto out_queues;
> +		goto out_ida;
>   	}
>   
>   	dev->clt_device_id	= ret;
> @@ -1453,6 +1453,8 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
>   
>   	return dev;
>   
> +out_ida:
> +	ida_free(&index_ida, ret);

This does not work.
'ret' is being re-assigned to -ENOMEM before going there.


But there is definitively a bug to be fixed.
Maybe by assigning clt_device_id earlier and using it in the error 
handling path?

CJ

>   out_queues:
>   	kfree(dev->hw_queues);
>   out_alloc:

