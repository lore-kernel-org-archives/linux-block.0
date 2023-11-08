Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235BEEA3
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mkeZv2Dn"
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D7910F6
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 18:49:29 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5bd33a450fdso4431832a12.0
        for <linux-block@vger.kernel.org>; Tue, 07 Nov 2023 18:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699411769; x=1700016569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O0pCvuuqiIXdmKShmtr7TpA+fcjvN0E7H6T0yqECQ54=;
        b=mkeZv2DnhoIyRbBuK7CY5yaWxHN1s5p+QmDM3BNCpspgzZcv2dMrH/HWZXX29VTovK
         x/1n39eFc6y/eBLXhRQv1xyABCO7N1Q/CAiLNGbuCC/frkv0SBLvJrIXp/03eRn0AKdR
         qY1+TBte6iZDKbP8tA+PfsIADvzU1OH1BOkyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699411769; x=1700016569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0pCvuuqiIXdmKShmtr7TpA+fcjvN0E7H6T0yqECQ54=;
        b=lt2z3bvojlvmE9ADiwi86wACvWJ2Rcs1PRyITMOx9ERkJc+EmhaRbQ/cEfvm7JYDCg
         adxNWCrJmNJn3nw040vnZcFX3BsXuxeLx4Xa4hNluCKPXcY3OpIITvuDn8j/qig3+aGU
         o6YBIWXUT0GA5prvbg5Coo2fLr/kXsY7zwqa0W2L/dCesMRFSApL9cGmM6N/UqGUTh1s
         YAxTy4eyI3C/NLE5QmmeBW9mhGtNRo5Bf9bH8stfbpPJxJYT7kheFCjSnSxaaqNofelu
         SoCWdYWcWYvOadH5UQfr1kAsq/ANhZyHYcGKsVnOab3LoQG4qxZWPB+Xdgm0fD9eQe68
         0aAw==
X-Gm-Message-State: AOJu0Yw/WTskZNJgcDPmR7a112TtVEwYfVqrIlLWqXl/dxIWSoFeEgEt
	1w09RytCa3z7ClViZWzRn7jYNQ==
X-Google-Smtp-Source: AGHT+IGGCUffSEeIf39+LJitPMsQTTvAdYxDCHBABfr7nE8eOSrRfqBUm7WkSiHgQUm8BjI0viaqaw==
X-Received: by 2002:a17:902:b613:b0:1c9:cc88:502c with SMTP id b19-20020a170902b61300b001c9cc88502cmr756838pls.69.1699411768942;
        Tue, 07 Nov 2023 18:49:28 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2fe:d436:c346:6fcf])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902690100b001c74df14e6esm523291plk.51.2023.11.07.18.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 18:49:28 -0800 (PST)
Date: Wed, 8 Nov 2023 11:49:24 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Vasily Averin <vasily.averin@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, zhouxianrong <zhouxianrong@huawei.com>
Subject: Re: [PATCH] zram: extra zram_get_element call in
 zram_read_from_zspool()
Message-ID: <20231108024924.GG11577@google.com>
References: <ec494d90-3f04-4ab4-870b-bb4f015eb0ed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec494d90-3f04-4ab4-870b-bb4f015eb0ed@linux.dev>

On (23/11/06 22:55), Vasily Averin wrote:
> 
> 'element' and 'handle' are union in struct zram_table_entry.
> 
> Fixes: 8e19d540d107 ("zram: extend zero pages to same element pages")

Sorry, what exactly does it fix?

[..]
> @@ -1318,12 +1318,10 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
>  
>  	handle = zram_get_handle(zram, index);
>  	if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
> -		unsigned long value;
>  		void *mem;
>  
> -		value = handle ? zram_get_element(zram, index) : 0;
>  		mem = kmap_atomic(page);
> -		zram_fill_page(mem, PAGE_SIZE, value);
> +		zram_fill_page(mem, PAGE_SIZE, handle);
>  		kunmap_atomic(mem);
>  		return 0;
>  	}
