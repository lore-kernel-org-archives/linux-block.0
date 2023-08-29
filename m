Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05ACC71153
	for <linux-block@archiver.kernel.org>; Tue, 29 Aug 2023 00:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbjH2A5F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Aug 2023 20:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjH2A4z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Aug 2023 20:56:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEB3124
        for <linux-block@vger.kernel.org>; Mon, 28 Aug 2023 17:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693270566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsCS4Saz7XJ/AO8lGkQ98m+HzcdDjapam8XYjy+GN00=;
        b=busECbQQR3GM5eZyE/yE5hGJtjogZJcXdrbGHe2yGncK+SDPVrM+g2qqyjb45+jskFntXc
        ZLe/qhfYZkfg5y2DNHtRKF/av4BJOCKj9LUWAGe6BvyfQnbhyb/4sWfUMO3hjl+YJjzlP2
        iJIXyfEkDG33KjBpYHYXM8/DX0WmTs4=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-VJniLZN3OCyIU1mSaFo4LQ-1; Mon, 28 Aug 2023 20:56:04 -0400
X-MC-Unique: VJniLZN3OCyIU1mSaFo4LQ-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1c0ed6a6df5so4575156fac.1
        for <linux-block@vger.kernel.org>; Mon, 28 Aug 2023 17:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693270564; x=1693875364;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TsCS4Saz7XJ/AO8lGkQ98m+HzcdDjapam8XYjy+GN00=;
        b=EnnK9qEypw0ZYigvRTnD6ik6qV1hm4NrMT3C+bxthQbA9eKaNfHYejigET6aiVA54w
         rZpsdoVY+3glV1fdT/7GACk3BRfUIVYCWnfHwZuPcbjlLRgL+sCKJXCZryA5LOb/9McH
         q0lRA7xQImLBRZr+AbuyzWyD29mICLFFmujV96+DCbmUFcKFHCS2UIZHSm3RAgtZSnNU
         /xnaYYVYkndwVE2ZOKIhGAbWbI3fS44aFsbj2uraRsdsrmh6wBxCRQR24jnFIl5UVi6k
         Ed0/9M8obi3UxN1bNYwSwEeWB1xk4NLFKo2NKj8NyN49WnL2Ixi1TYT6RHkueFLIMi5Z
         TnGw==
X-Gm-Message-State: AOJu0Yzlg/tDwpqJY6sl4wICXOA5uPsCXMShoDCZ3pP3a+y4cFmrgFSJ
        vlbQTRH0riZmFIy/zxameTorOYS7jsOACNxTU1QowTAE2ONbXx8IVDgMJoLln3HFMyHS5hlB1Fe
        OPB1bN2jkFbNMgXslsWB4zzk=
X-Received: by 2002:a05:6871:6a9:b0:1c8:bfd1:ecb8 with SMTP id l41-20020a05687106a900b001c8bfd1ecb8mr14029331oao.30.1693270563767;
        Mon, 28 Aug 2023 17:56:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH99L/GJlPzzKJakqdR1VW77qqM+gVjCsypWEmExtGalGdQ02IIkeJB2oJ06A5aWe+HL23ziA==
X-Received: by 2002:a05:6871:6a9:b0:1c8:bfd1:ecb8 with SMTP id l41-20020a05687106a900b001c8bfd1ecb8mr14029312oao.30.1693270563512;
        Mon, 28 Aug 2023 17:56:03 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a802:98e3:3c98:3d83:9703:4411? ([2804:1b3:a802:98e3:3c98:3d83:9703:4411])
        by smtp.gmail.com with ESMTPSA id ck3-20020a05687c048300b001b3538afd01sm4905729oac.51.2023.08.28.17.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 17:56:02 -0700 (PDT)
Message-ID: <1cd98cb37dcf621520e52ac7a15513aab5749534.camel@redhat.com>
Subject: Re: [RFC PATCH v2 0/3] Move usages of struct __call_single_data to
 call_single_data_t
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 28 Aug 2023 21:55:58 -0300
In-Reply-To: <b84ad9aa200457b1cbd5c55a7d860e685f068d7a.camel@redhat.com>
References: <20230520052957.798486-1-leobras@redhat.com>
         <CAJ6HWG6dK_-5jjoGJadOXqE=9c0Np-85r9-ymtAt241XrdwW=w@mail.gmail.com>
         <b84ad9aa200457b1cbd5c55a7d860e685f068d7a.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2023-07-04 at 04:22 -0300, Leonardo Br=C3=A1s wrote:
> On Tue, 2023-06-13 at 00:51 -0300, Leonardo Bras Soares Passos wrote:
> > Friendly ping
> >=20
> > On Sat, May 20, 2023 at 2:30=E2=80=AFAM Leonardo Bras <leobras@redhat.c=
om> wrote:
> > >=20
> > > Changes since RFCv1:
> > > - request->csd moved to the middle of the struct, without size impact
> > > - type change happens in a different patch (thanks Jens Axboe!)
> > > - Improved the third patch to also update the .h file.
> > >=20
> > > Leonardo Bras (3):
> > >   blk-mq: Move csd inside struct request so it's 32-byte aligned
> > >   blk-mq: Change request->csd type to call_single_data_t
> > >   smp: Change signatures to use call_single_data_t
> > >=20
> > >  include/linux/blk-mq.h | 10 +++++-----
> > >  include/linux/smp.h    |  2 +-
> > >  kernel/smp.c           |  4 ++--
> > >  kernel/up.c            |  2 +-
> > >  4 files changed, 9 insertions(+), 9 deletions(-)
> > >=20
> > > --
> > > 2.40.1
> > >=20
>=20
> Hello Jens,
>=20
> I still want your feedback on this series :)
>=20
> I think I addressed every issue of RFCv1, but if you have any other feedb=
ack,
> please let me know.
>=20
> Thanks!
> Leo

Hello Jens Axboe,

Please provide feedback on this series!

Are you ok with those changes?
What's your opinion on them?=20

Thanks!
Leo

