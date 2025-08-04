Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA7B28C2A8;
	Mon,  4 Aug 2025 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325998; cv=none; b=S1OO35opo/Dlq8kjAtyU3YB/EUxtoxyW9Mq6q+9jsgxWcqQbzfFI+BjXY4Lu9Qc9q6NowFf15nsBYmMRKhxdfVplUvR18QARH55Nzf8iu8jCZ80wpytc48BfU8BlxLSkKwcBu6H/Ylg+bc5RXR1dBSBL48//H6RBDgJ0+GSM4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325998; c=relaxed/simple;
	bh=jAMcpIMA2yOpdrzrC5aJSA8pvC96qIhLgPp6E4vF2KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbZOonWO59e2FEkU26EuAdUEgoyfGf/jH3dRH4HbQ7yi2KI3FUPMkU13h5OcpPBiq+syUiddz8mZswmZ+lLuX11q2k5LIhc55D/i19a2hsVb2CEBjur2ppdC5w43kqA3N1Oy0RQDkStR4kY2fpw7nA0nru8e3sgJzt+lAop2YNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFIwSb9Q; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFIwSb9Q"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-321265ae417so1571535a91.2;
        Mon, 04 Aug 2025 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754325995; x=1754930795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4mUwsosghGp994MgaYh4cJSX7jdyflbkgOmQIM/ga0=;
        b=GFIwSb9Qv++kTiVkVf0Xmazfs9Gh4OznwUxerqpkyDIJn48CtTiochDCy8SF81Uj3H
         /OzdGmTafDBUSfWkZp+QVk18nvqyGqdn2dDSUmCaWyjq3uqcunERKhvTGuXkFlirCCzb
         csIHdpwN1ilDmx4p9E/+KJOHPDY3h/uakm290RZRTyG9nICz0fQrh2G5VqEIz+DH4rm/
         Qd8dSMJchn0vxY8+rr4wn1KPxSvj/NNYX0gDUKOAN83zmWi2daZWrDtJxjcUJGGS9e67
         L68svwq7EKv3XGLSI09rlrss9Ye0pFKQ1L+1xpu+vVE/ruPsjdYS7/ayhCt3ZX/+QJOg
         aojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754325995; x=1754930795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4mUwsosghGp994MgaYh4cJSX7jdyflbkgOmQIM/ga0=;
        b=J5LrO7urX3sO0BIgG5Iu3aetiuTuvjyJvbyxpDqYaKVVdZ7a1bTbpgKWdKKuDHXMK5
         uWkzob3i9DmjLXhhuQD88/bK9KiDJZGw6tDBAsD4wI+4fDiATdlK6yavU1Gz02Kd1kyk
         3V1md263dCcUfBQ/qQmdBkndvgN00Fu78G/xDhoCrhR98wGIg346FNkFYQNXAUjEg05i
         GlStUxeYVVpUI+5GwSwphvfYTB++6bX4bczEOCghiznIEfxP6oKONoF3n/wZ0YQIt1LI
         3leFjPHC4VJwaYYSss4j/onE191J9UCmyZflszv01YiWmR1d7n25B9IjIXfJKfem/jWn
         yufw==
X-Forwarded-Encrypted: i=1; AJvYcCVTUkx7Z0KIpheKXZxJx2hF+gs6VK0bbRPhMmRE5ONsnj/XcQTaZEwXuOIhMAuXy7wG+15zWtuKA2LS5daw@vger.kernel.org, AJvYcCXDw1MC0X14lJcUZsNOHGbVQqvY7bFb5UmrJET47iUwM+N1PngfDat36/+c5wWlJ51DCygtWldKv8mung==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZshmbjnplOtRKaBDVoz62d4A4rlnFT3St0TS7fznE21jo/F0F
	FBfxCLeE2xACGGyI+wZgVM1rzhyazMRaZZR12TTCGnfZ2MIYwAuWZLmwYKqAr65Fs4QK+us4Olq
	bhIKn7AP964IgIYd59O60HTPF6UpHkrQ=
X-Gm-Gg: ASbGncvljdqhSsww/UNZIPo+CdqS/3p0YR83wUXqhafYB8N/piESlYFvQE/wgl5EDeC
	0SGR7jPVrkVLkeHUpYsz38kutrPy/NX52e5JJQ5TlsRdXdTOwhcG4zjUdDSINum0z5V/BpcQ2p5
	uiK/hXImvRRG8McQiHdWmQjZ6uK91zfYcd9sDoukP8mCaFq8J6bkzxIjFZG4kXv6LsUJi04qORI
	PVXMiaWYH1vfevhZVPIwAolBpJ+Yamo1KOwvJ0=
X-Google-Smtp-Source: AGHT+IGedtaqxiBb0zj/dEF8Sov1sHd/mE7bUDGYR+q1eN4H6na85hWj6H5WXDEqHME+bb9z8spw3cEmb8eUpUks0wU=
X-Received: by 2002:a17:90b:4f48:b0:321:475e:e09b with SMTP id
 98e67ed59e1d1-321475ee15fmr2883377a91.26.1754325995432; Mon, 04 Aug 2025
 09:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727173959.160835-1-yizhou.tang@shopee.com>
In-Reply-To: <20250727173959.160835-1-yizhou.tang@shopee.com>
From: Yizhou Tang <tangyeechou@gmail.com>
Date: Tue, 5 Aug 2025 00:46:23 +0800
X-Gm-Features: Ac12FXy6xdjuVEpMGnhErQzjqXC28hXlEZbtmQLZAY6zPnS3NEafwM6wAf2-GTw
Message-ID: <CAOB9oOZp3VazSYuvj5+dc+ky7OyfcdHTOPT02q02k4ykC+zrLw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Optimize wbt and update its comments and doc
To: axboe@kernel.dk
Cc: hch@lst.de, jack@suse.cz, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tang Yizhou <yizhou.tang@shopee.com>, yukuai@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 1:40=E2=80=AFAM Tang Yizhou <yizhou.tang@shopee.com=
> wrote:
>
> From: Tang Yizhou <yizhou.tang@shopee.com>
>
> Some minor optimizations and updates of comments and doc for wbt.
>
> v3:
> Fix a typo: change 'cur_win_nsec' to 'curr_win_nsec'.
>
> v2:
> Patch #1: Pick up Jan and Kuai's Reviewed-by tag.
> Patch #2: Pick up Jan's Reviewed-by tag.
> Patch #3: Take Jan and Kuai's advice. Change the name to
> 'curr_win_nsec'.
>
> Tang Yizhou (3):
>   blk-wbt: Optimize wbt_done() for non-throttled writes
>   blk-wbt: Eliminate ambiguity in the comments of struct rq_wb
>   blk-wbt: doc: Update the doc of the wbt_lat_usec interface
>
>  Documentation/ABI/stable/sysfs-block |  2 +-
>  block/blk-wbt.c                      | 15 ++++++++-------
>  2 files changed, 9 insertions(+), 8 deletions(-)
>
> --
> 2.25.1
>

Hi Jens,

If you have no further concerns, please consider merging this patchset.

Thanks,
Yi
