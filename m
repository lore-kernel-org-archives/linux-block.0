Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C924C77B72
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 19:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjDKTNn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 15:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDKTNm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 15:13:42 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C78946A3
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 12:13:38 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54f21cdfadbso125741517b3.7
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681240417; x=1683832417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyhAcQmoHbAJmyI6qNybDWX+d0nq9TvXS/75WN8UzuA=;
        b=S2f+5gKCSSzDOMOS6mIOicl0bR1GjNPjs24KWw1ZqU8L7QMlPQQKweyrpx5vW1RjKJ
         5C38HUdsLCTBSys6gc60xF1N+O6daogXQypFY+aquyajA0zIHayA7/np0IYE7V0ZR5+a
         /o7LaS9b5UhjtAIy1W81O6uUXzYpim0EndlWb+spMWkfdCb/H3gLY6I0J64z2Rz0fxC4
         2Y9gbJ32KP6PeX1M/X5Cm1TfxUBa4YbdGtJiZypDJyIv+sjJpbeQJhWqfdJX638mi0VU
         ua2nLslyeNXA3wus84B/BahgSozqvbNONWUP+NQxRKQwiJFyeDl0ursSU+XFZKPSwzmq
         T5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681240417; x=1683832417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyhAcQmoHbAJmyI6qNybDWX+d0nq9TvXS/75WN8UzuA=;
        b=bYwMZ3txnnWcsE2HbnarTjHbxDOUOmSuogx19WkXBct7Zx40Triy+ysmA5Btn5294P
         YOsMSV6666TXH0LiZ3s1nbrKYn+AKWa39tIe25V8Or1b753lf2RHbPoWE5DCzmEBXEOa
         uKQt3T3YZCKU7sZL6GUrUPGnablIjGw+LIIk7Pe9pG7HgNPdWNpcx8cn+D4G3ztFjWEK
         6+2i7svmttX+e4Wl5VIXqbFTRpROwxOGqUFv5lLMUBtvucTix8W3M/CZc89z99JyMCz3
         9e4Dobo2X2p/ulrOYw4HDFPYeIMNnUpV+SM67wEGL1U4mAcLDpY0JLEOYcBMpnWt6kWU
         M8rQ==
X-Gm-Message-State: AAQBX9cA4ZNbs5PaH6tCmZhcwvh8PdA39sAkt3W6dSJ3qa95ri4y4s4q
        HsPJK32equ8E8LcMlegsfU8oGLpyjvOoefWqtww/
X-Google-Smtp-Source: AKy350azG2i8uc9BAHp/wk8VSvxtJ0aqfSk9gTsrxDzJOGJbd8PZzFADbtv5hxGRkczUVNGtVCqIHdlrFObziFErZeI=
X-Received: by 2002:a81:a904:0:b0:54f:2b65:a865 with SMTP id
 g4-20020a81a904000000b0054f2b65a865mr4260299ywh.8.1681240417154; Tue, 11 Apr
 2023 12:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <1675119451-23180-1-git-send-email-wufan@linux.microsoft.com>
 <1675119451-23180-3-git-send-email-wufan@linux.microsoft.com>
 <CAHC9VhRguGeb8=oNVFebshL_2LLZ4hf0qO97YBVm8OObLsLNTw@mail.gmail.com> <20230406200055.GB19196@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230406200055.GB19196@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Apr 2023 15:13:26 -0400
Message-ID: <CAHC9VhTkEHvoSFu8h=tuGJAjPhohj7ABPi+XXVg4j5MesCbtxw@mail.gmail.com>
Subject: Re: [RFC PATCH v9 02/16] ipe: add policy parser
To:     Fan Wu <wufan@linux.microsoft.com>
Cc:     corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
        axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        eparis@redhat.com, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, linux-audit@redhat.com,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 6, 2023 at 4:00=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> w=
rote:
> On Thu, Mar 02, 2023 at 02:02:32PM -0500, Paul Moore wrote:
> > On Mon, Jan 30, 2023 at 5:58???PM Fan Wu <wufan@linux.microsoft.com> wr=
ote:
> > >
> > > From: Deven Bowers <deven.desai@linux.microsoft.com>
> > >
> > > IPE's interpretation of the what the user trusts is accomplished thro=
ugh
> > > its policy. IPE's design is to not provide support for a single trust
> > > provider, but to support multiple providers to enable the end-user to
> > > choose the best one to seek their needs.
> > >
> > > This requires the policy to be rather flexible and modular so that
> > > integrity providers, like fs-verity, dm-verity, dm-integrity, or
> > > some other system, can plug into the policy with minimal code changes=
.
> > >
> > > Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> > > Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> >
> > ...
> >
> > > ---
> > >  security/ipe/Makefile        |   2 +
> > >  security/ipe/policy.c        |  99 +++++++
> > >  security/ipe/policy.h        |  77 ++++++
> > >  security/ipe/policy_parser.c | 515 +++++++++++++++++++++++++++++++++=
++
> > >  security/ipe/policy_parser.h |  11 +
> > >  5 files changed, 704 insertions(+)
> > >  create mode 100644 security/ipe/policy.c
> > >  create mode 100644 security/ipe/policy.h
> > >  create mode 100644 security/ipe/policy_parser.c
> > >  create mode 100644 security/ipe/policy_parser.h

...

> > > diff --git a/security/ipe/policy_parser.c b/security/ipe/policy_parse=
r.c
> > > new file mode 100644
> > > index 000000000000..c7ba0e865366
> > > --- /dev/null
> > > +++ b/security/ipe/policy_parser.c
> > > @@ -0,0 +1,515 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) Microsoft Corporation. All rights reserved.
> > > + */
> > > +
> > > +#include "policy.h"
> > > +#include "policy_parser.h"
> > > +#include "digest.h"
> > > +
> > > +#include <linux/parser.h>
> > > +
> > > +#define START_COMMENT  '#'
> > > +
> > > +/**
> > > + * new_parsed_policy - Allocate and initialize a parsed policy.
> > > + *
> > > + * Return:
> > > + * * !IS_ERR   - OK
> > > + * * -ENOMEM   - Out of memory
> > > + */
> > > +static struct ipe_parsed_policy *new_parsed_policy(void)
> > > +{
> > > +       size_t i =3D 0;
> > > +       struct ipe_parsed_policy *p =3D NULL;
> > > +       struct ipe_op_table *t =3D NULL;
> > > +
> > > +       p =3D kzalloc(sizeof(*p), GFP_KERNEL);
> > > +       if (!p)
> > > +               return ERR_PTR(-ENOMEM);
> > > +
> > > +       p->global_default_action =3D ipe_action_max;
> >
> > I'm assuming you're using the "ipe_action_max" as an intentional bogus
> > placeholder value here, yes?  If that is the case, have you considered
> > creating an "invalid" enum with an explicit zero value to save you
> > this additional assignment (you are already using kzalloc())?  For
> > example:
> >
> >   enum ipe_op_type {
> >     IPE_OP_INVALID =3D 0,
> >     IPE_OP_EXEC,
> >     ...
> >     IPE_OP_MAX,
> >   };
> >
> >   enum ipe_action_type {
> >     IPE_ACTION_INVALID =3D 0,
> >     IPE_ACTION_ALLOW,
> >     ...
> >     IPE_ACTION_MAX,
> >   };
> >
>
> Yes, IPE_ACTION_MAX is kind of the INVALID value we are using here.
>
> But I think we might be adding unnecessary complexity by using the
> IPE_OP_INVLIAD enum here. Currently, we are using IPE_OP_MAX to
> represent the number of operations we have, and we have allocated
> an IPE_OP_MAX-sized array to store linked lists that link all rules
> for each operation. If we were to add IPE_OP_INVLIAD to the enum
> definition, then IPE_OP_MAX-1 would become the number of operations,
> and we would need to change the index used to access the linked list
> array.

Gotcha.  Thanks for the explanation, that hadn't occurred to me while
I was reviewing the code.

Another option would be to create a macro to help reinforce that the
"max" value is being used as an "invalid" value, for example:

#define IPE_OP_INVALID IPE_OP_MAX

--=20
paul-moore.com
