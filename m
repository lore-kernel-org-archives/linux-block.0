Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9671E4AD
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403596; cv=none; b=jvUZFaK24aQMVLYg3VAEZ+ZM685K79Yev53owxpLEJmxBgOpvgBZTKl8772S8CXK9BJb8SSSX0sQUMJ9kraWLngHpwtctjg6fxeubPcLMBnHodtL8oYR7S9RAk2Hc+78p1rGk1/7rmxl73RflTZawv6WM50bblnEQamUPlKg5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403596; c=relaxed/simple;
	bh=IIaXFQKJGp42/A/dmLPrjhTC6nOpGBrYODeUe5ulqfQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GStfqIFysZLzM1YjsDOS2s+akRV65G45MZ9CZ3F3zIouLRNbO5sDFdnLcvEIzMbA5sOiTFDQDrFusn4SHMtfbMzZBCuHUUv5NVk02REm144dCjN5jovH0Cm8H40HVG8X0cWpkavvO9hHpcp4lzWdEffl6WeQ6zG5EXgIsC+OP7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HqXa6066; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HqXa6066"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cb80633dcfso201131a91.0
        for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721403594; x=1722008394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmjqiBmJBVEyMGIx8VEZyQ8Uzo0U1Uz6G0w5deMZhXg=;
        b=HqXa6066EoA/mWUPpr/ntMkZtIXmwMSxBC04erA7Kw9nwD31+lD10wCsRwSsNAcbOR
         U2t4RRkTnUE6W/2BllOXRbmSNaBZAcaK6Mfviletd0yWx8p+rcWPNbOic3Yk7M/mFAI6
         yWk7ZfE82k2PNmHlFqg3vqObAgSvEFy0wJI4E6nY7j9kugpnf7L9ad27Ks7FBWbxPzIv
         b6I+0MCU4N2Fol+XLFL4tDD0a5aH6VGmN60uEe+M8fyI5QUb2sfkrsmpr46Ly3RimpMa
         iny1TGdDbJsXuGmYB/CAqhfWeASdjutowRg/gH9zagW4cfvyoVyBUn613B6BtCoXG003
         XVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721403594; x=1722008394;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmjqiBmJBVEyMGIx8VEZyQ8Uzo0U1Uz6G0w5deMZhXg=;
        b=VJgbus6MzTyIIjOvzApSahTJORskLoOTYBXPQ3up2eTL7C2QiBlORAazIQCyt9LY0m
         4W0IP3ry6WVUDA9l5md8EXuI4ymMvAAss3uFaxzpjNUVH6PJsTy1LxlwLBl9qtgUZH4T
         0feQzy/jNVA/2VdTXu37p8c92vKha3kDD5ukmh15Os1J/ZHLTxdTSWJsBhGQ+fQbY2yB
         VmtMg7odXqQnQfxAVjNyG3P6FOIHgdrGiR2uBkJAXLSEhoq7r03SKgZcK7lDAAMrmduS
         KgWm+ln25CXVCsO/1T//ggAzgMCAsH6uasJwBbcucc0kLT6jpHi3LyTQC0JA8f44cX/T
         2ABg==
X-Forwarded-Encrypted: i=1; AJvYcCWFDFPYtIRR0fYIDnih8jTlpZ8VKzg3ZbImcGtCn5GkRu29TFEjps5XXHUv9GdIuHybBGI8TTAlUsNhW5sOsmXHQYR3kzc9hmSwnmI=
X-Gm-Message-State: AOJu0YzFYoy9e7faxnQQ5poOOLUml3otZCzCN+avqcyLeVD4Pu4Td/9r
	sm8LDVS5cKuZ5gjIeVHgCXPdTJK9iH1+SdfHXZWXW07dcwmAF0pPPbPd94SK34M=
X-Google-Smtp-Source: AGHT+IFfdFIdvCQWYQsXxU7377pA+fday1SiLgfXjmmVtbpGtZn0yHIIPC0G5TMUvwt6xM8uW3a92g==
X-Received: by 2002:a05:6a21:10b:b0:1c0:f1cb:c4b0 with SMTP id adf61e73a8af0-1c42298cd9dmr242511637.6.1721403594600;
        Fri, 19 Jul 2024 08:39:54 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb773411basm2968003a91.30.2024.07.19.08.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:39:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Ming Lei <ming.lei@redhat.com>, 
 Omar Sandoval <osandov@fb.com>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Yang Yang <yang.yang@vivo.com>
In-Reply-To: <20240716082644.659566-1-yang.yang@vivo.com>
References: <20240716082644.659566-1-yang.yang@vivo.com>
Subject: Re: [PATCH v8] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Message-Id: <172140359332.12097.1558892281494577679.b4-ty@kernel.dk>
Date: Fri, 19 Jul 2024 09:39:53 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 16 Jul 2024 16:26:27 +0800, Yang Yang wrote:
> Configuration for sbq:
>   depth=64, wake_batch=6, shift=6, map_nr=1
> 
> 1. There are 64 requests in progress:
>   map->word = 0xFFFFFFFFFFFFFFFF
> 2. After all the 64 requests complete, and no more requests come:
>   map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
> 3. Now two tasks try to allocate requests:
>   T1:                                       T2:
>   __blk_mq_get_tag                          .
>   __sbitmap_queue_get                       .
>   sbitmap_get                               .
>   sbitmap_find_bit                          .
>   sbitmap_find_bit_in_word                  .
>   __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>   sbitmap_deferred_clear                    __sbitmap_queue_get
>   /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>     if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>       return false;                         __sbitmap_get_word -> nr=-1
>     mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>     atomic_long_andnot()                    /* map->cleared=0 */
>                                               if (!(map->cleared))
>                                                 return false;
>                                      /*
>                                       * map->cleared is cleared by T1
>                                       * T2 fail to acquire the tag
>                                       */
> 
> [...]

Applied, thanks!

[1/1] sbitmap: fix io hung due to race on sbitmap_word::cleared
      commit: 72d04bdcf3f7d7e07d82f9757946f68802a7270a

Best regards,
-- 
Jens Axboe



