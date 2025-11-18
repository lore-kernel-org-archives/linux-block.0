Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C77286A7
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763452349; cv=none; b=EB+sC/SP/TE/N5Lx1W9LD8GbExHjgBqMDL9va4n0JXBgpOF0JSduxFH/wfzsmK7pdpV9AH8hSrDiWItTSB0L5FlzHkRnZMNQPxNVIKJcxmyDvcjnLIMoqKurIQxI/yB+Sqe/4X9uf2ZKkjlwBz701zTbPd6xqVeWz0Jyb52g1T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763452349; c=relaxed/simple;
	bh=qzaKfzrau9dH2g952b3wOv2LMkjbAWJffhqZKfRI2S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhxVx7+s9fx4zM5H3s+Zbg6PQ25Ax0ZHAXs3sIBcspIOZuse1J7Ou7GaCNTOSVf1ijH/FY98OgpVkQBAJQFFw0f36wWIDsylXTwjNdmQlJNTrTUaL8iVkLxftX86CTAKgKpBOWv94DCE7PopiGO9Is4GFILYQ6F8Pjzszr26dPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JvXwMY0H; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JvXwMY0H"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso5856935b3a.1
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 23:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763452348; x=1764057148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8o0lzY5+KXKP51IAC5h7ABQJPt8SMWT+JESmyEuQ4GM=;
        b=JvXwMY0HcyKrqUFRJ/WE813zN+j3Zg98pxKVpBu7L/M3jwGQ1dlrRSg76bf2R7Z0QV
         hXnhvbNnshHrgIZxYeWmw3aE4xIkiCjIV74UAynQjznIj1I1BkzCoA+EQexgjrWqTz/K
         kr4oTQ44DmYoC4FY+IH5RfHOL9xpNm5+WRBko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763452348; x=1764057148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o0lzY5+KXKP51IAC5h7ABQJPt8SMWT+JESmyEuQ4GM=;
        b=aASczvTm9TCunQgaaHdgbuR78reE1Ftau/MkyHlKYeGTG1F6iuzbl/v5c4Au5Yp4Rl
         QovpZgSj5ieE2Ttug5sFGyaGXf9VbjZmtUkUsiu2+OrRUWTPL817cMuu7kJ23K08y0PX
         9zqsEAefuVTfWzg3FWaPw4CUy/ROvMSkgzXdhe6OuO9qJ+//nHoHDwczCZaN/ipbhjKf
         dGRCgltrn1WI/cd7HGdYhuIfL2zVtlTcXNK3gtg6DDSjHts+fm3Q+fCF+1fZQxrWOuc4
         ALnu+3l1pze1eU9hSsxQH7f+28vgGW/F9hm3uxMuJgzljMFLwDthl0z0txOlOfZIC/1i
         x1mg==
X-Forwarded-Encrypted: i=1; AJvYcCVcmYUFFQiQmya5hNo/rCwrFOCLo+KJVfFnEd1RWT/KcnSJhY22dEn4GY4F1RG5cOiBht+ekDRm9yS8uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDsGsXUNUVgYhwFshD4WOmkRZ+HqNlxJhP1wf6NpdZx+93hrME
	beHtkYojo0f9xrIXy9GCtouG09pgiEg5XvRZZa2o94SzkYv+vfUJG+ALbwyAq6Dspw==
X-Gm-Gg: ASbGncs4su8KgEuO2b1FZG+FTMSIpm/GqSkVIRbJ72/DHCJzeNI1iA3KmM/OFn1c3YM
	3u6+SFKJ0eHHSioDwfLitu7HCAMBuibnykCTOfvHIojA4J2PE6X9boAPA19Ygs617hXcZhGKS4K
	S7t7SrWsBsgVGjxEwUiIgFbUqYRyLH6XB2iZdpljk61t6Q/HBW+TPBBBLNk8FSHO2RQioZDWAq5
	U6fySOh2Gvfc019kWdyyOOJs2oPYzW0Z8PJjZVpECbJkK4VFFL1Qop+B527EhIt3eMAwooDTw+a
	ObyZHy/LgK2ttGPcuMlxrXugQ/nEaa53rLCVTzI83yK8cBPTo6zTTBOHB7X5A93C7jxz0xceFIV
	YWvRI4SkpKL4nO4Tz8LfCayb7gJ8+Gpzl11DdZ8nturvrG3Jg5HVB5fljaFmrdOnfvWbTLjjArL
	AH2YGGWLUyzGvVXiY=
X-Google-Smtp-Source: AGHT+IFA5v96ReJAqZwqn5Ht/zD2TwsmTS/QwZ4pMs1RMftRZA4u6b3AE4qcFjb1+ZXHb5341uOCmQ==
X-Received: by 2002:a05:6a21:6d95:b0:34f:afaa:125b with SMTP id adf61e73a8af0-35ba1f96f23mr19782645637.50.1763452348006;
        Mon, 17 Nov 2025 23:52:28 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:beba:22fc:d89b:ce14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aee147sm15609775b3a.13.2025.11.17.23.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:52:27 -0800 (PST)
Date: Tue, 18 Nov 2025 16:52:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: senozhatsky@chromium.org, akpm@linux-foundation.org, 
	bgeffon@google.com, licayy@outlook.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org, richardycc@google.com
Subject: Re: [PATCH] zram: Fix the issue that the write - back limits might
 overflow
Message-ID: <bo4g7erropsvl7vulufdsjqlkkbjycaounh2vv4a6urttxvubr@f22z5wlgntox>
References: <tencent_80150170978D13BAF69D63E57D7F5175F90A@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_80150170978D13BAF69D63E57D7F5175F90A@qq.com>

On (25/11/18 15:39), Yuwen Chen wrote:
> Since the value of bd_wb_limit is an unsigned number, when the
> page size is larger than 4 KB, it may cause an out-of-bounds situation.
> 
> This patch fixes the issue by limiting bd_wb_limit to be an
> integer multiple of PAGE_SIZE / 4096.

I really wish we could just change wb code to use PAGE_SIZE not 4K
units [1], unfortunately it's probably too late to change that now.

[1] https://lore.kernel.org/linux-kernel/20251110052741.92031-1-senozhatsky@chromium.org
