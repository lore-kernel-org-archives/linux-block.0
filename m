Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60341446BF8
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758672; cv=fail; b=abPwygBgfhOD9hQrWRtriuAsHfzM4ePGE3buuPGoM1fj0rNYrmL+HGmARAVi5K51yB+RhpiH1lEolvwZIhJQryxCY8xhRBYCbx540m+UW26vUa75+VfXvyKHjAvwH5OWF/G6nd/dEizqdiyeWpgmRXJ/xvZYlwdTCBIN8gewbRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758672; c=relaxed/simple;
	bh=jjd0KEG/NBOXWmwGkt2V1dWNw5vceT2ola78j22GHAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRsS5gy/4khXSrOILrGbHEYSiVzfXf/ivBjmhRQHyFSiUnmT5ry+5nd1Tl/Q8+fs0UNYjhE5TE4JWL3AAut0T154TgaSJ/fegvCC8j4e7ORrBeXULN8ny1IBpaqEtUYupdcWMqPL/ikaAgjIIbtLFVtiEu45eLaJFPTa8KepDf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MEbkSTuE; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MEbkSTuE"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U7d6J1606523
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 01:57:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=FSbzH3J8GpCu3CO+DRX2zaPG7BxRBagXxEyW5
	XsxKiw=; b=MEbkSTuEtJDyWYMNO6YL71WnCSoBA2M2Ck/I1j+uuUHs9mx4xl1lP
	gEqVlxysJcR7edYasoLN4634LrDsZRUwbwdmJVoFzEjMQJrdc2dUZfzF+dZo469C
	5b186aQQR+hHRBosxnqh344iEb4SzDtTYD/teK309BdwlV2lRDorTb6kPJni+ZWa
	W4E/9CX0ofByb7dQQjPCOTa2hzmevHGcOwgw3KwZjp0bp4d0aaffmeV4b5S63UWM
	uLJX101Vdvir1zuV9/bkNFYr8hoPBW91pSuY/NMULyzKjf/x1DEgQ91XgiTsTBK+
	0Q34mZldvMxcKiDGUn9y4QuzYXk5yFVnQ==
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h0gg97nf8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 01:57:46 -0700 (PDT)
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a615ab0c06so5989071a12.2
        for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 01:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790758665; cv=none;
        d=google.com; s=arc-20260327;
        b=pAT5A7Sna+zMRGUKK1WTwIBGBmd/3txqoZr8a8nQX5CrMPXqGTvkx2FTNiDeEnGNS9
         sl/pdhqbtPSYWJxbMMEmjhHDvisaxyIG+Br0akSsl4j1QkhT/fNYMOZzYtBcbCT9LrAY
         ZsSNUAJExz4EpTgpFZ4uOzoRpJNxGuIyaEGA2Oe+9QNjpTSB4R6sZkPC8406VvXO0CP7
         isAMRz3RyA8Oo60xQE5cq0q1bSYSXJ5C1qxWKNhezOMUMwFpzivPQWEon8HvheTOG0Da
         89IkP3y4aIYtvBrjdZba4quo5m81bv/9DSyIbN4dSq+GvpuD+kxo5tXsK6klCZgW1ejl
         aiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=tm60U/TGR2G1p40eU4sJMqqHLE9qAL4X5WQ6mS0UHeE=;
        fh=1QzqfzXLv4Q1HwwZkPuHzZyfHzJiuGpsTd3zsfAOrZ0=;
        b=EmfMMo83lB6uBxFOnMhyT64+1tuBPDBiArUsxSFwC2qooGxezvqVeITzxfejkoSDoU
         bJqgWWgnMDUuV2gU4vlquZKCZvo5NfsmGrpKbYr/vr0Oji+LJk5P31FR4bHLBKB+EnSR
         F94r/KOtCEgo8RTT0DNqfu4/jsXCG+7akyLvfBwSmswWEbnr1wNTaFZQmN87O4dSSyae
         FrV9oLakld1dt+mAZ42Ldzs0VEdxBPFiSOgCw62KGPZOebt6rvweOkfe/GsgN2q/PgXT
         wnQOEmWLY1VtjGmq5IvU+iZdArYJSS2tvDP0GclX1tguu0otgmNRWE06qjYue3DmP8Kb
         iSgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790758665; x=1791363465;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tm60U/TGR2G1p40eU4sJMqqHLE9qAL4X5WQ6mS0UHeE=;
        b=zD9jFIpAsm7MmOAOkg9xl+2jT+AYOt3QBreuZ/ATEleYdJWNcgi/rwrr1MYNz3kewr
         UXIOlemDrQ9TmNPXDF1XN5tZXwYoXEsAtQCj9/HFgiUUdae+Q25x6cLu7oqGk9MKf5Dw
         tIU+3wONxDbPu75vyX+r36l/2D1h4vxIK5j9x8nkerp1IyJCMcvTaJYGCaNhU1nbs8Cm
         8qF/ZMkkH+sXwNlDucwkYwQgFUJicftHg8eKYwq92JuA7uapyHdjp19YlBuI6rD4QnQU
         46CZDQfIlqRX1ltrvBkef+zppMvAv22zpBLrLkO52sQP/qKp83J6dDci2IqxyS2SRz0q
         wvzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzeoCetCouWUjReJbXk72jexaNs7gisT61M5++QFo21KSN/jqkp07O1m6VO7mDFALi4LO+qxIK/NQ8XAQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJldA07erGYY5BHd7SSy3UqKvzfDA5NWoEloK+LoJoa/x+UCNii
	TA6Ld+BpwEbT+4gb51fjIM2NDI/gB7y5KRkAxSX5wvX/6WQMlx4wKz+HXHA4mrnOZl1jJfvLe8N
	HYRvgXACGoCxAKJMN4bVuHGDkCMiZuYRbDo62wSmMgjiMXdiKq9tNQQkML5XlFTEKuCl/JnMARU
	9PDeW/AbKJ5V6hyC0cGFKR4gKK6oq98zhB4ztW2A==
X-Gm-Gg: AYBFou3gA3e91jR/XVtS0rretXn9H2O2HNDn136kPJrguryPSjS2ZsuNSKrdZzIUoEb
	tYoaMyfVOR8hX1jW+Cbmtwi5wITbjA6d9G5CoMIUi5jDv8/Rgazz8gmb2YtR04dyoj5CGWT5tbC
	/T8nde4V0Ce5+QKb4ZlK2Ptg1N2v8Br+jaQHtk8Hc7ZS9BGgBtpGPIlnOwaqqWnTNdlRcncCzGx
	L9uN+/XHgW83oprnw==
X-Received: by 2002:a05:6402:24c6:b0:6ab:1c2:967e with SMTP id 4fb4d7f45d1cf-6ae1997603cmr348799a12.32.1790758664846;
        Wed, 30 Sep 2026 01:57:44 -0700 (PDT)
X-Received: by 2002:a05:6402:24c6:b0:6ab:1c2:967e with SMTP id
 4fb4d7f45d1cf-6ae1997603cmr348775a12.32.1790758664322; Wed, 30 Sep 2026
 01:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928081900.4187482-1-alex@ghiti.fr> <20260928081900.4187482-5-alex@ghiti.fr>
 <CAKEwX=PJjGe3kjYCHwxijaZ+W8HvOiNQTTS-Da1R02hPW=kCDA@mail.gmail.com>
In-Reply-To: <CAKEwX=PJjGe3kjYCHwxijaZ+W8HvOiNQTTS-Da1R02hPW=kCDA@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Wed, 30 Sep 2026 10:57:33 +0200
X-Gm-Features: AclHuK8QO5DXy2cZ_qgdu0179rbpj5mlyiQ1Y2SMBWaoqm3aGlQoLCg7t0LKm2c
Message-ID: <CAEmasaWgracciCPNB-39iZ6RRCbGfQYFNiWSHsfP0qaaxCXCKg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] mm/zswap: move reclaim-driven writeback to a kworker
To: Nhat Pham <nphamcs@gmail.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        david@kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosry@kernel.org>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Chris Li <chrisl@kernel.org>,
        Kairui Song <kasong@tencent.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
        Youngjun Park <youngjun.park@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 4raqxJE442fGtrJfO7590v0Z4Fs5rufc
X-Authority-Analysis: v=2.4 cv=aI9lOr9m c=1 sm=1 tr=0 ts=6abccf0a cx=c_pps
 a=9KvDgq78n9V61H3VJbnhTw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=pGLkceISAAAA:8 a=Esfd6WMfZuu0XR_NPF4A:9 a=QEXdDO2ut3YA:10
 a=j5kO0B45gQVIxiUYEfTy:22
X-Proofpoint-ORIG-GUID: 4raqxJE442fGtrJfO7590v0Z4Fs5rufc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzNSBTYWx0ZWRfX3oSWALS/3B7N
 nuZbyGHU4AFxigRXTPGl3TDn5Wexxgx70VFlGe+FsMia2IpdziWrPIkC7z6+uJvnSQhjRsO0iA8
 jtUod144GRulenFNbVXHpO2YjLgN5NU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzNSBTYWx0ZWRfX0pANVax8kmPm
 gCSn3cgRinuzaqFqiobox+ET/qeX8d9UoxYqix+dc1pN4MsyJFSJ4sIJnx6YcZ9a3NDBikOljUD
 gD1QbaacRkSXc9H1LVlX6laEkGgArgRcGtdNoOSzeMUa53Yrl6JIlyehhjf2hDn+FYmg8mxEJVg
 qyt70QsfSq/GO7LpxwvmpCN2mlOs4xc/rYNfmaKEQeLW+lQTx4zv4DIfHpzzCmxt8FzLET3dRMT
 F3/ahv7tTAGdpfOF0ZAcmOkAPOHaZGzvAgA9X57UXLQ+6HfJM/j2Tf6q8yBO4hqml4wpTSL010O
 ZLkSA8t6kVOSi3i698fP2gpjxygPoxTiGzt2RhUzHl9PjjAGbO8wgfPkFm6R48qd2LXsKxmylSI
 cCOYjmhjSqIZqJsRN+uUveFV/7CKWfl5qt/Elt6kHg/ESmJ9PmzaeHHwHQpPrctcc+hFph85b0D
 ana79DQ/zdalvx8vY+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01

Hi Nhat,

On Tue, Sep 29, 2026 at 3:43=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> >
> On Mon, Sep 28, 2026 at 9:23=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> w=
rote:
>
> I understand the problem this patch is trying to solve, but this
> solution seems more involved than the changelog suggests :)
>
> >
> > zswap_shrinker_scan() writes back in whatever context reclaim called it
> > from: an application thread inside a page fault, or kswapd reclaiming
> > for the whole node. Now that the cgroup IO controllers throttle zswap
> > writeback, that context sleeps uninterruptibly until the owning cgroup's
> > IO budget allows the write. Such stalls were observed on a large
> > production workload.
> >
> > So defer the writeback to a kworker: each lruvec has its own work item
> > on shrink_wq, which writes back what reclaim asked for, SWAP_CLUSTER_MAX
>
> Ahhh, so it's one work-item (added to the shared shrink_wq)
> per-lruvec, not one kworker or thread per-lruvec.
>
> Hmm, supposed multiple tasks in a cgroup enter direct reclaim. In the
> past, the amount of writeback submission will scale with the number of
> tasks entering reclaim. But now, it's just a single work item
> per-lruvec - IIUC, the submission of his work item is idempotent, so
> it wouldn't scale like that anymore, right? I haven't wrapped quite
> wrapped my head around this, but this sounds like a non-trivial
> effect...

It would not scale indeed, the worker does not accumulate in this
version of the patch. That needs to be tested and discussed.

>
> Also, do we need to defer writeback submission for proactive
> reclaimer? Or kswapd? Only direct reclaimers have concerns with the
> latency blowup from the throttling right?

Today the writeback bio is issued as root, which incurs debt to the
cgroup. The submitting task repays it on return to user or on any
other IO of the cgroup until the debt is paid off.

With this series the bio is throttled at submission instead, so
whoever submits it sleeps until the cgroup has budget:
- for direct reclaimers, that's the application latency we observed
- for kswapd reclaim, it would stall on a single cgroup's IO budget

So we need to defer for everyone.

>
> There are a couple more behavioural changes, without proper
> justifcation or mentioning in the changelog. More details inlined
> below:
>
> > entries at a time, while holding a reference on the memcg. The shrinker
> > does not queue more work while the worker has yet to claim the previous
>
> Why not?

In the large production workload I have worked on, when the shrinker
is enabled, the zswap pool size decreases by ~97%. So I did not want
to accumulate "too much" work to prevent zswap from draining "hot"
pages, it acts like an additional throttling mechanism. But that needs
discussion, hence the RFC.

And you're right, In the next version, I'll clearly point out all the
behavioral changes I made with their justifications.

>
> > one, and reports nothing freed, as nothing is until the worker runs.
> >
> > Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>
> [...]
>
> > +
> > +static bool zswap_defer_writeback(struct shrink_control *sc)
> > +{
> > +       struct lruvec *lruvec =3D mem_cgroup_lruvec(sc->memcg, NODE_DAT=
A(sc->nid));
> > +       struct zswap_lruvec_state *zls =3D &lruvec->zswap_lruvec_state;
> > +       long old =3D 0;
> > +
> > +       /* Do not accumulate work: back off if the worker is lagging be=
hind. */
>
> Why not? This also has a non-trivial effect on the writeback amount...

Explained above

>
> > +       if (!atomic_long_try_cmpxchg(&zls->nr_deferred_writeback, &old,
> > +                                    sc->nr_to_scan))
> > +               return false;
> > +
> > +       if (!mem_cgroup_tryget_online(sc->memcg))
> > +               return false;
> >
> > -       shrink_ret =3D list_lru_shrink_walk(&zswap_list_lru, sc, &shrin=
k_memcg_cb,
> > -               &flags);
> > +       if (!queue_work(shrink_wq, &zls->deferred_writeback_work))
> > +               mem_cgroup_put(sc->memcg);
> > +
> > +       return true;
> > +}
> >
> > -       if (flags & ZSWAP_SHRINK_SWAPCACHE)
> > +static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
> > +                                        struct shrink_control *sc)
> > +{
> > +       if (!zswap_shrinker_enabled ||
> > +           !mem_cgroup_zswap_writeback_enabled(sc->memcg)) {
> > +               sc->nr_scanned =3D 0;
> >                 return SHRINK_STOP;
> > +       }
> >
> > -       return shrink_ret ? shrink_ret : SHRINK_STOP;
> > +       /* Nothing is freed until the worker runs, so report nothing. */
> > +       return zswap_defer_writeback(sc) ? 0 : SHRINK_STOP;
>
> This will have effect on the shrinker control loop too, right?
> Shrinker API accumulates the number of writebacks overtime based on
> shrinker_count()'s output, and we serve that number of writebacks
> throgh shrinker_scan(). With this basically that accumulation just
> grows over time, correct? Check do_shrink_slab() in mm/shrinker.c...
>
> Feels like this completely breaks that control loop.

Yes, this is another behavioural change that I will explain in the next ver=
sion.

Indeed the work piles up in the shrinker control loop if writeback
cannot catch up but note that it is bounded, which is what we want
right?

>
> >  }
> >
> >  static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
> > @@ -1807,7 +1897,7 @@ static int zswap_setup(void)
> >                 goto hp_fail;
> >
> >         shrink_wq =3D alloc_workqueue("zswap-shrink",
> > -                       WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
> > +                       WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
>
> This turns a single-threaded workqueue into multi-threaded workqueue, IIU=
C.
>
> Worth at least an callout in the changelog?

You're right, and the explanation is "we cannot starve other memcgs if
one worker stalls because it exhausted its memcg budget".

Thanks Nhat!

Alex




>
> >         if (!shrink_wq)
> >                 goto shrink_wq_fail;
> >
> > --
> > 2.53.0-Meta
> >
>
