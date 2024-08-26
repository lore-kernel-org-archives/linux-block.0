Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6074C1B
	for <linux-block@vger.kernel.org>; Mon, 26 Aug 2024 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724703382; cv=none; b=FeI9ifnSSZZ/389HTQuwyU0z5P3Bt5xF6M1qOtgSmY69b0cfizgTbfPJxV/srtVpxQk6qzpyUhcGuc0BhCzf1XpAt7VH7WT1FCwEsA+0giY9YlKFtM8N9o2d+hAnYScuiSGwGrGp0mCC6FYgF7nN9xguEAorLWu6/B8nirANzk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724703382; c=relaxed/simple;
	bh=EZ2ygm6G/NnFoOPeqy7rnY7z/Xqu0xb4N0J1Un9eJso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEtjaLKlF960tGYD+5J8LrMXUREDDH2qcOm2IKJzOLs/ZTYWXdnw2CrBbsSfTQ+ffwU4eZVWQ/AeEjTuerJJ5MiKzFQo6ejrjaWSQ+qcbgnEgKTCTK5Uxe1jSLL+GuOV5T/iTobhiLQJ/ZjzwnxFUZ+vs4xJA8YKhhho/67W/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=12NE4nTn; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="12NE4nTn"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8251e23eaebso169090639f.3
        for <linux-block@vger.kernel.org>; Mon, 26 Aug 2024 13:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724703380; x=1725308180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sSxs7jjouvW3KnBPno8bcr1cfW8lerR5JOU49camY7U=;
        b=12NE4nTnHWOhVwPaNdvdWQiU43XhQvYOE6/zNmSoEyrNrzm/CZUzihQ4TOwlJyIbVl
         wzfXYnUPSEwOzi+AD+Ff/kKqr0VCEykaSu0PC9XYyWBGq0ba7Km5yVsPxQrYofhfPb5v
         cmyMiqHtv1tbYKSPapFjC7GCcdrXO615IvrstfR1K0Hon4oAfZDmPLQaJ1eF5JxAwrko
         keCGIWDZ787hOelNdUQtCbIlbVb3+akeLP49N5up0KtH+8nmssKSKEWqncWFNIwaiG3D
         M/v0gjKAMW1XoXRaRdayYTQJoiuJ3mLs8lDYjPP9bXAT0oqrYmBPtuAYMDvdpy7uAxKE
         TPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724703380; x=1725308180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSxs7jjouvW3KnBPno8bcr1cfW8lerR5JOU49camY7U=;
        b=XEDsIgAXPyOJ7Ly5BTXiu87hR39NYsjeWT2B+6ytP6EiaGJi/TnnExrkifcWZZT2bx
         jaxRNZpPlxv5E8QABjxE4vDrUpWkWNU762iLe8EBBZd/eLHJU+8nlMEzbsQ01cWT/yIy
         Gq8c6FP+qhMeorvF35zYuHQ9nbHtfpcrQdnUX2/i03ew3Na71tmrldy/el2Jaa8b58jl
         Rl7TcFm+WXI1iHZ5wudl3PY+nkl/juOU4fG00sZmlCA1gCQfyVYtkMMIEmoEAj2VacQJ
         T5Ou8ayPV3DGnVDTIldvA93zdC4iXJ3+RnH1ZCkR2ecj83oBVuioo/hxUduA55YdLRUY
         LqSw==
X-Forwarded-Encrypted: i=1; AJvYcCVGqYCUCPdI/Sxp2KHD39X9BnwPxS2Vp4s4oVoaz+yzgrx8N03M6VoBEuV38GoXBAquZitgc82JYcz25g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3a1WpglY4YHxmBePdPBdnrYC5yPZU3ePbjVVn5HbST9yBy3hk
	4Qg2F5IhJhoHw8ATpwXmO+Jh30eUiG+wGGLa4g2lo7Qnp8UKiEpSf7Cke7Q88OI=
X-Google-Smtp-Source: AGHT+IE09LM98Fww2mHxkcFOYXbtJ1LS1EZ1s93chVjvbv4O4wdv5u9HvkuJeWYYO4JVINgKmY7++w==
X-Received: by 2002:a05:6602:6305:b0:825:2c2c:bd7d with SMTP id ca18e2360f4ac-827881ae83dmr1235550639f.13.1724703379860;
        Mon, 26 Aug 2024 13:16:19 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f1f670sm2338418173.25.2024.08.26.13.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 13:16:19 -0700 (PDT)
Message-ID: <c698f351-5fdd-47c8-8450-54af72c7ad4c@kernel.dk>
Date: Mon, 26 Aug 2024 14:16:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] pktcdvd: Remove unnecessary debugfs_create_dir() error
 check in pkt_debugfs_dev_new()
To: Yang Ruibin <11162571@vivo.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240826062653.2137887-1-11162571@vivo.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240826062653.2137887-1-11162571@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/24 12:26 AM, Yang Ruibin wrote:
> Remove the debugfs_create_dir() error check.
> It's safe to pass in errors that it gives you.

Please make it:

Remove the debugfs_create_dir() error check. It's safe to pass in error
pointers to the debugfs API, hence the user isn't supposed to include
error checking of the return values.

Note both the rewording, and that commit messages should be formatted to
72-74 char line lengths, not tiny ones.

-- 
Jens Axboe

