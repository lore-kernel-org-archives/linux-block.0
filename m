Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43380EB64D9
	for <linux-block@archiver.kernel.org>; Tue,  4 Jul 2023 07:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGDHXL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 03:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDHXJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 03:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A5F199
        for <linux-block@vger.kernel.org>; Tue,  4 Jul 2023 00:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688455343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bdLaHXWSXyMp87ZNvGpINxLMzOcUGO2IBdu2cJPw4Wc=;
        b=cQFaZcmIfvnGB6W5O6fhNEBrBeqaQ409CKhNdqLF+cYr4NHH9iTeAPFFnDpbEwMNtbhZQ/
        yNwvtAGh7yAGqe0ZPj7TovWLOtt7irwhW4xMazZvRKB2E6xxQhDBZ984ik6k29050ky+bh
        aQ0vyvh+Lfil2nrNTXrem6GWmKT80zc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-ZHmMbL2COQyNPSFt9h5iUQ-1; Tue, 04 Jul 2023 03:22:22 -0400
X-MC-Unique: ZHmMbL2COQyNPSFt9h5iUQ-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b884781929so3806141a34.1
        for <linux-block@vger.kernel.org>; Tue, 04 Jul 2023 00:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688455342; x=1691047342;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bdLaHXWSXyMp87ZNvGpINxLMzOcUGO2IBdu2cJPw4Wc=;
        b=duQpYW+/ooR2JDcK7QYOdwoU5r2tbwz2L0HYoCihVHKVZ3o5qPSVWrJW0R2DDKooix
         TtaaWNjg5z8HmAMX8R71wzwvIxF9J8Q9F9O4BlPSpPHwVslGRp06IThVr3ZzgzLrj/za
         Rkqbh340H73O0T5a+RHmwRpeJllXWD/MBcgaruCfjJHn/wTfybaEY3koNn5V5cbDL6oV
         99bbKlVpc3oESv+q3Q2ufd79JhMFJj+Rz6VGUxKjkpC/8ZsdLULlDGMGLglS5nZspz15
         3aPDoVo5ktOds2iaN4K6lJnk0MJUQUORoimD8juZRqkW6H6/6kK8GzlMI9+877eCSS92
         cwhA==
X-Gm-Message-State: AC+VfDw+egTmLdxnFPF0HaktZbnBh+tqx84Ri9T/2/cJjIYOmgyGu+i6
        ngY7TZB7uYVctU9kVm1ui50ba40SkKuQfx5EheAsKmqRHwoVE0ZV/cA3j3KKbXWbAquYkSWNkS+
        nZU3yXjjFhAU8LZRq0Kx9jqM=
X-Received: by 2002:a05:6830:917:b0:6b5:33ea:6e11 with SMTP id v23-20020a056830091700b006b533ea6e11mr13103595ott.8.1688455341881;
        Tue, 04 Jul 2023 00:22:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+761W4uDVVsjIqNlJix6Ll+/PJrIb4pGNbUIu0+CLwqti8xzBlSixZSbq4q+BWokV5DtPBg==
X-Received: by 2002:a05:6830:917:b0:6b5:33ea:6e11 with SMTP id v23-20020a056830091700b006b533ea6e11mr13103585ott.8.1688455341661;
        Tue, 04 Jul 2023 00:22:21 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a800:faf8:1d15:affc:4ee8:6427? ([2804:1b3:a800:faf8:1d15:affc:4ee8:6427])
        by smtp.gmail.com with ESMTPSA id m9-20020a9d6449000000b006b469ace1b1sm1127509otl.22.2023.07.04.00.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:22:21 -0700 (PDT)
Message-ID: <b84ad9aa200457b1cbd5c55a7d860e685f068d7a.camel@redhat.com>
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
Date:   Tue, 04 Jul 2023 04:22:17 -0300
In-Reply-To: <CAJ6HWG6dK_-5jjoGJadOXqE=9c0Np-85r9-ymtAt241XrdwW=w@mail.gmail.com>
References: <20230520052957.798486-1-leobras@redhat.com>
         <CAJ6HWG6dK_-5jjoGJadOXqE=9c0Np-85r9-ymtAt241XrdwW=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2023-06-13 at 00:51 -0300, Leonardo Bras Soares Passos wrote:
> Friendly ping
>=20
> On Sat, May 20, 2023 at 2:30=E2=80=AFAM Leonardo Bras <leobras@redhat.com=
> wrote:
> >=20
> > Changes since RFCv1:
> > - request->csd moved to the middle of the struct, without size impact
> > - type change happens in a different patch (thanks Jens Axboe!)
> > - Improved the third patch to also update the .h file.
> >=20
> > Leonardo Bras (3):
> >   blk-mq: Move csd inside struct request so it's 32-byte aligned
> >   blk-mq: Change request->csd type to call_single_data_t
> >   smp: Change signatures to use call_single_data_t
> >=20
> >  include/linux/blk-mq.h | 10 +++++-----
> >  include/linux/smp.h    |  2 +-
> >  kernel/smp.c           |  4 ++--
> >  kernel/up.c            |  2 +-
> >  4 files changed, 9 insertions(+), 9 deletions(-)
> >=20
> > --
> > 2.40.1
> >=20

Hello Jens,

I still want your feedback on this series :)

I think I addressed every issue of RFCv1, but if you have any other feedbac=
k,
please let me know.

Thanks!
Leo

