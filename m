Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855791B4152;
	Mon, 25 Nov 2024 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555013; cv=none; b=mtKI6A5g9T6/eba06RBqhN3Ql72tDZAxG7ItFrWqhQFbX6msam7OkHb2BvarhmjsBxWXMq5eAycTbphtrmNNDu7YdrkhRTauBBNvm8ILpb2byB8kfJK8AL6znre7O8604k84oQ030Uepiizdm5Qw3vPIwS0Dg/b8i9w2RN19jy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555013; c=relaxed/simple;
	bh=+4u48gpD1Jj6Cz+HFaPKL6LTmpdlPUj6k1KeEetzyOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbJxozWzFwX0sNj9yLPp3tGBa8flSDdRjD2G2qnzzCQWrLppXNrZcpmsPsKJ3cQUnwJ2tuzj6KsfGPtGE7OKpiXlcZpmEBvWSj7fbphPJxMFR12pmY4sLVhq6HK/HgFKlFlo4tUS77YFrzH9SP+9E0FO43tDeVzSCXq3YJqFA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du/7omnc; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du/7omnc"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3889bc7ec6so4414295276.1;
        Mon, 25 Nov 2024 09:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732555010; x=1733159810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ia/d0zzH9PgohmxMU9kgpub0xyeSlReyHlI7D5sBI8=;
        b=Du/7omnc8mXN3Jt46IgjC19xDhQFndW31J3xlZ1lP3qJeRLaQtRZtucrtaos9okZI2
         ZGcAI1WiMddh2uQMUqydC+7/1LfDB+SbZ6HkgdF8h4plANqypIGxGtsG7th2ukZc5CWA
         AOBSik6FkdPdoVvGzuR5fa11xhJ7Iadze/mj04II9S6vl4CxqF6ffO/yP0OwC1vyS1+D
         inopmV7oGo0x5PZfLozHweDuT7PJaztDtR/S0ZYhgR76rPDaRS0T9IiJy1NFx2YpZr0K
         eYMk4Q4ZnHNKj+J5YEwW22mx7oGvLaBFywdHOjucThhRDXqDhyuzynlgHVrOycTWQRlH
         kINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732555010; x=1733159810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ia/d0zzH9PgohmxMU9kgpub0xyeSlReyHlI7D5sBI8=;
        b=Rz5x7PpKbcP6730aAToARMATQMiUYuQb2eoUuxeS/qcGIuUCwa3b0PKRiGFq5z9QO+
         sboHEFWlod6wz1Zsunt1NiMpBVnzZgAibFz4GWJVV4JiLld0ljHhRlNGy7stfMsq59UB
         gpUngmSUpz6YDhzVRqOV9rcamQD5P/KW17aKaY0jLbKRw0oPvtqnY5wGE4rISG7//af9
         4pWz6DG/1Lwrxui1lK28ooEiU2HHYTxlQ1wRZGRcJqYCJu6ZKSAy2RQRxHA4+3+h6q8L
         xb/9kxLvoeBJhyRO6FWkKQwWH+u9ayOED8Ssg5XYQ68ViXDyfMqa/nw3q8ELysGgAPRR
         nz3g==
X-Forwarded-Encrypted: i=1; AJvYcCVHQ3pWCopT+jZ1bVarX0uvBrOaxrLldxnI9PuDMppEKaiYuaq+Ie5rAQk/TlIv20OEVPZhiCRi4J98VA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEaI8omcECg9msrUyl6Qs7UxhjsgwjjjtQGu8zuWgw18SPGWZU
	N7y3U9t7zTtOXY2iyMfT8TM9KcUEaV7Qvl2rM6CWZAh5lSq1nKJm47TC7qzfPjetM4K8fnEk66c
	BfdoGVI+ZfWH0z1dZbEMTOuw1LAM=
X-Gm-Gg: ASbGncvmDwz7JJIiov5iR8LHwFptZgHS2P4IZK76Vw4mTjrHxZ90Kl9ylN13jpejPlW
	K+sH14mNuKmA6ErqTKQSaNgfVspTyB4o=
X-Google-Smtp-Source: AGHT+IFhHP9m3zecw8OEgG02F3A9OsXXGwtA63gEpzTtaUkQlDZ70T/ymKlRRC3X1ecvprD6C1YIqfbDKWDJyty0d2g=
X-Received: by 2002:a05:6902:33c6:b0:e38:f11c:f04e with SMTP id
 3f1490d57ef6-e38f8c27cf1mr9355829276.53.1732555010479; Mon, 25 Nov 2024
 09:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-bSRbCo7=wfUBZ8H7c3Q-7XSG+SB=R4MHHNNGPvBoinsVSZg@mail.gmail.com>
In-Reply-To: <CAP-bSRbCo7=wfUBZ8H7c3Q-7XSG+SB=R4MHHNNGPvBoinsVSZg@mail.gmail.com>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Mon, 25 Nov 2024 17:16:39 +0000
Message-ID: <CAP-bSRab1C-_aaATfrgWjt9w0fcYUCQCG7u+TCb1FSPSd6CEaA@mail.gmail.com>
Subject: Re: [REGRESSION] ioprio performance hangs, bisected
To: hch@lst.de
Cc: LKML <linux-kernel@vger.kernel.org>, axboe@kernel.dk, bvanassche@acm.org, 
	Linux regressions mailing list <regressions@lists.linux.dev>, linux-block@vger.kernel.org, 
	semen.protsenko@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 15:44, Chris Bainbridge
<chris.bainbridge@gmail.com> wrote:
>
> The commit 6975c1a486a4 ("block: remove the ioprio field from struct
> request") appears to have introduced a performance regression. Test
> case is the script /etc/cron.daily/locate from package `locate` (which
> is from findutils locate on Debian). The script runs:

I did a bit of debugging.

The problem is the function req_get_ioprio. The commit changed:

 static inline unsigned short req_get_ioprio(struct request *req)
 {
-       return req->ioprio;
+       if (req->bio)
+               return req->bio->bi_ioprio;
+       return 0;
 }

So when req->bio is NULL this function now returns 0. But previously the values
of req->ioprio were sometimes non-zero. If I revert the commit and then
instrument req_get_ioprio to log where the new return value differs:

  static inline unsigned short req_get_ioprio(struct request *req)
 {
-       return req->ioprio;
+       if (req->bio)
+       {
+              if (req->bio->bi_ioprio != req->ioprio)
+                      printk("req->bio->bi_ioprio != req->ioprio\n");
+               return req->bio->bi_ioprio;
+       }
+       if (req->ioprio != 0)
+               printk("bad ioprio 0 != %u\n", (unsigned int)req->ioprio);
+       return 0;
 }

then log shows:

[   36.922906] bad ioprio 0 != 16387
[   36.923061] bad ioprio 0 != 16387
[   36.930186] bad ioprio 0 != 16387
[   36.930680] bad ioprio 0 != 16387
[   78.875421] bad ioprio 0 != 24583
[   79.228801] bad ioprio 0 != 24583
[   87.411118] bad ioprio 0 != 24583
[   97.419607] bad ioprio 0 != 24583
[   97.421059] bad ioprio 0 != 24583
[  107.210364] bad ioprio 0 != 24583
[  107.210775] bad ioprio 0 != 24583

So, the new function is returning 0 when it would've previously returned these
non-zero values, and returning zero breaks things.
