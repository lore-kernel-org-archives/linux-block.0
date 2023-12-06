Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qPCQvmXw"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4FA1BD
	for <linux-block@vger.kernel.org>; Tue,  5 Dec 2023 21:26:19 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40bda47c489so46942675e9.3
        for <linux-block@vger.kernel.org>; Tue, 05 Dec 2023 21:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701840378; x=1702445178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ulu5nhyRlnyQ8MunkVHfj+UFUXCSjX9bMOiyU7LTFHM=;
        b=qPCQvmXwsAAXuxbK+AWbCefPnupo08xFaoemwv8esC2Bw7sqoG0nEwzSr6d/yLwvqo
         THLF2jl+qxlHQEj/LXLXPYsZ4gJ1+tm9C18Mmpc1/6tErC1SZfIWqRvsWWD9dAgK78Q3
         3OhkpmYUM4vTirJkwrcG4IZ/f9+gfO1JqzPAHX98hQtLc/5eVKEBSrKkhCY4e7whsvkv
         +BmLJluGZ56TeuWGbkOO+qPBFSwsEoeEVjl204/9dCaU2LwW4lrzzQygQLlDBXV0IMzI
         5aGebAHL82gPlLpBluHtTkoaOEzFp5bD9mU0utCP2m9Jz5EpoA2LdzenXPHOpR9V3uyX
         1aRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701840378; x=1702445178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ulu5nhyRlnyQ8MunkVHfj+UFUXCSjX9bMOiyU7LTFHM=;
        b=P3NLqUKvaDyqWwKeZtRRDK3bicRzvIZxge+KmtRkcwnBglIqPrkUt4YJnv+hwGp8Bw
         5xsBr3j2ak0B0vYc8BeDudjzayZDi/mGtjmTWt28PsnVYX5W4dm0CukI3/tpyHTcAqjy
         tbvXMVeP15vDIMtIrwFQ3sik4f9yOvm7QFHquYONPiHdUE9+9X8gatGNgARvgVqXwNND
         B0qrAWvWcwTa9kcc9JEWL0n9ZiWmOItZ8/ZQuEOMF+DRrc7RegXGYOfidqArc0POL3qP
         yHoniUNqz0EppqFIaCf3D/QtUc0a/UBbgawiUrcHL84fVHjUdizyBHftbmb8yifJtwLU
         sctg==
X-Gm-Message-State: AOJu0YxpzJ1jJSsxccB5kLCp9BtKx1qKFKZMt7GUJKSLt9R6D9FSN2jG
	GigqF6Z1UVf/psKCk2I0kKQ02V0jDrDVQP12h0U=
X-Google-Smtp-Source: AGHT+IFrA2e8aOe5kCqexFSWIg5gbf2W70xBWnSm4duIVP8QhQk/cLERvzAU0Yq0g/NUx22dL0blIQ==
X-Received: by 2002:a05:600c:22d1:b0:40c:2102:d6c6 with SMTP id 17-20020a05600c22d100b0040c2102d6c6mr50420wmg.138.1701840378312;
        Tue, 05 Dec 2023 21:26:18 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id fl8-20020a05600c0b8800b0040b37f1079dsm24783242wmb.29.2023.12.05.21.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 21:26:17 -0800 (PST)
Date: Wed, 6 Dec 2023 08:26:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org
Subject: Re: [bug report] block: bio-integrity: directly map user buffers
Message-ID: <e9292363-b784-43f5-bf04-4b8586239a2e@suswa.mountain>
References: <1177558a-9dcd-432f-89b1-4ac9cbd9cd25@moroto.mountain>
 <ZW9P8w_Gp9IS8022@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW9P8w_Gp9IS8022@kbusch-mbp>

On Tue, Dec 05, 2023 at 09:29:39AM -0700, Keith Busch wrote:
> On Tue, Dec 05, 2023 at 12:35:30PM +0300, Dan Carpenter wrote:
> > Hello Keith Busch,
> > 
> > The patch 492c5d455969: "block: bio-integrity: directly map user
> > buffers" from Nov 30, 2023 (linux-next), leads to the following
> > Smatch static checker warning:
> > 
> > 	block/bio-integrity.c:350 bio_integrity_map_user()
> > 	error: uninitialized symbol 'offset'.
> > 
> > block/bio-integrity.c
> >     340                 if (!bvec)
> >     341                         return -ENOMEM;
> >     342                 pages = NULL;
> >     343         }
> >     344 
> >     345         copy = !iov_iter_is_aligned(&iter, align, align);
> >     346         ret = iov_iter_extract_pages(&iter, &pages, bytes, nr_vecs, 0, &offset);
> > 
> > Smatch is concerned about the first "return 0;" if bytes or iter.count
> > is zero.  In that situation then offset is uninitialized.
> >
> >     347         if (unlikely(ret < 0))
> >     348                 goto free_bvec;
> >     349 
> > --> 350         nr_bvecs = bvec_from_pages(bvec, pages, nr_vecs, bytes, offset);
> >                                                                         ^^^^^^
> 
> Thanks for the report! I don't think there's any scenario where someone
> would purposefully request a 0 length metadata mapping, so I'll have it
> return EINVAL for that condition.
> 
> But ... bvec_from_pages() only reads 'offset' if nr_vecs > 0. nr_vecs
> would have to be 0 in this case, so it's not really accessing an
> uninitialized variable. Everything in fact appears to "work" if you do
> request 0 length, though again, I don't think there's a legit reason to
> ever do that.

When we pass an uninitialized variable to a function but it isn't used,
then we have to look at if the function is inlined or not.  If it's not
inlined then it's still a bug, but if it is inlined, then it's okay.

Passing an uninitialized variable is undefined behavior in C.  And if
someone is running KMemsan then it will trigger a runtime warning.

In this case, I think it's likely that the function will be inlined so
it's probably fine.

regards,
dan carpenter
