Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1D43090C2
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260560; cv=none; b=P4oBTiqKnYOM0GuKNJoRlXM64l+2dxsaNE1y8dixWfsks5bclDmLK62p1HwSkTKjgFiblLmUXehhfQH2evP/rQytano0i3tV93LWMNarXRF1QG7nqf7pXSwhj3q0wR1ypk7UEZOSDPZe8/fq1h9O/0pTfwxmtVQrgmYJi5lElKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260560; c=relaxed/simple;
	bh=jB2oMvtjSlTt4fVzJfxYs7QB0QpySnep/Y2yZ6amjhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noXZFLSiNYXyZilcmFzDvDrIPxx7kRR0yW2tMv4kqEMyOYbII9c8+LGk2l6gbaUqm5/+/dqMunJh32XWDzeDcm7hMC1bH4g4u/7VLX1rwR7ZPYHoNkoa16voSGkPLk0cT3HZdXt7jtoHs96z0U8vXFOwhtf6VbRFOtaoBAgMl2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuqO/YgQ; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuqO/YgQ"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-46704fbf62dso223210b6e.1
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773260558; x=1773865358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDadkc9uehD2Q82HtUQ1xvN3p0rzr8EBQuFGGMiWazg=;
        b=EuqO/YgQdGHBNcg4CCSUHDiLIJsNAIGvXoghAVbSRQLYbyF8g+r6O53xrmPaDErnf7
         CchtW1WTlXC+lSnA9KyHUopVOuRtT5bOvtnvHGVfyF4zHnq/5IyFZ7kBKsSgeyPEZhSi
         U8e3UIy4RTbkJOW4FsiEh8IYgOu5mi0wMnZDTVYVnZsg+Z33GKC3at3m0DCJgwopeUdi
         aXuAkg8Mr4BZOtJ/QouHQaMh/5OEN+hPzF0GtJ2gn5LV859kT4Zp/K2pxnOpDp2DN36W
         TbGp4ttihOyTB8sLvlSU2+97AZFfbkVODE5XYLtzPdKVlmhgud/Jj0HuV/9LI7PZMnIF
         VgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773260558; x=1773865358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lDadkc9uehD2Q82HtUQ1xvN3p0rzr8EBQuFGGMiWazg=;
        b=GoKh4+51Z0k243QKC26HqbN6KzFvzI3CiGYiJii33+evLgdRX3f0VRLF1jgTJLFw8H
         z+nfENS18CVOQFMTd5pLmtfFG9szLZ2bgt9QMEfmngLR1XlRGDGYA83BI8vLx9HNKNHy
         EBqZzgmx7VHQTY++nXtrlVjNMX6etHClU5GE76tSKIguCq2M8luYgckEDKEJskTKOBAO
         GBaz6hgbg1ohh9G7Dz3hdZZpkCu0nN4sKa4xmJCSZ30+R+P/TGWoesbgWG0MnneJ+D9F
         kv3kPVn8p6hlnmstpc9IENGeKJaweL2zKAurp+tvCqiuwAK+S7YXs6b0TBsYN60Vmk40
         t7bg==
X-Forwarded-Encrypted: i=1; AJvYcCWGP88iIZbrGdsuLtEUgnUhpEBGrCm2BJuwVh9TjyPlwUzek8hlpReU7N865iD/J7wVoRJbmW9t41TDyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtxiN+A4i436onzrmSkTNDIH1GMgvtdKoIZ8RzP6+44LZKCYsm
	uFzkbTobO+oP1KEJPwx6ivJYcW4Ih0kNDSN/ZaGDFr4ymfxqNoCP3twX
X-Gm-Gg: ATEYQzy7HSJBRx9V77915U0xGubbyQ2nJrPlccezIWqcRVAXE4uPMdVj+pcL9gERCrh
	up2X/dlPnonp7V1rsSZf7hGhEzNa13De/R6dlZXuQU4u9ywjI35Yw8/hri6v4bbQYqhmtklBgcv
	0Owm23aZIyOctZuVONJWRNZF9uT64f7R5S79dEYerE0zwk+iZOcNfsuYZLbm2ARFK//xqoDg0ep
	SezY6n67fFZssmuFGi8HMaREMd0tWhRvf4ombeTGvb2s20emT6IjGxjzMWBJwFnkO6FjSFZdMHU
	yZBhv6RLzEzWAQ1aVTsCbV+8d9qC/xlOihVEXI5Nc/sRCU7NWAfny2pejYYlTtEk3a8VCV7Xqan
	WkgLDBW8lM7Oh6JsS47EkqnIYm7YuQtMed6sJxu2zmw3yL/Mb3xo1NEyHPmICqcE7qaAeNXsGN+
	b/5bZVaUn0p/VzKGw9S01zWQ==
X-Received: by 2002:a05:6808:4f54:b0:45c:881c:e0c0 with SMTP id 5614622812f47-4673359c4a7mr2171831b6e.47.1773260558347;
        Wed, 11 Mar 2026 13:22:38 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e268f37sm2889525fac.6.2026.03.11.13.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 13:22:37 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 04/11] mm/zsmalloc: Introduce objcgs pointer in struct zspage
Date: Wed, 11 Mar 2026 13:22:28 -0700
Message-ID: <20260311202230.294520-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAKEwX=Ns9zGhSSYOfVunb2dR-i-0krFP4SKQfro2FztLkbH6-g@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 11 Mar 2026 13:17:22 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> On Wed, Mar 11, 2026 at 12:52 PM Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> >
> > Introduce an array of struct obj_cgroup pointers to zspage to keep track
> > of compressed objects' memcg ownership, if the zs_pool has been made to
> > be memcg-aware at creation time.
> >
> > Move the error path for alloc_zspage to a jump label to simplify the
> > growing error handling path for a failed zpdesc allocation.
> >
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > ---
> >  mm/zsmalloc.c | 34 ++++++++++++++++++++++++++--------
> >  1 file changed, 26 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > index 3f0f42b78314..dcf99516227c 100644
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/zsmalloc.h>
> >  #include <linux/fs.h>
> >  #include <linux/workqueue.h>
> > +#include <linux/memcontrol.h>
> >  #include "zpdesc.h"
> >
> >  #define ZSPAGE_MAGIC   0x58
> > @@ -273,6 +274,7 @@ struct zspage {
> >         struct zpdesc *first_zpdesc;
> >         struct list_head list; /* fullness list */
> >         struct zs_pool *pool;
> > +       struct obj_cgroup **objcgs;
> >         struct zspage_lock zsl;
> >  };
> >
> > @@ -825,6 +827,8 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
> >                 zpdesc = next;
> >         } while (zpdesc != NULL);
> >
> > +       if (pool->memcg_aware)
> > +               kfree(zspage->objcgs);
> >         cache_free_zspage(zspage);
> >
> >         class_stat_sub(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
> > @@ -946,6 +950,16 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
> >         if (!IS_ENABLED(CONFIG_COMPACTION))
> >                 gfp &= ~__GFP_MOVABLE;
> >
> > +       if (pool->memcg_aware) {
> > +               zspage->objcgs = kcalloc(class->objs_per_zspage,
> > +                                        sizeof(struct obj_cgroup *),
> > +                                        gfp & ~__GFP_HIGHMEM);
> 
> I remembered asking this, so my apologies if I missed/forgot your
> response - but would vmalloc work here? i.e kvcalloc to fallback to
> vmalloc etc.?

Hello Nhat : -)

Thank you for reviewing, and for your acks on the other parts!

You're right, I missed changing that on my end after v1. No reason
vmalloc shouldn't work here, let me make that change in v3.

Thanks, I hope you have a great day!
Joshua
