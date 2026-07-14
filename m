Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF7643B493
	for <linux-block@vger.kernel.org>; Tue, 14 Jul 2026 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020929; cv=none; b=C/MRAEwMZSQvxdmWPYjqYtkMVPpLhPkY+G7KkeLbYpEzYUInce9gDRPKCNiMFMAtJ2jZIzoB6YhNDzAXNgZvHqs0lKPJBcZ9SCE8wdg7isn+88eaAzx8daRZHo7eN0Y+keo/dwKYgP8ntadaOleCKgPp0xa5DIzhbFJly0J4UMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020929; c=relaxed/simple;
	bh=W8OT6ovmAQkwBwCI5qoFSNzG+sz1ik3/qbazlMkp4fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOeFzbP+H3TZsLh/ACIlQmFj2LKjoj+N3RwUnlGNRpKnXUX2OJfN7ViS1ssYjpr/N9kvzrwC4MSTLTD/UfZgjcMHyq0Q5EFMS/rzj/Tj7EOu+/MNFTZieLP684lXrlNTtXjW2w+65guVa7nLwfW+TG94sWbaHcszjmeNsHWqg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlMpiiPu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlMpiiPu"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso2518105f8f.2
        for <linux-block@vger.kernel.org>; Tue, 14 Jul 2026 02:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784020926; x=1784625726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ersi/mYvINkBI2FWvIZV+GjZx0POxK8U4eXz4ZcSu2s=;
        b=JlMpiiPuB/c2oZZrBc95DV5SlirlC+vI33zg0SPOc/HulQ6PRfzknxCCkoafPIpvrP
         /EJj/1KtO89mjrSwAg804DK5vh0COyxGNwuawFtnFZ7KMBigbh7Zzl57kK43Uc+sUCpE
         GCcqSMQeeV9CRff6mbMZEH7sAKA5t6q/8IcQVSdLwXCGd07VBWMpDWIVtj2UX6ZZVhsX
         0NgcdbBMpU5zzjkqiMRgF/+NQWG+NLTSjvp/R3LTfmwft2KTKXT4bD3XsaWvDLQ9qOGc
         i61iRKqNiiAd7ancftpI04EnANyP1jtq9AboinBkMGpTe2fYXFve0PE4fjxU28iAycwY
         oXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784020926; x=1784625726;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ersi/mYvINkBI2FWvIZV+GjZx0POxK8U4eXz4ZcSu2s=;
        b=cKpuFJSYsMUv/KahVipNKHWNvcw02tyLL+BBq6GubuGd5BarbKeIElbCWKglkp+bUr
         oA357p+ahE964SfzMPx++PX0BvsnE8Jirb3dXUW4a+cXaTmUMoKH1J5e4rXiH5DIC/aG
         M8oXIwHRAg5viflukDQ77g1A5bYPEJEJEJsNeFmnHI20tiIsxvzmhMTyPIfT3Wp7a3Ib
         YpK978VebRImnQzN3xC44Vm7SqeR9ifNim/2MWZFdS837XLwAmKXzglTMd5G3e7I/EXJ
         vbMr4QtWD7GJPTk5AeMIsMx7cls8tkWrYpmEguqH/Zw5K8Tzi4TAOqfMYEfPrj7AF1No
         YR6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rou4DyImRtcdVoQJX4aPTiJ7ZcNXBjF6VdrPPwon+3dGDh8hmfKKA3hzR9q/mnUIH1mrvl3iBLwGROnBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv1AfIKIsQBzrTrRGZG1BJFiGaXenA0r6QwHlg3xpK0K6kxYn6
	dXHp2hcMe2spgcWqQDlEBL/wfeAA9i80vRbWuoW9kJewIatianaB6bKpUcFklC0F
X-Gm-Gg: AfdE7clOPXIiEijY69KqRyoVFl6sRf9LRt5u9ol+N+ajcpr2AuLoNWKF+1A/ZXp7fgd
	IpNcs1z/WYqtfKMBvmwMFYDw+TAByIDMYVNFWvkm0xt0+b3hYYz2y+Clc2P8bUrHkpUPohrBVto
	L2BKFjI8Aj7JclhXGX0oSEaRAlQkTAZTK3hsJwTxEkjXb7zjl1GrjeRh3B1AMag12jAUjcKDMlo
	cO3jN8vP5+m3LwRJdXqHePlFMzu/8FTkZmGOMzRoJDVdWzNO0z54iANLY1yuCG2Ix5eRI+j+VZW
	AEqF9nNM3ONcXmOaDH3ROzUc7fhUbA4tZgtye/GxKVoerjST7A1pv9hzXUCI5HApOG8qTMXZ2ID
	/UU4FIpb+eDX4ReHF7SrvfVNfJpAVVqbeZD7fYx/2rrVC9MMuYgf0FCh1vkEG5W6rZIS7wgCZ9a
	CK3agSuBwCDD3iJZo6pcqbIpDKoLLzH1ysa12snr1OO4a5LfvmiPGkGLnRgCpxVJ0iqUs28FgAJ
	KJI9VKvM9mwDZ+/c4e+7DSG7tWKHWnRl+AZfIuDQU584A==
X-Received: by 2002:adf:e186:0:b0:475:6c34:2120 with SMTP id ffacd0b85a97d-47f4887dd78mr2004457f8f.18.1784020926324;
        Tue, 14 Jul 2026 02:22:06 -0700 (PDT)
Received: from [192.168.0.207] (nat-wifi0.uniroma3.it. [193.204.167.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f476e9d02sm6291743f8f.19.2026.07.14.02.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 02:22:03 -0700 (PDT)
Message-ID: <619bb771-1038-4ec1-8d4c-17dc69df33d6@gmail.com>
Date: Tue, 14 Jul 2026 10:22:03 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Add dmabuf read/write via io_uring
To: Christoph Hellwig <hch@lst.de>
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
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <20260713071828.GB30168@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260713071828.GB30168@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 7/13/26 08:18, Christoph Hellwig wrote:
> Hi Pavel,
> 
> do you plan to resend this series?  A lot of people are eagerly waiting
> for it to land.

Absolutely, I'm going to finish v4 next or hopefully this week.

-- 
Pavel Begunkov

