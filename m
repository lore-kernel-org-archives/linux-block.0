Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E36243E484
	for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542149; cv=pass; b=YWi2xhhmjezl/I/DYn3TPiVpgaY8xIpeXoERi0E1HxmkoxMyM0mrC+RIPrZVbeQiMHmYw7FkaiNy6xUCZmA892iJYQp+xbBPverJ+b/G2jeTcMq0qC2Qu63PXQI+0wCpHoYe8NvCjM1FP0oIKmMZy02/oIOImrxpC7qGNK8jHyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542149; c=relaxed/simple;
	bh=OaYKz/8UNJPHTqaurxpclVEI6MeOPbYBwJrUelUHVSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLEikLI/4Mig3Av3hX1TgbL/usP72dyiGAwHhBGR/bs0RYkRENH0F/rMzpNGZ1jj8dKK6lv3r/k0ojAGBS39A0uVCV614+aOakVdH4SU1JY9tGbxuAWg3+F8tXyshQ5pU7psPOqlIj18dNLHh8JwAt+QaqI5TlhRZDsZUiyONZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HjdZP9Gb; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HjdZP9Gb"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49553515a8bso14142285e9.1
        for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 06:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786542145; cv=none;
        d=google.com; s=arc-20260327;
        b=RJ8C2HSzjrPN8uNIrNmlUDLjPbc4crSFbphvvS9pU/4Nam25wqe63sOR5IiF1URkag
         EDvBG7T7rzJ/tYxuE5Gi3DHXG4hhKD3B+/VYOU91GZIaF2kUAFH/EaOpcCYnwt2JFqQk
         GoeSXJNedxemlBU47Kk0lroPoknNtLp3ci+k1aN6XvXmi4xjZagYposSI729O/EEvqoH
         GzccDbNpu3sunTwMsyiTSAWY/1+ozjwblX8XUO+eHXWk8IZimZzxcZIrflfBiv5mCNew
         r6b4mkOSaSP6463qQpuQH+8U4ubDzZeHWCElgQPdvQiHec9Bd7ItrdW03L4brHIfidVg
         OgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5tGpXLx/o7dEo7Q3/7U1JEPYlPhC8+W5F1DtfAIZ18E=;
        fh=lMyIbi/TPUqHWVGsZ1EteFaYmx+D3k20iEvyYbUrnjU=;
        b=e6SjNKQiXP0z7pGB1Y0c6+g1S3IAsLtaaxA8vgvs5Ypr1+zyuM5DafiIO/AqrjoLOh
         Ld497+wCYYAuGJ6IEyLf1C4H/h15mcQQkzm1romPEAjknYbmYQRSLU6u3o+TnyuxaSRx
         RWOr0nG8NWeWlROgPIlVl11/W9fIxeRMaUhOyQQoke1cVE1TkCwrd5v7WRO3HmKcc8a4
         e46Pgyvn+Dg4kCdPz36t1HK6RoPTCZLtgQ+Ct/DYY4n8uWtqwWII1uJ+Re2DrVNgmRb/
         cfG67AOs8J1vPrwo4JrWJMkEV82Z5ZW0IXhrCn10zpeKFBaZ+LcCM1kc4DsW5N4ZJZWz
         Xtcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786542145; x=1787146945; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5tGpXLx/o7dEo7Q3/7U1JEPYlPhC8+W5F1DtfAIZ18E=;
        b=HjdZP9GboP2C1f/GfQkYqllSxbidziD1jt+uCNcmfidvIEiYj7X6oGLk2SdETaeSv/
         FP3qlWyKUHkcpRXxTN+0jrkP4HJs/9qqh153fQvgKBAiYcrIZKWMpWux4Dsqben2uoo2
         jq093FKT3uA3aomdd2cHNrjpIRlOie6Xnx8HTUAdI+31sVJ84yBMM/bsT5a+pEYDil3U
         okCaDms5nJ9C88MF1JR6aB6nrXNpTL7Kp+XEeJgvlpofEJi+xTC/dW5nL7oZv1u5DkOI
         0h3GV3E3UVDkhGTD5f3Vug+cO26rsABqHAZS9nImESOa77Y+AEshR5wM0WD3ViSgl9aH
         Lk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786542145; x=1787146945;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5tGpXLx/o7dEo7Q3/7U1JEPYlPhC8+W5F1DtfAIZ18E=;
        b=NeBm30eIgXD8LxZ/0gZHjTudHPKvHlnRa50i+Gp3Z7R1gffvrE4InzcsUvpPRzCI7D
         2ZN0lt1Sp5VV8cqY9vUTcx8T/q04tL+ojP0Ka7T09gXt3Skbz+dweOzVwoNSbdHbiYKz
         wf4o8oecP1o+MHu2YQKqW0HwAe5/4BNvsWAP4zfpz8V56XWuowOcSwK4mo2XuPFJCOjM
         /L0OHcXJIUffwCR/ajo7fHtP9w6Y2amVGwtMvWrsWFK6NeakzSJduEoivTcUraIXzSdp
         OQ/mRNQ4OmZb0RCiz5KGzIznhanHR2ROJrLV367LYdVFM7IQYv5vqX35GOokWEvRLtvg
         UVog==
X-Forwarded-Encrypted: i=1; AHgh+RpF2O60z8S8fwwCMmMY1tJmPmF/30ZKdqvLSBMR1v/wm5djKyi8YhOvBd8DY8zht8ag9l2+56k0q6TbvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmlp1Nb1eu+J4/nMPgd2cH6xcv9uxlAdh3SJRtLfWyPgRMxMsz
	Sun9uCefVuz7zD3QQQ0vUgP/JokVjIfcw6BGvOzZMF9+yS4qTPPj6q7RFXgDDfDYTA7Ktpim6eY
	xVzuLK7lxyLgRQgq0Ox9jCr8Skin+dh+mYCSLoUa7tg==
X-Gm-Gg: AR+sD12tJtPlDG7TcGbINynsXgislOzu9o7Sm0HCTBiCURGnVe2Bu21CAJRk8fyAmNe
	qtbxBL4pvBmjFxgrExZ6ym9iAJqiA0YLnXI1DJ70hFa5Rw0XIJcaISjfj34DEOhoOIfFi2421w/
	x/aVFvm037VBAZJjKspSmMq3fx0gFLvKe6qrfk0qS1+TNvXr2RoqTvj0BwcIYc2cKc1xxq7NVoa
	0Y+XJYL3CjAiLsPjCTvVj11iFVlVy4n6pqJiNbGZw2sIT95w0MGv1CECIq+40uvxLigSkrLdaoP
	wWvZ4OaDYw12C0jyT52jGMtQ8KLE7cwjkzhuRbLQbneEi465zb9sp4NOcVoOB/le9KQmmbv2raY
	lrTEuaEmM+wInI76eN3iRvmJFzKbMet72hUzTBzBAAzg=
X-Received: by 2002:a05:600c:4690:b0:490:c6c2:52 with SMTP id
 5b1f17b1804b1-4997c0fe67cmr65880095e9.3.1786542145347; Wed, 12 Aug 2026
 06:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513085340.3673127-1-neelx@suse.com> <20260513085340.3673127-3-neelx@suse.com>
 <20260601224920.GB25574@quark>
In-Reply-To: <20260601224920.GB25574@quark>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 12 Aug 2026 15:42:12 +0200
X-Gm-Features: AUfX_mxUX5B7ho1XknbfVlc-uLWV2Eu6v2suT3UDLMiVCVx6n4XVBbcNHB1dnXs
Message-ID: <CAPjX3FfouCuSTTBYASnjRgvu+kR7mJtRsd2WZ7Lc9om+P8hK0g@mail.gmail.com>
Subject: Re: [PATCH v7 02/43] fscrypt: allow inline encryption for extent
 based encryption
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>, 
	linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 00:49, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, May 13, 2026 at 10:52:36AM +0200, Daniel Vacek wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > Instead of requiring -o inlinecrypt to enable inline encryption, allow
> > having s_cop->has_per_extent_encryption to indicate that this file
> > system supports inline encryption.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> >
> > v5: https://lore.kernel.org/linux-btrfs/ba0289bf103653d5d98ef576756c9a2a66192865.1706116485.git.josef@toxicpanda.com/
> >  * No changes since.
>
> There are multiple places that check SB_INLINECRYPT, and just one was
> updated.  Perhaps we should just require that if a filesystem sets
> has_per_extent_encryption, then it also sets SB_INLINECRYPT
> unconditionally?

has_per_extent_encryption means the kernel fs implementation supports
extent encryption, not that the mounted filesystem uses encryption.
That said it would result in all btrfs mounts setting SB_INLINECRYPT.
Is that what you meant?

--nX

> - Eric
