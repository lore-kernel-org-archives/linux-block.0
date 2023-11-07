Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41C14F94
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZaP34jUM"
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9660511F
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 02:40:47 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6c39ad730aaso2122575b3a.0
        for <linux-block@vger.kernel.org>; Tue, 07 Nov 2023 02:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699353647; x=1699958447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E5bVgAnBrPKuuIv1GsX1T/ElEDbYt5f55yZ06zTuk7U=;
        b=ZaP34jUMScv4Rb96HwxndhamdxgfJMy7TSX4GbeERQHgUTm9nrBxcY9RdfdRV4v10J
         NWDSoN7BAaZK+BoBUtWr6P5Xo7z0c1VG2Plvx6y8MCnkOv1F3/tpi2w+6QleXcvDcd0j
         2tPA6gTqWIbaeC6hhjiisRHBnhLLmVcMwR4/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699353647; x=1699958447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5bVgAnBrPKuuIv1GsX1T/ElEDbYt5f55yZ06zTuk7U=;
        b=PxfkFiVSa/Xj46QW5wVxhU0s/WQ/lAmOzlpc5XOo0GccNG/C3bs5lDWzY64d6r19be
         CQJH3ovIPn998UZyHFkrmKGhtU/cU46mSsRj+1exClQtnJKayo7oIARiKDIjEyj/4DmP
         d9Iw6m96KKGUtoIjEcWyFrsy/DBDAUyTmGJfvpkNiaLgI+OB8m6cxmjp7BJl7NfuKwqz
         5AbAlNZN8Ji/RW6K4yHt5uhviu6rngfQgWOYgrY90lHg+SesI22SonZNQmzRFKOQnAup
         NPzXWrZhczW1MJcx+YL6K/WUs1h41N5JOEUwK/hHxBHzhCluIcK/4UMhPAeWSycRJ6s7
         fmMg==
X-Gm-Message-State: AOJu0Yy+o9lBoaf5V1Hqmef16gChyfMYu12bihRubLN/BCzxFsunCHqR
	7POIqsDFdH0P6QxfyRD3X5WKl8nkEJbRepAfgxQ=
X-Google-Smtp-Source: AGHT+IFbRLUT4lyHV82+MYXOzHcl1oHrGFAtsDfQLUUvqeVDjzywe/ntyfH8P+tltWOAAe1E+vLoPQ==
X-Received: by 2002:a05:6a00:24d6:b0:68e:2478:d6c9 with SMTP id d22-20020a056a0024d600b0068e2478d6c9mr29983222pfv.2.1699353646837;
        Tue, 07 Nov 2023 02:40:46 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2fe:d436:c346:6fcf])
        by smtp.gmail.com with ESMTPSA id fm26-20020a056a002f9a00b00694fee1011asm6906299pfb.208.2023.11.07.02.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:40:46 -0800 (PST)
Date: Tue, 7 Nov 2023 19:40:41 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Vasily Averin <vasily.averin@linux.dev>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] zram: unsafe zram_get_element call in zram_read_page()
Message-ID: <20231107104041.GC11577@google.com>
References: <d10cdf1d-4a67-48df-b389-3a51f60e9431@linux.dev>
 <20231107073911.GB11577@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107073911.GB11577@google.com>

On (23/11/07 16:39), Sergey Senozhatsky wrote:
> On (23/11/06 22:54), Vasily Averin wrote:
> > @@ -1362,14 +1362,14 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
> >  		ret = zram_read_from_zspool(zram, page, index);
> >  		zram_slot_unlock(zram, index);
> >  	} else {
> > +		unsigned long entry = zram_get_element(zram, index);
> >  		/*
> >  		 * The slot should be unlocked before reading from the backing
> >  		 * device.
> >  		 */
> >  		zram_slot_unlock(zram, index);
> >  
> > -		ret = read_from_bdev(zram, page, zram_get_element(zram, index),
> > -				     parent);
> > +		ret = read_from_bdev(zram, page, entry, parent);
> 
> Hmmm,
> We may want to do more here. Basically, we probably need to re-confirm
> after read_from_bdev() that the entry at index still has ZRAM_WB set
> and, if so, that it points to the same blk_idx. IOW, check that it has
> not been free-ed and re-used under us.
> 
> Minchan, what do you think? Is that scenario possible?

Basically

---

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f5e3756fc21a..2d69f6efcee3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1364,14 +1364,21 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 		ret = zram_read_from_zspool(zram, page, index);
 		zram_slot_unlock(zram, index);
 	} else {
+		unsigned long idx = zram_get_element(zram, index);
 		/*
 		 * The slot should be unlocked before reading from the backing
 		 * device.
 		 */
 		zram_slot_unlock(zram, index);
 
-		ret = read_from_bdev(zram, page, zram_get_element(zram, index),
-				     parent);
+		ret = read_from_bdev(zram, page, idx, parent);
+		if (ret == 0) {
+			zram_slot_lock(zram, index);
+			if (!zram_test_flag(zram, index, ZRAM_WB) ||
+			    idx != zram_get_element(zram, index))
+				ret = -EINVAL;
+			zram_slot_unlock(zram, index);
+		}
 	}
 
 	/* Should NEVER happen. Return bio error if it does. */
