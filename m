Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C01175A78
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104724; cv=none; b=m1iQajV85GnawXhhnql5Cpo+UiqWydknCia7cYbD+pGsYgTXfj8Rp1IrpbGN/wWE2eKD6ggtniMG6iJt/C3MrnXAO5FxMkPGjUhascSTxE/0zDSndkumCyHMjICuqOJwJrykA92yipDDABFSwJ5nn809s4spZHKX43D6+OXE3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104724; c=relaxed/simple;
	bh=Hugvm+jxoXh6V7xQSyCucuJEOioP7jRP7KQYsVJdP1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spCiPl2uNXo80l5SmmzQxa2SRCqvMYSrB96QyN82tTiaBzK+zpTEskVQsvU14H9fAshgSOohoJ045mIkm6NP7OqLBvGpEQu8XP7P0c5xdZtM0n1HsVazKjmv6IAqXXFPaaWkA/Alb10/NB21BgRw5psPBL5n9n+KQO3IPZ7uNuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I3M+IGnX; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I3M+IGnX"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so4200583a12.0
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2026 18:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773104719; x=1773709519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JgIuGkK661WhUgAcGq5SdhS/TWkxB+zDVtaAdBFj00A=;
        b=I3M+IGnXxHdUJdwYq8QV/HnI8rOCEYmiyoP66s+APys8PrscKFQsKhG+7+/qrtyuHh
         m1Gd+6M4I6PowcoW0eYQpDJHGX+0Elv5CDN5oqC70zyZw1EuSsfm+zh5RX8cfuujMvrJ
         S+Olt5oFoG1vVoM02q2HCgA57S4on9WfLQJUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773104719; x=1773709519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgIuGkK661WhUgAcGq5SdhS/TWkxB+zDVtaAdBFj00A=;
        b=enfqXggI+54+JHRBschJWHfTxbIl6+BXRKex9EnuGPJ7GzGAA7unQjUxJsM0wqEj7r
         2r74LLqq6NzUWaWNe9Yt/+kLiZZAhOMqMnRdpiKorqrRtE8x4iaEAQDomLpsyH677Ugv
         7EDnvvhj+pdqluVmlMU6kCIIDR38fIE3XGEwqrpS0dLJQnkevk5v49zQBb/t80jJTRRn
         IXalHK65IiZ6rOq3gmu7rvwDbcKX+I4PYdhw2ovKkkxBlhcIpZEpxvXvQ8ExvYw2fBXl
         ByjHHXh0+0s57K0lCqQXV+if1hDEFQS4OM7ST4JKNdnaaCMrWHTuCeJuWJh1HpkIDJ1P
         xJbw==
X-Forwarded-Encrypted: i=1; AJvYcCVF+j4F3+iN52/IHIMIPVzm3xh0pLigCjo6OXab6uT8pA/UYZAg74CEEtOst58L5+Rml/8AwDJvI4LvtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeyQwKWPKvx4vl/F43sk6ebvU/+rGsfAzVLpPGQUtU7El9ezxn
	cUCLjW9xycQdlG6tetboh4dF7TBoApM4ThboIzhGuOvcU7afDO4yNaB9yihp8nCV5g==
X-Gm-Gg: ATEYQzzkACXfRfya+2fx5k+NEzGCIYStMDsV8AEkm3/YlsJ57M1LqJ6dz6Vo55R2agr
	R1RQVpaGOyNvlGSt1TGNzWTU1CnhjyDgaY3n64xv/o2SxntFOQjdFSCxMoHKsREX2Efab1uPt0b
	zIDp6P2I0IbM/LDcRH73hMwqAbaMLfN7QugNy3i1XdDsIUBlMrxW/yUeOV/C8E8QawarZP5Dv63
	DEEDLsGKw0mHF2wmLRrh7C6QRWe799dYJ3w1LNy0XuMbJye/wfcyJODiYzDkBMNQwZsuSinj6lA
	1H/5n20R7euYbGa6yBkqwjVwzR1HUKjqmJFXfaYlsmB/xkIhmCYBANPQzhZr7LLQKhIurzFmm8n
	lNP1Ynxhbc0ij8428dpBiKn5JJ+QWRRsC1BbASM0YF7A0O3Vb205sdchGMMcs82+77GP6IS69lZ
	Y6KHRS9OgGwrcc00xCn9Xn1TFIdVFKiuhLUcrnFokbZi67WEnFAFlEbzzvdq+UWrc=
X-Received: by 2002:a17:903:32ca:b0:2ae:63bf:29ac with SMTP id d9443c01a7336-2ae8252fedfmr121738655ad.44.1773104718749;
        Mon, 09 Mar 2026 18:05:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:5620:959c:240f:eb2a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f77350sm145552475ad.51.2026.03.09.18.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 18:05:18 -0700 (PDT)
Date: Tue, 10 Mar 2026 10:05:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: linjh22s@gmail.com
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH RFC v2 3/5] zram: Introduce zcomp-managed streams
Message-ID: <aa9tz-EIh7kOF3RM@google.com>
References: <20260309-b4_zcomp_stream-v2-0-7148622326eb@gmail.com>
 <20260309-b4_zcomp_stream-v2-3-7148622326eb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-b4_zcomp_stream-v2-3-7148622326eb@gmail.com>

Hi Jihan,

On (26/03/09 12:23), Jihan LIN via B4 Relay wrote:
> From: Jihan LIN <linjh22s@gmail.com>
> 
> Currently, zcomp uses a per-CPU stream model. This design is restrictive
> for hardware-accelerated or batched zcomp backends.

zcomp doesn't support hardware-accelerated compression, and that's
why we plan to delete zcomp API sometime this year and switch to a
acomp crypto API instead.  Does crypto API address your use case?
