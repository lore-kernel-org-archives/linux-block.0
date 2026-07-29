Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D6D3B42EA
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322193; cv=none; b=odkSU37yIx+3peQna5QeseRBpbZsplI8+PcxGKWkIEbqHwE2PDSFdH+7zaRaw+lEJFXr1wc6og1kJZpR8OtXxRjDgISbaUSLx0PABE/eFLuWEfrQ65VbDg+LBvDZTjspuINKFcp1Hc+iu/46yURFqTCpGa/kxvM3Zq/mNdJXOG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322193; c=relaxed/simple;
	bh=iNi2nFSA8g81W+/HnLXlWmnLlyUILEZvQTRGox6oYII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfyYs83yCvq608GKmyxWqemunlJGfa9CxlVRGa36JHu5mZU05UDDvPh+dXIqVnrRiorHticHYf8/C+9XbfyTVBGQNaMdAMAlnSxZvMVbzUH5jMC7WYH2+cWhkLslwpIlVqafTBRROhSWICZCm9UaomRH6xMS/sxBmuQQY/kLO6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s6f7Plz8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6f7Plz8"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15b1da6b82so79999766b.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 03:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785322187; x=1785926987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3xVEH4RvIZup14rRYV4Zvxl83sd+HTGGj/jXhd9ySH0=;
        b=s6f7Plz8hCZXfh5yIrDR0xQ3OAAJW6lfJ2nNCx9b0/4iAG0GjMrmw0T2rVHZYMI3hC
         ogOq+pzXWmy0m4piruY/4MCQ6T5/GjyfZFStJ+gYah5OmM+m1d++9jRz/weyos5l098f
         FKfMfTpcSM/RQ4KFk7bZuZtsZrdsse0K1beCRAdbe3KejCBQse+RNHSN7A/poayBldUY
         qHhGuPV6sNvmWF3VcHF0EaKge4A0A3Ypobo1f3LEr7c7xqOluLhscdDkMdcrVLONA7yh
         GeN3q6i/ptpHpfZ3AghdpxRH9Iqg/z4mdXe7W5VY1LoT6bi8nFV5VNT3iV8ElLNkLJbG
         UoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785322187; x=1785926987;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3xVEH4RvIZup14rRYV4Zvxl83sd+HTGGj/jXhd9ySH0=;
        b=OXEsjft5pWyKbZb57nhCiIn4rhOePHL0zPsOWsRn4P/j/Plv9JzDR+XRCVF0JXV0ns
         5RbRZxW5WuV5yj9kVCzZwDq0Ei+xE34XlB6RwleqeOK/dQ9teWRAdIRwv3P5bB/pggU4
         MuZgTrP3hicrm45YZlYr1CGd6ulWciIHjzO3JNQiEBza4Kz5dKFfBMj97sSRytWtjDAW
         gpXvezjP58CXehSpSEkRyJqpFfGt3oSzarFQshI8By6CVkk+pPGL92KtrmYhrdtTDUF4
         4DwOeq/4o/WbqpyOrTByHcEaDkr/E0dnfenx4pA2bRedr6jsDf0NwB9KlB4nH2o84Txm
         gsnA==
X-Forwarded-Encrypted: i=1; AHgh+RpSafmSfgocWpFjUErKrC8B+ulV7Z9mBsvKZoaVZ8qONOzL/g2GfTarXVCITcOM8UsTenVxaNyk494vdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpATWoQLWELa5xEosQJNq6FPJP6y5JH5oNOZXh1kHv6nqwm/OC
	/VXCR1eBh+lKFMnHiQwPf9SwpjiFzwJOYSTMBWZtiCPXcNJ10gK7NL6W
X-Gm-Gg: AR+sD13MPPyp0f4rHOr7CHhg2g+BmBPvd5O0pyoxBEaTbVZhfTJJKsimlESen8YU7qg
	B1zUCxvrCaCauk2VUQXwP75sCjrsKS6KuFhSheLnWf/DYbOzL/XZHDQMzDasWtlLGuPobMzig8e
	RWmND3TUihr0aV7q65loXi6D1SId4ibA9B8mi69xK82yrXYQU3EzPnFluEkFIVggKmlsCKmvUJP
	VjoAtZblXsWQFXHSZPLTYI+eGkSa+rv6h6ZvlKwygt7G36F7OkwQwcDD1IXGBh9q93XEceGciya
	QY+NNslqiGgIJ73AWsAU/QHWZSyqKwLiA22XLmLNN4fjnV4/7hdjwjSpE94oL7OsN/Ol5g6gFOC
	+xkSR1GdaAwPks8Yly/86SCfLkbBsucM9xfJw6D9jBekbnymGLK1zawiC0C5EtgyCP849yE+THp
	v/ExXJfm8XJ5AL4S8l6Ulztr7WrHYtLQcgPiEE+9IrSUuiu+hdcPts2mYyUxdcWkVbLQXxJV5At
	gm+JYArtfy49beyzXlVum/vnH+Ggy0t58xuFlHMnBZZPYJQaOGVqdr4sgI8noR07BLm3rjhG7+V
	3smmzfQ5M7gfUcy3uMHeLEWNf85frw==
X-Received: by 2002:a17:906:fe47:b0:c15:bea2:d209 with SMTP id a640c23a62f3a-c1f7215dee1mr299738366b.4.1785322187169;
        Wed, 29 Jul 2026 03:49:47 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83d27f47sm97965566b.26.2026.07.29.03.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 03:49:46 -0700 (PDT)
Message-ID: <c81be43c-2fe3-4403-b8a9-dd19855eeb58@gmail.com>
Date: Wed, 29 Jul 2026 11:49:36 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/14] nvme-pci: implement dma_token backed requests
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <19e5c945ea8114320c10f7951d19197d48b59249.1785274111.git.asml.silence@gmail.com>
 <20260729071048.GH9534@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729071048.GH9534@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 08:10, Christoph Hellwig wrote:
>> +static int nvme_init_dma_buf_io_ctx(struct block_device *bdev,
>> +				    struct dma_buf_io_ctx *ctx)
> 
> Please stick to two-tab indents for function declaration continuation
> for the nvme code to keep the code easy to maintain.
> 
>> +#if defined(CONFIG_DMA_SHARED_BUFFER)
> 
> This should be good old #ifdef.  Same in a few other places over
> the series.

Going to apply both for v5, thanks.

> Modulo these minor nits the patch looks good.

-- 
Pavel Begunkov

