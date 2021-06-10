Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56261C47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 09:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3229861407
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 09:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFJJVH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhFJJVG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 05:21:06 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315D7C061574;
        Thu, 10 Jun 2021 02:18:56 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id w14so1175223ilv.1;
        Thu, 10 Jun 2021 02:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QfwVCoi6ayQqADlUdXMFpYCGJg5/Zxbp6NlanrqRIxo=;
        b=p3p1rnxHxD+cZOJ7ZzKuuuBViilPrNvp4A8g246DBAATujj8LIRWWlxkNGGghJlqeN
         PxW+XY5gtJ4/WTYGiUr2I8aQliE+5AfwnH83NE7YvToW4P/ibydU0Ze04hdr5QufIvVk
         vHQkdqmeARkqyG/ypR48CsR8pmGUJ3VctqR0DflJhjjwNvQfPkDuG2FA+ExKQZOzjOI7
         q+8sPYt1I5EcsDOHSbiKzl8vNtYbAqopeEG0Ly/0UfG8HOpWZ1aeqhvzdjEZoZqgZYFw
         J9bCmhsEGm6GHsbwsNWY+nPEINj9GJ7GAI/dN+WzlMChUm+CwEXOrSMZLAT3two9vO4S
         auLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QfwVCoi6ayQqADlUdXMFpYCGJg5/Zxbp6NlanrqRIxo=;
        b=t3dKSeKWUZG3WdAp7jvp4W35eVMGZGkLk/R/vGuD/opoxmR8Yn3SC6IPq08tapsmXy
         h6nh2plZ1VCJLiezTYgSzssnQwq+Fv4cHwiCRQRfhGI8kaLzxAceY7Stscri8ibmwl53
         MX6u8c6zU60cC8Fy2gV5v09g0+lji2YA4LUuML9tf+p3qU9aPyHy55csVrMUIe3RfUDB
         gfdUmzRqOzkf6Cf1/Rrcl1PvG21nvzu9mXBTMUv1hQ+jGM7YFzM+sWJpH8hzBAjGVY7c
         oW9kje/TybXEga240HZ8KWTqiGfDRmHPYOHT2PMSrUfTuGefOjh77Z4/Abxw0aPTFfC4
         Qzgg==
X-Gm-Message-State: AOAM533JcF/ym8N/XRkssmk1hpbGF30XbYLFLXRN03z5vbcI+ucFU/vo
        QWa+bZltq7uQkOlrH66caAPPALxReGWT0WPrIxM=
X-Google-Smtp-Source: ABdhPJxTN3jIulm+V5g9Zs3FBf3qUGlNdBWAK5dIgGzwEGWqmCoWiOkFxXlymZYZPpAlIQ4OxEHieZaVjKn9ymIrvWU=
X-Received: by 2002:a05:6e02:1c44:: with SMTP id d4mr3082200ilg.49.1623316735609;
 Thu, 10 Jun 2021 02:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1618916839.git.brookxu@tencent.com> <20210610072230.TAxxdh-wsL4sihK2TJxF-Gz85ZgsFR7IwOuifnxFi0k@z>
 <20210610083147.xoefokucl5ey7v32@spock.localdomain>
In-Reply-To: <20210610083147.xoefokucl5ey7v32@spock.localdomain>
From:   =?UTF-8?Q?Piotr_G=C3=B3rski?= <lucjan.lucjanov@gmail.com>
Date:   Thu, 10 Jun 2021 11:18:44 +0200
Message-ID: <CAL2Yj0T70SBPfHLz0GUn7C7PF=i9pS5JD7TzOJhRaNFQN3U0dQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/8] bfq: introduce bfq_entity_to_bfqg helper method
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     brookxu <brookxu.cn@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Tested-by: Piotr Gorski <lucjan.lucjanov@gmail.com>

I have been testing this since the first release and have not noticed
any irregularities.

czw., 10 cze 2021 o 10:31 Oleksandr Natalenko
<oleksandr@natalenko.name> napisa=C5=82(a):
>
> Hello.
>
> On Thu, Jun 10, 2021 at 03:22:30PM +0800, brookxu wrote:
> > From: Chunguang Xu <brookxu@tencent.com>
> >
> > Introduce bfq_entity_to_bfqg() to make it easier to obtain the
> > bfq_group corresponding to the entity.
> >
> > Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> > ---
> >  block/bfq-cgroup.c  |  6 ++----
> >  block/bfq-iosched.h |  1 +
> >  block/bfq-wf2q.c    | 16 ++++++++++++----
> >  3 files changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> > index b791e20..a5f544a 100644
> > --- a/block/bfq-cgroup.c
> > +++ b/block/bfq-cgroup.c
> > @@ -309,8 +309,7 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq=
)
> >  {
> >       struct bfq_entity *group_entity =3D bfqq->entity.parent;
> >
> > -     return group_entity ? container_of(group_entity, struct bfq_group=
,
> > -                                        entity) :
> > +     return group_entity ? bfq_entity_to_bfqg(group_entity) :
> >                             bfqq->bfqd->root_group;
> >  }
> >
> > @@ -610,8 +609,7 @@ struct bfq_group *bfq_find_set_group(struct bfq_dat=
a *bfqd,
> >        */
> >       entity =3D &bfqg->entity;
> >       for_each_entity(entity) {
> > -             struct bfq_group *curr_bfqg =3D container_of(entity,
> > -                                             struct bfq_group, entity)=
;
> > +             struct bfq_group *curr_bfqg =3D bfq_entity_to_bfqg(entity=
);
> >               if (curr_bfqg !=3D bfqd->root_group) {
> >                       parent =3D bfqg_parent(curr_bfqg);
> >                       if (!parent)
> > diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> > index b8e793c..a6f98e9 100644
> > --- a/block/bfq-iosched.h
> > +++ b/block/bfq-iosched.h
> > @@ -941,6 +941,7 @@ struct bfq_group {
> >  #endif
> >
> >  struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
> > +struct bfq_group *bfq_entity_to_bfqg(struct bfq_entity *entity);
> >
> >  /* --------------- main algorithm interface ----------------- */
> >
> > diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> > index 070e34a..5ff0028 100644
> > --- a/block/bfq-wf2q.c
> > +++ b/block/bfq-wf2q.c
> > @@ -149,7 +149,7 @@ struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue=
 *bfqq)
> >       if (!group_entity)
> >               group_entity =3D &bfqq->bfqd->root_group->entity;
> >
> > -     return container_of(group_entity, struct bfq_group, entity);
> > +     return bfq_entity_to_bfqg(group_entity);
> >  }
> >
> >  /*
> > @@ -208,7 +208,7 @@ static bool bfq_no_longer_next_in_service(struct bf=
q_entity *entity)
> >       if (bfq_entity_to_bfqq(entity))
> >               return true;
> >
> > -     bfqg =3D container_of(entity, struct bfq_group, entity);
> > +     bfqg =3D bfq_entity_to_bfqg(entity);
> >
> >       /*
> >        * The field active_entities does not always contain the
> > @@ -266,6 +266,15 @@ struct bfq_queue *bfq_entity_to_bfqq(struct bfq_en=
tity *entity)
> >       return bfqq;
> >  }
> >
> > +struct bfq_group *bfq_entity_to_bfqg(struct bfq_entity *entity)
> > +{
> > +     struct bfq_group *bfqg =3D NULL;
> > +
> > +     if (entity->my_sched_data)
> > +             bfqg =3D container_of(entity, struct bfq_group, entity);
> > +
> > +     return bfqg;
> > +}
> >
> >  /**
> >   * bfq_delta - map service into the virtual time domain.
> > @@ -1001,8 +1010,7 @@ static void __bfq_activate_entity(struct bfq_enti=
ty *entity,
> >
> >  #ifdef CONFIG_BFQ_GROUP_IOSCHED
> >       if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
> > -             struct bfq_group *bfqg =3D
> > -                     container_of(entity, struct bfq_group, entity);
> > +             struct bfq_group *bfqg =3D bfq_entity_to_bfqg(entity);
> >               struct bfq_data *bfqd =3D bfqg->bfqd;
> >
> >               if (!entity->in_groups_with_pending_reqs) {
> > --
> > 1.8.3.1
> >
>
> If it is a resend only, I can offer my Tested-by since I'm running this
> series for quite some time already.
>
> Thanks.
>
> --
>   Oleksandr Natalenko (post-factum)
