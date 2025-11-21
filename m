Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03D428468C
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 02:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763693333; cv=none; b=HvsXbjALY8sbIVo3mlUT4Be7SAQAyRZdcjYPGBjFFGDbAiDsTMRF/i4U81+GZ//r2SUY/uV2dgH++ltv62c9ae+i4onXUKFnBxxYsz4zKEd5G9Fk0klZxu8KwQyk+uOqPpPM9dQaTOqr0eYcXw+HO2tzeJNkLeSmKWDiM2jh7Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763693333; c=relaxed/simple;
	bh=j1TNjpj0AXGkfucdsj5/q3BWkzbXPIPEtFPLFTdGMxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPMlozE1OQ4ub4JKps/ZvPEdVxDKG3qERoKQV/DmK3jcpi554v1PJxOWWfk6vRtVD4kw9xoWF1CNF/oYRFpE/8KSUSbdZgeD44P801W2qJJKrN4jKHgYuvh9TV+JP/2sYvjBQwZdKraWI117f5LiY9F3QrOFTshByVsQ5MlObZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WRRw5CH6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WRRw5CH6"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2980d9b7df5so20205715ad.3
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 18:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763693331; x=1764298131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mN56KAVECGZFLtl8e3BK+ApEqN4tpkmsSG1PhSyua4A=;
        b=WRRw5CH64+J3rNFQeT4NTOpA9F//uAAwJ83oGtvssxG3IYsS9aP3hd6fVF7fggYnL2
         PrMpvhnPDADy9c8GJEO012WnPY/Lu8DveQOkOfGaRLQYh31GUz5xlsAYOHwxDpetY+bH
         jz40ytFUVqe0IfdSjQdugkrwRYs1z89XwN9+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763693331; x=1764298131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mN56KAVECGZFLtl8e3BK+ApEqN4tpkmsSG1PhSyua4A=;
        b=oeotWhewpkcwm613lo+Kcefy9v0Y5hVofHdeR2O6n5qy5jhR0ZqAbHupENA37t2YSi
         +30DmzQVKjsAThkQ6CioT616w4lqjyNRrFo3vAbpDb1ANHk7jkUyn3y23z76JSnySL1T
         nxiWZaQY5yNpyRk7y/mGmx77xqWMxgZ2VycoqEMfbonnuDo866JKprMcdRF4hyqjlwDG
         23UxtWRqy0Nit4v/q/xbZlc0elgDA7d4yKjorlgzfBv6MHXdQU/JFIYDfx+Ym3cd7m8v
         6kkwLIft+xWQqDKukCHwAQh1+rnowDxDe80ubxTQqtio558aR1zA37xzFrflx866K1XT
         BfTg==
X-Forwarded-Encrypted: i=1; AJvYcCX9ZGrxMQMy9573qyzZnsubJv+avjgr/QxXDIKs1rW/TMs4jo8TiVxa3LYAzg7anmNAhmSVpwmCnLI1Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+9TVVkLu2i5kSaiXnq3G93GS/zKDKp64BTq6BpakRFmmWLMzc
	3kqVztcp5nSU2PoS2waB57ms20itqUmtKsO0N+QBpxdpVU4pnVIL4DAjkvVnoreLJA==
X-Gm-Gg: ASbGncuAB6qEWqsmOP7gpQq9sz0of/jnKYNpYdiHpG+VsuEtIOgVGMulsUesfxeE/LV
	cw+RLKgnO0HwG1sEvluqAFuBQ+Qz9VjVniLLZuyj1X7CBDAF758Np45cA6MZFAO1lMeW9Ed0ALW
	DaBHpsVOZ6kJwEZ02DN2rA08G3b0GxI0eKJjpfZfQxRHVPUgzjrxo083bMv9phBejeVHSClglzz
	7EmeULE5koygm/PvHuQzv8yIvjPjf/LJ3T3Z+zRf2mGd7N8Y50ATw0I/eqZljftllX6q1E+JJbE
	xUBqwlJ6/LBNCzB4adTfSxUVJ+RZDM9UV2UedtWa8s9rcSkSFNUQkJT1qCMwKNeSLKp66JWdpLZ
	4u90q8PoKGPvshhJ/y8M93CMA+50aTCfRbrf6Wm5ky5kwkuwpeelPCpiGncWm8YNx1diwlWCTnP
	gtXz+TRe076oa3lQ==
X-Google-Smtp-Source: AGHT+IGO8vM4e+LbFZ+U2TQaDlICVXlmzK2vO0o0gJ1AIsq/eHFmVseFKAQ/T+Qq1ikLdhGppW2GVA==
X-Received: by 2002:a17:903:298b:b0:294:f70d:5e33 with SMTP id d9443c01a7336-29b6be8bfeemr11923735ad.12.1763693331090;
        Thu, 20 Nov 2025 18:48:51 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b321:53f:aff8:76e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b15b851sm39168435ad.43.2025.11.20.18.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 18:48:50 -0800 (PST)
Date: Fri, 21 Nov 2025 11:48:45 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Yuwen Chen <ywen.chen@foxmail.com>, 
	Richard Chang <richardycc@google.com>, Brian Geffon <bgeffon@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Subject: Re: [RFC PATCHv5 2/6] zram: add writeback batch size device attr
Message-ID: <uboc64fpwzcs4phm2xppyvuf3h5clkijbiahsb2wd2vah3po5q@dnzh7ir6inqz>
References: <20251120152126.3126298-1-senozhatsky@chromium.org>
 <20251120152126.3126298-3-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120152126.3126298-3-senozhatsky@chromium.org>

On (25/11/21 00:21), Sergey Senozhatsky wrote:
> +static ssize_t writeback_batch_size_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t len)
> +{
> +	struct zram *zram = dev_to_zram(dev);
> +	u32 val;
> +	ssize_t ret = -EINVAL;
> +
> +	if (kstrtouint(buf, 10, &val))
> +		return ret;
> +
> +	if (!val)
> +		val = 1;
> +
> +	down_read(&zram->init_lock);
> +	zram->wb_batch_size = val;
> +	up_read(&zram->init_lock);
> +	ret = len;
> +
> +	return ret;
> +}

JFI, as was suggested by Andrew in v4 thread, this should use write
lock.
