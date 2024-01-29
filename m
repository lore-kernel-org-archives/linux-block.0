Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7422EFBF7
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 02:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706497176; cv=none; b=I34bHbTsF9XIkQEhtUoubcFH9qfqvy811oJzESOTMdlVLD1khNutP0OsFBncHJjax6nMd9eKl9FrHHXLw4vL6uY81Pkx5Oi04xJx/YP3sQZijNmLGkfuJLnLEUhDyzbWZaeUcD//lEmggF7qqYFx9n0FIql96InRjSBhc8lJ274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706497176; c=relaxed/simple;
	bh=DZUg1XoT8wokjq4uWFSKm1U2glAHD2r08GSBb58s88Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwbAP0JfkFomMOoXdBuaGFor5ar+DtgiJhf3cSayH8dTG1k9o0OhsCzfMW0fj6MHU1ybFe9uG2h79VSW0yDD685VHQM3c4b9CSI08iRzTtBkztCFMNA6NZyjbPuVIbj+xIH4fh103F/hmzfpqdGDbLDvO8Y8QEJ0hU0SYTHvEgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d7393de183so8666715ad.3
        for <linux-block@vger.kernel.org>; Sun, 28 Jan 2024 18:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706497174; x=1707101974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2srdy/gEkxZEQX8yqvPWjPa+KiI9RaTtwGAFirYHPc=;
        b=F4Jx4kOBptm41hpXpF32BS1V+JDfzeDHlb3u1/6H23CKgEM1c758kZZeTitmxDLheI
         lOjrs3ye4W2iev2+aV+8upXsrblwMTpI8oaQLvmmWjJqM2p+IpJSJjlGDBeaydgOCeae
         kcqGEllX3O31IIQSM9iH+IRxfnVLmrkseWjmd2OkRX+dbkVK5oovRT/1M8EdKjEMc9w0
         AKj0D8xCqxdSFYO+QUrcvLsI7hdbIzU31Em9q0Us72D0aQrV2Sj7RnBpV2jsWTiVu1+c
         622W8hKqbSa3rzMIMizoUP5Eq7/TafS+Cr6EF9Qd9izThaZaUsmT0tLZZtZgVoqRXXw1
         Lx9A==
X-Gm-Message-State: AOJu0Yyegruh2CSxvSoLVxUs82Exfn193A4MxKXs0YnRNLv+p8v8+2+T
	mz28obRum//vVbqmKu4Vj6YE0aairfahDjniAuZkVBzC2KeDiC9W
X-Google-Smtp-Source: AGHT+IHLzWKpOpr3cILvZHyHMjuA82VdDmKya3ofyHQ2fh7NkcXPc/ZbcxRl9w9fzz4kk68FVx7Wdw==
X-Received: by 2002:a17:903:246:b0:1d7:147d:6a1d with SMTP id j6-20020a170903024600b001d7147d6a1dmr2077904plh.55.1706497174501;
        Sun, 28 Jan 2024 18:59:34 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id z2-20020a170902708200b001d89ed2d651sm4239317plk.102.2024.01.28.18.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 18:59:34 -0800 (PST)
Message-ID: <df263948-07e0-4aab-a645-ea401d4d413b@acm.org>
Date: Sun, 28 Jan 2024 18:59:31 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] block: refactor disk_update_readahead
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev,
 Hannes Reinecke <hare@suse.de>
References: <20240128165813.3213508-1-hch@lst.de>
 <20240128165813.3213508-3-hch@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240128165813.3213508-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/28/24 08:58, Christoph Hellwig wrote:
> +static void blk_apply_bdi_limits(struct backing_dev_info *bdi,
> +		struct queue_limits *lim)
> +{
> +	/*
> +	 * For read-ahead of large files to be effective, we need to read ahead
> +	 * at least twice the optimal I/O size.
> +	 */
> +	bdi->ra_pages = max(lim->io_opt * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
> +	bdi->io_pages = lim->max_sectors >> (PAGE_SHIFT - 9);
> +}

Would this be a good opportunity to change (PAGE_SHIFT - 9) into PAGE_SECTORS_SHIFT?

Thanks,

Bart.
