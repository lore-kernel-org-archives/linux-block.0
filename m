Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5F072627
	for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763857376; cv=none; b=J0erP7zCPoaDCTR0LXCmPvndP2f33nm9omhEb/cBcJYUC7mXKP1QEao9Ltw0CAe/ZZ6MlhrdHCCU68JoRulBHR4jgFR8wNqgRBMDbBxIHU8hIOwfV9bjhDFoIymobR5skQ8ZfwGY6LSC4yu9YGfq8aZIjhoH03NrHYvfrJNgoAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763857376; c=relaxed/simple;
	bh=Pa2Q/64gwzQEYgQ2lnM49u7vlqs/sI8fDQA8hvtV1Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzn3mI6ITg2igKIgOqSw9A8sINCa4T6UapwP4jzG4Fg7YVoES0RBu08CGeSvfk7W77z8HzHMNW0zAvBFNcHr683RQ18+e1SplXjOJsizw3spE1U1riemnUjWaZ1xS/rLitxg4BVEUPnH37DpatxGM5yEJtGexUCIezWU/QtYxEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NHXyKWaB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NHXyKWaB"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34374febdefso3424890a91.0
        for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 16:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763857374; x=1764462174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FHAiZmWkDhnXuoPqEc1Nf7Paa0Td/r7W/5Ao6DSoK3w=;
        b=NHXyKWaB+kD/sZP9vftuyYRLivUGzm2I0T6kP1PyBvQvosrdd+6tH1ONtxqfFYw2eb
         XDPs5De5trT7+/UGtB0j167zlSIPi7dQKz+RGj3PtCyfLGJG7CCV/yQ2I1m0/fBAaHEB
         dTOmfnA32mEoERDh/Ec08vbDnnQCn6vsvsTQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763857374; x=1764462174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHAiZmWkDhnXuoPqEc1Nf7Paa0Td/r7W/5Ao6DSoK3w=;
        b=ucHfL//QJzz0KiPG7sN9S7eg6fYBOmid2F26ZvEBBEGG1EXEQIUcP7hzFq7TlNIodH
         +iVyVJFtTp/tq9k1X+gmqCTRONGUqJCKGf86LBh/RBuWb250HP3HVZwXMM4+yNxamou8
         eGNdWX6hR9oYC6uEo3zDhzjQ4KkWGnSqnfgJDmaSW3OERm8Q492eyg4TqSHlMmpoEJ7J
         XvyB5B02/VSzv79q4F2SxZ7Dh3p3tGJK32SYQzbNMQOOIZWpNse+78zWjwOlmPICPuJL
         RDJP1Wcy3MYAY2phXCsoFY2/JtsYdNItVVQvaYb34zVQnAu5KF+b4VE70JiBqbs9+X/G
         O8dg==
X-Forwarded-Encrypted: i=1; AJvYcCVECRkqFNtqycVecaN1CNqRICtWxloyXZCWH5QqV0CTqAm5azaYLIzrAkQk/31qqC19IM6Rzcak/VK2pA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2k7G93XObwZ2izglnVoXAE3Fnea/9dtNtaMb0pl6HycVXIDZd
	WdYc0Z/UVWDYjma2hNRfcLiR+NiDoDtItkYP0r1SRGUOzKr0zfEvZDBL79OyAaoUGw==
X-Gm-Gg: ASbGnctUM5uNIPcIou8DanGRMcgEfzuhVhtR++j+ok/zUB1Mnf3gDqMBYF8OgtJ1YY2
	LUvUiiPZnzz9Oemvkjonqja+UpY9Usts87OCIJkgpWMpT6AsryqhfI3AGwoBOzUc5/2uxbVNY8q
	ywekRTAqzYQXWcCoAnbwoFTiEh22jgFpV45rRH+cd+wcvlKsvPuewX3FBk4MM4z/ev0Sc0FGlxu
	GfIZT4j/tH5CN5gZQlzi1kahHQy/4zm+7bsxIfok/0HN3BP1pSC5XwGJVwmop9F9IhbkWlJOpgb
	AbW2rkrjy2gWW9jKorNmrJ/tPHjdropiOxwdskoiYt4cHLGO78tQGGmypytTkMAmdC8ePoQUGm6
	X6BPg/PdbvwTqGhOVXU5AeuKMTtmn/qrcTfa97LQS8lddmbKXpAhDZNvloFNA/tPoM6zHi0L86g
	mGsIxScSX//jeny2jKYkriKA2EDgC16LntdVcKQicCFMuK8otv4SLQB01TShzz
X-Google-Smtp-Source: AGHT+IH8FBGlGeoQlTTcY2Ds1x+EIg6ekEamifVS+TUuaNagUXwwLXZoC86g7wj7iuLp7+iUaAexuA==
X-Received: by 2002:a05:6300:8b0f:b0:35f:9743:f4a with SMTP id adf61e73a8af0-36150ea9786mr8054586637.26.1763857374220;
        Sat, 22 Nov 2025 16:22:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:296e:57d:751e:5598])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd76129de4dsm9097957a12.36.2025.11.22.16.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 16:22:53 -0800 (PST)
Date: Sun, 23 Nov 2025 09:22:48 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Yuwen Chen <ywen.chen@foxmail.com>, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, minchan@kernel.org, richardycc@google.com
Subject: Re: [RFC PATCHv5 0/6] zram: introduce writeback bio batching
Message-ID: <d652n6zrqbkt4oltusd5egbnrvd5xz3k4kbmqnfuwuatdyuekn@22jscte4mx7m>
References: <ts32xzxrpxmwf3okxo4bu2ynbgnfe6mehf5h6eibp7dp3r6jp7@4f7oz6tzqwxn>
 <tencent_865DD78A73BC3C9CAFCBAEBE222B6EA5F107@qq.com>
 <buckmtxvdfnpgo56owip3fjqbzraws2wvtomzfkywhczckoqlt@fifgyl5fjpbt>
 <8c596737-95c1-4274-9834-1fe06558b431@linux.alibaba.com>
 <kvgy5ms2xlkcjuzuq7xx5lmjwx3frguosve7sqbp6wh3gpih5k@kjuwfbdd2cqz>
 <853796e3-fd44-4fc2-8fd2-5810342a6ebe@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <853796e3-fd44-4fc2-8fd2-5810342a6ebe@linux.alibaba.com>

On (25/11/22 20:24), Gao Xiang wrote:
> > 
> > > zram(ext4) -> backing ext4/btrfs
> > 
> > This is not a valid configuration, as far as I'm concerned.
> > Unless I'm missing your point.
> 
> Why it's not valid? zram can be used as a regular virtual
> block device, and format with any fs, and mount the zram
> then.

If you want to move data between two filesystems, then just
mount both devices and cp/mv data between them.  zram is not
going to do that for you, zram writeback is for different
purpose.
