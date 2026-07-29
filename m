Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FF22BEC43
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 02:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785293350; cv=none; b=PkkKQTrhgxiSgUGGRB/CrdrmCP6CEesg3cG2wuv+W/niRuqTrIbTwS9u76EyX6YjbyArtTua4wmsOeLx+lNSkIJ0wvGi/2xLqXoYaWkzFMmharEqXofZeKuw/oyTA/hjYi/5G+5JLEltXvGhWeblc2EAbgyFr+lYgw2NU2PQ9iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785293350; c=relaxed/simple;
	bh=Olm9k1EQK6ohYQ+stSBkjo2DlCfbNlvkFdSudkFk/qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdcL3dPIlqrG5n6qaV7Q+RhUabISU/6/P8VFqXSS4UpSCdlzLNiGujPh/7MWwTHkH1t7CM+Wgw9kMRvf0alsJErp+cJ2uifHN6zZCJi0NlDSZcgOTiFgy3PAbDNsVLwFXLrIJWS+rdPNoKhDmNjT1u7K1k327ArEnDatcAovik8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oG7Y1KiA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oG7Y1KiA"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so389309a91.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 19:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785293348; x=1785898148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gfC0YenoaaQTKBpaij+xpTxgjwyA2vemEAL0JkmqAZs=;
        b=oG7Y1KiAvDjHK/y0oEEHyfMvtmt7fOMUtL6l8uU26lGHOaGIbx56DZzn/KpprfZ+fa
         Ml9k1QciPYz8/2qgT5fIKg9rwzuVG0mXL/go6xGqZbUKNEZjOrDAL9+Ucw0MVCF2XYc3
         yLXRUffZJ+F8uzGQ1cRvcVJTvWi89LhdSGAYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785293348; x=1785898148;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gfC0YenoaaQTKBpaij+xpTxgjwyA2vemEAL0JkmqAZs=;
        b=qig+xbJHTS03uUbW178DECsZMUrUFsLqjA3dMP8mLIn7PK/ykwHrKdEzR7a0q+EoRQ
         LMqo6m7M3IgE0/mXHq2iNlGPw02BujOOJoOKI/M0W0OoXQ2Bb5Rxdc1YTnfdnp/A0i1a
         5QuEBEiIQQvWJE7MtLY1qvY1zs/9aIU6rffEGptVT+fbpkNH1QMNCwBEYoYnAsqLyf8C
         SikYJ6hpG/vFwmUkeuQri2RJejTGDfGLaeuOg8g+Uxy234c3or1TUr2L3yZOOM5DXdS+
         cyROQrQ3jZSxxhssT6fokOe9Cc+T+fcRct7gfLPwalnb0CJHi9cOLxgJkfXqCuh94n6w
         /HSw==
X-Forwarded-Encrypted: i=1; AHgh+RqPx71D/cxEhdYYTtWt6VIOlgXqr39F1LFWBo0qfmnNANAvb1KbfqYUUUycm0a77lYJm2tSgUh9UgMBYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv/eqPw1WKlzxZ8WI/oIB5bJrgNnJ50nxirWmbwJkKWB2x5m9B
	YN58atAE+yWCeE+Kk7sKkAhTmn1h+Z/NpYlh6+PBPBPrneWMiN+FjaORDi/juMyQHg==
X-Gm-Gg: AR+sD11kchY+dLg9ED5qAIdascVUR586uUWMofau1usJ9zPDowPya/W+8DfIal6SrVS
	0QPj8hqMURNV8LL3NJn+obGzBNJO+ql2y6JoLK+M2U/ydALUE8PoGKbH+nhkE1OYYcfnquvESEO
	XTY+lmGKFXfTOFUlW4IWcEXmsQhvycmw7Q8ZutBW6EdszINSWd68R60Vu0hSjtvVImE3/eLV7eg
	qKTwmf3svHbVQr2HxI8VlS6hQ3HHvIhb2rcCn0DMomgGXu9YNqtkH6cjvRqq4DoxmcsioFLL6ZP
	A0sIL1DPabd4BGlTyPCWnVzJ4h7ebL3XojICy7cb2s2dC4h5sJpZz46F26QiBcdvtoLrHdx0/L4
	9Gz2cpFO3CzcFdsbhqrlGpD3bf4eAEREJKm8IYi7tvaC74j6IAPew1FH2blNdFRKyk3Cotn4US4
	LOrfM4pVXZ5Dh0nr3CE0rrztJBc24yXU82c5GB/JUVrqhR6VQP/3IAjoll6t1Wq+TDw3h7Dp8UZ
	EuPCGtPjUDGSjUC2DmmroUkM/msfG6XFc35h0A=
X-Received: by 2002:a17:90b:2d87:b0:38f:5869:387a with SMTP id 98e67ed59e1d1-38f6a2d1e75mr4927236a91.8.1785293348253;
        Tue, 28 Jul 2026 19:49:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:65c1:52a3:f6d3:37dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f81543abfsm186860a91.4.2026.07.28.19.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 19:49:07 -0700 (PDT)
Date: Wed, 29 Jul 2026 11:49:04 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Haoqin Huang <haoqinhuang7@gmail.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v2 1/5] zram: fix early release of global cdict/ddict in
 per-CPU error path
Message-ID: <amlqBrwJKoSNFazf@google.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com>
 <20260728173411.b2cb2d88147fe768cd6497aa@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728173411.b2cb2d88147fe768cd6497aa@linux-foundation.org>

On (26/07/28 17:34), Andrew Morton wrote:
> AI review might have found a few things, about half of them
> pre-existing (zram/zcomp):
> 
> 	https://sashiko.dev/#/patchset/20260728092935.31139-1-haoqinhuang7@gmail.com

I'll take a look at those pre-existing issues.
