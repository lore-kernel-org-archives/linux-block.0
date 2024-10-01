Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B71C3F01
	for <linux-block@vger.kernel.org>; Tue,  1 Oct 2024 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797882; cv=none; b=SuRYnthH2vzigq2RZSWGqrJKPg6NI/IYYMctNZJqWBtvyoIgFX0SQyCXn3PbepJNaVKBMO/p5nJ5Jv2S3KDLqOuODsO5oXaHVAgE+J5dsLCUYAFxq8Uf42d5N6LtGXdFz3Ew1dqClHovCXEDim5uYBFNyOAFdPKNlmRnVgJY7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797882; c=relaxed/simple;
	bh=AkQqJ71eit+tBDIxL/hvxSHTu8TiJ7RqjL/KrBTpfQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ix4ILx9C0AbgkIWIJPf3w3H/N+5fHhlwEV7AJyT9o1o/FOkznJskQSOv2F4R6rtppkGmfJsca7c3ScmZUiJLUCv356Agxq5LVsK9rEo/BUuKL1y3UiKzD++TUbxDk6AG34UvTETRN5JWjYpnVzLBLU+eUPhNjr/6BV4i03ecUOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqcUjDxx; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqcUjDxx"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53992157528so2961743e87.2
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2024 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727797879; x=1728402679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LcFytHts4BnD6TJGHZBuIYtm74DnB7NL+eN3GOhUgo=;
        b=AqcUjDxxVaex9NfCakTSOSOreu12uWQuFxJDzSMlAyhVfUJAQyrWEQA+Zjddo4THZa
         s6Lci0ZP57628SMvgMWFtKv6lSvJks3jnzRFttd/LEcmB8hi6Qv53pD8AfsZz98swXU/
         DIn8qEdEEDrvOtgQW+MTCgz7+1HbpuDOIKlhkW6SlWGbVpSukwivbYMQd064dI9Thrfw
         UttOmLHuDiEh+V3Lq8aHS2wnyCLrE1jrm44pvEU7NfX3kO62+n/c6eQu0JdDzwAyQXQG
         BRwel5qeS8OFVuvX+Nf0k7svnBKltwTtydrhrhm62y8ON6IVGXQBcm+hzTGENzwdJ1gZ
         /ZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727797879; x=1728402679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LcFytHts4BnD6TJGHZBuIYtm74DnB7NL+eN3GOhUgo=;
        b=hAe6oFtEHndBW0KCma2izOSQXjr4ohd3EEVxe6hy8QV518EnsXRmvZI90CAYTtw2aN
         Yz4juGBLkO7us64bqrrLcDS14oXiJrQ8Tx9uAIPl1QiJm+pDX3JjGA0Uwsx/XZ31xlGw
         WUaBDh+jYmzC8RdxJNJWqag/Z/4827r8r+nLp+dmTpLGR82g8QLVc2cO5Z+VSIVFHBko
         KWqjSljvYBAfd29uPtqzX1JBR8hmjtgYbs/JaG066S5Ii45ju5HRBm5Gnpz4EX/i9nqV
         qojJWfkxy35OgJ5Ds+lZL9HZXiTgdWSMKDaHkYjgR8jgtbjWLld5XUkPc4LtW34b/DSF
         Wy+g==
X-Forwarded-Encrypted: i=1; AJvYcCW1UZ6UY50/jrVvf/XCZ/8bRAvY/uqxVHlr8IX7aCWwpnw6N+Ap3jDgbnYcDkMxPiJpGWuImW1uB2k8Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfFAN5dfKogqorcNdjcZMeVf8okbu8MPkbH1NJu6xqqSX+LLwA
	+LxAPGLegg8VgLzK/xSIEu6kXiEGaammjf/BpuuiK+r/TI2yA5dHnonL+8U2AGvvOYeKCEZSzub
	dlYqIRXenIjTetK6eF/9Nqnk21Cg=
X-Google-Smtp-Source: AGHT+IGYUosvjqy+TahmXf0yE0JcV9EQPkhMBKu30bZKmaEaFqD/fVW10d/wn3WrEueJEc2en4G+5aHhPXb+QzTZnxo=
X-Received: by 2002:a05:6512:3c8f:b0:536:53b2:1d0d with SMTP id
 2adb3069b0e04-5389fc30f11mr7941711e87.9.1727797878683; Tue, 01 Oct 2024
 08:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001140245.306087-1-nilay@linux.ibm.com> <CAB=+i9QEQJ-LVZsDSLG8xf2g5eLP0vi0HUNnCwLqWSpx0St2bw@mail.gmail.com>
 <73e499a7-6237-4f67-84c1-d6434b89df26@suse.cz>
In-Reply-To: <73e499a7-6237-4f67-84c1-d6434b89df26@suse.cz>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Wed, 2 Oct 2024 00:51:05 +0900
Message-ID: <CAB=+i9RJP-4nZbTEBwerCcNxELW6iZMQd+NBO2owX9HK1xOgpg@mail.gmail.com>
Subject: Re: [PATCH] mm, slab: fix use of SLAB_SUPPORTS_SYSFS in kmem_cache_release()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-mm@kvack.org, linux-block@vger.kernel.org, 
	akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org, 
	rientjes@google.com, iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev, 
	yi.zhang@redhat.com, shinichiro.kawasaki@wdc.com, axboe@kernel.dk, 
	gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:39=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/1/24 16:50, Hyeonggon Yoo wrote:
> > On Tue, Oct 1, 2024 at 11:02=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.c=
om> wrote:
> >>
> >> The fix implemented in commit 4ec10268ed98 ("mm, slab: unlink slabinfo=
,
> >> sysfs and debugfs immediately") caused a subtle side effect due to whi=
ch
> >> while destroying the kmem cache, the code path would never get into
> >> sysfs_slab_release() function even though SLAB_SUPPORTS_SYSFS is defin=
ed
> >> and slab state is FULL. Due to this side effect, we would never releas=
e
> >> kobject defined for kmem cache and leak the associated memory.
> >>
> >> The issue here's with the use of __is_defined() macro in kmem_cache_
> >> release(). The __is_defined() macro expands to __take_second_arg(
> >> arg1_or_junk 1, 0). If "arg1_or_junk" is defined to 1 then it expands =
to
> >> __take_second_arg(0, 1, 0) and returns 1. If "arg1_or_junk" is NOT def=
ined
> >> to any value then it expands to __take_second_arg(... 1, 0) and return=
s 0.
> >>
> >> In this particular issue, SLAB_SUPPORTS_SYSFS is defined without any
> >> associated value and that causes __is_defined(SLAB_SUPPORTS_SYSFS) to
> >> always evaluate to 0 and hence it would never invoke sysfs_slab_releas=
e().
> >>
> >> This patch helps fix this issue by defining SLAB_SUPPORTS_SYSFS to 1.
>
> Oops, thanks a lot for debugging and fixing this!
>
> >
> > Hi Nilay,
> >
> > Thanks for your effort in investigating the issue and fixing it!
> > This makes sense to me, but is there any reason the code avoids using
> > IS_ENABLED()?
> >
> > I think technically either IS_ENABLED() or __is_defined() (with your
> > fix) would work
> > in this case, but it made me think "What is the difference between
> > IS_ENABLED() and __is_defined()?"
> >
> > IS_ENABLED() is already frequently used in mm and only few code snippet=
s use
> > __is_defined() directly.
>
> I was wary of using IS_ENABLED() because that's intended for CONFIG_ macr=
os
> and SLAB_SUPPORTS_SYSFS isn't one, so even if it worked now, it wouldn't =
be
> guaranteed to stay working.

Oh, you are right. After looking into the history, __is_defined() is
actually intended for
non-config macros.

With that in mind, the fix looks good to me.
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> > Best,
> > Hyeonggon
> >
> >> Fixes: 4ec10268ed98 ("mm, slab: unlink slabinfo, sysfs and debugfs imm=
ediately")
> >> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> >> Closes: https://lore.kernel.org/all/CAHj4cs9YCCcfmdxN43-9H3HnTYQsRtTYw=
1Kzq-L468GfLKAENA@mail.gmail.com/
> >> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> >> ---
> >>  mm/slab.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/slab.h b/mm/slab.h
> >> index f22fb760b286..3e0a08ea4c42 100644
> >> --- a/mm/slab.h
> >> +++ b/mm/slab.h
> >> @@ -310,7 +310,7 @@ struct kmem_cache {
> >>  };
> >>
> >>  #if defined(CONFIG_SYSFS) && !defined(CONFIG_SLUB_TINY)
> >> -#define SLAB_SUPPORTS_SYSFS
> >> +#define SLAB_SUPPORTS_SYSFS 1
> >>  void sysfs_slab_unlink(struct kmem_cache *s);
> >>  void sysfs_slab_release(struct kmem_cache *s);
> >>  #else
> >> --
> >> 2.45.2
> >>
>
