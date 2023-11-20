Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ZNkQsobK"
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5840CBA
	for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 09:08:04 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6cd09663b1cso3094972a34.3
        for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 09:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700500083; x=1701104883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YONG+Z2URy3adHFF9a9PVlDLMWSCL7QCJLkVV8u42Pw=;
        b=ZNkQsobKvKdCL5Kkrx73xMxt+yoOxAEqzqxHfFngU14SX4zsgAupXQztKG+yvgqZL1
         FM3Aqi8+snFliYSusXYCYZM7rVWIotjYuPGz/pr1ADn06YXsElZQCgPOScMz6vpRZevl
         6Lb1tDulwo8ZfQtDob9059QN88PnmtW/n3Ne2d/ARHHS7rkJmacTxfSgW6AupT/x8Wee
         XKb5vT9byw5GYuQpAR0vRgqwkW/W4VsIu2A12/XFTATmuCQAdE2jnoLvwzZg0pQuykR8
         N4STGC4nmcBdZV+PNuTkKeUTq4YxFcmN5jVz1wTJ+WoGEdI9mGajvkLCJT7uVw3xXMJG
         vpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700500083; x=1701104883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YONG+Z2URy3adHFF9a9PVlDLMWSCL7QCJLkVV8u42Pw=;
        b=OOV7/wApG+9Wvb1fzPgLVfUBlXBtyqPcfq1t7eEsKtwoHE68V8thaM5IyJryNOaL9t
         gHSZdt8j1c8QdhbB07OansQwKv+tGf0Fp0ypfRoy/n3AvualKJUmfKQbBvxckbimtL/3
         iSjc8CvaV0kunvo10vg4kfEYB7v4N08ip08wNfCD7UauLqJ/SZwE0h8Nj4CJrr2KLfuR
         c0J2nz5Rkz7yTzEHueBrYUiBldGfUrWzHnecn+zKjVwRtAG7IgpuU/GbAtW5Oq21U4H0
         MhuM7WnRYMqAlMCZbXhsd0VyAFPmzEH8+WUU7vVGXNCtmsARWJUJiRbILYeuA+10i9Y1
         VlRQ==
X-Gm-Message-State: AOJu0YwiH4iMF24OTZzuEnB8C68r08OSt42ZgX1OtfSmH+02P+EBc/Vh
	ExFE8X6v9W8Zt060oWyy78cWAQ==
X-Google-Smtp-Source: AGHT+IFntqoennN4i02M6FokmS927XOCsf17rxNKxMCqvhCEf4Qanz23np6ZpH0J6iyKKVqOgDZ1Vw==
X-Received: by 2002:a9d:7f9a:0:b0:6cd:4fc8:3efc with SMTP id t26-20020a9d7f9a000000b006cd4fc83efcmr2991186otp.19.1700500083719;
        Mon, 20 Nov 2023 09:08:03 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o10-20020a817e0a000000b005c98f9d2444sm1389692ywn.3.2023.11.20.09.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 09:08:03 -0800 (PST)
Date: Mon, 20 Nov 2023 12:08:02 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: linan666@huaweicloud.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
	linux-kernel@vger.kernel.org, linan122@huawei.com,
	yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH 0/3] fix null-ptr-deref in nbd_open()
Message-ID: <20231120170802.GD1606827@perftesting>
References: <20231116162316.1740402-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116162316.1740402-1-linan666@huaweicloud.com>

On Fri, Nov 17, 2023 at 12:23:13AM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> Li Nan (3):
>   nbd: fold nbd config initialization into nbd_alloc_config()
>   nbd: factor out a helper to get nbd_config without holding
>     'config_lock'
>   nbd: fix null-ptr-dereference while accessing 'nbd->config'
> 
>  drivers/block/nbd.c | 82 +++++++++++++++++++++++++++++----------------
>  1 file changed, 53 insertions(+), 29 deletions(-)
> 
> -- 
> 2.39.2
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
