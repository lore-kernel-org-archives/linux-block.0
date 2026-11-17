Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913244;
	b=5qbCJaTVgQEdd2ZTFFPthT32yCGrvXDu+b8EdVTH6pebONBfKyGF9nMQhykBsdXv0PCy
	 dlqdudQScPZIAbnzjGNEXMVoUTBBK8/mrO7fT6Kv985xSI50hbnAEB6RpS7l5jPYn2bga
	 BpsD9bCAb91ji9tQ0NfoEc1QjLrj08Aa1aqJwMAKUxA1KhfiNzLNmLa4xzSGPfCF/xaer
	 TOUQiP2i3qfsggdwiXQjce4DIHXHz/4DA0Z9BrF6LzNwn+Rlx/+3KkVEymoJOlcavCU69
	 xA9G55ccmCrtDZVF+6z1G/VSXNmGK9Wy4cZ/qKYj3QYsN1WtsveT5viWcxcSyxOQe0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=nDf0c3k4gQ1q2fbwcAejo0l5m753k7bveaKyF8JgDy0=;
	b=auGki+QA+YK6ekzgSaqHeuLtW07Wj3dMJ3vBDfBP0Qh9nTL98C74rII/g8tcgE4GLQ86
	 74zumaYDMi+80hv4vY7sBVAyeMKu+/3FGHrQcVqVLZmVODqnZmk6DoYeN6fr8rB3CKLHl
	 FMNyxtuONnrQCaiszxYe+v1xsz/RTpxjkEbfBrQy1arMUrId0wXnA/QW7YuKOb8VvVaKh
	 bI7HuFMuR+2caoAsAMyhU+S1/tbVMN4T9fNBW8NT1CHIKzFDs8cPVwOi/GNeDc360Hv+t
	 vs5bEt59NfH+NhZkwgu8jFNjLj3vrKYL+z0f7t+gvetQLuW8yx+LQtNnra8iqvwKdJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uxo0IEyN;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4BD606A323
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 11:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F4BD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uxo0IEyN
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ad47c246f8so466439a91.0
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 03:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794913243; x=1795518043; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nDf0c3k4gQ1q2fbwcAejo0l5m753k7bveaKyF8JgDy0=;
        b=Uxo0IEyNHKjLd4a6l7dp7SZYF39WCPT9iZ7ghs78WnryN1MwhNtj+jpxJFAvDsj4iR
         jIs96XoJrSoFt2sw79tnC4gQUQh6geDV7TzeYHZH08HSogJPXesQq9OGW8bP2O6NNPc/
         FJfmJ56agT7NDMWJ00G0Ew1l7ldfzzHM+FqOo0TM86TtQMDCuKxNXDe6QdfywQo3i8O+
         O2F4mnsWXvTFaSaLZfR6jWeflcCqI+a5kA8Zr6oib5Ek2h+bWMccBetF9Cbh+tdfqFIj
         +9jhlG/jl3qj0Fd3w/4EE8QBAk+p+x4LgD5h88nwWB161kpyc907dXWSlmqqfIzGMOZV
         tMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794913243; x=1795518043;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nDf0c3k4gQ1q2fbwcAejo0l5m753k7bveaKyF8JgDy0=;
        b=taNzzo1T9KBhj6LdI3x/LqtmIRI/EYRf5whbXhsv6DEPFwHwkg0WgDGZQLqKz3RQKB
         20Wwo01YfqDN0IOCj8nu4+OQIgWy5Klgo7jiV+5dNhXxw/FU7keM6YaPATsdv+34LVCP
         Q74n/+stnBELWEqtFhVbS0FF2AGIHurOJ3Ang6ORsSZxQExaOJDOHvFwBdeda0XORoo8
         o0ZD+Kn13DZJMxOAIs1dg4Xb09SvTvf7fm4TnL8LBSCbZEi7ZtuKwcBF1m4MQ+Vinhn6
         Ib1H5AxkEE1fKUbqakjoej/+6rjjvTScGRPhLK2BqYDwsqfgMEqthrMdINOA7Bdpcqu8
         hbQw==
X-Forwarded-Encrypted: i=1; AL+hErGHtcj7OTlshXSsID/LWskLsYcZHwiDij8e+ln3kyoDzmCqiHZMP3mILHfQKliUbwI6H8FeFJ+FcJgpHg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/+zTlX2XGEZzwgxFBnQwhPKZ+e6XNHwpH34WFwkCKpst6u2HxT
	dDYlPXCp4PMRxw3H+rPLRnYChEza5Tc0a28015EoH32D7tl26bOl1vCk
X-Gm-Gg: AZFdTZdz7px4hndelCNSvMUW1RCHFWXjzn3VY5IWUT3zd22wPgxTnx7Ox41qgAV4cG4
	yyOYkwRURLiPBE0kEfMfjUp32LESdqAs3iKfuPt9nv9LiZ/+/Zo0LKiJJNZaRgB6OG99P1as2Gh
	QlfIqlZhuX180dPpMYcnDBY3bD2+9wCIOMwQTM0ILFuMOhTd7ZssXc1emhan37+PQtQaWrHgX3D
	B4HQn44N9ffn3D2I0xMR1Mfm5jr59l4jSLG3F2eFEBLwC+tReJQSdF/Fg75vxm+EitK+Nm01yFq
	QULf1r8h6PtQu3NI2UKghhthTnw8PaG/G4qufmFG2aUJ+1Cugeyr/VzLF05dVITv17UOo3im49V
	o3HAw+LWDye2swRmqyC910ZrI5v5bL4ruqSViQMjQbfFpPkwU9S0HYQ2Uvl5e1ppTGgVCVVx46p
	myeEQXs3b+6wDTMkypoMDJF3mt7KqQcYbPQXV4HWXDls6a6BocFViL16oa3+zm+fMeNjrgUy7zg
	2sQIbdmEGAJSQSv5Zl0xm2v2LnBg9cE9LDvPVAj0Kl9C3woGbIb1Y6QLpAnuJXkaHTvZ6M6bxHG
	uWeSiBbzfatCjrs2U+SfxWU5E+/dmsKbz38ipGpHvKE0hvxXo6KA7X+9ozdPVVLzWkc=
X-Received: by 2002:a17:90b:568b:b0:3a6:e61f:749d with SMTP id 98e67ed59e1d1-3b1b0815b27mr21198226a91.1.1794913242798;
        Tue, 17 Nov 2026 03:00:42 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac255634sm3583538a91.5.2026.11.17.03.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:00:41 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 11/11] zsmalloc: populate new zspage outside
 class->lock in zs_store()
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
 Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-mm@kvack.org, Yosry Ahmed <yosry@kernel.org>
In-Reply-To: <20261111064707.2568433-12-senozhatsky@chromium.org>
References: <20261111064707.2568433-1-senozhatsky@chromium.org>
 <20261111064707.2568433-12-senozhatsky@chromium.org>
Date: Tue, 17 Nov 2026 19:00:33 +0800
Message-Id: <179491323381.964041.11173076535030687661.b4-review@b4>
X-Mailer: b4 0.16.0

On Wed, 11 Nov 2026 15:46:34 +0900, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> A new zspage is not on class fullness lists and is not movable until
> zs_store() calls insert_zspage() and SetZsPageMovable(), so neither
> other zs_store() callers nor compaction and page migration can see it.
> Nobody else has the handle yet either.
> 
> So for a new zspage allocate the object and copy the data before we
> take class->lock, and don't take zspage read lock.  This makes
> class->lock critical section shorter and saves a zspage lock/unlock.
> 
> [...]

Reviewed-by: Xueyuan Chen <xueyuan.chen21@gmail.com>

-- 
Best regards,
Xueyuan

