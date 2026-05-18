Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FFA3EEADD
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100267; cv=none; b=ORYy8S++/HPw3RJTZY3sdpW1ELDf446+M/GNMp7O3ZBdTD3QCa3LHJ/KpuTlqyEy5z/HG439Oh0qjxtNOnrwa1EdS/NQNJ2Z7eTJlyFiI04HUrcNJpOlf3D8aF3KtUYhLwMr6S55NNd99Pdl1G+siatseUYf8q9VZ/aSpSkWjnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100267; c=relaxed/simple;
	bh=uNvks5nLVhab845gPs8D4jnOry1W6hE6xPWWd9nU+CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BotaLIzypSi4PcrauoH0PELKUNz20XOEXkJqtHbEe6JNPFMN9iUPSgR8UEZhv6/lgpVYA51YNxJTxkQMJkrimyYR9tB8uwRLz1XWXklkz/zZdlmp1DHt6UGFMdSh0F/pcWnvHNmiBzkTp/0Fj7FqUD7Fe5WmspxihPRs7z73WGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFtHjJDu; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFtHjJDu"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67da63ae541so4664217a12.0
        for <linux-block@vger.kernel.org>; Mon, 18 May 2026 03:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779100257; x=1779705057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hx27Zr2PfQkgYP6DocpvbcVC/5/Kjswu2b3jiJPzVQY=;
        b=SFtHjJDu5+thx67ZQgSBSlnzrWP8St/IsgqvFJBv+8gm1ZrL2dyXiR9tOuiCjTHlxK
         leC3X5LwO9ivz6GpTCXdCkORR5nUXpH3H7zydiX32uINNdws6VGv3HNPz767MpzZyFLv
         CwtfM3jnULTNL8ABAm8hoRo8Gid93oQikbr8Xq08xamILO2ehZBd0oG56QxnAvJixFAt
         w6azypF0dMLXHB6c7c0334C/m+OJ2yS/GGsT+E/iEqTBoTUUM1K96VkKyWLbFWOKggQK
         i0EgO1KZSz8N0Ht7I8I199PJpHmud6anBnAwiAxTKU6aQqsnKb7fdI6vF+DEf3UPLiaQ
         +FvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779100257; x=1779705057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hx27Zr2PfQkgYP6DocpvbcVC/5/Kjswu2b3jiJPzVQY=;
        b=aZfszWCiX/nNbznu0RvzL7iu5sjw4elw6dzHUgsAaZ+JgYDKiIa4Xszf+UgWsQ6Nvw
         NL9DfK9b5JSitPzoaySPeqXTY/MGyfDIJNTq+empU8DhSozM6Qx+P7xu11izOWQPa+Yh
         VG/+3lN23I7CONSPhaGtCJw4/RrVgMt5wze0BZo34kNkNHMWfvit1glh3smJhIoxReUT
         7US/yamr+S5PwQjaS/aeOgl/9tW/N0hg8Jqzl+PuLv2TId5NM1T33ZFm6ApmLkyhGD+Y
         JehXaf1bD3TfDlaNuKKDkexScgCOhLVJn7Aw1+s+xYMMV26NmOl8K/3TrkS+VYlwxtfE
         VIVQ==
X-Forwarded-Encrypted: i=1; AFNElJ880o2DBvkuR18dzcgzvk0e3Q3SMFrvFYzJ2nDK6bEVCAFMjn/wvUaeEMSapOq4j1SN8P1nmzHlrW5mvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZgkIu7SiwQfPPrUVqodGDkfUhYITjuDhGKo/mUzcWiKeryTRw
	XohLMYL5/xUtjqZmGbzXJ032x3WsTS1uJA0swW+ey3pUqPvo3oMLnqxV
X-Gm-Gg: Acq92OFxGDFuREUbtoV7jMM3Ph7yjjlxAnpDyCQbPcoKInjT+UwGjPr7S+GHmDqvu4F
	CZfSvWj+EDgwrQfRNRFYNUbMBJW0Rj0k/lpfqYEwYCDwBjlklLYo/vUin/E0HAI6dWaif7UaxwP
	939XSaLW42zNr8hDD43R9N6fzKdGaqJMm2yTBw9I5Qhc3y7BtGvILX25u/EmKiz5dNBxLAl60bv
	xX1CoaHH562XvM0kHpdQxjWWavgj9COkX2f1kA/azuemb1zDSp1CYstKzb/ebc7fWpgy2s4Xm52
	mRGKgwfevnKlohaM9DGO+PCykc/InOo1hB3mcMOszRP8RRQ45OaA+KOQLMXKEAXEDgPZGkdXZFG
	oN7qw7irlF2KLeAMimcPh5eyvuVFqTHCETI9LWWyd1Kcgc6kyWoUORTQ4BUvj0kXX3ohGtAu6Gs
	bE1oenIxp53oGM3mvCw3F+1EE5V0lk31tkl7rxoevom5xD5OcJGIvhz5SuBOwaKbSZTIH7jsmJs
	SZBtCL2pJyC/o0gLS0W74yUxCa3zpwUr0kcjSVjBhajVOSEHykViVcvaWM=
X-Received: by 2002:a17:907:1c0d:b0:bd2:bd3:1ef8 with SMTP id a640c23a62f3a-bd517a99797mr714341866b.35.1779100257041;
        Mon, 18 May 2026 03:30:57 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:ec20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e4d54dsm542055466b.47.2026.05.18.03.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 03:30:56 -0700 (PDT)
Message-ID: <574f42cf-0d72-437a-8eba-fd970011e206@gmail.com>
Date: Mon, 18 May 2026 11:30:54 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] nvme-pci: implement dma_token backed requests
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
 <20260513083817.GC6461@lst.de>
 <CGME20260518092930epcas5p30d3b49f26efa5969ddcdb15351a886f3@epcas5p3.samsung.com>
 <50ed7240-d8d3-4816-bcc9-ce8adbbbf841@gmail.com>
 <f9e04625-50c6-4fa9-8b12-76496e29f10c@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <f9e04625-50c6-4fa9-8b12-76496e29f10c@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/18/26 11:18, Anuj Gupta/Anuj Gupta wrote:
> On 5/18/2026 2:59 PM, Pavel Begunkov wrote:
>>> FYI, I really want SGL support before this get merged, but ignoring that
>>> for now:
>>
>> I was hoping to let Samsung guys to send a follow up they already have,
>> but I'll ask them to have about taking it into this patch set.
> 
> I had done patches on top of v3 adding SGL support and PRP list reuse
> optimization for the dmabuf path.
> Branch: https://github.com/SamsungDS/linux/commits/rw-dmabuf-v3-nvme-opt/
> 
> Also pasting the SGL patch here for quick reference:

Thanks Anuj!

-- 
Pavel Begunkov

