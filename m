Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612383B95F0
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394847; cv=none; b=qBiuaPFBSLjlVQeRrTr1Gc9IlUZKCFld1vGbr5Pz+jGNeXlOqMC81aev3pEKJL6Lny22KwvJ7XpWjb7WDM0qYu2SHKIxnmhlwLsF+H7YqGwhwjaRIOQzF/Y214jwJmtQO02waZN4SvsMRiWr0H2fT4pbI9Bct45vTS541+TEx1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394847; c=relaxed/simple;
	bh=FLpkfaJDuEeqIwYpqo/shd11sSgL8uzmgI+MKV7dKIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbH4/Fn+/G/RbB/pjseMGB8yjXeeqUDcOfSIOwT1sboxHVQO2H6KU4zNZdLc5iGbvhXo2sdCJdS2z7POCR1UpTD5Kc4NCysqBRzxPvgR7DRbk6KHFYKA8wkUjbsHK1Ggl0EJ6drjf0OvqugEA/jebrlpAGvsA1ZplBKRJHUtaZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HTntrq2J; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HTntrq2J"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc61541f8cso5252475ad.0
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 00:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785394827; x=1785999627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kmQwbnowmxojZsKZZE98MtKAi+i/Wx/9r/LQ4dTILJQ=;
        b=HTntrq2Ju/DAQm5QLIyXzjHAgUG6qobvPDuBurDl59qz2QiEgqeT9Mxv+ETZuy5j1E
         mzBSO+ExSbaphM7cveeqeScweHcSJDPtfx/F3z2lugc7yJts3E6ldmzxFPA4YhrcZiFz
         HuiHp/1++5ZG6dKtZDQBRBNNbPuu1A1AWBLw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394827; x=1785999627;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kmQwbnowmxojZsKZZE98MtKAi+i/Wx/9r/LQ4dTILJQ=;
        b=oHzUjazAdOT0ftBRsheQSImeJ8p9Q6dzAWleS3gVO696E/nKDjxCO4iAPBH7NoATgo
         t1OA9sxnQM+rO2avDITSuQ3Y5Hlolbrg3UehUndI7g3jXLFQpVtpsWyJUoKOXwvXfjF6
         ZhktaJFb17I6rX0ktm20ODBc3aGsm0/3jF+XBo+Mb0fx/7nmxbRQSKh331R+vOW8diHy
         TLJXUr1VSn46bSzmXyFFhk5stUtSjuMzaBF5H2PuBRxMoSskgLF4Ies1WcY3I1FjZHqi
         ByUNqcYD/t0LQWfXiMw0lf9514HBj5Lp9MYQD8/Y3RYEIAhJrcFu0tbmLQco8q4w6N2A
         Qg0w==
X-Forwarded-Encrypted: i=1; AHgh+RosaGcvtymKtZpNhsbgqiwekkQS3icxK7BMtXhmZ9se5cx5LArcdzemTslym+b9uydwJhxjJ4OS0t4G5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/KbxXrGTpPa6ykNZtTzhjdkf+al3fYKZpbUbbveQOcT4GNaSg
	bK7MLFQbJBzehjHlBA18zwF5L0Jm8kHCUqku7P15LlVScSbX+55pupigrQnXOrmcsA==
X-Gm-Gg: AR+sD12i1pOX6RzENMu0m0jn7rZfZ3HjriPFK3fXjyT1/tP3BBUOYohwwp6v2D1IghQ
	rVFPcBLgcnG755Fm0QVJHZf1LC7Ci3840nayLw/JRDczI4uCMZOikuGQbx03CFCA8OOD2+CejhI
	wrhNYQCZklZSGEa0cB6asnu0MLV8Wlx7P3YNtdrFyEp3YKuXeso83TgbS6qGFZ49LpKXjcvdMIr
	yDMlhSnGQXYgTgAUqQi+28ypQcSLrdzS4An6bNx3e8m6mUMdVDQQgWbnUIrgwVRgvd+/CJ1Y0/6
	j8pqSpHuou+u98nWKLU8RDk9nVRcjxaJJSjP6oCydggg1oX/5I9wCH9Oy1oO4JRJWqH8sUentsT
	I++jPQlIMTltwxZXO3a9PltyY18aUKehAQOSH5svqnBq850JxlG05IrY1r/3b6mx01U//p9cOsS
	GKI0XGnfzkUkHe1C4anghH+lqu8O7Sypd8sx721wPlwz1R5C5TTIbBC6l63u5N+wQBmwZwxXIPM
	/FSWbdbGuIeKShXbakD/FCmnOKrtQ==
X-Received: by 2002:a17:902:e94d:b0:2ca:53f7:3c69 with SMTP id d9443c01a7336-2d036eaeeaemr11751295ad.9.1785394827512;
        Thu, 30 Jul 2026 00:00:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fd2f:da94:c3be:e16c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c1b529sm21411665ad.69.2026.07.30.00.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:00:27 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:00:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v4 2/4] zram: reject zero-size dictionary
Message-ID: <amr2RKJa5RBGn9TM@google.com>
References: <20260730025240.17724-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-3-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730060133.80233-3-haoqinhuang7@gmail.com>

On (26/07/30 14:01), Haoqin Huang wrote:
> kernel_read_file_from_path() already rejects empty files (i_size <= 0)
> and returns -EINVAL, but the current implementation only checks for
> sz < 0 without logging any information. Use sz <= 0 to cover the
> zero-size case and print an error message if dictionary loading fails.
> 
> Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
> Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
> ---
>  drivers/block/zram/zram_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index ace65c586072..0223fd83bbba 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1709,8 +1709,11 @@ static int comp_params_store(struct zram *zram, u32 prio, s32 level,
>  						INT_MAX,
>  						NULL,
>  						READING_POLICY);
> -		if (sz < 0)
> +		if (sz <= 0) {
> +			pr_err("zram: failed to load dictionary %s (err=%zd)\n",

This leads to a double-prefixed line "zram: zram: " as zram already
defines pr_fmt().
