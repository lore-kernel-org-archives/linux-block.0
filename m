Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A7CD27E
	for <linux-block@vger.kernel.org>; Mon, 28 Jul 2025 23:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746416; cv=none; b=FjUSzf42Q1mdwYtKyXIH54cDCA2M7rV3FTnqTuRIrgnhCs50reGp+SS27wJWfKqTg6pshPJhfbomg49e1S98vFNipe5sbN5BSw2MuiU3CCyE2q+1vJVprpFvKmpkQnPZ1OMpHBE2PRdBhZFjjPczC70T98pKobKHiqihaJFyZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746416; c=relaxed/simple;
	bh=E/2RhvyA1pOs1GUxlg+XEcoTTWfM2MakJVx+AjSag0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9awwHZHWbmUaOwp3vEL2qNFlVuzPqXpkRKv2Y3dm0G8VxUYweKXJZOuCD7jLN0BkWzk0WQcyhQ65NGXLGWtf/qm6gAXV1DjBHeCCYi3tJtZa+BuK0jGbbUtuRVXdzssbdUpUIGLmw1vwloX14EPQsX9YNsWS7eSYqsm/yBZrj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c7qJuYAN; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c7qJuYAN"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso1005773966b.2
        for <linux-block@vger.kernel.org>; Mon, 28 Jul 2025 16:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753746412; x=1754351212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E+26wK52zuIgMaat2h2UVzkpyLSF/+lmokeA4bBtNbE=;
        b=c7qJuYANVmtzqpD5fYSx+Ac9b0w3hOL5+cvy6qUIfFqBDBvT+H+2hKsUS6Dk/iRBdk
         Va+Qt23539siJCYYzPeS9JwqGURasASv+VmY1gft9jwfaFRvzzOViBEA2Ahu8xI/Hc6f
         lBDtg4CNH17DlTDjYYgIzUoGqE0IhBBzvpDOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753746412; x=1754351212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+26wK52zuIgMaat2h2UVzkpyLSF/+lmokeA4bBtNbE=;
        b=fcnBfIeScUXD04jJkdqNyLyPnnJgRGF2QRmunIQCS72gdxhB1gtsKL/bq7sOi5YU7e
         nC6hUJUlXe1iOzP+nOivq3+GsYtJsNQhe4MdZlWD+jHj7jTd8+l1RiUKHGmugB7pKF0y
         CZUkFBacRsgEI2grNfaVzJJY9gpQY4jEleeZBJGyDkJhG7XIjbHk1KaTu1yCU4awIFro
         FQkGn64IaIk6Zlw9YKJmzSZdUkUEn3kQgOFK0CxpVPTySUe1DWqWQa730D5NrAUSSrh2
         57yZvlT9qDZvjk5extIGVXD1mVD/kctQWFas6Z2UkS+uYk/8FJHZYPOnDYapyxHF2GKW
         pAKg==
X-Gm-Message-State: AOJu0Ywhb5P4ZI9mGtPKWzM7smRDhYj36WNiBJ9iWZY1uqIE+soAVKAu
	T0BaXBIm+pIGX01OqjKCOfCHHZksSyj2ovC96x/DeYGL8jHR+iSq47d2ymyqTnEfgLsrxkS+hJ2
	g7cWdaek=
X-Gm-Gg: ASbGncuW1EZHQAsGrjR/0qfVQ4cdat2Qe8P2+HnbsZL6myJTTmM5A0v+yjSR2dycZsL
	8dNyo12xAEShZTroIXkWHcLXOHr3C6lK+VEzz0muH2GxArKnmrqmclWMBc0LlmYdsaALAUTWOUB
	V1qCjy4GqnvmhPDbkEuFuhOX+OR1x8H+9SMEIxulZupWCDlNMYF2c0yjDjBzBQXrPWHvNhmSg8w
	kE0YfIZwgaak2OfHA+AT1Hm6bK3kGIxdRBsi92rejdqJE6mIcv3yIZ11nrL4y+FUDHiNk1sMq4x
	gMDvS5BBce0NaF01rfhqae/t2g1gkd55P2Fso0D9aPeDwRZkDctcvqcrMpdxZ3GFoI0advOb9fL
	+NPj7aB9iyX/K+mAkCyAX+lpvnU1adxeb4IHb8UOraGVvKiCf8DRwHh/qao2lKcVL4ptm2HIe
X-Google-Smtp-Source: AGHT+IEoDflkXpOiU7/m6GXp3B/Xhk9Oinn4Z6q9BOE6Dd/bzRYnCNo9o2i/h7poDhevZEpQ7Kyqgg==
X-Received: by 2002:a17:907:c1f:b0:af2:b9b5:1c06 with SMTP id a640c23a62f3a-af61c8aa24fmr1477184466b.14.1753746412082;
        Mon, 28 Jul 2025 16:46:52 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63585ff65sm500664866b.29.2025.07.28.16.46.51
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 16:46:51 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6156a162537so323219a12.2
        for <linux-block@vger.kernel.org>; Mon, 28 Jul 2025 16:46:51 -0700 (PDT)
X-Received: by 2002:a05:6402:4316:b0:615:1e13:6686 with SMTP id
 4fb4d7f45d1cf-6151e136b11mr8249747a12.31.1753746411072; Mon, 28 Jul 2025
 16:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9855947c-74e1-43cb-bda9-a720293f33ae@kernel.dk>
In-Reply-To: <9855947c-74e1-43cb-bda9-a720293f33ae@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Jul 2025 16:46:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1nQssztUsjK8gX2UCx_oa5S+z3Yt1uLxcPZ7eWmig6w@mail.gmail.com>
X-Gm-Features: Ac12FXxL5oW6FKD44h-bozh4sfXYna1CjFdryB2ltE7mv8KQo3J6GJZ8PLRfURk
Message-ID: <CAHk-=wh1nQssztUsjK8gX2UCx_oa5S+z3Yt1uLxcPZ7eWmig6w@mail.gmail.com>
Subject: Re: [GIT PULL] Block updates for 6.17-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Jul 2025 at 06:26, Jens Axboe <axboe@kernel.dk> wrote:
>
> - Removal of the pktcdvd driver.

Ahh. Good riddance.

               Linus
