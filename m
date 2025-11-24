Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C81306B30
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763991396; cv=none; b=G7XHPpCbQMph1xHcsXhnKQ9IK3GcHQ1uctMcBlkf+Sy8KaJozbYtgwX68/w+dOa45LhkQ8VPXPS4evGOUWzEdl8a4D2rjQM9nyz6VZwmHBJVmRBaMHZ+jgmW0hOSJtn8Xz/LbzgC7z0RN+1m8uFslPtHm3pEb+yNMIw6X/w+et8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763991396; c=relaxed/simple;
	bh=E4Kvahk4sfkEzDMtaEQ+7t96X+5OMROz94rsckBU8Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ns1Igl5ghSCYhKJtDbXCHX5xX44uLP88h/PlF2+pV4kBfMvwCfJjJMLBrNwdxz1FPqyRvfpqLvdu6eeo+HvLTEXRstYXuXnQJN5xIeMJEWzXxphvxacAZJyTjcqN2Qjcf8Kw+HPT8D2iC5cWGoB40BGYcc3OpWxkbC+ySSy6So4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvtjFiB9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvtjFiB9"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-645a13e2b17so2433646a12.2
        for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 05:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763991393; x=1764596193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E4Kvahk4sfkEzDMtaEQ+7t96X+5OMROz94rsckBU8Tk=;
        b=lvtjFiB9vOuY0MFV4pLK/ixeb6Z4c9ZY7gn2qKUx9+1RexOHaSUyWSglRZJuCzAmyI
         aMdNdO1fccxwExP+LF55qGmEKNwwDn81g/3It6mABrgmGHndD7WIU8fjonneji8kccIf
         uEqyxX0yxqoaaqlnAL07pAgW/Dcwszy2JZ1BRXNyv5ln/u310UTLKYrrXHgJT6CS1wCw
         kyv9p5ICGJGZdg0od7BLrm7dquR+75qR5oqBYnKahhpHnq9hXwy66tbakh2V8TP4eYPN
         9NiIYkr/pyBp/VGoeHeh8t06oxlVB1mQ8Y0u0DkAepnKgvxiKd+z8pmTh+kfjWKR/fvg
         YY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763991393; x=1764596193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4Kvahk4sfkEzDMtaEQ+7t96X+5OMROz94rsckBU8Tk=;
        b=ip2RNv9AKY2fXqWivntOj5gIKUhdnmCdgEQJbUfsO72zc9Bhdj1vjO65RfcC1MBf8n
         SyNqq7vYQIUht4J8UE1SM9KAc/5UEhHS3hC/5q8SaAo2NgGQs5Wxu4l/2yxdwG2tKqP/
         6wPSCG8m+0/NJAxjaNeCjJuE52yB+QJ+FHwmvHcbKelfYH97V+HH1YsDhDFIswCfPz/I
         hTTnpVM+sOE1pivbO7mge5Z5+bq0BakoNpQIV4cTr/IgaYVkNneZDCb375et1plHyQzw
         UN2o2gENvBZfUEomuU7x09tQhioQMHjdyeDc22jr3wXRPu7f9um49Sagq3wGuYFGY5i1
         NePg==
X-Gm-Message-State: AOJu0Yy7uCLL6kKbCn+fmW/wTyFmuU+zqQRCdt5SD7D5J3eFz2MZ3WEr
	ppLqQB50/CiIvTwvb9NKipWecyq8aZhSa9m26zzlGBeGTTrCOEtedvLiqAuozPGBKgmV8kke75u
	z4v+8iOn0ESh1wPXPDqqjDfEQZm8Yhw==
X-Gm-Gg: ASbGncvhprhxk4JdP4pq3H3+zhLBddGFVAji2tAAaT1XsxPxykHU9pgaKXKhf3UR6vd
	5+I8pvuDXn/ONMkcVqzSQvxQ/Dc4p4BZxLKG9qwzJ/bjTVOyztMqCsCKA34CoRhRhiH0srRvfvq
	ohHvzGe0vkTNeM61NSg9HoBNM6E+R+2Pnof86QwptSJOxid0AtBF/WP4H9p9TXsNhpYrnH0CinE
	mh00MfA3MC2AJ6e257dxpY1IE9UjXsMlr2Xvs2gGg3E4Fgo7Ot9odFKlu2kKNg41BngjrLGJEKN
	JQhDD1SVURIVZkhQCSzV+QUXNxRCh6WeMqCgT6SDjVgDTdk3sVXIT5aEwu0oXXhkQKI=
X-Google-Smtp-Source: AGHT+IEnG4Z6JyAnZPsc9zRPIurpTL3mzwNg7U8txyPxgdZYEAlachoenhHzENGex2kidp1+A4wUbZCJxBRlVZeptSQ=
X-Received: by 2002:a05:6402:34c7:b0:640:edb3:90b5 with SMTP id
 4fb4d7f45d1cf-645543493b7mr10042269a12.7.1763991392543; Mon, 24 Nov 2025
 05:36:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763725387.git.asml.silence@gmail.com>
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 24 Nov 2025 19:05:54 +0530
X-Gm-Features: AWmQ_bkynwx2lMdwns4GsIfVtYmI6CqY40r8-Afst6-_o29b3r6t6sfqC-dnOGU
Message-ID: <CACzX3Au7PW2zFFLmtNgW10wq+Kp-bp66GXUVCUCfS4VvK3tDYw@mail.gmail.com>
Subject: Re: [RFC v2 00/11] Add dmabuf read/write via io_uring
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"

This series significantly reduces the IOMMU/DMA overhead for I/O,
particularly when the IOMMU is configured in STRICT or LAZY mode. I
modified t/io_uring in fio to exercise this path and tested with an
Intel Optane device. On my setup, I see the following improvement:

- STRICT: before = 570 KIOPS, after = 5.01 MIOPS
- LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
- PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

The STRICT/LAZY numbers clearly show the benefit of avoiding per-I/O
dma_map/dma_unmap and reusing the pre-mapped DMA addresses.
--
Anuj Gupta
