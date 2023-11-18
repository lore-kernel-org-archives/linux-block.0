Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BfVnbc/Z"
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7119F2
	for <linux-block@vger.kernel.org>; Sat, 18 Nov 2023 10:34:12 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5094727fa67so4326207e87.3
        for <linux-block@vger.kernel.org>; Sat, 18 Nov 2023 10:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700332451; x=1700937251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iN30444otYgrHG7wXHjLQUqEXj0svyI3isTOZp0Uy+o=;
        b=BfVnbc/Z+9NvdMks4DLHIT1J9TyHIIW0gIJuHyrcCZDmBVhRX2n5yxKsG6JjTe+dag
         ZSHzyvkl2SmbPC93F/QK5e6T7ae3sm6P9AW0UfUODftwTDBCUkHf3DdHGqwyTn06Q0nQ
         jo+Uy8ngkhawRC3VcHTs7L3SNd0Kj1xNZEUR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700332451; x=1700937251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iN30444otYgrHG7wXHjLQUqEXj0svyI3isTOZp0Uy+o=;
        b=N9JTF06So8IuQoSHdpGYE4Q2a4V43XrYt6ekbO6N8fjySdv0Q/HUxibNqU7y/SeI9/
         6Px1FCOHLZqHG2j5jtVtk7j0lhx5WhzNrINjpEo4o2f7eq0oZqUnHPFEzQcX0GdH2t4I
         xbvcR/2Sl986hjPpgw9Y2ZrsKyg8igGt0Pqdf2TWML//vZqRD7lAN3xgqvMfpTrvIuCF
         Ru3azdsgh0iqfer2RYtZV0h8HILmYEFMhi6T4myW7GnOYbpfJpyIP9pys6elkon1QMl3
         PQ3Z7wnxEpIuOllBbRnsY5TIk+9jg+Xxg0wu1fJXMju5yXSMMx3HXhVqKutc/j36o1+v
         +9PQ==
X-Gm-Message-State: AOJu0YwAOoW8xNTznlXOCRFDqi9qfaE6ApbCvS1hK8JKTy+1j/aRRBk6
	pPa//ndlrjm2TwABHufu2KlvhcZ3jbfPJlPwkyXb5GGN
X-Google-Smtp-Source: AGHT+IHqFgK0Qy82Ltunj+PJAw3ri8T5diCJjuKeErhTmaiADiTYz6ulq0Peb+vuIWcURQqu6w4nqw==
X-Received: by 2002:a05:6512:3e1d:b0:507:98d0:bec4 with SMTP id i29-20020a0565123e1d00b0050798d0bec4mr2716805lfv.54.1700332450830;
        Sat, 18 Nov 2023 10:34:10 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906314a00b009a13fdc139fsm2092537eje.183.2023.11.18.10.34.10
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Nov 2023 10:34:10 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so4177212a12.3
        for <linux-block@vger.kernel.org>; Sat, 18 Nov 2023 10:34:10 -0800 (PST)
X-Received: by 2002:aa7:d145:0:b0:547:540c:983 with SMTP id
 r5-20020aa7d145000000b00547540c0983mr1912920edo.30.1700332449803; Sat, 18 Nov
 2023 10:34:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZVjgpLACW4/0NkBB@redhat.com>
In-Reply-To: <ZVjgpLACW4/0NkBB@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 18 Nov 2023 10:33:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjV2S7xBcH2BGuDgfKcg3fjWwk5k74nq89SviMkH-YsJQ@mail.gmail.com>
Message-ID: <CAHk-=wjV2S7xBcH2BGuDgfKcg3fjWwk5k74nq89SviMkH-YsJQ@mail.gmail.com>
Subject: Re: [git pull] device mapper fixes for 6.7-rc2
To: Mike Snitzer <snitzer@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	Alasdair G Kergon <agk@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>, 
	Mikulas Patocka <mpatocka@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 18 Nov 2023 at 08:04, Mike Snitzer <snitzer@kernel.org> wrote:
>
> - Update DM crypt target in response to the treewide change that made
>   MAX_ORDER inclusive.

Your fix is obviously correct, and was an unfortunate semantic
conflict that I (and in my defense, apparently linux-next) missed this
merge window.

But now that I notice the mis-merge I also think the original change
may just have been wrong.

Not only did it change MAX_ORDER semantics from their historical
definition, the *argument* for changing it is bogus.

That commit claims that the traditional MAX_ORDER definition was
counter-intuitive, and that was really the *only* argument for the
change.

But the thing is, the 0..MAX-1 is often the *norm* in the kernel
because we count from 0 and often have max values determined by
powers-of-two etc

Just in the mm, we have MPOL_MAX, MAX_NUMNODES, KM_MAX_IDX,
MAX_SWAPFILES, MAX_NR_GENS, COMPACT_CLUSTER_MAX, MAX_LRU_BATCH, and
probably others.  And as far as I can tell, *none* of them are any
kind of "inclusive" max (that's from a very quick grep for 'MAX', I'm
sure I missed some, and maybe I missed some case where it was actually
inclusive).

So the dm fix in commit 13648e04a9b8 ("dm-crypt: start allocating with
MAX_ORDER") is clearly and obviously a fix, and I have pulled this,
but the more I look at it, the more I think that commit 23baf831a32c
("mm, treewide: redefine MAX_ORDER sanely") was just *complete*
garbage.

Calling the old MAXORDER insane (by implication: "redefine sanely")
and counter-intuitive is clearly bogus. It's neither unusual, insane
_or_ counter-intuitive, just by all the other similar cases we have.

Andrew, Kirill - I'm inclined to just revert that commit (and the new
dm fix it resulted in), unless you can back it up with more than a
completely bogus commit message.

What are the alleged "number of bugs all over the kernel" that the old
MAX_ORDER definition had? In light of the other "MAX" definitions I
found from a second of grepping, I really think the argument for that
was just wrong.

And old MAX_ORDER it is. I went back in history, and the MAX_ORDER
define comes from 2.3.27pre6, where we renamed NR_MEM_LISTS to
MAX_ORDER.

And that was back in 1999.

So we have literally 24 years of MAX_ORDER that was upended for some
very questionable reasons. And changing the meaning of it
*immediately* caused a bug.

                   Linus
