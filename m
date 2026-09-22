Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B600654A7F8
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085948; cv=pass; b=ioe+IeSu8hAGlJPeSFmjtW/nZNxKLH7KAEHQib/P7gWVmvaIEHL2bzXhvAJGpHkh4Q+w0k6xDLmZ562ASq+NvZ77eAOq+onONtsKiUlBUtXmBPeNNjXqK2kgjXEl6vtiR3OoqDzX0Qwmv4zgDMLR598IrKc1Km5AoKplEbDboSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085948; c=relaxed/simple;
	bh=4H7cYh/XcFy79IKh5ntWbkLJLoAWIpLRyRLXVAEP+zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+aNJ4C3Cf7I/vFDwKTKmWwZqnvK97rYyWPACqsxyLP63UU6MXu/81hru+iSIgZ12QXvQkx1Xnfh0ZONTM2qh/0cU+75kDJHAKvANqwGOgthLfkK750GMaM0H8AB8vETwnlcd5WntXkD83cktP4K4SptIQ1Lspl0k189etaq2mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OaZw4Jlp; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OaZw4Jlp"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350faaso2318519f8f.0
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 07:05:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790085945; cv=none;
        d=google.com; s=arc-20260327;
        b=UvyLx8/JSQ26zWnxePB3Ign9JZxw5f3c6iG51fGjtDCGYEkEQHRotszd6GijCxOcm6
         bYWaudStSLzmVLi1DokiKXgqFHTaQJf9yW/7lfMT2cbO1Us51h/YeZRwMD/BPvHufrIb
         w8oQzTvDI9bmrUQgOzC8NHGKnMDAh1kQv87/uGZuKjPZu1ZjGFZvY7eKMg+GXavIATH/
         2sqZFfd0g9crLYzpVTRpWfCienTnHYLWlP6cHHNyzEd861ExK1NSuwEpf/fMvqsVvlSk
         LkgN8h2DHPnYtYNSrlz9/H/4dI8RxqaYE6N+Y+GkQhxk7wK3vx+55EJIXvG3Kfzn6mDu
         Q6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LV8hwkL+g4D+YUVw11Whf1ua4hVH+TJu4M6R33VpXN0=;
        fh=igM8J6s/r6VvNCtw01/jPw/kIC42aLMk2iproMFdKu0=;
        b=ZHDLxTU3WS+0df/Po2DCPhkGbHuzUJ1pDfZsdHz14UBi7FRaDBJAXzQZjR4yIo3koD
         2jaUEDVzzPjoqQ/+Ml+oGWlJJlptTK2JHmgfMx0ozdvuyf5yiLtXLX1axvLOx9cITPyA
         MwTnUi0+4VySTDDY39ZfwMLnppj1bybuonhlMoN0EQyeFtA5f+o/qcS0gFOhCTj3xmVs
         bSDWsRvWyWESS94xRZRtNJvFIdaGM573jTjFQtQegmTBJI7XcIv32qC8QdjWjEW6UxCg
         8Y68W0BSegoamewjWGf4JkYy3eOC1EggOFSp745gRswVad+c+Uaai7XukFHwmDdowLAQ
         XL3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790085945; x=1790690745; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LV8hwkL+g4D+YUVw11Whf1ua4hVH+TJu4M6R33VpXN0=;
        b=OaZw4JlpEJnPotAAApkw/LFOiwvi3X6tj5Xr6yfn43f8A4HJunL2BYhfAn/tznUyVN
         qjajcgIof+vAF77Nlhhn7LGc8XluAKPY9Yugz6Saty9rYpmP2sMv0tARCSpOk7VNloUX
         pg6RkXpf1TMnVHEw2B1zF43vBSyFXnJTkQ80F6dOKOiEAGWiHSkNIcJ7rQ3Ikjox+m3j
         IWk3KcV3HzS5aK8rZVaUHv+4hEfKXf49VAYL0MLmlhtyUpDhuaGK2eEgUidZx8GkSY0o
         6dUI/uQ/eDY1C2+J4jWSCEsIm4YwmSej4UX+8SNIix6XGo6yUUSuhmH5ang8rK0XG26q
         sY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085945; x=1790690745;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LV8hwkL+g4D+YUVw11Whf1ua4hVH+TJu4M6R33VpXN0=;
        b=nZ6K0AnMcgLG9hrOKXUDpU1A+kYjsBRpxruDpLkCLxLuv3IJOc6JkS8Wpsc/ApzhE1
         kAv74Xw+CO+swgPjR9db/B1Uu1PBYhCiHJ619jzgeirrNCbWSsxe0zRjn5DJuNlOmYpE
         pDv3x0dREh8MrXZa8MSzVJvChJFWOqtAHpi+nmvivXBh+o/Z7DQg9RcsBpq1FIW/DiMm
         nRyePhTBrf0wZ7Q99yFYM2W8odilNs14GsySL9vxHylfL3k8kao0cDX/CgxmVo0fe5Zl
         0YiDMM6BF5flJ1H2QLu+KQ4w1kqRXULlP9SEFdOThgy90xee/EIHiXmf/R3rt3+tBGfs
         LJbg==
X-Forwarded-Encrypted: i=1; AKwUvBzCr0S5dDyUWdTpwAXFPHUh1hGJEf8586IyKe9d7E1b7FcmqST6OZEOWkqwuJqr2Mvit4EyNZ7+LvBlgw==@vger.kernel.org
X-Gm-Message-State: AFuF++mGrGTcU04eHXG14exbqZICdBCpDsylOBVRcZr+G33CP18sb8O7
	VQ+vkDmc15IFhEcfysJctb+ufYOVNp7jAYhuX/Rv6px0G8IYialfyDV3jAFws9GXwa3bKn0Hirh
	Itby9H2x+PTDVBLvPWnGXmGMx/BNl3HDur5lVtUku6A==
X-Gm-Gg: AYBFou0TKIUCpaPmg5tt0V8zKDfI5XTjs/7rH34nDE9xfymt2WaLC6prlikDEqWro12
	XpB2nZ8NiF8GqQK7Qyvs3j9GzB5p4b6G9awbrjfePoIKmlmlF4KUV41ygrRs1ioxx8WYXxHsJOC
	yL/DkmLQ3qcZPnc2gBV4BXSO+lVrkhgFRa3aj+pgm3F+ZU+X7XyXaurhqBCUlUXO5orn8kcEFau
	RLg/80QIpgdUh6Dn9+MaBBZHg+kUTFwPz/UTjdIdKIQATtybU0NeuXoqNow0jnrB2yUY4U9j4UI
	fxW0PQSpdgW8rEC6ZRpOsi8/8MssmEvrLLsiHdrK2rNKt13S0trX6Su3s52sb5344IMC+bxewUJ
	BX8VBmPMws1RA/HKC9KPrK35I7zlR4uR7oyuJN2s/4tqqeUrfk2+P
X-Received: by 2002:a05:6000:2409:b0:487:342:d147 with SMTP id
 ffacd0b85a97d-4871e363e1cmr24110192f8f.39.1790085944981; Tue, 22 Sep 2026
 07:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513085340.3673127-1-neelx@suse.com> <20260513085340.3673127-14-neelx@suse.com>
 <20260601234454.GF25574@quark>
In-Reply-To: <20260601234454.GF25574@quark>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 22 Sep 2026 16:05:33 +0200
X-Gm-Features: AclHuK8dl-tYp2fYNBoxko904-iqmC5latOeVGuZqXI84CESlhxypC11MK8aWjs
Message-ID: <CAPjX3FctU6PQ1=2vL5yVPhWRb9konu2P=Oz_W4E-KSu0FmG96g@mail.gmail.com>
Subject: Re: [PATCH v7 13/43] btrfs: adapt readdir for encrypted and nokey names
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Omar Sandoval <osandov@osandov.com>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 01:44, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, May 13, 2026 at 10:52:47AM +0200, Daniel Vacek wrote:
> > +     /*
> > +      * TODO: This should maybe be using the crypto API, not the fallback,
> > +      * but fscrypt uses the fallback and this is only used in emulation of
> > +      * fscrypt's buffer sha256 method.
> > +      */
>
> You can delete this TODO.  The SHA-256 library functions just do the
> right thing now.

That's great! Thanks.

While at it, there was also a BUG for folios of order > 0. So I
cleaned up the whole function a bit.

--nX

> - Eric
