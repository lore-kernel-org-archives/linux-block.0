Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5B342B310
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929217; cv=none; b=HN+hP8kz0HVoN/7tJ4nKuXD0v4OxARCyUOp0YyXQDHncFUdK49e6s7Dg31GbumNYhz8/kKEzFmZg46clT/J9BR1kFsWFvfRkpbq8ozDhjb5QdWW+Ke434KM5hT9bTEGqWEloWFytedUH3YuZZ96w7EAQ01LzQPRdbRyZTPy0gOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929217; c=relaxed/simple;
	bh=JlvhUDwnRsmJuGIJfu2RAFP7l7jWwFFl8s2ejpgMDDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/J3qBDvu9MDhjxcrcLnPYpyjQQRRWhghPa8ZBBAyRyMxGz+tc+zK3F3aX1EWOI5REEEF6dMe6W5vRkq86EZNrsYNIOiMXkdRuhHgD0UNpzb/2rSFYvtIEk0igDjpvYmAwWI8zwKkg7td/K9rlrPQIF/15FpRJ6JtuHryN2NzOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dEfv9Enw; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dEfv9Enw"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e041ea211so967156a91.0
        for <linux-block@vger.kernel.org>; Wed, 05 Aug 2026 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785929215; x=1786534015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hk7zSpsVAMsj5hapJzjDxC/by63XNDGUaS2i07kGkes=;
        b=dEfv9EnwieeasPxKYldwNlambEWBB1enONnROHMqhwzgxA8746PxmSsJLQAHj1blbg
         sq31R8iq+YaZW756UIM0oBrBiLhdqFaZ5FUngRpK8Nya6YCfZo2uYzIChxgysB6xU5xb
         L2BZQQwWPRm8VZxcVSHneKLKlj9jzyCSfHP14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785929215; x=1786534015;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hk7zSpsVAMsj5hapJzjDxC/by63XNDGUaS2i07kGkes=;
        b=WpNzMQopcH1MM98v4SGq5yyNMOdLz78HFBz0fD/U76U0ayxEu0pQcBhjv9V7qtJ8BZ
         jkGjPcSF1dFf4rc2/jaqsKFsT3yapYbb7DDHFOH1dAOFduFVIXYckrkVanEW06wucg4R
         NE5WtU69dWVq0Vhwawg2Vk6kl3hMFJP084phD8pZfuK74TOUhAmPJkrVYyGY0ZtHDvbG
         +ppZZV5Ovi2WBJI8+hZuoLwA/nx3FRp+CrdHXwmvlPmtbf9UCffgq+wAK08GeuFnrGBa
         UZxue6Bk4YALIqvjw9ecrfyroFYYQbz2+k/Frchw5DRrzUIiTS3ykE6lAwfq3OTFB4D2
         05cA==
X-Forwarded-Encrypted: i=1; AHgh+RoD0/dvsVFbbdeELcCHmAc6ZStXOXZReARSpMxW39tL5w6pz1/rc0FzqfFiwAthXEaAYnP05zubPMdKEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVG/VjpxtOHgYiQgVDLF3UhMrkMPhZqp/FsY3sla9gZzMkCnS0
	R+Xd+/QHHf+PABcwFVFo14w81Zue756p2ANU9d0A1Yl+nIUDi7Nds8QTYryNEluK/3eG+tdp7o3
	q6pk=
X-Gm-Gg: AR+sD127nUCoSDeFaxpIAT5iSYeSKsEwZMmCZaDVZi53ZSIec0Mc6sRE9kAyqaS16m6
	GNb8w9HynvSMp1Cot1qc0ZlumfSdp1EMl2vGbLaE65lC55nOLfXD6llSLtJPW7lSXeq3F7OY4ib
	WjnWdvmZNKku9XVdEkID89+J3bhNv0Kd4HtX6hI8mY/qrnaU0UEqorNczNwFZlaeBcZOSKWyPv3
	fnYakQbqW+3pIB0Ll8VLRR4pOOsMBlbbGRU+bEx9g3wzXhGjAyPHmUSkVVC2aRcSssOTcizrVjy
	/gDMKBq5uau2dLsZttDhnE2iP5C5aLkk2eHQ9nfs6iy/p4adVAyImRUO+4+reouHjOSmFJVPmCB
	NklVB8l7JqCGHwUEjIILsSPDn8KyIEfc20uq6HLHQ9qDcPRPKQGVngKdSn45nk8KV1ORKJWlNam
	U9/LSsLG4kM8PL35cBrjhQwu/ajo4S7jAV4x2EghGIM3ARw5gDaQegz6F+A0dfi5fS+fOD/0JCq
	soI1Ts8oTSY4lQoCXAzAEo4atgs
X-Received: by 2002:a17:90b:528c:b0:37f:bfd6:8b40 with SMTP id 98e67ed59e1d1-3903c5993cemr6583221a91.5.1785929215205;
        Wed, 05 Aug 2026 04:26:55 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8002:2a47:a704:5a58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390392aef87sm2964341a91.13.2026.08.05.04.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 04:26:54 -0700 (PDT)
Date: Wed, 5 Aug 2026 20:26:50 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Longlong Xia <xialonglong2025@163.com>, Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Longlong Xia <xialonglong@kylinos.cn>
Subject: Re: [PATCH 0/2] zram: fix stale scan bounds after reinitialization
Message-ID: <anMd5GBmYmq81coH@google.com>
References: <20260804065919.3970386-1-xialonglong2025@163.com>
 <20260804131046.7c485858542d586bb7c51857@linux-foundation.org>
 <anKUG5B3qfZRVf8n@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anKUG5B3qfZRVf8n@google.com>

On (26/08/05 10:42), Sergey Senozhatsky wrote:
> 
> - read_block_state() tear-down is something to look into.

Likely false report.
