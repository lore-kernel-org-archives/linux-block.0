Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B270823B9
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706034991; cv=none; b=Sgy6p+2YN3HMLX8bYe2pNyVbMBVNRr1sqjN9O/7dtna/pTFGs0x05DuPuo83H2/ZkWdfT9o4rMuHGIQ4XLU5ATswR9SD9eWEaCDcLvcxmJTGg8Epc8w3UHXwGYCAQDkjyOEVaD4ATAHIEH1WQBPI2aOEZk/TS5UPnSVO7+7XZvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706034991; c=relaxed/simple;
	bh=vDtg1iZRVRrVnemg+ASwvkfBWydyonOPNdBnoTQCelY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QFzDjksH8dnrcpEKnUWqPzs49TE9viHyXsPu3mP90GcNY3J/cy5igbR52EwrnpqiPSzcAceymg7EE9YYS2MMR2eP1VaqjuUuOs/PbaZOpvvMA/rxa2TZpzQePtxzf+ZCmYoppoYN+g1JtEc9hgmpl3yxVVuSQRkyfEN1rKtYHsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d74dce86f7so20591865ad.2
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 10:36:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706034990; x=1706639790;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31fo8UYypauFo19zSI2R5UVJz71yhBdHAMLKLKEF1Z4=;
        b=mbY4yZd4fHyZXvWx8JpQkgb1UBmmSmB0DMj2zSGHggExV9KF6hmja+udXY8oTYfiev
         kjVaiVLsfk5K/UkuSmB3xFuh/VnIU2sBAk4kCwl+wVnwdATOU4SJuWPI42Q4eXd2izi5
         kGOlvDZ1MNgiQA3Yt9SXz6BQ5OP1wyCrMNkvTAoJI4QmRVRwgvU6UTO+3wjB5pZoAcJc
         MA8IoR52c7bnXV2Vx4ebL5JcHU/NTjHXeHpImgY6mIltacKrvi4yaJIEgxDUahOTWE3n
         9qx5RsNvllvXW02LDfytOMjdtfeAfpX2auRUakgtczQLHGdbU45Sk++Bwfoo3oPFvYjk
         oAYw==
X-Gm-Message-State: AOJu0YxMjpH1OfOKn6ImOfhO3MxoeHAFaqWDKLUsAYA/NpUFSpP8h4h8
	rNmU0ocJ0NPXwQ+TvunddOv/0uf0xr6a1phegiQtNCY/o7LYjdHD
X-Google-Smtp-Source: AGHT+IHlvJS+I4wMVWh034l6lcA+Ni1HNGgzAejIWjdUBKh78whbja0oNevkTd1Ulkgy0JcOdXULtA==
X-Received: by 2002:a17:903:948:b0:1d7:6f4f:c61a with SMTP id ma8-20020a170903094800b001d76f4fc61amr1431916plb.36.1706034989517;
        Tue, 23 Jan 2024 10:36:29 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902d11200b001d766749e9bsm2090141plw.156.2024.01.23.10.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:36:29 -0800 (PST)
Message-ID: <1c695e25-af8e-41b2-adfe-58c843e7dbc1@acm.org>
Date: Tue, 23 Jan 2024 10:36:27 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] block/mq-deadline: serialize request dispatching
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-3-axboe@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240123174021.1967461-3-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/24 09:34, Jens Axboe wrote:
> +	struct {
> +		spinlock_t lock;
> +		spinlock_t zone_lock;
> +	} ____cacheline_aligned_in_smp;

It is not clear to me why the ____cacheline_aligned_in_smp attribute
is applied to the two spinlocks combined? Can this cause both spinlocks
to end up in the same cache line? If the ____cacheline_aligned_in_smp
attribute would be applied to each spinlock separately, could that
improve performance even further? Otherwise this patch looks good to me,
hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
