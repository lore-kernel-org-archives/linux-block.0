Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B033B6F1
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 03:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784863472; cv=none; b=BO0qENzozvXAc1eF6gBSB3vCHPaxi2zese6M4QjMtKgHrKQdyGqONaX+Kt1s8d16fIzfKCSZZhjcXK4nWzM/WjsbTvCpwqCABWXu6SJYzs5pKaQLfjPDq/yv4vLA/uRTn3OcLUHm1ZUm7xAXtJnUPGCt814CcVKrd/2RfpQzjSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784863472; c=relaxed/simple;
	bh=rgjOfO4aPyc2lcOdqawmMnLupom2yPe5T+CEQOfc8NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxBSkVkWWWxRhfxOKTvsFgIq+kE5eENq75qUTgasDsoXJgLK42Zuvij9KAYdluFNYMdo60n0FeMG8XbYXyXo5tgtYJ5eKWdTbKgXArfiVjL20+NDRIDLrbCXs9+/TWt9dSJkn57MA42H6GOpFukFsoqNUjnER3NHG/1Qen1kwlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QCtEACXi; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QCtEACXi"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so1316016b3a.1
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 20:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784863471; x=1785468271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hm9oIj1K1tgewTs09Ec3mlyW7LXuMO/BD5Jfkqnoqbw=;
        b=QCtEACXin+GIK6M2U4+KxobGqs/yGZHUEg6d++PDhm8Rc0QOmZcZCWgPyiUd07LScF
         7C2kKwi2AJurKLCoSkCxINPSsiwrRXu/0o0N6pJ4E0UoBGsm0ogXkxplhBiDtmSQhTRK
         0pCPdxHxOuNNDQV5W6PfKycSMb/mKl81V2ITs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784863471; x=1785468271;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hm9oIj1K1tgewTs09Ec3mlyW7LXuMO/BD5Jfkqnoqbw=;
        b=jQUT58HW+6ozarCgpBQR3zhBuc45JHmR4FQ+IVqnDF+XGu5W8NUYBrXvDWyPFxvCPj
         zvCUs4frVNZSjqQ3UZItpBdbnR5wsKBl4AXQaiK6jhd9xFLaBTeIOPWwuK9fKlcgUE1Y
         /RNmI1wu97GKLKsr0otS8GsM325cDQGSvtr2fn6Nn/jWh22MqAGKBm3NWfJERpWoKCzT
         3hbyKCgi2rQ7rgnMe7cWkxGI+mJz9SxtgR9i5R/HWKO3j6wwBYhzrPE8idEp/uYu/ry8
         J6rh0mATpZaiUo5e7+gLdodsPOFG9ixj1GKQYPijXVY30QJfvJbz3NA4gUQmhDeEY+wR
         KZmA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3iJ33IPlGVcHU0OdLxvhw7PsfhcSGbCw17SOOHBv97pb3PlhbdwpN6JNidGZO5x/llRTCYHYr4oXcxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGbpynM/Ht88zbWhvhM/4yMM5kzzHwhszY5kh32ITCroASRlzC
	spJF1qnDCdBkkl7kTNAPcaIDJUa/1h2qyZQOm2oV84WVUhIgvHR/wHOe2nl42U+JUg==
X-Gm-Gg: AR+sD13wbJNURDIEO7wjBXJbKyyZlg4OnAEM6BfT5AdisRcQVxXG542AQ7PrRuDb745
	WUxvjrMfbv8rpBXcw5gbRmMce9ysqhhzJdEvmFKdLWs8cL3ReCUcsCWo4UHbqe37vFSpZKssW1U
	YFJfUm3yaZUDaxKhzAP7Kx7iMRJ7nD+FztD1ODaOpUGl8S01eGEL0U+0eJ5NWOT3JPjg38QtjbQ
	YgS+BnFle5upOK9qxs0W8O5xy1KsrmIMezNr5CWXta91i1rc3RYSEFKbDBaxJ+QvPYcazub3MAU
	mFOvZ/2zEfizIZRTCD6SupO2XSm5td+XZYckXKbY04nkoO2oMzerQupOiz6UuqK6ppSWhCqb1Bp
	ARIyQuYcxW/s+rBjJHUGI7oLLX0j7EPqxiridSCHrTG2GcbxPp7AB2ZChbLwKMRFPYIxX2CEh+l
	bzV5y/vYXas7Rwemtk4cbJpMI6B6JXoidnuj4KTsIbLg==
X-Received: by 2002:a05:6a00:4f90:b0:847:7cf2:a8ff with SMTP id d2e1a72fcca58-84e2e957966mr5971433b3a.30.1784863470651;
        Thu, 23 Jul 2026 20:24:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:c102:f12d:5168:6be5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175f31b3sm4001385b3a.54.2026.07.23.20.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 20:24:30 -0700 (PDT)
Date: Fri, 24 Jul 2026 12:24:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] zram: Use a custom key for each zram object.
Message-ID: <amLYsq36Qm4Isj63@google.com>
References: <20260714141300.3945672-1-bigeasy@linutronix.de>
 <20260714141300.3945672-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714141300.3945672-3-bigeasy@linutronix.de>

Hello, sorry for the delay

On (26/07/14 16:13), Sebastian Andrzej Siewior wrote:
> Each struct zram uses the same key for its struct lockdep_map which is
> used for locking analysis.
> According to Sergey the lock chains might be different if zram1 is used
> for and zram2 is for ext4. This might lead to false dead lock reports if

    ^^ swap  (a minor nit)

> it mixes a zram1 chain with a zram2. This can be avoided if each lockmap
> gets its own unique key.c
> 
> Use a dynamic lock_class_key for the table_lock_map.
> 

[..]

>  static bool zram_meta_alloc(struct zram *zram, u64 disksize)
> @@ -1999,7 +1993,8 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
>  	if (!huge_class_size)
>  		huge_class_size = zs_huge_class_size(zram->mem_pool);
>  
> -	slot_lock_init(zram);
> +	lockdep_register_key(&zram->table_lock_key);
> +	lockdep_init_map(&zram->table_lock_map, "zram->table[index].lock", &zram->table_lock_key, 0);

So I wonder if we can give distinct name, given that it's per-device
now: "zram%d->table[index].lock" and use zram->disk->first_minor (which
is a unique device id).

If you are too busy I can just send a trivial follow up patch.
Let me know what you prefer.


Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
