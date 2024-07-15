Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED1D4C7C
	for <linux-block@vger.kernel.org>; Mon, 15 Jul 2024 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721079149; cv=none; b=jxtqpr3eaj1kurd1KD+qq9/RIUwr73dzvnsRbWTrGBX8SFRak6rugdn6Ui+UN2sJWB6fSS1RRHWt1fXlFlk0wTOlr9t5CroUPVQpZghPp2zKFGUftezWDwUjSy3Q7XbK6PtcaHuCeQOw6M6VMabESNr0E5cmKsWc0sb2GprQT+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721079149; c=relaxed/simple;
	bh=qCin3X84XHr8UcjkMUiI+gRDNOBi1y1CzzQzr6M9j1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+oE/neDTJNDligdtdMJ5eOskXTnrp5UruPDaE/iYwJur0giDV5W8aMiwu0/xxoH787lpjxpyXwzlANcmFbJG+VpZBkbhgcik9QH1xdPv7S1O+llYH/WlOC6Lxx0XwGEX1M0mtgSEn91Q5jYhNdSmfZCguZz0AuIc7eNmUbUuGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TPxRV/W+; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TPxRV/W+"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso603448866b.0
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2024 14:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721079145; x=1721683945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+uP3ZlEf6kGzmHG6f8+vwhVWqv6B8pCWINYY2uLN6vw=;
        b=TPxRV/W+VS692KT7iWsX921AsiZY0pq5RIJfZu6dUrT/J+kjXSDexOtZgyBorsJ2IW
         5kXhG7AlnskoyVIs88GIoCIBLyzkbWTqnd49KwKnBymO7unXFXON88hTaWk36q9A+rUn
         +E1s4+sUKx51+98iMGIHN1BVJTwxNfI/8hpsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721079145; x=1721683945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+uP3ZlEf6kGzmHG6f8+vwhVWqv6B8pCWINYY2uLN6vw=;
        b=ZZKVHeihcqiqWXxtST/hkLZJ1jJrGsEg3B1Zc7VMbpYVcNa6SOW4RGkLDqdXf4o1IL
         Ji1ak8VAwo9BjoFzh/xY0kBBUVhitrcPNIl9Axb2Pyj3llzNSz3atQDLP4PglFybBFMT
         grnMWRqaYoL2m5BLplcj7XGJNejZ0xF/jaHCtfXitKcKw/Cj+220I+T2KlAxJeqd7yn3
         qNPw9RXaE82WiE55qWDERuFcQHWVRy0RVI0OpsJNUHndeQ00yeFEqlzVHOmbCo1Q2PLw
         OzaK1kn2nNiMj/4B4UF8pgCBD0HnMX/mvlhr1Ro3W1Yq7eSm72saq0YpGeUktjHZ3kEU
         6kZg==
X-Gm-Message-State: AOJu0YwPrBpd9CG3AkTLJxiFIP229gCI2oxwnp5CRRwQLVpipmuNYzC6
	RqrpP1G8qYTDjQFNlR73QNPqMx9O3fjINc2lE4z0MKcgqwFcp9Sz0xrjnHtCML55hQ4A9gK1gF4
	/qS8LCg==
X-Google-Smtp-Source: AGHT+IF7aJf0GSw37bswATbnj4pC8vC/LBhT3YQJwiklfv4Cnt2oFOFK8ugr6JSKsOGorBWaDSb9TQ==
X-Received: by 2002:a17:906:2ccf:b0:a77:c827:2cb2 with SMTP id a640c23a62f3a-a79eaa3f42cmr11808866b.44.1721079145130;
        Mon, 15 Jul 2024 14:32:25 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f21afsm239395566b.119.2024.07.15.14.32.24
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 14:32:24 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-595850e7e11so5992614a12.1
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2024 14:32:24 -0700 (PDT)
X-Received: by 2002:a05:6402:27d1:b0:58d:836e:5d83 with SMTP id
 4fb4d7f45d1cf-59eeed298e0mr74770a12.22.1721079143720; Mon, 15 Jul 2024
 14:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e988d4c4-f8b2-4cdb-9915-790abf69bfed@kernel.dk>
In-Reply-To: <e988d4c4-f8b2-4cdb-9915-790abf69bfed@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Jul 2024 14:32:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZzZJCzRd1Cx7e7XbXCL-dRJTLZUoVu3ki=GvTuA2gxA@mail.gmail.com>
Message-ID: <CAHk-=wjZzZJCzRd1Cx7e7XbXCL-dRJTLZUoVu3ki=GvTuA2gxA@mail.gmail.com>
Subject: Re: [GIT PULL] Block updates for 6.11-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 22:44, Jens Axboe <axboe@kernel.dk> wrote:
>
> Note the statx change for atomic writes will cause a trivial conflict
> with a patch that went into the 6.9 kernel via the vfs tree later than
> what the 6.11 block tree was based on. Easy to resolve, only mentioning
> it for completeness sake.

It may be easy to resolve, but as I was resolving it I threw up in my
mouth a little.

That whole

        struct inode *backing_inode;
        ...
        backing_inode = d_backing_inode(path.dentry);
        if (S_ISBLK(backing_inode->i_mode))
                bdev_statx(backing_inode, stat, request_mask);

does not belong in the generic stat helper. The whole *point* of
bdev_statx() is to not need that kind of bdev-specific knowledge.

So I rewrote it to be

        if (S_ISBLK(stat->mode))
                bdev_statx(path, stat, request_mask);

instead, and that whole "backing_inode" stuff is now inside bdev_statx().

Because wasn't that the whole point of abstracting this out, so that
block devices could do their own thing?

And if the backing inode is a special block device, but the "front"
inode doesn't say S_IFBLK, something is very screwed up.

But hey, maybe I screwed something up. But randomly having that whole
"d_backing_inode()" logic in there seemed entirely against the
abstraction layering.

            Linus
