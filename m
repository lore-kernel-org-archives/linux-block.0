Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5FCA4A
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kidAwMyT"
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2F3129
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 17:42:33 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc4f777ab9so46038295ad.0
        for <linux-block@vger.kernel.org>; Tue, 07 Nov 2023 17:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699407753; x=1700012553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uRaBsOVzYONI9pogErmQ9X03ygbaDdU6U4Qoxn4y618=;
        b=kidAwMyTVazSg+VUFr99Bprtz/I7aJ7dNixfjiVXuvjvWp1Nh/5HfZ6sDGdGUendNK
         II3Q1xKIqRPzBFMbGclHe5zLNWLAq1vC2MXDpmWL9lxiVAjN/H3WoS4xhThYDBSvt+dw
         g513OONJ5aJlhdexqmWQ9hOeP4L1AKBHrQE7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699407753; x=1700012553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRaBsOVzYONI9pogErmQ9X03ygbaDdU6U4Qoxn4y618=;
        b=amjVP5HD2mM90HvjiSuiGOTW+R5o5GZc8cA9FzHgls0UZp8NEIOi517wdMDEg6tyPx
         8/+IcFBRMFUK+0HZLB2NRfEti9CTynCRxb1fJPWTTmCnhameBhZe/JjkXoqZ3galdWpU
         C3I9xUHzDyLIQIAFaz5OSb9epkjpNx2/S8YdVjGsZF5Pd2uGQuITavpezDsSqnsK4+2i
         oW2wDktSBjKOKYueHOkFvBCN8oJqCSbIgzeGL8xv/ybxhgLRVPKqi5Fa0Dfk8zyNI7Jz
         Mu3Iw7d34kHJvMI71Cp8bHRbKBBPLUov9O+Rrg84yJmXEVp18IrZGwh7VzJBNYTu/Gdb
         Xirg==
X-Gm-Message-State: AOJu0YzjBnyFB5H4c3JIRLB3uZXwhM8k8zJrG8x6kHNeS0DvoF7AKms6
	zmQWNqvtm/e63XZKttjEEmG2sw==
X-Google-Smtp-Source: AGHT+IEiX3OQXe/Bpr16powrllKhPlWEmq4Fndw9pepmzaQ/R+ZOIvuD5AuOqCc8KrphNFU1/9C7Aw==
X-Received: by 2002:a17:902:7407:b0:1c5:d8a3:8789 with SMTP id g7-20020a170902740700b001c5d8a38789mr747226pll.4.1699407753200;
        Tue, 07 Nov 2023 17:42:33 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2fe:d436:c346:6fcf])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c14c00b001cc79f3c60csm457816plj.31.2023.11.07.17.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 17:42:32 -0800 (PST)
Date: Wed, 8 Nov 2023 10:42:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Vasily Averin <vasily.averin@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: unsafe zram_get_element call in zram_read_page()
Message-ID: <20231108014229.GE11577@google.com>
References: <d10cdf1d-4a67-48df-b389-3a51f60e9431@linux.dev>
 <20231107073911.GB11577@google.com>
 <20231107104041.GC11577@google.com>
 <c57eb649-c573-4e41-85f4-870d08cf88b9@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c57eb649-c573-4e41-85f4-870d08cf88b9@linux.dev>

On (23/11/07 21:19), Vasily Averin wrote:
> On 11/7/23 13:40, Sergey Senozhatsky wrote:
> > On (23/11/07 16:39), Sergey Senozhatsky wrote:
> >> Hmmm,
> >> We may want to do more here. Basically, we probably need to re-confirm
> >> after read_from_bdev() that the entry at index still has ZRAM_WB set
> >> and, if so, that it points to the same blk_idx. IOW, check that it has
> >> not been free-ed and re-used under us.
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -1364,14 +1364,21 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
> >  		ret = zram_read_from_zspool(zram, page, index);
> >  		zram_slot_unlock(zram, index);
> >  	} else {
> > +		unsigned long idx = zram_get_element(zram, index);
> >  		/*
> >  		 * The slot should be unlocked before reading from the backing
> >  		 * device.
> >  		 */
> >  		zram_slot_unlock(zram, index);
> >  
> > -		ret = read_from_bdev(zram, page, zram_get_element(zram, index),
> > -				     parent);
> > +		ret = read_from_bdev(zram, page, idx, parent);
> > +		if (ret == 0) {
> > +			zram_slot_lock(zram, index);
> > +			if (!zram_test_flag(zram, index, ZRAM_WB) ||
> > +			    idx != zram_get_element(zram, index))
> > +				ret = -EINVAL;
> > +			zram_slot_unlock(zram, index);
> > +		}
> 
> Why overwritten page can not be pushed to WB to the same blk_idx? 

Yeah, so I thought about it too but didn't want to go too deep into it.
We probably can only address it if we synchronize free_page (?), read_page()
and writeback(), so that we never have concurrent bitmap modifications when
one of the operations is in progress.
