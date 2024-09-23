Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB0C19ADBF
	for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108182; cv=none; b=t+Ezf7ezIVAimGhi7U5UvT+3audf5UNBpDwIEA4WoM+Q0yv+bCS9InGrdytOcRJQxxy5Wq2AsoRbhTViNG/asu9RRIC2DSgtcpw0qBHYJ8R+2INrP7NMitm2RXpM/r3kg2B1jXT3MW79ZsOw+ImPWRAa7PcgriHubi/QmaErdKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108182; c=relaxed/simple;
	bh=Jgi9WZn3ocScTDIXMurCWzHK1+wuwKcb7pJ9lWRo+vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEtjVMJabN2AonHnLQpYyfxVw0r5klsIlx2H1mme4jxia9TRz1S1cm1AnDmCtFeRaVMO9ebnE4LvLwNE/FGIbUwcGIEI6HYMxdGaOHIvajNInf/R9w4lvgl7BLzm01VoM9Z4nuQjYHkt8OfQTmJ586DYLGw85Xhjz0EAgVEJXSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bf4b60Zb; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bf4b60Zb"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d50e7a3652so2634641a12.3
        for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 09:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727108180; x=1727712980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3TDWYxveihy7Zr7fGwjiPX+G3CzpwHb+Ud3Z6ThKWQ=;
        b=bf4b60Zb54mV+ypBdlZZPgOJe6MThH1fSIk3ZkIFtWptDsRCxXEBWN+ibsPADi7oW4
         FUJMPuZQLpNqcwdshO//kx01eMNBX9tvtQ3DaFyODq36VAyV6JoVam9uATd4cD1h6eDx
         gv1L/0uZ4zn9lKTXCBSaQOxQRfEAFrhzKafeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727108180; x=1727712980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3TDWYxveihy7Zr7fGwjiPX+G3CzpwHb+Ud3Z6ThKWQ=;
        b=jSQXommKYCd4F+oxgUk4NDU+y/Cw0dkGENT5nEsxC3yWAkA+LekYiC6v2ES4bN1pOy
         jRH3g7A4MDE/4GEVzEfzHj39pry460/i7PSb55qVmYUFKYiwsgqEz685E1R9kvCjA/66
         2owlGG3kWFklYoi/BLQYn8hwNdB+HFCV9unPRqFOFF9T6y4nj/ko8+img6kTikkXPtcu
         OBnP7SciGUJiKrbquK160UPQ8yRTQYubTxTBhV7xK59XuumEqtLrZbUMH84kCcbtG+dZ
         8YOortEtuufCnYJjY4Sq5cvssxHea0zLUZ30RTBzcBd0mNgR6N4OV8dyQy/ucxerr5O2
         6nOA==
X-Forwarded-Encrypted: i=1; AJvYcCUkJNMaT6mU6CelBcZ1B7vFf7vZkGo6MelqnDr4HN0LWgfFIOW0sIRDDiAD/O6Yn3K+AfNuNmeyoRvEPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3kQo1iDxQHsToY7KdedhQ6MVidLNZ0fZkpbgZzouY05yFIecE
	qvLWNJaleu3C6i8Gd1EEF3GZmLSQ8nNJ5kiVha0Kf4VUYQyGazf/KHV1cumUEg==
X-Google-Smtp-Source: AGHT+IHVkQZwGgU1tvKl6k0F2v8TePIa8llrR7z9ZGmNXnGWkDebtWD+GohgUHbySm8F8jMBfv0+Cg==
X-Received: by 2002:a17:90a:c70d:b0:2dd:4f6b:6394 with SMTP id 98e67ed59e1d1-2dd80c7ecc7mr15271796a91.19.1727108180174;
        Mon, 23 Sep 2024 09:16:20 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fd63:e1cf:ea96:b4b0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef93b2fsm9619831a91.49.2024.09.23.09.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 09:16:19 -0700 (PDT)
Date: Tue, 24 Sep 2024 01:16:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2] zram: don't free statically defined names
Message-ID: <20240923161615.GG38742@google.com>
References: <20240923161108.991709-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923161108.991709-1-andrej.skvortzov@gmail.com>

On (24/09/23 19:11), Andrey Skvortsov wrote:
> The change is similar to that is used in comp_algorithm_set.
> default_compressor is used for ZRAM_PRIMARY_COMP only, but if
> CONFIG_ZRAM_MULTI_COMP isn't set, then ZRAM_PRIMARY_COMP and
> ZRAM_SECONDARY_COMP are the same.
> 
> This is detected by KASAN.
> 
> ==================================================================
>  Call trace:
>   kfree+0x60/0x3a0
>   zram_destroy_comps+0x98/0x198 [zram]
>   zram_reset_device+0x22c/0x4a8 [zram]
>   reset_store+0x1bc/0x2d8 [zram]
>   dev_attr_store+0x44/0x80
>   sysfs_kf_write+0xfc/0x188
>   kernfs_fop_write_iter+0x28c/0x428
>   vfs_write+0x4dc/0x9b8
>   ksys_write+0x100/0x1f8
>   __arm64_sys_write+0x74/0xb8
>   invoke_syscall+0xd8/0x260
>   el0_svc_common.constprop.0+0xb4/0x240
>   do_el0_svc+0x48/0x68
>   el0_svc+0x40/0xc8
>   el0t_64_sync_handler+0x120/0x130
>   el0t_64_sync+0x190/0x198
> ==================================================================
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> Fixes: 684826f8271a ("zram: free secondary algorithms names")
> Cc: <stable@vger.kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
