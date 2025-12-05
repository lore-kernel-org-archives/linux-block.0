Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC281EA65
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764918828; cv=none; b=MaQ3X42N6iyF4SUAVSJFYRuasNoIiq26Nm2fzgSgstwdNuzKTU1ugiwGJgG4quaaNTzNLs5OxpPQSLR+sph6WfWXA5G1Pgcl3KEx5X/gbtcCpRbakxFsGIQ56wI9HQojzU6MeQ7Q4eJh8v8aQSl1IqbzG6V+cSZoJTC+z86osFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764918828; c=relaxed/simple;
	bh=Pwy8IpSMRvV4pLYbOFuG1E10Sbp1P4ndJix3SkClrEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRck0BI3j55U8ayG+lwnEM/MpukOcTQ9w5n9o7Ot67rbDvq4vl4Y/UJYP1r93FQU+FyyE7Pf0lcBL22EWTOkYOVxq4JYM47ntnfaUdeagFQGg9KjybO29NnKJeaiPWgJHyo98I3ye8RERKBLacMqqVpdpPb81AeiqawEzW1H17A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdiGj0Zs; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdiGj0Zs"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso16657271cf.1
        for <linux-block@vger.kernel.org>; Thu, 04 Dec 2025 23:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764918825; x=1765523625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZsthjM36AzHfzJRPv+fucYmlyEL9uQqlbDBpqCCaLU=;
        b=QdiGj0Zsubu18EeDMdJMOc0rVl8qh588fVqBx4OqCAaJweWObgWjqkiVjS+uQxqBu4
         oZsntiEqSqKoloiwI3yGO0pcKeGfYSFSRWIlULTYOdLlOVik4U5luPzwweRqJCxvHHdP
         0a2c6mK5CQ16EQQevgGm5tdW8FFxG5XK8L0Aj8VGXS0SUlAdFanRgxR8BQZMoaiXBV/6
         LDwCTEG0W5pUwhgLCX8fM4bkvemFDaD5RKfVxZxQK6z1Zs1volK6++tlOqHYp/UQl9is
         hsFjkl8w4KXKGdOC9CneYFvkZ1zUHGdXfan6ZyEdypmqHDXAquisqQ+KdLZFMSckZ9xt
         5EVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764918825; x=1765523625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZZsthjM36AzHfzJRPv+fucYmlyEL9uQqlbDBpqCCaLU=;
        b=gmohNsIR4Jfwm3VLiilcl+0OmURQMbk8QM8WSr+0W1OXi+vGqHgV4xl+6USEzAvXhb
         fFTGNiMdT8EGiLXbQ5C1WjF3vDWYoqhH5CLRhI5gXCizgT7XylZ3QJxSgwI3b+X6eKVf
         4QML9uYxN8wcJtMES99n3T4Zxzr6aY+7MtSASuN9BX8kUzy1FvL9IufNAfiiNmzfaH3A
         llRep0/xStMvRiubsYCLNkr1IVTi+h65cAALjbtGjJ6Z7r7NlRBMhPzCePvADI/ZF8un
         4NiGWVQfUmC+9GhjrE7iduGKliPFBAk/e2L1T9qxEYRadXxJhJWzIHqUJafZHNIqAgyd
         VsIg==
X-Forwarded-Encrypted: i=1; AJvYcCVkO1pDJDb/81mooKR1B9e0WM91kgqEmq1EPtd7SnlI9pheSOEmfoxB4JPpvH+nEb0YrFV0WMb4ktkmqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVvLjOyng2LULmX4OPNlCAgoc1EnAJbmfypVQBao73lNm7gGSx
	nB0JV+G4r/Pyu6s3njbHp6Luv8qPEffMkpZuU7AXov1gx8DnRcM9VMfLurDZpsCsuh1xvCbIwvA
	kY02TGkBsdfXBsY4ZpoyevR4RHMDaUBb9wfVn
X-Gm-Gg: ASbGnctqnTCQ24SwibEK8IdqlxkGGnh2Yle/h4J4944frdLx7mvxFAbQTubS7ShudLn
	zBrw2p4kJI3PvlUu1Et0lHa98DrejIm/J8vMm+IomAv9CFfe8ojtEtUDeUljnIzg9AF+wdl2WRC
	ABpW7cJ1XP026fTWnUm++xingxUjzz9gys5qzCAmvynDMy2jQ4vqYHs2X3uGDoJlceDjfvF9YdE
	zwXdJ61k9r91Ojnt9KeOzfiTNQvKGr/wG4vtDfnsotBcPHvM22o0osWsjKwqibFHOcHh34=
X-Google-Smtp-Source: AGHT+IHJYWyI1mjiCTADN5mDPLjPn3O9aCgQQv/47u89Ok6QQjz9aaYuj5efWq8w321nH+Wx4kCBL9g4Yv4MqXDmCBE=
X-Received: by 2002:a05:622a:50a:b0:4ed:8264:9199 with SMTP id
 d75a77b69052e-4f01765302bmr128016701cf.67.1764918825449; Thu, 04 Dec 2025
 23:13:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204024748.3052502-1-zhangshida@kylinos.cn>
 <20251204024748.3052502-4-zhangshida@kylinos.cn> <CAHc6FU5KQBpJOWcx0uiE1U5vJoON147wFMUn0oWzUmzSQajirw@mail.gmail.com>
In-Reply-To: <CAHc6FU5KQBpJOWcx0uiE1U5vJoON147wFMUn0oWzUmzSQajirw@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 5 Dec 2025 15:13:09 +0800
X-Gm-Features: AWmQ_bmJlyuWuTYYPV6iO6_S52PTzlNhO3cILZ9KpXHKGaOmepcVIhpJGge9aIk
Message-ID: <CANubcdVgSO1RwAU+mp5AguaZk78SqrBRS-eWbgz1mNLs7JA_uA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] block: prevent race condition on bi_status in __bio_chain_endio
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	hsiangkao@linux.alibaba.com, csander@purestorage.com, colyli@fnnas.com, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=88=
4=E6=97=A5=E5=91=A8=E5=9B=9B 20:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Dec 4, 2025 at 3:48=E2=80=AFAM zhangshida <starzhangzsd@gmail.com=
> wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Andreas point out that multiple completions can race setting
> > bi_status.
>
> What I've actually  pointed out is that the '!parent->bi_status' check
> in this statement is an unnecessary optimization that can be removed.
> But this is not what this discussion is mainly about anymore.
>
> In the current code, multiple completions can race setting bi_status,
> but that is fine as long as bi_status is never set to 0 during bio
> completion. The effect is that when there are multiple errors, the
> bi_error field of the final bio will eventually be set to an error
> code, but we don't know which error code will win. This all works
> correctly today, and there is no race to fix because the race is
> intentional.
>
> > If __bio_chain_endio() is called concurrently from multiple threads
> > accessing the same parent bio, it should use WRITE_ONCE()/READ_ONCE()
> > to access parent->bi_status and avoid data races.
> >
> > On x86 and ARM, these macros compile to the same instruction as a
> > normal write, but they may be required on other architectures to
> > prevent tearing, and to ensure the compiler does not add or remove
> > memory accesses under the assumption that the values are not accessed
> > concurrently.
>
> WRITE_ONCE() and READ_ONCE() also prevent the compiler from reordering
> operations. Even when the compiler doesn't seem to do anything nasty
> at the moment, it would probably still be worthwhile to use
> WRITE_ONCE() for setting bi_status throughout the code. But that's
> beyond the scope of this patch, and it calls for more than a global
> search and replace job.
>
> > Adopting a cmpxchg approach, as used in other code paths, resolves all
> > these issues, as suggested by Christoph.
>
> No, the cmpxchg() doesn't actually achieve anything, it only makes
> things worse. For example, when there is an A -> B chain, we can end
> up with the following sequence of events:
>
>   - A fails, sets A->bi_status, and calls bio_endio(A).
>   - B->status is still 0, so bio_endio(A) sets B->bi_status to A->bi_stat=
us.
>   - B fails and sets B->bi_status, OVERRIDING the value of A->bi_status.
>   - bio_endio(B) calls B->bi_end_io().
>
> Things get worse in an A -> B -> C chain, but I've already mentioned
> that earlier in this thread.
>
> So again, the cmpxchg() is unnecessary, but it is also harmless
> because it suggests that there is some form of synchronization that
> doesn't exist. The btrfs code that the cmpxchg() was taken from seems
> to implement actual first-failure-wins semantics, but this patch does
> not.
>
> The underlying question here is whether we want to change things so
> that bi_status is set to the first error that occurs (probably first
> in time, not first in the chain). If that is the goal, then we should
> be explicit about it. Right now, I don't see the need.
>

Thank you for the thorough discussion on this matter. Based on my
understanding, there appear to be two main viewpoints:

Side 1 (S1) argues:
A. Using cmpxchg() addresses all the issues that
READ_ONCE()/WRITE_ONCE() can solve. That said, cmpxchg()
appears to provide a comprehensive solution.
B. While cmpxchg() introduces some additional overhead, this may not
be significant since it occurs in a slow error-handling path.
Or nondeterministic order of overriding, Which is not a problem.

Side 2 (S2) argues:
A. While READ_ONCE()/WRITE_ONCE()-style protections may be
needed, addressing them in this specific patch may not be appropriate.
B. The cmpxchg() approach adds unnecessary complexity without clear
benefits.

The trade-off between S1B and S2B seems somewhat balanced, with
no clear winner.
However, regarding S1A versus S2A, I wonder:

If we agree that READ_ONCE()/WRITE_ONCE() protections are required
here, is there a specific reason we couldn't address just this code snippet
in this patch? We could then follow the S1 approach and use cmpxchg().

However, If this change remains controversial, I'd be happy to drop it and
resend v6 without this modification.

Thanks,
Shida





> Thanks,
> Andreas
>
> > Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  block/bio.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index cfb751dfcf5..51b57f9d8bd 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -314,8 +314,9 @@ static struct bio *__bio_chain_endio(struct bio *bi=
o)
> >  {
> >         struct bio *parent =3D bio->bi_private;
> >
> > -       if (bio->bi_status && !parent->bi_status)
> > -               parent->bi_status =3D bio->bi_status;
> > +       if (bio->bi_status)
> > +               cmpxchg(&parent->bi_status, 0, bio->bi_status);
> > +
> >         bio_put(bio);
> >         return parent;
> >  }
> > --
> > 2.34.1
> >
>
