Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3025017C3
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ksipwHS1"
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFD591
	for <linux-block@vger.kernel.org>; Mon,  6 Nov 2023 23:39:15 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5afbdbf3a19so62669917b3.2
        for <linux-block@vger.kernel.org>; Mon, 06 Nov 2023 23:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699342755; x=1699947555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0b2uAK0sTnMtt8sJVqtZt8wq7e4UQ5SUD8tyD2zEIAY=;
        b=ksipwHS19zH2ls3agE6j8mx1huUfmPqJJ1kaxOsECCEPJMeO5O1er/+kpclJWSDpZa
         huTP8ughYgWPQjChg8tg6YNeXU239LTttMlgPzhEs3Iy8iQArfwI0oeXb7c3I+3gsfII
         i0JLt0/wS1mJ3e1soD/fItalfEqm2PQZ3wokk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699342755; x=1699947555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0b2uAK0sTnMtt8sJVqtZt8wq7e4UQ5SUD8tyD2zEIAY=;
        b=HJKEHpXhJQ3YmdkA71RF6oNYNNwdK8seAGP74gzklQZEonegkV/4wiwG2T72JTFr4v
         CX65sEzjqFf/lkquI+wOrI8LbqupckY52w7KvRJVFz3soJxLBy2a4qLc+tQieXU+GLTw
         oQKE+24eCPruvcE/vKpvzOOD9i9VP0RzXrduelEdujSVM5ti67E7uVINk6HkPGDecv32
         A0We0iKrdPGDalqGvEkcfkL98IaeEksU8/22HfOiTwRhcAq2lMXXuC20leF94yzPEqy9
         oSRRnmHC7H3ktT2lJm1hpH5HBH4soVDibQQskv6Jx81INPR+aAO7EL1A4hNpKQfpYRha
         d78w==
X-Gm-Message-State: AOJu0YxQlosritC/qw0OeWLt1mZoU+IJGg5omp0JqTzmtovH17xHOcBk
	6n/6AJSnTe7tLvql+/Ll0JRFUw==
X-Google-Smtp-Source: AGHT+IGBYGmHNhAi24PQZPJ3JnNUBMcMmYndGPSqtFx2tldIxGSOCx5EPERGhQOBR5I55xCoagxrYQ==
X-Received: by 2002:a25:cecd:0:b0:d9a:bfe4:d827 with SMTP id x196-20020a25cecd000000b00d9abfe4d827mr33406692ybe.19.1699342754897;
        Mon, 06 Nov 2023 23:39:14 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:7d66:31e7:94a6:e6a9])
        by smtp.gmail.com with ESMTPSA id h22-20020a056a00231600b006be0bd6a4d8sm6666858pfh.36.2023.11.06.23.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 23:39:14 -0800 (PST)
Date: Tue, 7 Nov 2023 16:39:11 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	zhouxianrong <zhouxianrong@huawei.com>,
	Vasily Averin <vasily.averin@linux.dev>
Subject: Re: [PATCH] zram: unsafe zram_get_element call in zram_read_page()
Message-ID: <20231107073911.GB11577@google.com>
References: <d10cdf1d-4a67-48df-b389-3a51f60e9431@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d10cdf1d-4a67-48df-b389-3a51f60e9431@linux.dev>

On (23/11/06 22:54), Vasily Averin wrote:
> @@ -1362,14 +1362,14 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
>  		ret = zram_read_from_zspool(zram, page, index);
>  		zram_slot_unlock(zram, index);
>  	} else {
> +		unsigned long entry = zram_get_element(zram, index);
>  		/*
>  		 * The slot should be unlocked before reading from the backing
>  		 * device.
>  		 */
>  		zram_slot_unlock(zram, index);
>  
> -		ret = read_from_bdev(zram, page, zram_get_element(zram, index),
> -				     parent);
> +		ret = read_from_bdev(zram, page, entry, parent);

Hmmm,
We may want to do more here. Basically, we probably need to re-confirm
after read_from_bdev() that the entry at index still has ZRAM_WB set
and, if so, that it points to the same blk_idx. IOW, check that it has
not been free-ed and re-used under us.

Minchan, what do you think? Is that scenario possible?
