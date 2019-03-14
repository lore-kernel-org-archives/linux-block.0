Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0AFC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860D62184C
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="gEZWdUla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfCNQP2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:15:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56104 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfCNQP2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 12:15:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so3612258wmf.5
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1ISUeNh72ONMqMRqy4Bb2sjGisIJL4lyuhKFUZ5ugZI=;
        b=gEZWdUlaRhIQHvvre3jWTj7jLamG1e2WK+qDYKpeB80Nw782C9NFv140uxGytbtH1g
         rljzSNPycaZbcc3NoQ58YrJzehccrSzBXhl9msC/VDItxI/bpRO06F3jnP9r1Gb+6uCJ
         BuVnXqks5ld9PGvPVBA3+XpXt1WQ9aCWJE06V54ShSu2VWvPZPKmZ2VkBmF5IvhZ/Omf
         coUdx09AMJDVNNoSnsVYaabY76Ut94Vsk2N/JBC/TP90iKuP4aqyJGE2r3Ptc1Z3qAxv
         +RMBBkVZ9LD9Y99jR6y1vdXnvuOuN/UQbmi2Y9ihKPDgLoJ9T0ngh7jKqq8Tf2TQSQwf
         rt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1ISUeNh72ONMqMRqy4Bb2sjGisIJL4lyuhKFUZ5ugZI=;
        b=fqhnKD3hc+djh/QGm/0Q+tE/guDm0sHPEtXKhGpOqf15cpVysTljkL9SJCam0kb8dS
         LWKul4Ynyq4vrX3sHztS+vYOaiwYph9DvWeHJaRZaxy34FiY9hgeXxEllx9oKJB9fU9C
         lWs2UZdNPjPjjNE4xZhVWY/poejR3limDyUHmBIW7Gcpewk7iyrhoNR+o6lh/ia1XcAC
         RiN8kOTC7nvlXT6OgZS+Hbl1ufwSOLcQkbGDBN1PvrJLUtWok5Qyqu/VldzT2BA9sEDw
         lckJsFd+3XiElu/fxJTV12DKg5KO/SYzxoXmZ/FZXJwbiBx9FIKNQpHHyzSBZlNwr89l
         tdPw==
X-Gm-Message-State: APjAAAWg61NXZLp0XjTh22U0bsqDS9lVkTu6TvKrWbhGI0wvoaq3xnUx
        W86HkDqZLs4Vgfe5xyAiU7mzG73fyzK/C6Byt9D++Q==
X-Google-Smtp-Source: APXvYqzaOl2K6oXkx6toYWYMf0lCcoqlLG7BFaiWf/v0QTPXPGnDoa/ClydXU4TrADlJxVOcWFt4WK88x8LXxAwNFz4=
X-Received: by 2002:a1c:cc0c:: with SMTP id h12mr3387280wmb.140.1552580126550;
 Thu, 14 Mar 2019 09:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190314111637.20236-1-hans@owltronix.com> <103c19f4-02a2-f54c-13f8-30bc5447426e@intel.com>
 <FE25456B-A63E-4601-960D-96F519250B8C@javigon.com>
In-Reply-To: <FE25456B-A63E-4601-960D-96F519250B8C@javigon.com>
From:   Heiner Litz <hlitz@ucsc.edu>
Date:   Thu, 14 Mar 2019 09:14:58 -0700
Message-ID: <CAJbgVnU2RXK4ci79n0szwTpZ+UB2zx977PHo1ie7h5y5kJrbhQ@mail.gmail.com>
Subject: Re: [PATCH RFC] lightnvm: pblk: fix crash in pblk_end_partial_read
 due to multipage bvecs
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Hans Holmberg <hans@owltronix.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 14, 2019 at 7:16 AM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
>
> > On 14 Mar 2019, at 06.49, Igor Konopko <igor.j.konopko@intel.com> wrote=
:
> >
> > While reading this patch, idea came to my mind - maybe it would be simp=
ly better to get rid of partial read handling from pblk in current form at =
all and use bio_split() & bio_chain() combination instead?
> >
> > This would definitely reduce a number of this 'kind of complicated' cod=
e inside pblk and let block layer help us with that. Even that the performa=
nce of such a requests could be a little worse (few smaller IOs instead of =
single vector IO), I believe that partial read is more a corner case, then =
a typical use case, so maybe this would be a path to go.
> >
> > Let me know what you think about such an approach - I can make a patch =
with that if you want.

I like this idea as it will clean up a lot of code and get rid of the
read_bitmap.
Note that a single request can be turned into up to 32 requests if
cached and non-cached sectors alternate, each one probably requiring
an l2p lookup. I still think it's worth doing though.
When you split, note that you have to release all line_refs which were
acquired during l2p lookup.

>
> I agree with Igor.
>
> As I mentioned offline, we should fix this in a way that survives
> further changes in struct bio; either making pblk handling visible to
> the outside or rethinking the whole thing.
>
> Igor: If you can send a patch you mention, it would be great. I have
> been trying the helper approach for some time, but it is too specific,
> as fixing holes in the bvec breaks the bio advance-only semantics. Your
> approach seems much better.
>
> Thanks,
> Javier
