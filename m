Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4866738AC88
	for <linux-block@vger.kernel.org>; Thu,  7 May 2026 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152328; cv=none; b=N4hZaC8tZ01YTGNsbGghOYzMQcIIoWmgmdJ3bXui9WRdsXuDjw359M8BTv/5H235ng/tSNzp7UuoFgg1xUvw8i9umYlgWfkUkX84BipaBf75A4UoMDHnFitvKL6DpuxXJYhCo3i8lNzoFmOm7+TBbCS1ETFZz9sHMK2mbviBbjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152328; c=relaxed/simple;
	bh=Uh5+hbKyt+eagl/vXSjdcsiL76jTPg7xEjrqMwBzvoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhzS70n8J3qjW9XaDM9aFrJU3sygNhtEovjFUXdJwiAw4yo9K8A4Eg+cOk3HkblUu57hnfLJ1Nl5ugIo8mKWWEmoYthjm92kdDLzSwtVAzyAZBl/hpPdX926K0Sx0oFsMr83hZzyxyu+33JPK3HpLYCgb5RTRCMQsHu9FLR7PKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=bJ527SLB; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="bJ527SLB"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40423dbe98bso333226fac.2
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 04:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778152320; x=1778757120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLF/SD3w9fwkTaGU1Nd2Fb6KSRZ4PWz+kR0DtxLgWSQ=;
        b=bJ527SLBt/HtWpO27l2eXMRUqsb4ioO+J7mN7aqg9M4lk8ossbpsIootAuXaPlg0NC
         0cZpo7bhfh8RsZaw8MurG0xLGhpjoaBXPyQwW4pLqFh54aL6ogqHx5hi2WXepDwAOtZB
         E47j1H9W9EtvOIu3LwCyKCZBrjCaJqFh4bTIcp5BKwOCsXcidSu6RX+SdHkXfI0u3CSv
         YobO4f+v7oYS5akauL7PA0LdA7I9BhxLNj+LE2I38tY5t0xwQXf/ZZB/bR8fmnQ4r6As
         rn6fEJmUPlsw2961yf/wr+KaPEWT4djVDwEiyqd7IXThP3dDO2e4MuW7fMCRDwX7qYDN
         9Iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778152320; x=1778757120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLF/SD3w9fwkTaGU1Nd2Fb6KSRZ4PWz+kR0DtxLgWSQ=;
        b=AlCR0uYxJCfl8zbPlXTPsi2RAAp4ojzbuy4gbJ121sbbmmi+qPBGolzXzmxSP675xm
         r9/SBuFOksgjxqfyqJlTQTBZj3YyfVMEMcPEyFithnwFfk/4oKwzVoCRXes6Zw1M50Z+
         0bPx19pCUJFjMuZPVRCY1DFOlhAsv1AIGMLObQ4Wcy1zxK2cBci3tOaufd3SCkyBafOJ
         ybURs3n2kmlVqKfTDhH5rt9Wo6w5J+24GpBhU82ZjDrl/11JgPXgI1u5uWZPG1vfBZYi
         ZFh9Q4a//YY1aFJ5hNRDFcQv8NcmeLGbc6JEa0+JVYyVfegB8bCpHfw08ot+aY/Mo0N5
         Mgog==
X-Gm-Message-State: AOJu0YzFDpUmXQOLHSagwNyjs6+mJ+9iSCt6oV5vPAsARow+sQmJ0fic
	7RvYRfbJ2Bhws0elkue9IxxRW8EpL2RIS8q7NS/bQF0L4RqsvCfTSPGTay04Mn40v88=
X-Gm-Gg: AeBDieuxyDTbdcWlGD7qHSSwVJvOjBEiQ/9+mhuSXGFRnA9caUUSTLjFQEhWNeJ+qgu
	fqAsMxckF1UmLyms8PDEpCXaD0R08bMokhyOiBbFHHf+feA4VkgZ77pGOgCADUGbt6ZYRg/sgoZ
	2Zu7w0GCY68TetB9Zlz1D8AKsWp+RqIIAlKA2PIQaB7DF/APbPDFDSPF27Gf2/e15ISJ2XEj2Rx
	dK1cF9YPt8u/5snYWGHECjTwPLDj95S4nHbwZGPUXZyk+IZuQN8IG73npn1fDVGn+/e1S/N2oIn
	yFfFY4eMZ3iM6TNFvYS+c8f3Mpn4pytJ4yZn6yUXvQBDLe0qqIYsg5ccX+RIgxqSQW5E8tRWLNQ
	Ecp4FxCugmDPs5SvOJwDuAVUwvsZW3gx82ZPdS7jzOlvKSix+GRLbk5F4tkD7fiVzVtWscV64Ny
	rzZ7/QuRrk6Ep6hFLR94UDPRAnwwdXf6VHF8G5CcJjejq0VnQhvtQAkwXEZjfPFw==
X-Received: by 2002:a05:6870:e0b0:b0:430:29c3:9d15 with SMTP id 586e51a60fabf-434f5577a52mr4423440fac.1.1778152319945;
        Thu, 07 May 2026 04:11:59 -0700 (PDT)
Received: from [172.19.1.202] ([99.196.129.181])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-434ca5af84csm9536136fac.12.2026.05.07.04.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 04:11:58 -0700 (PDT)
Message-ID: <518e9c89-2e8c-4e23-993e-533314e98023@kernel.dk>
Date: Thu, 7 May 2026 05:11:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix typo in comment
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260507105836.25757-1-shofiqtest@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260507105836.25757-1-shofiqtest@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/26 4:58 AM, Md Shofiqul Islam wrote:
> Fix a typo in a comment in bio_split_alignment(): "occured" should
> be "occurred".
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  block/blk-merge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index fcf09325b2..395b23ed95 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -403,7 +403,7 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
>  	 * there may either be too many discontiguous vectors for the max
>  	 * segments limit, or contain virtual boundary gaps without having a
>  	 * valid block sized split. A zero byte result means one of those
> -	 * conditions occured.
> +	 * conditions occurred.

Generally happy to take typo fixes if they come with real fixes too,
otherwise it's just unnecessary churn that potentially causes stable
backport issues.

-- 
Jens Axboe

