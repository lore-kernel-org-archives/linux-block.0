Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331E194C85
	for <linux-block@vger.kernel.org>; Thu,  5 Dec 2024 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382586; cv=none; b=UrOJF6NS+YUM+DpTfZAnJ3j+ELeASr5TbqTFAEWdvFi9EIrW2XYHyjR53k48F6gIq2ueKYsSoeqAsjG7KUDRneWZ4gJnCZOvnhX+cbbu9Nj8Mi+cfe/pQVjh5eUi7rSeXro5FhMcr6pLiqB1lsshMD2CWPeQbraiQo0OD70Y0AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382586; c=relaxed/simple;
	bh=grkbsRH6D4ZYbAuOb1wmAAyXnV7iDlG0b6TewkJIGas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9godCG7hLSBFpr5BDXbTwG/aQSO8GpfogPyXyzY4atpxVqOX8pqyRC55IOPuhwNpRS9sOmGrX3HFzD9xgYR5cWrxSUFyKW6Jz8Kbwbe9uypIfBDpHrhA/GNdxsvXsAG5IxPbMqBvd4inYnCbv0axxUiZsG79G8WX8LI8BLINFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NsO9kCsX; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NsO9kCsX"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so522712a12.1
        for <linux-block@vger.kernel.org>; Wed, 04 Dec 2024 23:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733382584; x=1733987384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SHVMmQ/KzbcoO5ieQjC56n0uvyFf9M/Mj/sBzX0iX8s=;
        b=NsO9kCsXqWNmeiqUXxTVF1KOXwcQtipmoak50kQZQMmK89e+Y3q7VfDOcOrUJb215S
         30qmslclFKHLfVF0YXJ4r3429pPKL7d8uSaAXoJ5Yjw5p5liTy3VW8hQ/pxYlqYb9S4T
         TfFaNRfkjmVRSfy/6sMdyAVzbFWBAyvcM7Ucw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733382584; x=1733987384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHVMmQ/KzbcoO5ieQjC56n0uvyFf9M/Mj/sBzX0iX8s=;
        b=b5xmJYFWEgCB8ZIlBwwqpt2VAvHi1bwRho0ZzeVjYc8OFtLlTFmUyANW3Nol1w1xgW
         0eycvhSLeKIpiaJ85B4FnqSuL/gOvJnERtKJKx8IX9IBAY0wN/3ZoclUOcfoBs3uX6vP
         /WxMrPfo/CW387nYYDfBmcwLg2Bt28KaQIngBAPWILG7Y/Dad8hOiJMitQ+sVRjpLSLp
         t9HSbFVIUBHjMER/PSDBgvmS8VomrMPmM3VX3vX8lmHLzksr0r7VhjSeEBXzOWYfLTtD
         9iD6GkjJfqVmg5Uegg+ZDdwPZKyIMWY6A0YwxAecwsV9vNepKcHXVt3v/7bw6zDmAg9Z
         CEig==
X-Forwarded-Encrypted: i=1; AJvYcCU9hccqhJyf1YJZ/iNuXeDXK7Z7bCEUqZjJ18SZuSgWIJ7jhj1X1waFBKcMenGHshj0ejgaKmcY4tyVrA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn91sA/Inqjuo4ZS+JLKTQOViioMhs8uAgU/b2FPmi6JRLJ3EX
	OgtKQgEFYHeLMSn3qmTgU8lhI//QKBR1gV7sx+UN1C2w4bTTwwi3h0rAIaPgAw==
X-Gm-Gg: ASbGncufEPtKxCl1Td9DVeh9tKGXfWv2+ra/ddev32kwymjXlYb14SOFhJFl1pyks4u
	2Av0ffbBBcjwj7O7vsCOg3id72gj5rJS8wv7Gd38LzjMSDfDxegYgQWvAcZNfl7iV92VbFZI/KD
	blL5/yYBhQdMiXLVyJTlwOm133cPE+JJ1w9KluZgXORThVBMQ1BeR97/6/akf7I+7htwd8MCleq
	uB5/HrVPyXzTE3t/WLIkybVsJ/6GyxIr+Xkr7VpmuExtY1ou+ac
X-Google-Smtp-Source: AGHT+IG6kRB6dDFmeXz1ne2Hv+akOd+C09aPhvGPo0ufEzIuAUB/OWr1JBmHkYw/DqGSl8lg7DDPHQ==
X-Received: by 2002:a05:6a21:7e89:b0:1e1:6db4:8a29 with SMTP id adf61e73a8af0-1e16db48a6cmr8797451637.41.1733382584222;
        Wed, 04 Dec 2024 23:09:44 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:84f:5a2a:8b5d:f44f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156e1e20sm652384a12.32.2024.12.04.23.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:09:43 -0800 (PST)
Date: Thu, 5 Dec 2024 16:09:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Desheng Wu <deshengwu@tencent.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] zram: fix uninitialized ZRAM not releasing backing
 device
Message-ID: <20241205070939.GF16709@google.com>
References: <20241204180224.31069-1-ryncsn@gmail.com>
 <20241204180224.31069-3-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204180224.31069-3-ryncsn@gmail.com>

On (24/12/05 02:02), Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Setting backing device is done before ZRAM initialization.
> If we set the backing device, then remove the ZRAM module without
> initializing the device, the backing device reference will be leaked
> and the device will be hold forever.
> 
> Fix this by always check and release the backing device when resetting
> or removing ZRAM.
> 
> Fixes: 013bf95a83ec ("zram: add interface to specif backing device")
> Reported-by: Desheng Wu <deshengwu@tencent.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/block/zram/zram_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index dd48df5b97c8..dfe9a994e437 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2335,6 +2335,9 @@ static void zram_reset_device(struct zram *zram)
>  	zram->limit_pages = 0;
>  
>  	if (!init_done(zram)) {
> +		/* Backing device could be set before ZRAM initialization. */
> +		reset_bdev(zram);
> +
>  		up_write(&zram->init_lock);
>  		return;
>  	}
> -- 

So here I think we better remove that if entirely and always reset
the device.  Something like this (untested):

---

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0ca6d55c9917..8773b12afc9d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1438,12 +1438,16 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 	size_t num_pages = disksize >> PAGE_SHIFT;
 	size_t index;
 
+	if (!zram->table)
+		return;
+
 	/* Free all pages that are still in this zram device */
 	for (index = 0; index < num_pages; index++)
 		zram_free_page(zram, index);
 
 	zs_destroy_pool(zram->mem_pool);
 	vfree(zram->table);
+	zram->table = NULL;
 }
 
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
@@ -2327,12 +2331,6 @@ static void zram_reset_device(struct zram *zram)
 	down_write(&zram->init_lock);
 
 	zram->limit_pages = 0;
-
-	if (!init_done(zram)) {
-		up_write(&zram->init_lock);
-		return;
-	}
-
 	set_capacity_and_notify(zram->disk, 0);
 	part_stat_set_all(zram->disk->part0, 0);
 
