Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684AA1842
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710202920; cv=none; b=NAohW2mpPWypyEovzXotfkkNcFVa/zaWm45OvgRGkqweg3V846PLBqYPjnN1afi5XRTezywy1MsLLw/FPQhRpaGf7eUk7YICaLg8xQ0yMXpVotnP+fUJzoqaIPghYTw0JkxGi34F7nP9INDggo/pfzIWaqlnzPOu/np4WkHRoVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710202920; c=relaxed/simple;
	bh=sVhmgHy9PCcejmfVEERC9wwhGMYszouMPihIMKFqia0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YX5zEH9p43a1z+j2U7T9THb/grbqOD0LhucuLhCROY69bR5xImbPw6qGtWvyI4U8cyL8IFM/onhIQY30eQ9C/q31+HbsiZ/d6m+heKXe26GmhIuS5BNbOEZluJNSQzeQ7LES8D0j/VJz/frbjiAGMzaq9J/bw4y4MUahqBHQ6Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LmHxpo1y; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LmHxpo1y"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a446b5a08f0so891663466b.1
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 17:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710202916; x=1710807716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hRTxv+1S4/1SAdakO+Mwp2ofzsgQ9UxPy96ABnahNCc=;
        b=LmHxpo1yEo8QRm/XJQtD5LjO3G2JElIl5UkXrk44Cy8o8FLUeSdhgxGBpPgI0Pgf9t
         /Xq0WvaFIDBbmUERQMt1tZvmqVCC/InOQWgj+Q3DY1o9llXJ6kBJYZAk7nb0X438ckiN
         EnyffXaQuloqxr/1YuQpvRgdpHWCegDwf1lOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710202916; x=1710807716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRTxv+1S4/1SAdakO+Mwp2ofzsgQ9UxPy96ABnahNCc=;
        b=hzgMbxxmdXhpYp3bvg1UZkagpZkzs5HstdAC5J59/d3m80jhqXzL8Jgjdwlugk2p2r
         vkdoeZ8/L+r+I2SkMaqzsUSvVwMrcbzGyBHAVMTLQBxJZPc3NmzMe73YekY31HENOmnd
         O2mq2YdvzqATIcQofcNZ00xWYm9aienQ1ZpLmxpAoaUfHf+0AxwgrkbbeZKbX/nvPdBG
         9Lf9nJZRpB5d9d9eyfTLeNnH9K02TBXrpH7L5gNJP2WKGweOdoMMaKA8TeyWY3K9JvFP
         vSswHK2fCoj+ArPNO46EEhuZo7MkQlS5gYf33HguVrhF5jg+zopAyDYMAb1Q6nNMQO8T
         ebAg==
X-Forwarded-Encrypted: i=1; AJvYcCUOEFqM8W5CpdqCsDZaih/bMgE30Ssn+eqV2TnZyuUcqTfM0Zmtnb5EG/xJhYQaABXEYJhqvHF02iMGOG+LFxg8nZro5//ZPS674WA=
X-Gm-Message-State: AOJu0Yw8rmvXzFbdCzitWJpTx3vTsXjzzUVZE6Lp2GERcrvHPEPbJuNF
	6XlNND1vyBgzZiWNih0V2paKaAe+MAZqOTtobiG6ilh+vdNaUm2+1KsGocYxm/38+OOx8EdJmv2
	BrSgImg==
X-Google-Smtp-Source: AGHT+IFYrp8stqorgYYxM+SyDVIQOS+YT5EwvmkNm29AFCvkSqyaeE+HjQbDUIRHqGrL0GDk7gChHA==
X-Received: by 2002:a17:906:aad0:b0:a46:29d8:40c8 with SMTP id kt16-20020a170906aad000b00a4629d840c8mr3373968ejb.17.1710202916334;
        Mon, 11 Mar 2024 17:21:56 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id jw18-20020a170906e95200b00a462520d561sm1593777ejb.54.2024.03.11.17.21.55
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 17:21:55 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4627a7233aso263995366b.1
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 17:21:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVk9KsCyclyzYDl5X6wkMWsr/A4re9StV5qrpcNU8O4lQlpiCtlzUq6p2cXDpSU93nuy1+bfRPWF+HYJne5Sl5uyxZk4yO8g+PLxlE=
X-Received: by 2002:a17:906:35cf:b0:a46:4473:3ddc with SMTP id
 p15-20020a17090635cf00b00a4644733ddcmr148241ejb.4.1710202915401; Mon, 11 Mar
 2024 17:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
 <20240311235023.GA1205@cmpxchg.org> <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
 <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk>
In-Reply-To: <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Mar 2024 17:21:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>
Message-ID: <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Mike Snitzer <snitzer@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 17:02, Jens Axboe <axboe@kernel.dk> wrote:
>
> Just revert that commit it for now.

Done.

I have to say, this is *not* some odd config here. It's literally a
default Fedora setup with encrypted volumes.

So the fact that this got reported after I merged this shows a
complete lack of testing.

It also makes me suspect that you do all your performance-testing on
something that may show great performance, but isn't perhaps the best
thing to actually use.

May I suggest you start looking at encrypted volumes, and do your
performance work on those for a while?

Yes, it will suck to see the crypto overhead, but hey, it's also real
life for real loads, so...

             Linus
