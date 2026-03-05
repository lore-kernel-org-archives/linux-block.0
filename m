Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A8225775
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716747; cv=pass; b=MeeXkvwKtYRmRrzHgQsfuv8kuVmt5KimG6FQ6NUUcFj4YiYHeO5zq81SUb/I4EeXzBlxfuRS1wpCesEMZbBnrE5n8s6dik/AUDmgpYVALSUV7VyPf8EqrJRYX613AnLc17/M7mNoAkK6cji8VpTks3U4+uqLRkQ+6bQursv8o8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716747; c=relaxed/simple;
	bh=0rXBmacZjaONc95kJThVMfZ/fSAqBYpdNS9JoAuszuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4Y3PEFTfQzojbxziFtVqqFLK3QXxZj036O4OeSkBnchch9B4T5bhcqNxUuhwddEoZsaT6w/WXRa7WA9UTHQP8+8i9rnEy2ezKwqNX5loPOM9ctdwEkHG7VAPdmAVf9JgXf1Q8+3QnrSnHhnZipEY7x3pUnT1+8XDRg+kLRw4N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k6dJO1To; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6dJO1To"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2be1b5fe11cso4195977eec.0
        for <linux-block@vger.kernel.org>; Thu, 05 Mar 2026 05:19:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772716745; cv=none;
        d=google.com; s=arc-20240605;
        b=W0h3DIxfVhhx1qV12Ao/eSl7s2pTCLo2ALKKrdj5TxMVThmSEyLkBWGIge5dhEBhU5
         FgEO279TkaBI/gNOm4n950GIWXao1gp6ITCnvPeNc8eUbQrWpmsJM0PFN6MtG2HsNcuj
         AwdNZ2QJUbM6oUSTTacvvUVKk7u+abFHaCpy5qiI3IzuhLa98VYelGub6roa+tAiA5Cd
         xRde14SyrdrlhsiWLUTP+N4x8wRfulSnhRe7+pRGABbm2kGe/LBj8pxKxJXImBfNMMF6
         kGVsDmkSn+CeE97Fe+eQXf0dDBJeS+/L7CQzCeSgpYoVOkulkq2zYwCVTHZxghlS66H5
         C2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0rXBmacZjaONc95kJThVMfZ/fSAqBYpdNS9JoAuszuY=;
        fh=sl09Ex8dav1u3veiI06BI/vbImSphaZjMZkGyS5GFIo=;
        b=Q2bVUd2pnpdKju0KdSZ6hADTKpNM5XngTUzQcWpV/1FVtzOhny7xQYLnUC5+a8EDDX
         7VaQgW4aBgjYWgr+bwlT0pMXaLnBoz50DLjLVTS2s7ZvpwbScRykk8ry7/GtX6LGUADy
         dYxWaUEjFSKVn0fAZa25N2f0RSgkqvK4UZI9a6lVtuoZ5W/lir/tyuy6mJL6mJuP9eN0
         wjQH7sFdmLiDV9MnxhCTeOEG84pFVaykAY3HNueUpRNXy8XxB2tqpxokYjiPHj7ueZCR
         GpLucirYi+kTk1hNYPxmLkm3nzXW/hD/DlZ0Ec0XlKvZ/WmlzXcTj2PEd5TYkzI2AB/7
         UYCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772716745; x=1773321545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0rXBmacZjaONc95kJThVMfZ/fSAqBYpdNS9JoAuszuY=;
        b=k6dJO1ToRrIEb3lVLux42V5niRT7RtnqXPANmudJtipqjVvzPhdUdP019efmLZ8Yf/
         FLgnOb4XYb52TrxK2qVC3Ni/xLm0MoVbx+cdWt+s2Jr9kxY83wSlsc5wLoDTIs5hw7zz
         5tGIpinYGqIkqqeAnJ6wMmKqNL7pppclHONz9tVbo6MubRfxmwpdts+vQnxqaPBmdhwX
         EN+d28EYTkgmI68EfSabkGMtqa26ZN872sCPELfVIEhJa7D6pMjNqL2GVEDg6ri4G9DH
         o4E8kuLzEpO/RXmZjQ8GUXJY4KgiIyAKykp2y5OkrlLm9zqYTbIYLRrZR49RKyRWQ2HN
         oggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772716745; x=1773321545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rXBmacZjaONc95kJThVMfZ/fSAqBYpdNS9JoAuszuY=;
        b=rcbQWOqJyOjskU2kmMIF+SegKlLrDmva1VGCRSH7ce/0Fxqn3j/kiGGIuRCcmmJPVW
         1zvKhJtUKkUP7q+dbQXZtMsW0/xeoMWTHrcC/h6dLdf5P/EtlPNXcN2bBvza3sDIOjri
         qwiWKFDaYQrX2RQlGDl71LlVZlQ6wP7y6WpbBoEwSmvngN+rTgatqwDpS+p4oVAwfQv3
         B9WSrsNTt7BQeY/JisECvY4l4SPF+5+VnTpcxhDsI/t/negCDMLyKCjj0sbzn0jNY+JU
         Spkaqa4x1w0DNOrIy7QmhEmJqvZuRUTgnwuw/kexI+4z4f1E3XKQegVeDba9UXsilQNp
         Zs2w==
X-Forwarded-Encrypted: i=1; AJvYcCXQTTqUK49yPzq6lwjOqBa8inNrO7LQqEtNCffa+RsyaKL8xJNI1KN+VrOvY8+S1WalCDO05kFvPS/8Rw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1J9RzaduHQ7Ajd9yIrZZOynYnw58J+pwluby5rBaNEW5gDHWu
	8p1ZNyr+0dntOYz9XDXrtPA35x2zeonT3wKavOzQnx3j3sm+Jd46aVcBOdHqFVCKJEU5yjLcNQ/
	CGQiQS/6zs6QeKKHvEldqEJDtIgIyNp9b/fEPWLqe
X-Gm-Gg: ATEYQzxAfKjA4+y9wP1S6zxkENoGjwXFEXw0Ijv9NfMw7/dhVJkLTA/2hZt6FCJuwba
	XPKix1gWV8KsoPw1dKBsPhBcXgk2/cqjGVFArnwJvIoBCXGRKO25CfZcsY0PNd3jq5Rt4Uc0GHY
	X2l/LpEcpG29c3NKsHavJHpSQAo0Eo84P+uRecR9GiGgOvfMcrUG2bkl0OJsXdLMdsvd2AReVgp
	l4fKvL5ppq+C4FqEaWCVQGjs2JjKKOCozCP5dL/zRSb9saQSMBF0Zfp2zyN+f7/E138gS23XYKI
	+3XZnNRN6JqOSYLv/AqLC6a1CZ9sWA69J2d0jr6ap2nYKkBb
X-Received: by 2002:a05:7301:128a:b0:2be:8da:3207 with SMTP id
 5a478bee46e88-2be30fd3614mr2288679eec.6.1772716744690; Thu, 05 Mar 2026
 05:19:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304194843.760669-1-bvanassche@acm.org> <20260304194843.760669-3-bvanassche@acm.org>
 <an6x6or3aceomqwhy4rc4zz5a4kyrnbitoz3v2m2ekkfaaslnu@uuwya3gdk3qp> <a7834c93-1eaf-4230-9add-d1c4b77549c8@acm.org>
In-Reply-To: <a7834c93-1eaf-4230-9add-d1c4b77549c8@acm.org>
From: Marco Elver <elver@google.com>
Date: Thu, 5 Mar 2026 14:18:27 +0100
X-Gm-Features: AaiRm520Kx783LqSWL3htEOfXsnZU5XjdBxARnI4LQ1jmC6VG2WVRuZhBl1_vas
Message-ID: <CANpmjNP0gqV7A34Gsyu2AjE4Cfg=k2FX3NyLd3XhD_gTJ=jyuw@mail.gmail.com>
Subject: Re: [PATCH 02/14] blk-ioc: Prepare for enabling thread-safety analysis
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org, 
	Yu Kuai <yukuai3@huawei.com>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Mar 2026 at 13:46, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 3/5/26 4:10 AM, Jan Kara wrote:
> > On Wed 04-03-26 11:48:21, Bart Van Assche wrote:
> >> The Clang thread-safety analyzer does not support testing return values
> >> with "< 0". Hence change the "< 0" test into "!= 0". This is fine since
> >> the radix_tree_maybe_preload() return value is <= 0.
> >>
> >> Cc: Yu Kuai <yukuai3@huawei.com>
> >> Cc: Jan Kara <jack@suse.cz>
> >> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> >
> > Frankly, I dislike changing the idiomatic ways we use in the kernel for
> > checking for error returns just because some static checker tool is too
> > dumb... It may make life easier for the tool but it makes it harder for
> > humans which I don't think is a good tradeoff.
>
> Marco, do you agree it would help to add a variant of
> try_acquire_capability in Clang that accepts a range of successful
> return values instead of a single boolean? That would not only address
> Jan Kara's concern but would also make it possible to annotate the
> many functions that return an ERR_PTR() value. With the current
> thread-safety support in Clang the only option is to annotate these
> functions with __no_context_analysis.

Yes some better support is needed. But this might also be wishful
thinking only - we can dream. :-)

This was discussed here:
https://lore.kernel.org/all/CANpmjNPquO=W1JAh1FNQb8pMQjgeZAKCPQUAd7qUg=5pjJ6x=Q@mail.gmail.com/
under point 4.

It's a tough one, and no clear solution exists yet. Exploring the
design space here is the first step - I don't think "accepts a range
of successful return values" is trivial, because we have to either
list those values, or encode the possible ranges as an expression
which we can then match against. Only the latter is usable IMHO, but
implementing that in the compiler is a big deal - we need some kind of
solver to match expressions - or severely limiting allowed
expressions.

Either way, getting that implemented and upstreamed is a ~2-3 months
effort. Which is why I have ignored this for now given the poor ROI -
the current infrastructure is opt-in, and my thoughts were to enable
in as many places as possible where we don't run into this issue. We'd
need an estimate %% what coverage we're missing and if it's worth it.
I understand you're working on global enablement, but this particular
problem needs careful design analysis before committing to anything.
