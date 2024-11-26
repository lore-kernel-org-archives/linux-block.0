Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA431B87C0;
	Tue, 26 Nov 2024 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612734; cv=none; b=DKC81/v0WtjoM6ILoLub+L5HMoQnE0FurblGNaQNkv+xnudl2m/bT90BEwm+5VyhIIunxP3TvieeIMkvfzLQpK6xhnmJgpFxTVkrrSJhYWLHksRuPpLAON2QwvMfOidAqzvS05JkGiOUcv8T4yRW5/Med/aNQgoKOTYjJSqyUXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612734; c=relaxed/simple;
	bh=H8eF2eXLoEAWy3yZQI4qwWZRVJnCj0BbC/ST/Qo9VCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOSY3zH1ZihNMpsV5wNRjqVCr3SwBysFbn7cnh+Ry/Fx01EIDZaHu5kKjPxSJI1/GlGYHtctSfWvgq+LGwysSuTjDWX2dvpq/+eQKkSRXPXL/nGigBXaNHyhcgSYryBwx4qO6pjpPszvaNyoh32YXV/jRlLYViORiCrO6Y0R0/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxHHAf32; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxHHAf32"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so5065893276.3;
        Tue, 26 Nov 2024 01:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732612732; x=1733217532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVDCky70auYLWD6XOWEkaP+WV+CoPiiKjrNT7eFkl2U=;
        b=XxHHAf32kePwdJMjDzJsm2iBBb81HZmEoDCV2djiRv1Hy2MClhN0rmQxcVAgp1TFoz
         +c0kd/S+Jg0db0bH0QzcPc1E5SpJhzTaR8rTiBavx0MiNBmQxEhLs8non3acJLLxiiGM
         P0wGymIv+RvkTNWApgCz+8ANrRmhPzSaVXo8WySjGVkVZ/bD5Vp8wAzSmo6ZrKFXql8F
         d8El0uKLw7H1eK//gWDqNzIJjpSU4BO1zApeX+RTMbm1UCoDuqXLhmoFUy0hI/ie7+ev
         YWIgj4XsZ0fMT6bVyDr4TWzmMxhMuOhYkKTerITgLKjw0ngzjp4l2O4Tuma6oUSVVtXs
         7C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732612732; x=1733217532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVDCky70auYLWD6XOWEkaP+WV+CoPiiKjrNT7eFkl2U=;
        b=ktwt5HTmI4+CaaZGiEwzVRpSWrA9RrFAnzGgOO7uTMpdrcNWz0FNyjWAkOsV/bBGtA
         8HZSo4ZtXrW1mhSjDbx5TU3hBWoldFl8SnSWF5uM+vD3kMKbocw/ALGjPc8U8de0RYcQ
         grkWdk7lk6qMqJ6DQEb3lnlX7TUjudJuWQ6Puc1EPgOgRG1HZjPYJEv7r6dtlKzQAd0U
         hV5rXMsV97Yr863pA0RLL5jyfHBGkOJUew71ERwnGdbJXXIrJ47sdsfjwGNNjqQJLJUO
         rAZaD6sKKE1jEFLbpiClMn6QHWOkdbB/OTmkaAMg+0ts1ybKpnQ9Ho4g1ZRrl2UgdiDv
         O0Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXuPaTcxnNhAdyOIykZ9XE0X9DgH6FSv5kxgOwXu/qOf9yw+r2MCiwaCoQgnw929pk+II3eX66MfPe2dA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ud41HD9uUSxpNokVBYm4gBufTIzbZCvejiGK2T6eHG39fp0H
	KmrMttbdH3Qm4LNXR+ERYr5akUhdesWYk1bR1r2TREYvmUqN8Op+ql93QGFUcaDkraKOBw54tAf
	t0rz23FgrClCs/FzJV5fXjEsSG5M=
X-Gm-Gg: ASbGnctvB+/+x+FsdAXG9gsHqMdHkXhZjkiyvL0U0lc5Okic0wayw5bIWsPl5ZO/7cj
	IyV9rcqgDeslOw3ik6G7m25hFVJgiKjM=
X-Google-Smtp-Source: AGHT+IHV02X2n+cTXOdwOWnWyjBXRCSdI9G0x+XWqC/yRz8lOxPMnte8V4M5zojwdV+Ku0e8hXCcOj0QHix71W+R8dE=
X-Received: by 2002:a05:6902:33c6:b0:e38:f11c:f04e with SMTP id
 3f1490d57ef6-e38f8c27cf1mr11236518276.53.1732612732255; Tue, 26 Nov 2024
 01:18:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-bSRbCo7=wfUBZ8H7c3Q-7XSG+SB=R4MHHNNGPvBoinsVSZg@mail.gmail.com>
 <CAP-bSRab1C-_aaATfrgWjt9w0fcYUCQCG7u+TCb1FSPSd6CEaA@mail.gmail.com> <20241126065228.GA1133@lst.de>
In-Reply-To: <20241126065228.GA1133@lst.de>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Tue, 26 Nov 2024 09:18:41 +0000
Message-ID: <CAP-bSRZehc2BxRC_z5MXKQ6qHNPXPgZoOQTtkiK_CFd494D_Fg@mail.gmail.com>
Subject: Re: [REGRESSION] ioprio performance hangs, bisected
To: Christoph Hellwig <hch@lst.de>
Cc: LKML <linux-kernel@vger.kernel.org>, axboe@kernel.dk, bvanassche@acm.org, 
	Linux regressions mailing list <regressions@lists.linux.dev>, linux-block@vger.kernel.org, 
	semen.protsenko@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 06:52, Christoph Hellwig <hch@lst.de> wrote:
>
> Fortunately fixing this is not only easy but also improves the
> code in mq-deadline.  Can you test the patch below?

Yes, the patch fixes my test case.

Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
