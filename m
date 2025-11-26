Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8282F7ADC
	for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152082; cv=none; b=IY2x8G530z+noH7qOVMG1ZlpGURIEJ7X78B9sd+Hz6+bhI9koScpRNo5HMffmwzQX6YAJ9YAJp8CsWCJct60cwMMViLgIzF58iJPxmljvvcXHkOPBO61XXlJ2sJsGnAYv4NRPb0vrD/4FQH8c+iWTvg+U6zJP+HaOS9SutAu+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152082; c=relaxed/simple;
	bh=J+H9DXT5OBV9m6l8dZrD5CNRbbY6UAu1yGdzlonCIWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EoaDc92vwNk0YxEgBFTcnULSGxAFyjV52LeGcUCBhgPebPXCAAIXa9bE2ux/1lKKbXu2mggegW3D15ghunafrn8EvYFNsLeXgD5Go/d+0sW99fHAdiR2VAQcXeMT81A8pdHCPQ5WdDwU+hcMsMb20e1HZoQa3E56YF8ECiRvwQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKGA0L3B; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKGA0L3B"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-343ea89896eso6617751a91.2
        for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 02:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764152079; x=1764756879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wi+SDeiIoLJQ2kckUqTjOMqCDPLpLNM9S07CFUmnZ6s=;
        b=WKGA0L3B057Gzll6INdvfCucFox8sUOKbK0/xptzAEm1CtM9N4d2y1HnTsntkU6aex
         QwULs9giNnQJgj0lLAwf6jb9TMdh8rhIrhxj2ZBk8VWIubRFMN5IEYLHsGExA7rqfoT8
         IqbcmzFzuRYhb3u54QqtQ/3Z3aGPoMznKVorGwct82G2lAihPCezhij3gzVE+Mm39slW
         89ipbSmYhJqZ4VVgA6mvg8+I2YnZnE9zqFEjiTglC8mrfX62oELo1kejbqZGdz1DnV4Z
         te5AyAaA4Xse9d9F332mXtoOz7T5uK74nTxGY0pae7my0MYBsMVTWhQRCSu902mvILRG
         vxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764152079; x=1764756879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wi+SDeiIoLJQ2kckUqTjOMqCDPLpLNM9S07CFUmnZ6s=;
        b=C6o6rxmT3v7NibkHYmbRHBGoXxVJ0m7SDHrbXsNx8g+VqNrs+6/ZxHLuh4aGifTaoq
         4nB4vCe/l2m5067TJtpbRV+nPMSg7aK92d9wknXRzLro7g4jUqdF1RhPRGIyb1w0xXY0
         tQc7uAhcTt3d9j63h4A3phlhpMzF0SZsfz3YUdu5r0ZTeqbGcs76mhOicu/0xQqxE31E
         PnVt2TAnnhrRMXQ0iRlR+o0dpqpCdh/mWE81fs2pnfiuEpZFkhbjqhQfqV/kVGh1nQ7x
         0hGre/mMPv+YInj76o1ss6lGkhYb0G8IaOgKh8R+2OlODzeZVPmU6qrTQqijiiJ5jM4X
         aQ4w==
X-Forwarded-Encrypted: i=1; AJvYcCXqR/hD3YBAxA/hHaZpKoXqUJBqJOKcMhVpax7JS52lv0dFIyZkJDMKQESRTxZwPJND0NkOTVS9ZZ+UhA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiz9QiCH1qr/uySFO+J69/+AApRsXO9pd3FILmS6MzxYGgWmKf
	Kh79GorvRk35LGc6kxTD2PmgWgECvNDepxzvvzBDRecSLslj/RmdRyNH
X-Gm-Gg: ASbGnct6cdadi7SWsT8x7l84W1m9HAX8XahogHzcI72dDLepnuCj9Q+PVvRu28D6wUr
	6+dsdBjHGeSemNm7aoNnDiCEirkZKMJWgK36CwwLZCVc3spIlWqo7b1IrtzH8zhux+SseFWEBOJ
	cTvJaviUx4e2jXdT2nYcaCabGboOaVuKuegIucrxw+EWiyoe5Luz0xDGMNkp1id3S9XBIErl7eB
	+cTLVZ6vqqn+Uv35tdEplc09FvuMopMk/2zAtPz63TpiKDTzhi/v7BP61slTKi4j05zKVdP/MrT
	2ZgMQCI2zLwGPgoCbunxOY++RPrCgf8rSsTknXnoC9K0LWmidwELLrhA9XJ5Hh4xEhtXVbOMtQW
	s5sDcjaMkdJ74EmzulCFOXPhA+ZpNIxZGYm8/nvc8EDSy8Jq8mEH6s93wV6E2dSy9zY9wE4dBmo
	aKsQUuQHHuVEWeu45ycmhphzklpjscMw==
X-Google-Smtp-Source: AGHT+IFQEabv4PNtolwpa8n5AuKpK1H58aTBlKZdu0dHQlwrZWrJMaYnh5FBOmSumqqz/nyBBS5z/A==
X-Received: by 2002:a17:90b:1c91:b0:32b:df0e:9283 with SMTP id 98e67ed59e1d1-34733f3e84fmr16715848a91.34.1764152078789;
        Wed, 26 Nov 2025 02:14:38 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63dbcsm20905512b3a.50.2025.11.26.02.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 02:14:38 -0800 (PST)
Message-ID: <e40cb47c-9f92-4982-bf3f-45ec9f2a1681@gmail.com>
Date: Wed, 26 Nov 2025 18:14:32 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH V3 4/6] nvmet: ignore discard return value
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
 agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org,
 yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org
Cc: dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 bpf@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-5-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <20251124234806.75216-5-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/25/25 07:48, Chaitanya Kulkarni wrote:
> __blkdev_issue_discard() always returns 0, making the error checking
> in nvmet_bdev_discard_range() dead code.
> 
> Kill the function nvmet_bdev_discard_range() and call
> __blkdev_issue_discard() directly from nvmet_bdev_execute_discard(),
> since no error handling is needed anymore for __blkdev_issue_discard()
> call.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
>   drivers/nvme/target/io-cmd-bdev.c | 28 +++++++---------------------
>   1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 8d246b8ca604..ca7731048940 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -362,29 +362,14 @@ u16 nvmet_bdev_flush(struct nvmet_req *req)
>   	return 0;
>   }
>   
> -static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
> -		struct nvme_dsm_range *range, struct bio **bio)
> -{
> -	struct nvmet_ns *ns = req->ns;
> -	int ret;
> -
> -	ret = __blkdev_issue_discard(ns->bdev,
> -			nvmet_lba_to_sect(ns, range->slba),
> -			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
> -			GFP_KERNEL, bio);
> -	if (ret && ret != -EOPNOTSUPP) {
> -		req->error_slba = le64_to_cpu(range->slba);
> -		return errno_to_nvme_status(req, ret);
> -	}
> -	return NVME_SC_SUCCESS;
> -}
> -
>   static void nvmet_bdev_execute_discard(struct nvmet_req *req)
>   {
> +	struct nvmet_ns *ns = req->ns;
>   	struct nvme_dsm_range range;
>   	struct bio *bio = NULL;
> +	sector_t nr_sects;
>   	int i;
> -	u16 status;
> +	u16 status = NVME_SC_SUCCESS;
>   
>   	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
>   		status = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
> @@ -392,9 +377,10 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
>   		if (status)
>   			break;
>   
> -		status = nvmet_bdev_discard_range(req, &range, &bio);
> -		if (status)
> -			break;
> +		nr_sects = le32_to_cpu(range.nlb) << (ns->blksize_shift - 9);
> +		__blkdev_issue_discard(ns->bdev,
> +				nvmet_lba_to_sect(ns, range.slba), nr_sects,
> +				GFP_KERNEL, &bio);

We also need to check for memory allocation errors in
__blkdev_issue_discard(). However, this cannot be done by simply
checking if bio is NULL. Similar to the issue with xfs_discard_extents,
once __blkdev_issue_discard()->blk_alloc_discard_bio() succeeds once,
any subsequent memory allocation failures cannot be detected by checking
if bio is NULL.

Yongpeng,

>   	}
>   
>   	if (bio) {

