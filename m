Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E834C43F4D5
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832952; cv=none; b=tjec0fsDXHCjgGM0UujrU3lpTKw80QiwkhRP8BTuk828mw04AgwSgqeST/jic4wGwYU4P0Ih4lGvkmLejsIWLHyhpcwySqndDy4XpBRi7gWpuOM0wvf7c2Fn8oDctx9Xgm37C4Xuk9ExcI1vH4/AssBES/YR309tM+lDNFkDoog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832952; c=relaxed/simple;
	bh=+t9We9CHhq5QIISRp6hFIb2HR/+6MY+ToLEhAlYRB8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8X8OMLzXqDWnxX4fMFS2VYx9rmxeTH8tage60w6/XfyOKf3komUMtYUuOcpjzItntKw19RHLcOmTb2ku9U4VAr9Im/GEbBS7OJAlM2D0+hIUn1BnF0THOZFCSdYXYpyBsdIs9BapubvSX0te2eiXrcpv3rfX6mfqT4D/jlo49w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JLFMkr8B; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JLFMkr8B"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8486ac3f347so754058b3a.1
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785832950; x=1786437750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Msf4BCiiq7h8sHc+GDuq/av89v8kUaD3jKqA6c2u6wo=;
        b=JLFMkr8BJcz3cfAuglwhBaNDDfVRhFMmg0016XMxPxAjtEekh0j6Zjd596K901Re0J
         Gx5Agtl5gfiqbMlcAU3umbrt4A0p2DrEcegf1JvZQQkLV/HrMuSeRq+VjA201rD7zBLa
         QECvhmEc+6XVBu947abshUAjjmdqkv5g8kTCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832950; x=1786437750;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Msf4BCiiq7h8sHc+GDuq/av89v8kUaD3jKqA6c2u6wo=;
        b=fqbujoUcrVWGvkd64s9P6M9XKR9fRB5Pd5yXQYP+pFlsGjXWBHXoSJyYJ1QMDQRyiD
         VUcFlbLZRnxE/O9boKiVvmCtNGpBSWAcAXJFQf6x8ThzO0w2H4tWJhkypxyhMv7UIgpw
         WIyNxLeoCpX22nyUNIh7avWP0Vp1unoppkUPR0xhEgbcuMb+NoPewwhavLyBuapMLii6
         bAxFVpstrBGtTY1IC2TskSgyd5xrmLGqid/cY9mmPsjYKapu7eZGPHFk1HhmGTd0EA4J
         yG2NMPs/8n1UmHBz0nwtAXRKhkAOflw3eEySv88KBYNccAfECtabOvmkepmJz+Ch/FDL
         bCRQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp6awGGSLVWlOjNc6dJIRj5MfZumv2hI0VlNYgfpMi3azoUBE06LgjZ5txyI23fm3LqZOo3WY6pTZmezQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8m08YeU91ssTVTXHOrSUP6ZwL095GrkNMxi7IU4qZFiG+jPUP
	vnNE8ipLhNtma/RdcDPkEpNH7W2lUWI8Sl8nTIZNa4UMEvhKqRu+urRb584lJfjGGg==
X-Gm-Gg: AR+sD11c2ey6dtxGxW5o+8gk2HGLSM54eKvWVrRd6z1tYwMJ2QXclFQa+4To+50Q289
	zdO930B+5D9VBOd0yNuSyg91fLyv9lSZDOAKK+OYX3KB8+LDKTrH7WJZuwU6hNhx4mY6yoQdyZU
	lqy42EH/NIA9sOr8htfGQN/e/+GKkJ2UlzpAICTtTR5laobvRXeXMCUWLoJe2ZclEludTqzKVlH
	4dXKhSU8O36oIaKnJPouioC5iet5VhMWRxarvoNYFmrQ9MhVZIkOBGjqzaIyaPmNGnASanlBBFp
	cBDx57F8HYnjWl60OqC2TcMLv4eVQZKGDImJI/MnnAhELLyRL7SGGDy6Ha8rsa0ux4aHznYTy/Y
	cSQ+dYBy1aySrnQzpBMWFMGAB9EUaUGuW2kk5Qy+A8JnkGXZOZD1A09yWDZmxzK9S84IQ/FSrfw
	xHCYalQyvLEOociiZAgNOXo6pjW6DJDBrAtEGuHX+mwBkUyYJEpbLCDTrlq8OnXeO0galkGItHS
	CzCsqxVseUVWXXP+iH0qaif7ttV
X-Received: by 2002:a05:6a00:4fd4:b0:847:b45b:fef3 with SMTP id d2e1a72fcca58-84f1cb227b4mr2528791b3a.27.1785832950153;
        Tue, 04 Aug 2026 01:42:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:32eb:b46b:e9eb:65c5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbd35a4esm4854159b3a.10.2026.08.04.01.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:42:29 -0700 (PDT)
Date: Tue, 4 Aug 2026 17:42:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Longlong Xia <xialonglong2025@163.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] zram: fix out-of-bounds access in read_block_state()
Message-ID: <anGlv6GhiDL8gQI1@google.com>
References: <20260804065919.3970386-1-xialonglong2025@163.com>
 <20260804065919.3970386-3-xialonglong2025@163.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804065919.3970386-3-xialonglong2025@163.com>

On (26/08/04 14:59), Longlong Xia wrote:
> read_block_state() calculates nr_pages before taking dev_lock. If the
> device is reset and reinitialized with a smaller disksize before lock
> acquisition, nr_pages still describes the old table. The subsequent
> loop can then call slot_lock() past the end of the newly allocated
> table.
> 
> Read disksize after acquiring dev_lock and checking that the device is
> initialized. The read lock then keeps the table and its bound stable for
> the duration of the scan.
> 
> Fixes: c0265342bff4 ("zram: introduce zram memory tracking")
> Cc: <stable@vger.kernel.org>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
