Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A64B477E21
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573130; cv=none; b=dkMQ1ROFAsEZ7ISasiyCXHtfequTEF+oXzqBfOU7J5BU2pqxoruz5R4Hk8UVL+JzWUP4ahV7OkjYBfdtIM+4IOmmKcRqIcmiEgYUoAuudz0j0wly9ee8erpFHhL2L20IPqGk3IwYsFgGVcCfdh/QfBnhK3bhki0U75kYSLfvtq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573130; c=relaxed/simple;
	bh=ML7iINJjRH4Gzjw9niY8gGNr83rzlZiUCq+9OWPM3vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLOh2VK4C9uFqf2Ou0Z+XUpLfK8Ilc/V997t/rr6jIpQAM/mm2o8lVZnY83o1fJ10guk3VUoi5/hYGivQbQOahZDw3TG6gnvuBapEvMcPDPZ9aKchnPNJjn8klExIMjwmJaO4xiL29E/a+aBP6uswvojUZcUSL9lR6zYfNV2AsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6ffAm8E; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6ffAm8E"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso11841485e9.2
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777573126; x=1778177926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+sxVPeWzK/5JcscdkmY85m6FCWps4Q/alwynbpD7Pbo=;
        b=M6ffAm8E/r1bGQBMqCF1p483D6nCifjpf3Dvf/n5RLt7zojYsQeA4OkChPnvHkN1lR
         a/6W5fxkqPhlx1cTIQIvj+kwr/YERqxCSmggYnfZOmvTiFFIQ09v5D/CoEZBzgMO6W7l
         wn/udkFL9WkaeKjnCg73Jk9aWL+NBuCULSuqKPsA8/Rb/vS4o8DysSNwn8cfMAYzW6yd
         X1HitFTmsQJkPmyznFkdxs1S/tUG9VypPy0YaqJtPIN7czKDfbiZxZOTdZsnx619bJMN
         eRGaG4gfwCPfDx1J+URaLMlTdez3lJyDuydWgmUqksjNcPWygKvXXhxdpjRQ1PikurOf
         IqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777573126; x=1778177926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+sxVPeWzK/5JcscdkmY85m6FCWps4Q/alwynbpD7Pbo=;
        b=MPe9qgr9FOIeSX135+CztV7YBaDEQPsQNP3ZIYgZIxmKrP0DSkbid4qZuQKvT8ddWN
         kSfi9misnD+AMyhqyTEi/G0tOwILbiJaxv2tLM/260Gh11bsO2uTENRtnMGNyh1oa541
         WaGK79/WQctHSzUxMrnTubqFJLQGVeLeuI+KLb4dYpCjUkPEGXxC6lhsgQJ70B3jX1A7
         zFF8RskTZrbszOvxA16CCJmtIpsVm9MD4Vn9Zn+fTlA2jTgX1M4pq7kZSlRsa04TEOwt
         R4yH0N2gwxi2pN9EdfoWD0KkoV8IimR6rfxtGxZTuvc5drl/qfBSIq1Zfv78//LievKs
         yWoA==
X-Forwarded-Encrypted: i=1; AFNElJ+6rKGbVZcuXImXJpysuEmDyiLcfaqvzaeUEAGf408qDund9qPalWdxMfZ8CVyjFgFXf69fNrwalZ0FDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAay06cekizyVC3jqtUnCNyQD5jbINS9kbrGhPysL9bHrDaimA
	lqF5cvA0ER4uO13aXoc+kaWvJups5F4rTWRBH0SCTeg4cAIXsd8KnU5W
X-Gm-Gg: AeBDieuTJYJCdLn+vFAqjkvlaEletGGQ6bVl7gM7/St4NobO5HbHWrc28hPSvkIqEYq
	VPCLa03FMGHB9YKNGyr7sPGshi2YkyhjfwfV1uQIRYJnO/TlO6SjR8NVZ+qxf9jH1QDqw+5CKQo
	nuFeJ1qyiYvp3XbvUnWp825kNpnOH1rbCFrn9PRcI5KjWh4gwyoUiu25LOu8oFqL0DFPSEldwBZ
	HTE/EQgEDxdtWuiYySMloviSKOOMBtggfPikwEPN8FYE1YNeOX7qnkIYHxwTHKaY5R7Rcg5JUvd
	sVcKfvtxU8e2CVKsvrq1NMbncO59Vi4JpC9QSgNETw5aPVPV3hQhIsEYBAGlWsVWWI7FlpL/MKQ
	VAmhvaeK5wIDC/YPukkSyaPpcAmQhU58QiWAvnhHuB8waFg/1Uw8tUEHNJCijoXApgPITBrm+O7
	6h1xSRxg1CznMICGocIPRO4qeNMn6G9PxUVjOq6NiNEKeK2uQwRFySw29RBOXAXAlFGJVKuu487
	GDSxryDF+04XjLSP3ECnFtsMhA+/H7z1/MaqF6+SVQ44y2AMlWNsmhX+vPpc1SZeWBGNi4MDJVE
	7Q==
X-Received: by 2002:a05:600c:3495:b0:48a:5339:ef0e with SMTP id 5b1f17b1804b1-48a83d62ffbmr66464485e9.3.1777573126483;
        Thu, 30 Apr 2026 11:18:46 -0700 (PDT)
Received: from [10.109.92.8] (net-2-37-141-89.cust.vodafonedsl.it. [2.37.141.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8d15fdedsm3944495e9.4.2026.04.30.11.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 11:18:45 -0700 (PDT)
Message-ID: <7f091660-2e60-4de5-a3b7-7b8d206fd6ab@gmail.com>
Date: Thu, 30 Apr 2026 19:18:44 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] nvme-pci: implement dma_token backed requests
To: Maurizio Lombardi <mlombard@arkamax.eu>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi
 <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
 <DI5RO76D5IWR.19K0ES58HUIVS@arkamax.eu>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <DI5RO76D5IWR.19K0ES58HUIVS@arkamax.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/26 17:07, Maurizio Lombardi wrote:
> On Wed Apr 29, 2026 at 5:25 PM CEST, Pavel Begunkov wrote:
>> Enable BIO_DMABUF_MAP backed requests. It creates a prp list for the
>> dmabuf when it's mapped, which is then used to initialise requests.
>>
>> Suggested-by: Keith Busch <kbusch@kernel.org>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
...>> +
>> +static int nvme_create_dmabuf_token(struct request_queue *q,
>> +				 struct io_dmabuf_token *token)
>> +{
>> +	struct nvme_dmabuf_token *data;
>> +	struct dma_buf_attachment *attach;
>> +	struct nvme_ns *ns = q->queuedata;
>> +	struct nvme_dev *dev = to_nvme_dev(ns->ctrl);
>> +	struct dma_buf *dmabuf = token->dmabuf;
>> +
>> +	data = kzalloc(sizeof(data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
> 
> Shouldn't this be kzalloc(sizeof(*data)...) ?

Good catch, I'll apply it all for next version

-- 
Pavel Begunkov

