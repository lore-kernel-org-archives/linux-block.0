Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794942478;
	b=M2AHEgUbCpq1e0NNRyPyPBAq22hX9Xrdk2I5OTDZYT663UvgRubGCynAsuAir/MxR0jI
	 sUUlUcladUzKqY48kK6u2sLm8Eu8gDXoA+YiTexoQp0v349G1OHIXix2qW0Nd6i0A6mI8
	 M+Lu2GT1Y9vN5QA63Zb9PkqPeZ6pr09CLkT9JlmRZNMbqtXfcD36fHwI+beS5cpWlF4k6
	 i03Ic426tNO9DzR092q2ctKXxCgr/zaVeaQxeLvO/K99DrR/RYeXsPNwp732QeyWd16Do
	 mNcM8cOs1eePDXP3LLjAtuOVkqX6JcEYr1sT0g6hduXHEz92Pz0/BcygGk96+VRCzFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=d4mLDd/uQdN7bY/YPYFedZvFpypXkiop92AccgpkyLI=;
	b=iAMrFvYwl4i8JFsZhm4zHVit5hzmb0ht3RBV60yKno9UOfoL5btpFL3aOKTr+qotBD4I
	 XwSa/NW5Nf8xysAdLhKsAUbbc209+S+KlO9kr5fl65ASj8Xlm8tDxNFMXYT9c8ws1E6dO
	 /3X0you+r6ZJBOumf/i1+Ro4vTCmJQ9/Gg7TKkDHEAnDU3z1aCGFg5Dj4e8cEpKof4mDC
	 FnwChed3HXf8/nHSyKKZnJuHvk+XhSQj8nAgXfiD+iltvhSKfLqJBOxWFbBuxtyhj22T9
	 AeYzaj9VwVzfeDYaGGE4uGw1oP6zHoPvwALGBkEV/2yHWkfHn06wAyA91950UTcNUlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CWEDb1yh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E427606A31C
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 19:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E427606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CWEDb1yh
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b70880c0a4so263065a12.2
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 11:07:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794942476; cv=none;
        d=google.com; s=arc-20260327;
        b=fx/I3BQv7f7htqd72Pvq1zU8zp/EnEqTHJM1s2Euqu0mtWIom02SY34kDMUumZKebT
         jjWHsma1Bjn1A0aidzsb+F5sMVdR++E9I0NTVhVQLss1XSbDoAn98l25dTWzd9tXR3gr
         DWwiCQPelOqhd8lPx1kWCnnFt6kzSyimvgR+PNV4MLQ3DivVJOJ3qDk85MCdGRz72Fus
         dVfcKmyezsGmlq8p111bthUSH/bqAYkDteEoRh9JxfwS0HYPDg8Vad2fY5ZhiNYMGjIW
         MfIAuiAqAZqeM/u41VBL6hOQAjKdiT0b3G6Yn8Co3Yjjr77FWUqQ6RBOfYpk0kC1tt8F
         nF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=d4mLDd/uQdN7bY/YPYFedZvFpypXkiop92AccgpkyLI=;
        fh=ovxW4fo1piKoNJFaaE3NiobcaLPqhnuBi65tC9e5PLk=;
        b=EXJ+LM3Duq4+SluGWq2nKCjLG/7L4INW4Mr5jxW0ysF9MjKYOegt9wlMcJXeFEWjc2
         NxELUTrk6G0PfTMmHV1oti0T2deh90rmiMVcXafl6IqY14P/uQRlMN15TSha8xleUPkA
         umCQd7UzSkkQxBzhoXffSQmC8xcZYtm46fVlW/i6bjJBHGHskt9rAbkyAlicAhQ6fKBf
         GveMDlTQvPB44QZTizQ2DvpianLQ041BqV1FskakVk6A0dZ5ULscOO2puHDENYOcsxbh
         fwuOjwoDd5f0MlRZk9PifDmmaFkDBh+ztRbjWLcmN8wq5kUXiKStzIMTr/QdI0b4H+Mp
         wKPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794942476; x=1795547276; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d4mLDd/uQdN7bY/YPYFedZvFpypXkiop92AccgpkyLI=;
        b=CWEDb1yhsbiFDT5/IZ7/+ZOPrREOd7QYymfn4mn6Q3O4M/XOPJQqPTJGnqB58RMoTK
         d51OjAwbUOQEm/An9tEkboKSQwfKtTb8W+xK6KBYiwTpDVtsT1Fn+G8BinE+hThL6m8s
         tLj33Jhkm01QTnfdykjmupghPb+SK9MpqJefbIjMr+4rGizgja6sZXviI8I3ITtFJzhw
         rL3zqAoAwzgrDWNi/SI5ETV2c0I4Z8dFBV/4wDWA3foDkVfxfPgNHHfYUqQgP3e1xJKf
         diZXa1wC79ggb6lRGQq65T2e2E0DuixcvtCunKoSzhLcGv4GlAB1MlHlX3Uao4m1tb0D
         2GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794942476; x=1795547276;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d4mLDd/uQdN7bY/YPYFedZvFpypXkiop92AccgpkyLI=;
        b=eSdYenXffojujRvvMNfi4SqhaWBwt1sM1KfTfwa3Bc1gzw3vY3x1annUofk5qMi2q8
         aRhQHM8BfGuAHLFW/9tF2Az/Ql2qdZ74nOXw9yKp/vDAu5vKD18fnoA6FqO0dJUfeTW3
         u14rLNnuoSG1iyCJyI36R/x6MUBItwRekLnkyIIN3sEKQjnMxzI+fv4cfUQMZZmrY7DZ
         zypNwvE8ys/Vq8XfXJh3+dWuam/ebHCKRXCIHfnGqHq7okpV2WMb2XcpCKeYN4pLsfzY
         4RO6XbH4Z5PhIpiiPsiuYBkroIVYCHYZ9YPFfokjBI5c36DsbGppK9n3BvAmQsyt68s1
         qEYw==
X-Forwarded-Encrypted: i=1; AL+hErGo666vx2rRbhmvWuCi8JG06XMnbJ7IutSsXknAqMZj99gCnOgALsIlXq+2BgcOIcepQXPaagtwrBN9Iw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8DDuAMNUuyhkbuRIEC03a15Se6/LL1JHoQQifqIJIhLcRQ4ned
	JWPFB5bvXMk8M74fKtArIhJrwbjhIVqHkFPtOM72JjdB9PY8kFoIC/MpRSIGxF0uDugJhaCbipI
	PV8kfD/Bu+MYlTC1JGi/a5ZzyKH/MLw2wMtSxEysw
X-Gm-Gg: AYBFou0n0B4HZplvuw2ZI4+axSXYrGwk7TGO9d8jFkKAmEUzxGNilEF00ItLl5xCd8q
	3gmYrBsulRC5RN8/wARRjYREd+0SNnctCtXXvJid5bCRTR7MWArrMQQfoTZ/srolxzaSE07z3TI
	vjreE+CGFT7P8lMaKP0RfpAB0JoxzpccV08BxTGT6iuO9sa9/1s1ChsrLMO5ZRrrAEYJH3/6ptk
	ZOTk2wJ2EhnmpHDlhRrjQYFSJa88ta/TP9XEL5/olQ5KZoi7f34dlvqBnjrk4uXED0/hI+jMrXJ
	OvS+KcCz8kvU454Pm8xJchwj+lFA64ko9WSZbkEi3Q8mbAg4/oDodJm32ws1BRA4aq4EkP3ClLR
	iWu6QnUxMTJJ/hA7tJxPHJMh3ub/eMSFQSKz/lovGgkCkD9rCmJjrGuZaodepjuXfo4g=
X-Received: by 2002:a17:907:2d13:b0:c40:b477:dfa0 with SMTP id
 a640c23a62f3a-c510e1e90f1mr20057266b.18.1794942475932; Tue, 17 Nov 2026
 11:07:55 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-blk-plug-fix-v1-1-7fa2a6215b8d@mediatek.com>
In-Reply-To: <20261112-blk-plug-fix-v1-1-7fa2a6215b8d@mediatek.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Tue, 17 Nov 2026 11:07:44 -0800
X-Gm-Features: AclHuK8_K-iJgh8nbeVlichavK0zIZlG8B8U4MkOUyaGlS8RKuiq1rZzu30675Q
Message-ID: <CAB=BE-S68WquuwZ506RriJctggHCebbNnhX+EYMWjxZxMqRDMg@mail.gmail.com>
Subject: Re: [PATCH] block: fix PF_BLOCK_TS/current->plug ordering in blk_finish_plug()
To: Zi-Hao Huang <zi-hao.huang@mediatek.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Cc: +Chao Yu <chao@kernel.org>

> Fixes: 06b23f92af87 ("block: update cached timestamp post schedule/preemption")
> Cc: stable@vger.kernel.org # v6.9+
> Signed-off-by: Zi-Hao Huang <zi-hao.huang@mediatek.com>

Note that Chao independently hit and posted a fix for the same panic a
few days later [1], placing barrier() at the end of __blk_flush_plug()
instead. Placing barrier() here in blk_finish_plug() looks slightly
cleaner since blk_finish_plug() is the only caller of __blk_flush_plug()
that clears current->plug.

One correction on the Fixes/stable tags (which Chao's patch got right):
06b23f92af87 checked `if (plug)` in blk_plug_invalidate_ts() and only ran
from sched_update_worker(), so this preemption race and NULL dereference
was introduced by
fad156c2af22 ("block: invalidate cached plug timestamp after task switch"),
similar to
691b052139c9 ("block: fix race in blk_time_get_ns() returning 0").

So the tags should be:

Fixes: fad156c2af22 ("block: invalidate cached plug timestamp after
task switch")
Cc: stable@vger.kernel.org

With the updated Fixes/stable tags:

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

- Sandeep.

[1] https://lore.kernel.org/all/20261116000723.934826-1-chao@kernel.org/
