Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA89413D2E3
	for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 23:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161346; cv=none; b=UVTFfoChHzbESXqnF4nBQBHlJuk/sEX6bb9Q4QMSeXGN2sPJsxlBAF1pZvZU09lMV2hh/UwUn2lnY0tkV8iF3EDDLO8mbK82ehSeE5ctjwJAGZHOFTVu2vfhUfgb/KKXCeWP/q2F614IYvUK4VMSas92aIV1kBaq997OjOEXrnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161346; c=relaxed/simple;
	bh=rFdeaF8OvHp8ycIMfjI32IqX3BMfkKmkCnOldjcHl/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DO8STOASaiEgMEcMpvCyyvnL5D7IVGUL34sugrz6RJn72NBxzVx9B8ue1RzqvkwveZeIk81ydjp5US2mSQtX5t0Htfj/z4bZU4l/na0eXGk5jGyjESTVAqFoAUcNIs6sjFEt6gC6L2qFtApJLgfuH3NpwNEhCCyKpiGu4KXfm7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Pnq2tk02; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pnq2tk02"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so449141a12.0
        for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 15:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709161343; x=1709766143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XmDUVGJ7uYNuJQyRX/NAFGYz0phL9n1ekfsCjXQN9T0=;
        b=Pnq2tk029hp2DbW9wkG6Ttyi0a4B7u0XS89VdZHBYs7YNjJFmMuUm8JnIMRX+y/z6H
         j0kZL8TCzfachEc0eI36IGzZRWuDMpoCNfEvJy3xRlEJVr0pqEf7noUIRUujyaRNVOVR
         YIF3UKbPKXsJ47h/5zLOBDTaR/W+FrqYzqnmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161343; x=1709766143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmDUVGJ7uYNuJQyRX/NAFGYz0phL9n1ekfsCjXQN9T0=;
        b=qRbUSVy38Dv51V92ulUMOXAvqr5M7K/NVmz4tbfA8xpAcHcl9IFj1vL1++hRVA81/y
         9amrGo/NBoW2EgH7iimygE2isJG8QusS0psIZoo5+svxc2c5c/5dMbanhSKUz9f9OO8s
         dndnx3l5pwWF2CGbOx+E0d+vyb1ueD4vgD4ZxZ7P3KLzR9HvH79AsetFHPH+bNHBUTxb
         eJBhkX8FsOqAfwDtdu5w4SHP7d68RSaH5LatMoxR8QFS3RaMaZ10WavZoIczfomL+Q8Y
         rPWJuWVqfqIq1fG0bSw6qO4IRwDepmSKIqzBwkcdd1a1BKwzptZ1pYS+17lV2BZ3EGfm
         Hu7w==
X-Forwarded-Encrypted: i=1; AJvYcCVyjFT6X3E9K1WNJj9gkjtBED5560ygHZQIrESy7JRtuqhXjKc+eGVddhxlmYdwvWwMdGon+GSxWjU7Xkshoi+s5SLTBO4C7f/lRJ4=
X-Gm-Message-State: AOJu0Yx1b/+7g25KtI+Tkn5nHw3DUQSNclIP47esXRdpPR6Hang2mMxS
	AZzTYSlbByO3nwgc/rf5xAiPJOhKNdKDAIu4J0+6e0VmZkhIWDfTE1DSNSZb4fKxOm3QFOUjhb7
	ARoZe+g==
X-Google-Smtp-Source: AGHT+IGKZTRd9qanFauWGlS6Uhq91ejSfg08JELqw+dFT3g9OTWLiGOzS/FnK/j7g1rLJgQ43NIZYA==
X-Received: by 2002:a05:6402:1e87:b0:565:9fff:6046 with SMTP id f7-20020a0564021e8700b005659fff6046mr212728edf.3.1709161342762;
        Wed, 28 Feb 2024 15:02:22 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id fd14-20020a056402388e00b005663bf7e207sm6959edb.1.2024.02.28.15.02.22
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 15:02:22 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412b246b386so2126775e9.3
        for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 15:02:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkwvvqnSdHQ97KE55af7RRpE1DSpqegrEgT0CxlwkiUU4fnn3UbHInGObdHR6hO/9IL9OF9ELi/5UYF0X5OAzCJeoLR6OpM/d/2Y0=
X-Received: by 2002:a17:906:b7d4:b0:a44:f89:8104 with SMTP id
 fy20-20020a170906b7d400b00a440f898104mr218606ejb.42.1709161037880; Wed, 28
 Feb 2024 14:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
In-Reply-To: <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Feb 2024 14:57:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
Message-ID: <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <christian@brauner.io>, David Laight <David.Laight@aculab.com>, 
	Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 13:21, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. If the copy doesn't succeed and make any progress at all, then
> the code in generic_perform_write() after the "goto again"
>
>                 //[4]
>                 if (unlikely(fault_in_iov_iter_readable(i, bytes) ==
>                               bytes)) {
>
> should break out of the loop.

Ahh. I see the problem. Or at least part of it.

The iter is an ITER_BVEC.

And fault_in_iov_iter_readable() "knows" that an ITER_BVEC cannot
fail. Because obviously it's a kernel address, so no user page fault.

But for the machine check case, ITER_BVEC very much can fail.

This should never have worked in the first place.

What a crock.

Do we need to make iterate_bvec() always succeed fully, and make
copy_mc_to_kernel() zero out the end?

                   Linus
