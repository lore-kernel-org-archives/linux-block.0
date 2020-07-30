Return-Path: <SRS0=0pY0=BJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9779BC433E0
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 20:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A1212074B
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 20:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgG3UpV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:45:21 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:33665 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbgG3UpV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 16:45:21 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M6lYs-1k8OYb2gtq-008McS; Thu, 30 Jul 2020 22:45:19 +0200
Received: by mail-qt1-f181.google.com with SMTP id k18so21393727qtm.10;
        Thu, 30 Jul 2020 13:45:19 -0700 (PDT)
X-Gm-Message-State: AOAM531J2zhpQnBnSWy7WpypqOSy3L7fHv9AgaQCkKFsPxJO7hqJAoLM
        rIFLexxTo/WXqqRM2SXwJ1ajKKLRGxEtFVcZ62Q=
X-Google-Smtp-Source: ABdhPJwwPO9hZwLZNagtwDmktY5mx1mcmsBMR1k9OLKFMguOZRxKmQmtyn1wb9YuRx7t2pYE3m7tLxnTNippxiVQFmY=
X-Received: by 2002:ac8:688e:: with SMTP id m14mr527498qtq.7.1596141918397;
 Thu, 30 Jul 2020 13:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200728141946.426245-1-yepeilin.cs@gmail.com>
 <20200729115157.8519-1-yepeilin.cs@gmail.com> <20200729125820.GB1840@kadam>
 <f2cf6137-987a-ab41-d88a-6828d46c255f@linux.com> <CAK8P3a20SEoYCrp3jOK32oZc9OkiPv+1KTjNZ2GxLbHpY4WexQ@mail.gmail.com>
 <202007301056.D3BD1805B0@keescook>
In-Reply-To: <202007301056.D3BD1805B0@keescook>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Jul 2020 22:45:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2oUgdaYicdHwWvCY-HqjrcBAEzYA5yc5Gw14RLLoLdug@mail.gmail.com>
Message-ID: <CAK8P3a2oUgdaYicdHwWvCY-HqjrcBAEzYA5yc5Gw14RLLoLdug@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] [PATCH v2] block/floppy: Prevent
 kernel-infoleak in raw_cmd_copyout()
To:     Kees Cook <keescook@chromium.org>
Cc:     Denis Efremov <efremov@linux.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3L5qp2rCNnf3YKbaKvTM/I14TgkbxDLotK+kqGmDy5kv4EqWsvY
 3YK9zFJKiRQNiKkcEWviVvPXF2YKH9azX3merS/u7E5ku0lGK2BEe6BuWGv7kY5h5FlIikK
 YUCRJcPj1GqQ9yFyjA1YYd4Tx3YaLrrASAx2OPJt7Nc46c/Df2RhdUBV3jNqAkc7PhvNDJf
 gMZxAXzaYFpayG0pNqxwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/5YeVEoM2Sg=:nT7UgV1osmuaiQ4kDFWQPL
 nd3TosOlVgCBOmD3RUGWJN22gSmwUE7EKzPxDnZy7ekwzA/kjt034CrsBrKVcd011YdfhXdxa
 q7XCmk/Z57h7/21fuXc0gQj9JC6w0qaz84NiveAb0Ahw6tbt04iIQmVFjfojovGrZtwwCk9M8
 A7TCkJK426vPExANzFKy3+TNNs/NvRbZ1e5VgGLg1/7AyaIkZh7zDl4M0FCEGzMvH1ETYh1pe
 e8IkSj64NP1KycYRc5yymYVUOAhaze3Y1a4BaszFwnuNQY/UYoLNywDADLdau7LS8hEtXfQ+6
 gSs8z3CwtnIL03aeIEKWQ5k5XfdTmHnhBGl+eaL2XMkmfmh6r2tLBibQvXwPuZ5d2j7LMQ2vn
 SdKAVDvQcwFJvs5eIsmJhiKApw8IPfgKRcJtn39eYtNjyqdD2IPYpNrdmGXTP6eFBtf9/FJUV
 DIdgVzo9ye8+OIySluFU/GLu6r+gcKlJj9GiieJPkeScAs3JZpOXqdpqXZJEmpQOdyTSPcRzQ
 TQqe9XaM+I+APLPH0Er3tpa9AzL/sjRhvs2aSKDBLcnOBvKC2Du/Gw0jsfwwWokEWkeaeXVNr
 QtQmgSUi7PYw9psITg799Hsje4dzEpR2DvOFqgPpF5Y69q7SlLtQx/u2bRVKHhYyxvQV2M8XV
 /3PSmXZRV642274DUpzIOyREZMx4UM6M3wH3iLoTewvi+t2G/42R5xqLc3Tno3mOum5iqjsqI
 XVTOKmvaAaQMbvpwCWHvrg7ObrNx8eNfViX3R2nEMFe66FQPBeZ0VwX6hqelpkssMcdZnaGJh
 NvlMHyamLX64dCEs5JvR/NsRkbrSIuxQLzUnfgad65ZVdtK2MbwKdHB34iXBQKbKQgaj4gS
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 30, 2020 at 8:10 PM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Jul 30, 2020 at 10:11:07AM +0200, Arnd Bergmann wrote:
>
> test_stackinit.c intended to use six cases (where "full" is in the sense
> of "all members are named", this is intentionally testing the behavior
> of padding hole initialization):

Ok, so I read that correctly, thanks for confirming.

> >
> >    struct test_big_hole var = *arg;
>
> So this one is a "whole structure copy" which I didn't have any tests
> for, since I'd (perhaps inappropriately) assumed would be accomplished
> with memcpy() internally, which means the incoming "*arg"'s padding holes
> would be copied as-is. If the compiler is actually doing per-member copies
> and leaving holes in "var" untouched, that's unexpected, so clearly that
> needs to be added to test_stackinit.c! :)

For some reason I remembered this not turning into a memcpy()
somewhere, but I can't reproduce it in any of my recent attempts,
just like what Denis found.

> > or the a constructor like
> >
> >   struct test_big_hole var;
> >   var = (struct test_big_hole){ .one = arg->one, .two=arg->two, .three
> > = arg->three, .four = arg->four };
> >
> > Kees, do you know whether those two would behave differently?
> > Would it make sense to also check for those, or am I perhaps
> > misreading your code and it already gets checked?
>
> I *think* the above constructor would be covered under "full runtime
> init", but it does also seem likely it would be handled similarly to
> the "whole structure copy" in the previous example.

I would assume that at least with C99 it is more like the
"whole structure copy", based on the standard language of

  "The value of the compound literal is that of an unnamed
  object initialized by the initializer list. If the compound literal
  occurs outside the body of a function, the object has static
  storage duration; otherwise, it has automatic storage duration
  associated with the enclosing block."

> I will go add more tests...

Thanks!

         Arnd
