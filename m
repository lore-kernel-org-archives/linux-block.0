Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB948C8C4
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114245; cv=none; b=VcSzNXb7E/n5Xf3vuNY2+zm6QJusRTyORlEils4bf/dHe85RH6NbsfLPRb8n90TuoCnFhIuZZewdcfSnVbxNbSZW711+bdY7hKIEEvRUvrm3jm3eTEFHDPfkqR3bOn7KGSUeHdIo/yWwcOFh0zlwl4jqeYEeLYWoKGJ0RPWhZ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114245; c=relaxed/simple;
	bh=Ja0DTfaEYIoGmin0aywYwaWpB4UWlA4iW9ZxB9BMNMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMi+zYK4GXmO/T/CH2pnOnlHH7knoKqNtWIahcKrAEGBiI+BMpIrt0XDNVr4jYekRdn5yG7+XXwW8z/i/gQfd8AKzJx2vUxY1mDVymbFJkc/1dTO1lt2JL+QiMXcaEGZdA0oW5hMwQCPTBllom3kt1+kz0WlDXGfC3gn51/I6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFK1UxCj; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFK1UxCj"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd11a3729e8so383702866b.0
        for <linux-block@vger.kernel.org>; Mon, 18 May 2026 07:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779114237; x=1779719037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m58bYDJ543WmyZ11IWytLuY71YuFJ2Bw6ePCWpryz/I=;
        b=jFK1UxCj/9hu/WpBG5drcZwxOWtR6cGYB4ErAsxcCoLRnUmHgxSqEAMVAolDJJrH9Z
         1hdwdgmStI3zkbuwkOFKLgAduKUp4s7IUV0QrqjtVZyxKN2R7lpp0/keTjJeNXORBfRY
         iKxXU0l5N5r8xvhB9XCY4w6jrNvDuJXLhYZ9wYbjP+gKbOrmICrOApzAhigvnRrrinaL
         Gb3NRTZM32EVOdDbYX5+S47nP2KhGAiP8F7wO2/WZgTZ0Wdf97sbuXSYfnv1T9IEtqU5
         Nv1u3gHY/kqeewKzSvB0u83tg+4FS0uxqPRyB/9oZfAlZtbMwcY0Wlc9g1oZrrMLTZS/
         v+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114237; x=1779719037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m58bYDJ543WmyZ11IWytLuY71YuFJ2Bw6ePCWpryz/I=;
        b=k9M8S5BSK4DOJRwmsYtH9fcAznmebcb0+zvIEe4RiQ2rH/z93sGGHmpq1de8d7QhMF
         2DTCpBpfXORbWrrsqDRnYZZ9Mv26eAwP9r9SG/cKaaefDWiuy4BXafmHkNoey2vT/tCW
         g4DXOBcducMFCsj/JsudieiwVh5wWackOW2Wl8RCXEA29ErUcRxnpH9BlLm4LMY797+1
         rglgFmZEJtBUHmRw0c5OQQnF4zbQlUSaMFfEosdrvEgVu6kpc4YcthrCaAMMvh1l015O
         MunkB7f3b2wTl13Sn0nG3L1G+uThsn1kzqCf+9cftxMVu8NqVYZWgulg/9XqDOfi7uVO
         draQ==
X-Forwarded-Encrypted: i=1; AFNElJ8o2h5HwOOUr5cGwGqpFMXdqWklAfnp027Y1E/s5VDtB5ryql7c3kCtIeqoqfB+BztRMfWqyDSsoagx3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkY8UYdy9jjzwa4OXHj0SI93uPH82yTNQRbUhEGDFCKGsqE2Hr
	g9B5XHraDIYLMeoGgAew3eDQRdPbz0FNztYgBTQuEF/QdrO5TJ1UmlWw
X-Gm-Gg: Acq92OEGmN1KV7xqhCZrYrBZLyxEM2TW/M7UGpG++wjhOMkhFBvUqnaYRose8f1zkk7
	OKPWWGvPhP6vZyYLge/Z0Dq+PdoPQjs0RryejY7BNEzEFimOpR3X/khy8ff6HPjhrfHBRSZCjw9
	WTSL90dGn/QNkGCwpM6/pVbV+ggtBhGj0w6GSF3sFMY0XweeEQzWhbmCFTGsvr8GttrdwBsMMYl
	BztT7RUkahz4KkZZchZDLEsnzTVrm1nl4cJqu8ztSPuxm5BsdYCzEB2+VRyTHpTcjvxmJ4h6vKV
	OMVEEEj82GJB0QyBA1RGPHfGF1Klx4DILpg7iYqg3bhfhPU9vSAV/ZdbzM3Jk90pXEvb4eEO9k3
	DD3AmAWJLDjtGFY/ubeIlyNlQRfgKT+KR9y5IiugGeYYZNiK7EsZPdnsZ8Dr/q+YJdNODwMHOW9
	l2w20EiAos3Yw6oeaerGnpF+D/Qws32GnHY4vf75zyAcy+bg+2w4PYlU0CRBRPMzgViYRoiryL4
	lkjdxmGhBotQrRxF3D7cFS2XcUv+JB8vR5Qgyn+K0rIFa2b6GtHe5usJ1VI+nI/GLwwzgrcitHH
	pA==
X-Received: by 2002:a17:907:c291:b0:bd5:7a3:a58b with SMTP id a640c23a62f3a-bd517994249mr821357066b.46.1779114237152;
        Mon, 18 May 2026 07:23:57 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310d58c79sm5325464a12.12.2026.05.18.07.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 07:23:56 -0700 (PDT)
Message-ID: <ea47051e-697f-4017-a514-be6ef7c110e9@gmail.com>
Date: Mon, 18 May 2026 15:23:53 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] lib: add dmabuf token infrastructure
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
 <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com>
 <20260513082431.GA6461@lst.de>
 <ebf41920-5852-428f-b98a-e0f44c8f3315@gmail.com>
 <20260518125326.GA5754@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260518125326.GA5754@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/18/26 13:53, Christoph Hellwig wrote:
> On Mon, May 18, 2026 at 11:14:09AM +0100, Pavel Begunkov wrote:
>>> This is about dma-buf based I/O.  So I'd expect it to be named dma-buf-io
>>> and no io-dmabuf, and live in drivers/dma-buf and not the unrelated lib/.
>>> But I'd like to hear from the dma-buf maintainers about that.
>>
>> Looking at what Ming is saying, it'd make more sense to keep some of the
>> parts like iterator and the file op more flexible and not automatically
>> imply dma-buf even if it's the main and for now the only medium. I.e.
>> ublk/fuse can use a similar interface for mapping buffers to the server
>> even without dma mappings.
>>
>> I don't know how the API should look like, maybe passing memfd, and dma-buf
>> supports mmap, but I think it's better to call the op something like
>> "register_buffer" instead and keep all it in lib/ for the same reasons.
> 
> Let's get the current version landed.  If we come up with some kind of
> non-dma dmabuf in the future we can refactor it and move it around.
> I'm a little skeptic we'll be able to share code as long as dmabuf
> is allergic to physical addresses, though.

To be fair, it's not that dma-buf specific. This lib/ code only
does some resv locking, fence waiting and queuing fences, otherwise
all the attaching is done by the driver behind callbacks. Switching
it to some memfd could be pretty simple. But The main thing it'd
need to share is iterator handling like forwarding in the block
layer, and it should be fine as it's already passed as a completely
opaque object with no knowledge about pages / dma / etc. for the
middle layers.

> lib/ is most certainly the wrong place for something that absolutely
> is not library functionality but directly interacts with a few
> subsystems.

It only interacts with dma-buf, and even for dma-buf attachments
are created by the driver. Block, nvme, io_uring are users, either
using the helpers or implementing callbacks.

Ok. Let's assume for the argument's sake it's not dma-buf
specific, if not lib/, where would you put it? I was also
assuming that dma-buf being under drivers/ is rather a relic
of the past rather than the desired location, hmm?


-- 
Pavel Begunkov

