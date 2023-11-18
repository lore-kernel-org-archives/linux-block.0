Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bFrnQCer"
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B05E1
	for <linux-block@vger.kernel.org>; Sat, 18 Nov 2023 11:14:46 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50aa2abfcfcso1836381e87.3
        for <linux-block@vger.kernel.org>; Sat, 18 Nov 2023 11:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700334884; x=1700939684; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R5xCKG+dPMG8F3WMME/kbqVh8kLHwHJKzVbHpwM9FHU=;
        b=bFrnQCertaoEUejQwPDoOCZ/bi7c3SNJtAlGQ00YYK9RXUgclsZhSI2De76KYJEu05
         yy73xJifOp5iRS71LJ9ZG0TGm6LWDf1EF3bjg597H7KdZf4rwbFvErvIIDP64yumfxDv
         yrZk4eeTp+OdhlzQT8tC0e+c3/U5XYAHR/mv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700334884; x=1700939684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5xCKG+dPMG8F3WMME/kbqVh8kLHwHJKzVbHpwM9FHU=;
        b=u4y1RKAf8HnvVsXgi8btkCLDQSwApCAnEqqPCXNlFmKup9N1HzL5MK+GqDRBq44uJS
         IYwsychhJYvL/s2Zqnb+t9TymC+vqrrVD/sP+yREH1vv2qdT5i+bGnXOP8OXxAv5Gp7S
         +BBcxE6m1LPjbkripxgxIUJFDpJ16whSMygywhcfGUxICfcXygeeD7PkkD+6oXyUPAJh
         2JV2uXCq5P4s54w/5hjrm4fKAuVLIHxoYvnHMPK3THZyFkFbSIxIFSecYe0/xS3n1AXo
         1zyfuhinARnWUZU65R2jy7xr6H1dV6mX1yUhgzgf5nptwyodEikSyRgk+Sps7J9dhQPO
         B04w==
X-Gm-Message-State: AOJu0YyRT8OkF6ZgCux8Yqu7B0Mid2w0H+QWA7IZRRbrynZwfexxg9WF
	SDjauzLcvISXBZW1vj3+JnbPVJrEEMWL2ZAEOjhduA==
X-Google-Smtp-Source: AGHT+IGLLecanfdYx41S8L07FU1tBSy52/KPOqC9JHOO7EsdG9DwCCWa0XGQYuFL8+PJfed4zktzVw==
X-Received: by 2002:ac2:5337:0:b0:508:11f5:8953 with SMTP id f23-20020ac25337000000b0050811f58953mr2104169lfh.26.1700334883857;
        Sat, 18 Nov 2023 11:14:43 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id lz2-20020a170906fb0200b0099d798a6bb5sm2155601ejb.67.2023.11.18.11.14.43
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Nov 2023 11:14:43 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-54394328f65so4244204a12.3
        for <linux-block@vger.kernel.org>; Sat, 18 Nov 2023 11:14:43 -0800 (PST)
X-Received: by 2002:a05:6402:64f:b0:543:7e9b:5cc9 with SMTP id
 u15-20020a056402064f00b005437e9b5cc9mr2096703edx.31.1700334882947; Sat, 18
 Nov 2023 11:14:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZVjgpLACW4/0NkBB@redhat.com> <CAHk-=wjV2S7xBcH2BGuDgfKcg3fjWwk5k74nq89SviMkH-YsJQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjV2S7xBcH2BGuDgfKcg3fjWwk5k74nq89SviMkH-YsJQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 18 Nov 2023 11:14:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjCXvFme97sxix_zDfq4-oNRv7fNp+YzWEuUGH-gihA-g@mail.gmail.com>
Message-ID: <CAHk-=wjCXvFme97sxix_zDfq4-oNRv7fNp+YzWEuUGH-gihA-g@mail.gmail.com>
Subject: Re: [git pull] device mapper fixes for 6.7-rc2
To: Mike Snitzer <snitzer@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	Alasdair G Kergon <agk@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>, 
	Mikulas Patocka <mpatocka@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 18 Nov 2023 at 10:33, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> What are the alleged "number of bugs all over the kernel" that the old
> MAX_ORDER definition had? In light of the other "MAX" definitions I
> found from a second of grepping, I really think the argument for that
> was just wrong.

Bah. I looked at the commits leading up to it, and I really think that
"if that's the fallout from 24 years of history, then it wasn't a huge
deal".

Compared to the inevitable problems that the semantic change will
cause for backports (and already caused for this merge window), I
still think this was all likely a mistake.

In fact, the biggest takeaway from those patches is that we probably
should have introduced some kind of "this is the max _size_ you can
allocate", because a few of them were related to that particular
calculation.

The floppy driver example is actually a good example, in that that is
*exactly* what it wanted, but it had been just done wrong as

  #define MAX_LEN (1UL << MAX_ORDER << PAGE_SHIFT)

and variations of that is what half the fixes were..

IOW, I really think we should just have added a

  #define MAX_GFP_SIZE (1UL << (PAGE_SHIFT+MAX_ORDER-1))

and the rest were basically all just the trivial off-by-one things.

The __iommu_dma_alloc_pages() code is just so odd that any MAX_ORDER
issues are more about "WTH is this code doing" And the "fix" is just
more of the same.

The *whole* point of having the max for a power-of-two thing is that
you can do things like

        mask = (1<<MAX)-1;

and that's exactly what the iommu code was trying to do. Except for
some *unfathomable* reason the iommu code did

        order_mask &= (2U << MAX_ORDER) - 1;

and honestly, you can't blame MAX_ORDER for the confusion. What a
strange off-by-one. MAX_ORDER was *literally* designed to be easy for
this case, and people screwed it up.

And no, it's *not* because "inclusive is more intuitive". As
mentioned, this whole "it's past the end* is the common case for MAX
values in the mm, for exactly these kinds of reasons. I already
listted several other cases.

The reason there were 9 bugs is because MAX_ORDER is an old thing, and
testing doesn't catch it because nobody triggers the max case. The
crazy iommu code goes back to 2016, for example.

That

    84 files changed, 223 insertions(+), 253 deletions(-)

really seems bogus for the 9 fixes that had accumulated in this area
in the last 24 years.

Oh well. Now we have places with 'MAX_ORDER + 1' instead of 'MAX_ORDER
- 1'. I'm not seeing that it's a win, and I do think "semantic change
after 24 years" is a loss and is going to cause problems.

               Linus
