Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1784737C0E4
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599667; cv=none; b=qtf9bLnks45eAg+ai/tjr9FtjRS08JYxxnksN9LmZE9F7JF+i+y1MuDdBiggEXnqt/lzZXxSzwxR/4/+eOgvK26U1l5kujjuW91ZdauIJZULh3YzX3tX6Pmej1MWUc4H8i6MRspHfPthIbNC34MXK6KZMkSh5tJLpgPcCs5VnLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599667; c=relaxed/simple;
	bh=So5T+PwK0h5wB2TBy4BEBdk40dKHXVlqW1XorlNO6P4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XVNn7HK2YgTc6bkI5OM2BjjehAVscwd+ld5PLU0UUZNc40ig3c6iMuBwtfmKrugZ094z7t8hOR4S2lh4HegZ/82w1exQbFC+VzOb34hYYewyBQ5mGgbWLD9uK5thEWAGFSKgVOKuUM8XEclQt0m0YAwvgDB0LBSzqilbwImgMTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=srx6qble; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="srx6qble"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-415c8a4d2e6so2686365fac.0
        for <linux-block@vger.kernel.org>; Tue, 12 May 2026 08:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778599665; x=1779204465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEsOf8XubBs/oNOFxIW9V5cC+c0JsyhoGC4fUhIAwv0=;
        b=srx6qbleOf/KrZg5de+2ltLtBNJFjkaMy6nYSI7HxM4cY3XQ5hOt6UOK2+p5YJyjhl
         X8IwQ+bGbsy1YPnYU7ydLS7gUvZrBGc+0DbCMQ/DOq5HGAoDbOuWNkr7nwCBBSfn1G6w
         PQMnof1CLn2ikRAqOKZur19XpgbN4MsXt9tRrZo6kKyPykJcnxKmrlCL3b6FObbC1kvv
         UyLHQbIKGzzp2Gig5596SzZAKqWEGfqznTNCAKVKhqKv3+O2X2M79nGg7+O0g7/8M/ZF
         Tr5L3/1eEgl0hMZPeyAsskNYe90QJOgph8Ij9IQkEtteb1P8JaZlS0fhDmSTxM54c1y8
         yCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778599665; x=1779204465;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vEsOf8XubBs/oNOFxIW9V5cC+c0JsyhoGC4fUhIAwv0=;
        b=Kv0Uav9zKafzKRgtPn008+ZJW1SX0EtFp0YKEz/dhKYiDm9706GsYFGC6VdErYEZUr
         bepGEe7CbBM6zZjrmSUkkWjTl+JI4HdjiIvP2lqDq+VqQ6DMT+aSdM1Wzp2Rqtt2b1sc
         B9waXitgIlc/sfSHtcikIEz/pusJhKbOJ1Ynvvm1vCe4LSyK0wB2D9z5kjOsKz0tvBq1
         72aaMkse/rsR51e+L55NBuRCzUITxRB3b7ip42ZKhnBCREsZ2ZduXA6GilBE73b3FFEP
         iorCgNJrA1dFIdnSf4M8TYemwfFhhpqDdHk/u5F2QLZVcAxKVpPdtEJ4iZvUeAycMLQw
         10bg==
X-Forwarded-Encrypted: i=1; AFNElJ/tP/rNZbEe86KP6P4MWmo8pe8/R7NoywDFbp9DqN1KKVNrzcosKlrXeXq2JSYfkXYRDnR+c8X5Ml3m9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8zGoPa9eRCeoFFXzwaMfdNubcQ3LJj6uFxS7n1DrVMSRU6YIf
	wf4NW59okogewL/60cih2c4JwBq9uY+RliYRU/UBJEhf5pAupArbPad6c5PpOtP/omg=
X-Gm-Gg: Acq92OFbaDUoCD5PI81YwJbUS/ny1e4DsYXQaqCCaGp7GRjSkzz1XEJA89SKhojgR2k
	Ih7gZ16Jl+/XHbSEfFnmBpj7Z7XFIwkxSQBZq3tOtESG1Y4FmVqzwIoIOBHmiO1aMTo3zfxd7Bo
	mIpY4nvhp+yF2G/Ktw8Usf5fBtxIc99quemGvHJI8gW+X9n4PtAsiHBs4OU4xfOnIXDxRoyyify
	UWIgZnUFHF9GOT//++jm0CLWG3U3xAH9pISj3iNBxhYK0IJ3HCkv6zWLFDYDoV4aQGVnpZN8N0z
	H+OvrqWo5pzBB2eeLsdCjV63gMitJNkRZADRhasN/mLz7awkJ7Pn4V99v4MozdG5a6Gubf13HlL
	YSvaThLbF8qrW8Uv4exKSmMSeSUYqVFLDGeubyQ+/uUjADBjaROqKwU+aJjFMjkLDBu0IRLMrhI
	aW0jjWYT6ULzPvbKwwFKk0cSJIi9jNtdV6GywEx6Z099cfOB5raDWHbwr8VX5nldVMT33mvp2wh
	vA=
X-Received: by 2002:a05:6870:970f:b0:42c:259c:6c8c with SMTP id 586e51a60fabf-439a2441508mr2107070fac.3.1778599665025;
        Tue, 12 May 2026 08:27:45 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355736f517sm13044552fac.12.2026.05.12.08.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:27:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Casey Chen <cachen@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 "Martin K . Petersen" <martin.petersen@oracle.com>, 
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev
In-Reply-To: <20260511212230.27511-1-cachen@purestorage.com>
References: <20260511212230.27511-1-cachen@purestorage.com>
Subject: Re: [PATCH] block: recompute nr_integrity_segments in
 blk_insert_cloned_request
Message-Id: <177859966380.306312.3636019256841689076.b4-ty@b4>
Date: Tue, 12 May 2026 09:27:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 11 May 2026 15:22:30 -0600, Casey Chen wrote:
> blk_insert_cloned_request() already recomputes nr_phys_segments
> against the bottom queue, because "the queue settings related to
> segment counting may differ from the original queue." The exact same
> reasoning applies to integrity segments: a stacked driver's underlying
> queue can have tighter virt_boundary_mask, seg_boundary_mask, or
> max_segment_size than the top queue, in which case
> blk_rq_count_integrity_sg() against the bottom queue produces a
> different count than the cached rq->nr_integrity_segments inherited
> from the source request by blk_rq_prep_clone().
> 
> [...]

Applied, thanks!

[1/1] block: recompute nr_integrity_segments in blk_insert_cloned_request
      commit: 2c6e6a18a37b905cb584eb0dda3ae482162a81ca

Best regards,
-- 
Jens Axboe



