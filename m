Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AB51C9DE0;
	Tue,  3 Sep 2024 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390013; cv=none; b=i7+pvLcOYxvtrwZs2acQq3+8Z1APQaE3YPEUnRpvTsKCxStw+r8XtPdW9Gmesry2WoDyBZ3SOEhC3WOkIqEV3psuUi3COsAtuPdtaU924QIdyeISIJk7tdgW2V8i7q58JHdvZaLOaPhlLEUVUl/kcAJaPc61T9GFLmXO+qEGQFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390013; c=relaxed/simple;
	bh=h06+Aki7jynEFM+YpTxeHZk0spThSMwAZx0y6ZikQuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkvJ6I32ivBnH6eogItmMMZl1ZBtpDrF1B67vZp/Lkw7e29K6YiKiSdf3Q8lhNSGvzGpETxD01FDZ52vROxSpk4mh7vtTWyrlz+uw+8LeRfRRpGD6PzDj38Uac38rFAJ0w+Np/ZLIhyv7jbXxenJWAvdCmliR7WTWgn3nV1GNDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlwXKW41; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlwXKW41"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2068acc8b98so14546905ad.3;
        Tue, 03 Sep 2024 12:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725390009; x=1725994809; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dTpB75Wc9hEyB5MLT0HI0j99cXUN6Zm5IWFHhwN0xzI=;
        b=UlwXKW41tU+U6g+QxPJ8UqLRLD47BVDl5kJLhEDMetSfcYql3afDH8SE58ZY3dyyG+
         Q+tK8c4a9/mGvar2TMkTLyK0nMmPBTTKXHp5BdVFntRe66T4Jto7Gx/9fR3JGqLwOcNA
         qB8Nq7MNwXQK82hbkgRcAKzHm21xVtqcNhZ8DURAgv8y1+WCbx/FSAHbCIe6GWnJ64tw
         tteSyES73SP/g/+PD/b9KqE6i49gegDPfnmM/ceSvpxwPF+KPbXwj+/S6py+ACJmlUZx
         K0Qwdcq6q6w0ZrMfXHy3DBJW1rwp0vgrECU77j7NxxPV7ptkC8Js2rXseDwkIqCY0fKi
         rwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725390009; x=1725994809;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTpB75Wc9hEyB5MLT0HI0j99cXUN6Zm5IWFHhwN0xzI=;
        b=JG8N9nx2wPRK0li3mcepyVTVM2xbGLRc9BdpZvJ8GK2PHWwon/lNDh0EAJnEelMz6x
         jMTdB3T1uIoM15XEf243uax26MqObgfR2TxLNwGKY6ppK1ZT1BEc/DDwPGS9FRJK/GAr
         TUQaqnyGEkIPZ9Kbc1wrWtKPOXOOIBqHYMXLCftvmY/1xGLRrXYfVrYuzM2zVEOgYV+z
         9g+fTAkfV+gZncthKhOuyhQPuhOtYZTRiDObC8HYiERrRrpQ2nFa7PGCvK18nkMWWQbO
         rCXEm8sjRdgcdhXeA6eoCWQr6mfCAh3eJboG64Qw2bxcNR+5uXs6rsw1b8cxo4bt4HXQ
         h/ow==
X-Forwarded-Encrypted: i=1; AJvYcCU/7tI7oGwF/LiiWEo0P9jU5PsrhQ4KhDvdCSEQtbHNC4+Sa4WN+4UVDHWS6IonnJxBwI6GvDQ069Z2w35fcVw=@vger.kernel.org, AJvYcCUlUYWzfWrqpotB7vWXZqxBJ69bsUrW90/I6lCbYD9hR8mhmzM8q3aTs6bba887+8MvV26fP7YWwxCteg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyHcXaGkaNu3ECv2q0fWeYbXRmiEQMUESasVMcyuDCKgCrK0Q
	OlO3+hbt8KlGJUu6mB4aQjkY8xonL7r4HfrplD4f6cPfJwQWwz4h
X-Google-Smtp-Source: AGHT+IE/I7vmp5yOXDoEoEWdWZ/Ny0AtKMx4R1QXUZOW18ihcaO1jfVsLc+I4gjdKtpJMRN77v8WZQ==
X-Received: by 2002:a17:902:fc87:b0:205:48c0:de8f with SMTP id d9443c01a7336-20548c0e383mr140770925ad.60.1725390008994;
        Tue, 03 Sep 2024 12:00:08 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:e682:e3dc:908:eef0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea67bc6sm1658225ad.258.2024.09.03.12.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:00:08 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:00:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Benno Lossin <benno.lossin@proton.me>, Jens Axboe <axboe@kernel.dk>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Boqun Feng <boqun.feng@gmail.com>, linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH RESEND] block, rust: simplify validate_block_size()
 function
Message-ID: <Ztdctd0mbsJOBtJV@google.com>
References: <878qwaxtsd.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qwaxtsd.fsf@metaspace.dk>

Hi Andreas,

On Mon, Sep 02, 2024 at 09:57:17AM +0000, Andreas Hindborg wrote:
> 
> Hi Alexy,
> 
> Thanks for your patch. I think I understand why you would suggest the
> change, with you strong C background. I would prefer that we do not
> apply this change, see below.
> 
> Alexey Dobriyan <adobriyan@gmail.com> writes:
> 
> > On Sat, Aug 31, 2024 at 08:39:45PM +0000, Benno Lossin wrote:
> >> On 31.08.24 22:15, Alexey Dobriyan wrote:
> >> > Using range and contains() method is just fancy shmancy way of writing
> >> 
> >> This language doesn't fit into a commit message. Please give a technical
> >> reason to change this.
> >
> > Oh come on!
> 
> Could you elaborate?
> 
> >
> >> > two comparisons. Using range doesn't prevent any bugs here because
> >> > typing "=" in range can be forgotten just as easily as in "<=" operator.
> >> 
> >> I don't think that using traditional comparisons is an improvement.
> >
> > They are an improvement, or rather contains() on integers is of dubious
> > value.
> 
> I would disagree. To me, and probably to many people who are experienced
> in Rust code, the range.contains() formulation is much more clear.

If you want to keep dividing into Rust-land and C-land I'm afraid you
will have 2 islands that do not talk to each other. I really want to be
able to parse the things quickly and not constantly think if my Rust is
idiomatic enough or I could write the code in a more idiomatic way with
something brand new that just got off the nightly list and moved into
stable.

> 
> > First, coding style mandates that there are no whitespace on both sides
> > of "..". This merges all characters into one Perl-like line noise.
> 
> I don't think it looks like noise or Perl. But I am not that experienced
> in Perl 🤷
> 
> What code style are you referring to? We use `rustfmt` default settings
> as code style, although I am not sure if that is written down anywhere.
> 
> > Second, when writing C I've a habit of writing comparisons like numeric
> > line in school which goes from left to right:
> 
> But this is not C. In Rust we have other options.
> 
> >
> > 	512 ... size .. PAGE_SIZE   ------> infinity
> >
> > See?
> > Now it is easy to insert comparisons:
> >
> > 	512 <= size <= PAGE_SIZE
> >
> > Of course in C the middle variable must be duplicated but so what?
> >
> > How hard is to parse this?
> >
> > 	512 <= size && size <= PAGE_SIZE
> >
> >
> > And thirdly, to a C/C++ dev, passing u32 by reference instead of by
> > value to a function which obviously doesn't mutate it screams WHAT???
> 
> It might look a little funny, but in general lookups take references to
> the key you are searching for. It makes sense for a larger set of types.
> In this particular case, I don't think codegen is any different due to
> the reference.
> 
> >
> >> When
> >> using `contains`, both of the bounds are visible with one look.
> >
> > Yes, they are within 4 characters of each other 2 of which are
> > whitespace.
> 
> I like whitespace. I think it helps make the code more readable.
> 
> 
> > This is what this patch is all about: contains() for integers?
> > I can understand contains() instead of strstr() but for integers?
> 
> To me it makes sense to check if a number is in a range with `contains`.
> I appreciate that it might not make sense to you, since it is not an
> option in C.

I am sure we could come up with something like:

	if (!contains(MAKE_RANGE_INCL(512, 4096), size))
		...

but even if something possible it does not mean it needs to be done.

> 
> >
> >> When
> >> using two comparisons, you have to first parse that they compare the
> >> same variable and then look at the bounds.
> >
> > Yes but now you have to parse () and .. and &.
> 
> Reading Rust takes a bit of practice. Just like reading C takes some
> practice to people who have not done it before.
> 
> >
> >> > Also delete few comments of "increment i by 1" variety.
> >> 
> >> As Miguel already said, these are part of the documentation. Do not
> >> remove them.
> >
> > Kernel has its fair share of 1:1 kernel-doc comments which contain
> > exactly zero useful information because everything is in function
> > signature already.
> 
> The comment is useful to a person browsing the documentation in the HTML
> format. It is available here [1] if you want to have a look.

This is a private function and an implementation detail. Why does it
need to be exposed in documentation at all?

Thanks.

-- 
Dmitry
