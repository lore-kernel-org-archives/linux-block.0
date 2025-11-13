Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03B92877C3
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762999452; cv=none; b=GMcYUEdrVXR5/u3UwEIhuwttjUAsBoDOzFcYmYDYaP+bPY4vokC9KdvSqzypJwPhZzXWI2evcKPF9NXnnB7HW4X5pDeelSTBrm4+2pbwgFTH8xlQMRSq7Xlc8VnBeiRgvzA4fpmv05upN8XvgZxH1WEZ1tfWydhL5zKRuFMTH1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762999452; c=relaxed/simple;
	bh=yHn8jywJbOIgoXMrWJ5culve++aKWfOdLzK27DJRUY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqDAt06U4dBpLl+Yi9UgQ5un3zHD8ymjnKX76vCKP3FWoW3MlPaCzeCgOBFT0nzKtk5FXlqhCbM+Zh2RnNyxEwaHvxXjo/JSSAEu533LeyxPhA53ln7Y5N2NVOhwpRc1/3DxFGnD7bp2U2nTZJVOMozaY7DF5OsNhY+ki8ZdXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GUF/BHXk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GUF/BHXk"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so225674b3a.1
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 18:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762999450; x=1763604250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CoWXrd8JO+QikmbPgskO6RB2/Wy00bhO0gKhHUyvMV8=;
        b=GUF/BHXkZ7guE5ciq+sK4dqZ1iAajFMKHf6+Rc2jDxe11mDz7CBWpWKfhYDis6iAVv
         uqSEIjtTcmtUWxFC3n6u/5ZNph8/zDiODhvuTRvFnyEIkacZz2dFe4Mw6sxNWGTseupd
         LSCu3qJzENlPZYXQij7a5S2k2YUyg+mQM/CoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762999450; x=1763604250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoWXrd8JO+QikmbPgskO6RB2/Wy00bhO0gKhHUyvMV8=;
        b=ofDI1UJ1lFihNSkp4BorclqyeNR4DubzSzqn7rrmKW5cgRgzSlbjcEi53u6hY5cH4T
         F+1U8XOzmNg3Sf6lKA/A40qj7AtIW1tf6FUY+gOpg/qEbAeo/Fz6WE8sx+oe9ZWbtbJO
         Lesq7lBJX2v2jXwNetNsIxT1HsPzD0RgXgk1Hth8dvrqEUmXANglCSJ5sMB10UZrtYle
         8HkQx+/uTRXrATJWW0O/3Yc1rn5O7p9jM2BAHWDPZB1P8RcYdlj6u3UNpkprP2J2u34Y
         R03psuJni1bAnt28CX93A/fTTEJvCpObqundwp0fQpR/3p/mkKGhI0KDAnXTtFcEnHup
         Y+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCULG4UN12KrmUKm7gfFLm/EHjpSPOwLhlUv03bXLPDxBTQ6dthUfxqu8I2HH5Se0A6oNRQuoF4RRyCjCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt0+pB1H7Vrkd66BWXd4vqH83DR2frG7G7RWU5B1cJYVcGPenI
	oyvb5u/MKnCYmuMAYZpueigKAPmJ03wPlr+Ti5dFh2e5M1LCBFBSu4JzF2JPaNywQg==
X-Gm-Gg: ASbGncu1hCdcLYZSDfgD4u011FjCihPM6LD0oeMCIYAi/Yep899OcOaBU/TiI4j+JjT
	WEM6VsMN6QffqNTbvp8fy2MlTkc3AwqgwZeoCZCKUgytq6lx43Gp0iKTgqb19ntEVOr1VcWSrjc
	LToOpU0tKmwWq4aM6uP2IU5jDSH+DBygb8ZyElvh37sX0YI/HU4Q43YeaWKJHYFzpu18h8yvlLs
	F5MJrEJ51Tb3ZaN+hy+4omi2NfXfLeHV6OYH8B3C3xNedrHuWSiZ7oUTgLqXrCiXWiBNHFVKdtW
	BqZWrEb21c/W4wtjwYJ9KZuoyP3pbAQlz4hWRL/VeGh0z5h7xcbJkZ/z/ZhzroMV9EGy3jBHAs7
	aHRbimJ4Zwqx9zAKjK0143XX8iB1oZa3zHwPtJMNB+RJBdMs2y1r85bxygNjqqGKkgBpdwRNs/g
	Vpxlez
X-Google-Smtp-Source: AGHT+IHfZ2N/MAyyzHG3SVOhKMI92QJpBdZOkjEdKOIsG/60o7oByCcoSoeNxaOzOVUQsWD6YUa5pw==
X-Received: by 2002:a05:6a20:e211:b0:342:5901:fd94 with SMTP id adf61e73a8af0-35909690c20mr6753978637.13.1762999449895;
        Wed, 12 Nov 2025 18:04:09 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2495:f9c3:243d:2a7e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927731a72sm389619b3a.50.2025.11.12.18.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 18:04:09 -0800 (PST)
Date: Thu, 13 Nov 2025 11:04:04 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org, richardycc@google.com, 
	senozhatsky@chromium.org
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <rjwycg4sfzuroi3yzsovtebwocabyoq4vq4fuc2cbh3w4n3uo3@o7dpmtvqr7fe>
References: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
 <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>

On (25/11/06 09:49), Yuwen Chen wrote:
> +
> +#define ZRAM_WB_REQ_CNT (32)
> +

How was this number chosen?  Did you try lower/higher values?
I think we might want this to be runtime tunable via sysfs, e.g.
writeback_batch_size attr, with min value of 1.
