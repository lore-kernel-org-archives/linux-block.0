Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930EA3F411D
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722364; cv=none; b=NKYYhfjiIOVPyiZHIsVoQkLCiZsmORZlsUSa9tWptDGNAygx0yVimF45/qx5QDerQke1E0B9v3+jML4ORqb24xYY2456F9DeXeeBo4O4/NQHlQrXQNaK5Sk9xp3GjsUGvZdnz520yH1tYm6UBsS8nAChYGo0WHTZ28im/4EZPuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722364; c=relaxed/simple;
	bh=XOdc5iMVgm3fwPRjW36/67m/FdoDannz+z0kjVgka+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkaBQPdzSTYhjmQpYuqjwP/t1KlUUNNgzVAL6tS6f3hOMgkdg4xgtHIkabkFCgZghBdSXRyrdc2xg/L2zhjA105AIII/NiNuvE5bNPXNFlgZ/6qJgWaMj6Usl4ies4vONcMJoez3zmmobWMYaqXQOz0uR9shlm1iojzqcAa7wn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVvyphC0; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVvyphC0"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-95fa7cd1392so7589390241.2
        for <linux-block@vger.kernel.org>; Mon, 25 May 2026 08:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779722362; x=1780327162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y3yt+51trvfb+bLWNvAxAG3tVigP6A4cl269ZrADQ/U=;
        b=nVvyphC0GhTWhQ5U4sZu8LA7x4fa3k81r+DPWeNConFOLcZL7+xv+38qXAr3jsouQ0
         BvfA58PiczMv0Y3+EcmKr1gnA5ETdXBKkzJTW4ve22BgoiuoNQ6WxNKZh0dzqJnuL3na
         hTKHZgC+J3FrjZo9g2jFELsp1HhVQokfUR9Cfl4VGxv2OBBPf3G1VRb7Wgn94YVndici
         Gow73V5N0b3zUrSWEDolLgGukpvbt1729mB+Sws/jx/hX+NvNZuyMR+zgjcDyM7JZVDz
         QHB+GsTVnMmIbNVDDFu21fOXRJoj42b0sXGNpbAOQ9as0xWqZOVzHzs8l/Cjv4ou8rQ1
         txRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779722362; x=1780327162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3yt+51trvfb+bLWNvAxAG3tVigP6A4cl269ZrADQ/U=;
        b=WKeHYcw0YI/HPes6HAL50aGJlIl9v+A4d0wxwrVGC4rRT42zM/Akc1MlNpM0iWaOfK
         07EKJ3iwlzzLpJfmx5UiHtCEBj1hAcjlQD4egcCu4WDaMBJR84scX5g3O2qZ8rBA1TKU
         G1aA6yFdb+1aA5bCEUsmHRpYicGsC+iof8t9nHU9FRNoH+F0QwB2jBp+xxG2WlR8LFap
         415Nvs0T5IycHtWFgPBTTp6k3S8+hamiKgndn9w3Kr2gfQbbdAfQSIyf3qqYth6WL7K6
         1bVXPxTzgNSMg1EKzBSBfKizjxfTDDMvxYuZXmJnb3gLZAdFLOJNCGzTay0wt78ETZWe
         ZlXg==
X-Forwarded-Encrypted: i=1; AFNElJ8amLUl2NG4ySYT93+9BU+2AgH7FtxA26meDHe974BXdBDalJlPdEcVGwEcuXF3URz6DEeIm4Xn1hs2wA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg/xkPwE1cLTBM2LipIxRkGbm1uTjhsAjqOj2Ol3TlqgjclS4w
	Ky+nYqpTF3qiMxPCCMAtfT+tJJfIHeQwa9P2+XTf4aICrsmSkijX51gQ
X-Gm-Gg: Acq92OFEQRrahXOUtyYQKgDJquwFGzvEicl/EyDlfQXPK9cgZdql4F0oeAQkWnUsNBb
	6feMxXSyBZ7A09eGldyQJoVAY4C8L4TSmD5B3S2/n9/iTd8+ZL2TGrdNqMSmuGvoeuuGAlx3ich
	/Gj/dfqBporbB1lZltJbcw98eOn+dx+/P9KxRYAJtEr2m9QONuyNiinN1yHwAUSRJ6FxJSmCjii
	B+U7gm4uGmHjrXSUaHr7STXSu7OxWVSs7yXXeV1Wgt/ioe6b6ltqa6DsDXKfvnM2jLcgZkVo1Tn
	30GWpc7MWvMqjilC4FEizTD6K54wKQrbPRQBONulLKTBlwZBN4dYDxyIM9O0TERpoXNH+HQnQQI
	c4BEnjqwU+xWOilk3xMpmygQkLv2Kr435KL4nZSrMzuH8JE3+SPs3yOovSbsF7myzlRrYXjbwgc
	6Q6fqTdm202mHcwRZbMGqzaaiUobC4rv4XL2rTtleD1UWFNQKDmBwu3HNxJyZWddFTeJDCdAUFS
	9Zbmig5A55efjPxfYFTwvSx12PAj80g
X-Received: by 2002:a05:6102:2b96:b0:65b:47:2c8 with SMTP id ada2fe7eead31-67c80b74c05mr8029524137.10.1779722362480;
        Mon, 25 May 2026 08:19:22 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcd81esm111398076d6.9.2026.05.25.08.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:19:21 -0700 (PDT)
Date: Mon, 25 May 2026 10:19:13 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] loop: Fix NULL pointer dereference in lo_rw_aio()
Message-ID: <ahRocb0Vs_m6RF_O@fedora>
References: <af2205e3-205e-4743-a767-8593c2c4747a@I-love.SAKURA.ne.jp>
 <9b2032d6-3f36-4d2b-8128-985c08a4fa37@I-love.SAKURA.ne.jp>
 <20260518174013.4b72dd50a5bcb89daaed1f62@linux-foundation.org>
 <d43125ff-cc66-49b7-b16d-1b2650c68c23@I-love.SAKURA.ne.jp>
 <ag0lS_CbKO9R5CV8@fedora>
 <94076bc9-2c09-4bb6-8468-b6b8af419cb9@I-love.SAKURA.ne.jp>
 <ag1nfIFcykmQHbkk@fedora>
 <1ab8c579-eb76-4227-8a72-6ec819135219@I-love.SAKURA.ne.jp>
 <ag1223nAa0wZ8ALC@fedora>
 <fda8abc8-6aa2-463b-bf72-865f6b838034@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fda8abc8-6aa2-463b-bf72-865f6b838034@I-love.SAKURA.ne.jp>

On Mon, May 25, 2026 at 12:40:19PM +0900, Tetsuo Handa wrote:
> Some commit which was merged in the merge window for 7.1 broke the loop
> driver; a race window where lo_release() clears the backing file via
> __loop_clr_fd() despite some I/O requests are pending was introduced [1][2].
> 
> The exact commit which changed the behavior is not known due to lack of
> reproducer and timing dependent behavior, but it seems that we need to
> solve this problem in the loop driver despite there was no change for the
> loop driver during this merge window.
> 
> To close this race, try to flush pending I/O requests. However, calling
> drain_workqueue() from __loop_clr_fd() with disk->open_mutex held causes
> lockdep warnings [3][4]. We need to flush pending I/O requests without
> disk->open_mutex held.

No, please don't workaround before root cause.

No proof shows that the issue is in block layer or loop driver, the IO isn't
expected, you need to figure out why btrfs still issues IO after this loop
disk is closed by everyone and writeback is done.

https://syzkaller.appspot.com/x/log.txt?x=101e4702580000


Thanks,
Ming
