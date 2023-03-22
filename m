Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F758C7619A
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 13:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjCVNas (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 09:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVNar (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 09:30:47 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A049D10D1
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 06:30:45 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p203so20937147ybb.13
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679491845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fj1ZEndN827h6H99ZndY6ISgjudYJ+QA+1NK7dJ1MKY=;
        b=dAp2Sm7P7M3MQaKNyWk6eEx7+O4qGXWX0+DMyeBe3i97co13uziImImpyMJGF4jLLb
         xA77N70wHknYdtIkxdMcbPBi2dV8fgnGDSaeaFCa1mFqNyi2hAATsozRzSBv/TnqPMkF
         p09JSU9UaWA35VbyplGqVFuvokTma7h74NFHl8ZLBKedG+qa8hQwxqEo3Q/saaytLRUt
         ofrdVXGmJBE5HUYGnmLV2DdhSwXE4W2Ugc8LdfDSnlBxpyp7jCxvYpN09mVgXGfV4ziy
         GFKhfQ4GzQyhKr+1Ky1+Ok7ncgb4g4cPb8nGHR4kSsvg1DAbYXUUWTkSj/BZF9mwKCf5
         lJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679491845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fj1ZEndN827h6H99ZndY6ISgjudYJ+QA+1NK7dJ1MKY=;
        b=kw406/sneLCgyMWSo1IyNmeopErhHpGzSiXmM6hwISPg+qDdEg6koEqk/SS4lxmNyC
         ZTzxaWR5957kQAtvpD096QROURKQH0tYoOVUgiDe2rE/llggka03ILAtR2FsL6M2PYcb
         tiNqe/myGykNZn3eDhIbsl/fAsD/siO6OxUONSSgNl9w/tkc3c9JIEUcFrRWLK1TxPez
         fbDzHVcgFeYEGSyhsmJegcI2XKS+JF5ChcBiZu+5JXNI0Fn7hr0qSMDtT/JBlVszgcOr
         G5lX91JdMjl7Xda1Lp+jStrvxbebn8X+7bRy8PSP9PG+gaj0fpRETMO4c3GgNuOmmcjt
         V64g==
X-Gm-Message-State: AAQBX9f0AD17EwU3yFB4RIhYK3uNb5JqEcTs0P5sn7shLLfNIbuHRozT
        wY8tMtlmwa3aMcoM40YFd1WEh/DIdOgNHcSJ1avdVg==
X-Google-Smtp-Source: AKy350bWFZJIkHw1dTAPTwr1WPguwRn3chvLp7222Dwm6xMXDK8TwrXNFJdroXPfKjAnjFCm6fSEeVSjJIIxXsUW6gM=
X-Received: by 2002:a25:5456:0:b0:b69:eb08:8f3b with SMTP id
 i83-20020a255456000000b00b69eb088f3bmr5910216ybb.4.1679491844680; Wed, 22 Mar
 2023 06:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <4b9fc9c6-b48c-198f-5f80-811a44737e5f@suse.cz> <CAANmLtzajny8ZK_QKVYOxLc8L9gyWG6Uu7YyL-CR-qfwphVTzg@mail.gmail.com>
 <ZBr8Gf53CbJc0b5E@hyeyoo>
In-Reply-To: <ZBr8Gf53CbJc0b5E@hyeyoo>
From:   Binder Makin <merimus@google.com>
Date:   Wed, 22 Mar 2023 09:30:32 -0400
Message-ID: <CAANmLtzQRsRHVRdMGccNK_+Ov1H_30ntWdhBJaHDBpYLzmVR6w@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] SLOB+SLAB allocators removal and future SLUB improvements
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        bpf@vger.kernel.org, linux-xfs@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Blah, sorry, lets try this.
https://docs.google.com/spreadsheets/d/e/2PACX-1vS1uiw85AIpzgcVlvNlDCD9PuCI=
ubiaJvBrKIC5OyAQURZHogOuCtpFNsC-zGHZ4-XNKJVcGgkpL-KH/pubhtml

On Wed, Mar 22, 2023 at 9:02=E2=80=AFAM Hyeonggon Yoo <42.hyeyoo@gmail.com>=
 wrote:
>
> On Wed, Mar 22, 2023 at 08:15:28AM -0400, Binder Makin wrote:
> > Was looking at SLAB removal and started by running A/B tests of SLAB vs
> > SLUB.  Please note these are only preliminary results.
> >
> > These were run using 6.1.13 configured for SLAB/SLUB.
> > Machines were standard datacenter servers.
> >
> > Hackbench shows completion time, so smaller is better.
> > On all others larger is better.
> > https://docs.google.com/spreadsheets/d/e/2PACX-1vQ47Mekl8BOp3ekCefwL6wL=
8SQiv6Qvp5avkU2ssQSh41gntjivE-aKM4PkwzkC4N_s_MxUdcsokhhz/pubhtml
> >
> > Some notes:
> > SUnreclaim and SReclaimable shows unreclaimable and reclaimable memory.
> > Substantially higher with SLUB, but I believe that is to be expected.
> >
> > Various results showing a 5-10% degradation with SLUB.  That feels
> > concerning to me, but I'm not sure what others' tolerance would be.
>
> Hello Binder,
>
> Thank you for sharing the data on which workloads
> SLUB performs worse than SLAB. This information is critical for
> improving SLUB and deprecating SLAB.
>
> By the way, it appears that the spreadsheet is currently set to private.
> Could you make it public for me to access?
>
> I am really interested in performing similar experiments on my machines
> to obtain comparable data that can be utilized to enhance SLUB.
>
> Thanks,
> Hyeonggon
>
> > redis results on AMD show some pretty bad degredations.  10-20% range
> > netpipe on Intel also has issues.. 10-17%
> >
> > On Tue, Mar 14, 2023 at 4:05=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >
> > > As you're probably aware, my plan is to get rid of SLOB and SLAB, lea=
ving
> > > only SLUB going forward. The removal of SLOB seems to be going well, =
there
> > > were no objections to the deprecation and I've posted v1 of the remov=
al
> > > itself [1] so it could be in -next soon.
> > >
> > > The immediate benefit of that is that we can allow kfree() (and
> > > kfree_rcu())
> > > to free objects from kmem_cache_alloc() - something that IIRC at leas=
t xfs
> > > people wanted in the past, and SLOB was incompatible with that.
> > >
> > > For SLAB removal I haven't yet heard any objections (but also didn't
> > > deprecate it yet) but if there are any users due to particular worklo=
ads
> > > doing better with SLAB than SLUB, we can discuss why those would regr=
ess
> > > and
> > > what can be done about that in SLUB.
> > >
> > > Once we have just one slab allocator in the kernel, we can take a clo=
ser
> > > look at what the users are missing from it that forces them to create=
 own
> > > allocators (e.g. BPF), and could be considered to be added as a gener=
ic
> > > implementation to SLUB.
> > >
> > > Thanks,
> > > Vlastimil
> > >
> > > [1] https://lore.kernel.org/all/20230310103210.22372-1-vbabka@suse.cz=
/
