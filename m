Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A464B274670
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390208; cv=pass; b=lAdxAaHPtQ09cwgqvdtnLReqNbAEo3593OuLcBmNb3ySG9HfQvxvRX8SlZy06TGu4/wZBvkjfZyOAAqUkUdtW+zjHUpVFsBfopjOFlqF3WxbAWXQW1rWkD1HiUxEr+7UzhUATTJ0k2DUkFUqtwTyWtUqFVynNYHCNgL+aQxviD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390208; c=relaxed/simple;
	bh=2r86Fx4ramj4tYJizidhOVEFXq0HJLOP0RBDUmIE1UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n38mBhvBuNK30osTeCp6nEdBGg3pZguczl7Fl0zkPqm9NhBAIO1y/aCd+BGhUNv4iG498397duk/76rW5YGGs74FJHEW7NmlZq806TyONVRtNNG74vx679K/qur6Cd6QelpGnbP69mLMFN79WT9PgS40zQ1+GrZhloZXTdWiMWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h21RnEhN; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h21RnEhN"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-658034ce0e3so3701058a12.3
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 07:03:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770390206; cv=none;
        d=google.com; s=arc-20240605;
        b=YRnIfkRb+XoxmzyefUaAQcZguaFeahvMXGDWttwRL+Q3Lt9j/hq1gZ4q/cel0vaKwX
         DjOBXLuA0WSAavVHZlxm3cldhK9QIzHsAkFlG9KkmwGd7dCHXxlgmxNb+bo8MiEgL3qj
         BvP5g7v/aA6IPjHBsX0Sjd4Q1R4fFSJG1oYfcu5LVPvbBcC0Z1MbC6dSIHmU883uoe+3
         5uMxpXBXZ9bzKS7KfP4iHmR+gWSo7PMCe/vSg1VWufzSSqaZfIYuoIVI9kAhyPnJ8v4V
         gkfEQE5BXBZ0rmT87yQuEKfZovcdMdFGH9fybNK+jnxlRXY2AJFIdbVC2zWbSWFAZI8c
         plmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cbNYgILYh6T0L6GkBJIakhSOuBf8eodDKh7A+HpUyVc=;
        fh=fu5FjAX/FzPTUltNlDV3vYnq2lRKAa9FG27MeWuatHM=;
        b=iFx1laQ8vlsRyloAQJXiqsZq44fxJeFhvXbWXnqqrk+yUdI+4qHcCTPEb8QlxJytEl
         nEfd4scBeG5g9KLy1U/K48iWtHWk4Spw6E0lplop+QhU5c6tt/itOTVWFQ4wOh4ztqNP
         QkW6Pu2H5YUFtgspv0yL9URy5iFSRTQ+tZP5m2P4JD0aqTKs5qkuQwTxzfzg/6wZ8PL1
         NfdRAewwN/Ei7kyL6ok3q2SKJML6pa/Ayt0HoXoYfE6INWG/g3+kfzCUYyZJBaJ/ijY9
         nnmpizlzq2ypahSxNuPqR5D2BRXlxNOKgBLKJtfxrG2a5jv3h4GtFXhmuyJFnTxF5uf4
         p3eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770390206; x=1770995006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cbNYgILYh6T0L6GkBJIakhSOuBf8eodDKh7A+HpUyVc=;
        b=h21RnEhNnb9U9nu7M9xtGxoq26lZ7RtZ5y8tnf++MzxNIeR/zoxGlSz2+uQVuNC9PZ
         yHSw66h35LTh51liKBCVsnULW4SPHEuf3U3wTeDKQ52JocVwVDTH/70Dh7mmfY/61EKi
         obOtto54jhMqGxzf20TJdO7GQMozHonKh+1T6BstjMVN2L6xeZt3DpF/An/Jz17SRps4
         QVoXKTvxdLczce/F7XPYXkx4J52KeOvNUOcWW4JH0wDPPqiEOL8vVaajHSrUH0z8PxHZ
         wM4ocik+fMaMfkWZttzhB2VxtImFzKbgvs0BU2fr408oAXoUxpQ6YQQbx52KCmkVdQK2
         DCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390206; x=1770995006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbNYgILYh6T0L6GkBJIakhSOuBf8eodDKh7A+HpUyVc=;
        b=JVpe+aK2VEOxNij9Nmb2Q4KWDzX6f6x6V05dza/R+I0eyQvT4yImykkHB55OlCQrjh
         qpAxTig8LxYzqrc29XCsOr/Z1uzZd95U7NCw1IuRv8bUlXka/c5EP67VNRDkRu/xWaUS
         2mnzpuu0Kx6B5xzTq8qCaHa8vDL5awUYIiSNdg0XgiiLiGCN2yrDUbWqf+IathAu4v4r
         Rq2o7w4D776eIkMxin3Q0d6nRGu4a2yTsA218bdBb6jU2KFCIWGRrYfTGp5/FFWdytQZ
         devOBT4WrbnpNnrtStNS+seqca6kmZx3In0NxJ1W72iDa1qEPcCkOVkuGDzo4J75rw8x
         Jxuw==
X-Gm-Message-State: AOJu0Yz+CKZY7OT52saXjnbsdlXlMszbsQTcew4RYwFoZN8YHJZ9K2Qw
	HmlX0e9ETsw5JsRueBEPGdc3cxsoOOyAzVh2pwf9ge2WRkSYQM37Kj/GXKJnWqsFHEoVYFlqL9S
	griBReQJDyHN2XljL4brOwqcG6buKAg==
X-Gm-Gg: AZuq6aKUjrjHNTAeseeOzLBMm7WkzfSxdhwG0XZMg+LK8XZxCkXYdIsGc22KCM7LY7B
	Yyv/DAOZjfwi76DjWMFYL9Nhcgtz8nOMlpTC+jefQx/GZtrQK3BfXKivzNdPOGMspfJ48o3vDXd
	Mhygdub6iZRK5/GbIWIA4lck701GI2qA1Nj9RewYlXN+2r0ivX4qziv5NKKbWQkPNXcgjftPE2n
	LJuo9thmiQnKtFqP6eVPenDSEaahN1BJ57F9EiCMGWG1v+d4TPt1OEmhPhfomTybslWH5apxolt
	aC8E9M0JQMVxNgKu+BU4IcKWlFEY1gPtzhVZWa3rHUXKpHv+FzyUmpmdig==
X-Received: by 2002:a05:6402:3583:b0:659:4383:c491 with SMTP id
 4fb4d7f45d1cf-65984193946mr1569160a12.33.1770390205748; Fri, 06 Feb 2026
 07:03:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763725387.git.asml.silence@gmail.com> <f57269489c4d6f670ab1f9de4d0764030d8d080c.1763725387.git.asml.silence@gmail.com>
In-Reply-To: <f57269489c4d6f670ab1f9de4d0764030d8d080c.1763725387.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 6 Feb 2026 20:32:47 +0530
X-Gm-Features: AZwV_QgZhDOY8h13FRDtMZqnV6_xaqir1VOWq2MTchb4BXyrN5R68VQhosU9bGY
Message-ID: <CACzX3Av_g5g=ssfSjHzkosEj7DMU=+xY5fpdU-zYGYc0cUWPSA@mail.gmail.com>
Subject: Re: [RFC v2 02/11] iov_iter: introduce iter type for pre-registered dma
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

> +void iov_iter_dma_token(struct iov_iter *i, unsigned int direction,
> +                       struct dma_token *token,
> +                       loff_t off, size_t count)
> +{
> +       WARN_ON(direction & ~(READ | WRITE));
> +       *i = (struct iov_iter){
> +               .iter_type = ITER_DMA_TOKEN,
> +               .data_source = direction,
> +               .dma_token = token,
> +               .iov_offset = 0,

nit: iov_offset is getting below too. can get rid of this one.
> +               .count = count,
> +               .iov_offset = off,
> +       };
