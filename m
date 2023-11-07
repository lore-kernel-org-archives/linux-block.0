Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11512328D5
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FmC6ZS3r"
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2297AB3
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 07:05:24 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66d87554434so40143116d6.2
        for <linux-block@vger.kernel.org>; Tue, 07 Nov 2023 07:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699369523; x=1699974323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zQkRUxp/qdG+mcqyz+AwKHOCtNKbDsz1x2+FtX/ZT2k=;
        b=FmC6ZS3rgh2v3az8ahjpxsKchW6HZObnAuKA2JeZa4bog5qXX5tFMmpgI8t1LiwkDe
         DRXE0nXZvginlZttYn7W2E1j59g0ia2XHw9IFhDNZ1ct++Z6fKbGpWDAq+tgi2NL++Lk
         1JTU8Mo6+saijEM+P/iYjewovJ0bwpDgHV2iv1sXHtge9C80Fsqnw8rh5/Mi4M+PO9t3
         rDxp7VAnhbSilvtL5Ka5BE4f9t3T3J5/qfdz7ZP7oFip3tOMmnT+rpnIPXaFxWNwvQKY
         sbKkHTnDdiMLcd1YzFtt3zdATwyKmjgB8Z1YJKUCCQz6IBtpSNCdVfqHIlTCPpbVk631
         XRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699369523; x=1699974323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQkRUxp/qdG+mcqyz+AwKHOCtNKbDsz1x2+FtX/ZT2k=;
        b=AKHy4FDttEZFnwOMPs1pKBqCaBbj0Xsmi8Lu9vHYA2Pb9Q2I7nxn9v1dDjn3hjjfxb
         dkuS2h2K2O5IL/iPxe4Q2L1E05b7LiJRgQeoIQKYV3rntm/56QOX2Fd5gOzmOmNDaXXw
         FNgE1mp7ApDu2kljPFwK8JcQwUVWA022y/IUeW2aLp0PRcMc59MfygCZQiNaICHO1q31
         UOz3XpGIq6xigMBF29Wvn7T6ptff60bWo8vUaXNv+5moZXkZnEum8WioD8mBa7qgH23Y
         srqS0G2crSHHzO/D+Ijngi9BVGsoyCzyqIl4IfTb5HDPKmkxWtavqS5TMf0+5eKM8mgU
         DLbw==
X-Gm-Message-State: AOJu0YwWa1uUKo0sqdpa6CBkwJqgqYmqJoD0cMFNJTvPQs2HtT0P4yn8
	OGOhQTlkyyPIY2yAJ0sSzWurCw==
X-Google-Smtp-Source: AGHT+IEabMSzZhzNJnvV8OfKHuh5oG/MF4IuVEHRT7Fo18Mvt+izrWP08VqFjmSyWeotreAUOrkDnA==
X-Received: by 2002:a05:6214:2465:b0:66d:145b:4591 with SMTP id im5-20020a056214246500b0066d145b4591mr44234443qvb.27.1699369523061;
        Tue, 07 Nov 2023 07:05:23 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ev20-20020a0562140a9400b0066cfbe4e0f4sm4414806qvb.26.2023.11.07.07.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:05:22 -0800 (PST)
Date: Tue, 7 Nov 2023 10:05:20 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, linux-block@vger.kernel.org,
	nbd@other.debian.org, axboe@kernel.dk, chaitanya.kulkarni@wdc.com,
	yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, lilingfeng3@huawei.com
Subject: Re: [PATCH v2] nbd: fix uaf in nbd_open
Message-ID: <20231107150520.GA3913709@perftesting>
References: <20231107103435.2074904-1-lilingfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107103435.2074904-1-lilingfeng@huaweicloud.com>

On Tue, Nov 07, 2023 at 06:34:35PM +0800, Li Lingfeng wrote:
> From: Li Lingfeng <lilingfeng3@huawei.com>
> 
> Commit 4af5f2e03013 ("nbd: use blk_mq_alloc_disk and
> blk_cleanup_disk") cleans up disk by blk_cleanup_disk() and it won't set
> disk->private_data as NULL as before. UAF may be triggered in nbd_open()
> if someone tries to open nbd device right after nbd_put() since nbd has
> been free in nbd_dev_remove().
> 
> Fix this by implementing ->free_disk and free private data in it.
> 
> Fixes: 4af5f2e03013 ("nbd: use blk_mq_alloc_disk and blk_cleanup_disk")
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
