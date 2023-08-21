Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24038EE49A4
	for <linux-block@archiver.kernel.org>; Mon, 21 Aug 2023 03:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjHUDJC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Aug 2023 23:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjHUDJB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Aug 2023 23:09:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A149A1
        for <linux-block@vger.kernel.org>; Sun, 20 Aug 2023 20:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692587300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0K3lSgVNy75NApVtTilpqgXO7eQ6PZvcXeC5v4ay/E=;
        b=LEt7PoS58Ag3jDShcRDjXq1jEt35/eH+YX1fbVtsFZ65hG+W2GT08qA8vXttlbzudf1KdM
        U+U/sLYnteZsFmk4MMyt7WW/bq+kjiDhM679+M4pMFuoHUObI1nFXnK7xiDAnGLmKq8XRf
        wxeiWNtWgOS8dD8aQrSs7aD3VaFyylc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-ZSMvmqi0MvOTe-khKORJOA-1; Sun, 20 Aug 2023 23:08:19 -0400
X-MC-Unique: ZSMvmqi0MvOTe-khKORJOA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26f3fce5b0bso903514a91.2
        for <linux-block@vger.kernel.org>; Sun, 20 Aug 2023 20:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692587298; x=1693192098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0K3lSgVNy75NApVtTilpqgXO7eQ6PZvcXeC5v4ay/E=;
        b=WXQXPZyETHpKK2LgrZJIiZWKF23NFiYt0tHwIVt44WEkJb6hOWkhi3KHH5vJgM3o1n
         B2gm8jrHbzfLNJRs3tkkIzC0M+5pDwHdCyCEd/qXzwZrsl9aCdH4aTsuwK2115guBQBO
         VcmLDFnqcq3Slu7Bb3zX/SYTFLGJpUmgBWiidHS178oRztFy560Fi2X9E8pg9txzpe2A
         4O8p0/e/StE9Pi2Ba5dAv5R6P3Jz+HkBgnlTYk4kGz4T8rRrXNnlI9d/P89k0cAPErS2
         sDeBFT34BK5EQD0OU6d6Mhd0Uz3T61rzWQiPBBuB0LG5Poowk8N4XjhskpA1HrTU1r7M
         stxQ==
X-Gm-Message-State: AOJu0YyU1abbVlDSGvEnYtg6Dg+BVU/8+sBngDf5jazvOl111WJjsmj/
        XX/cpRqVDgoC6yu6ExXBL65afRrWNIqcB172krOIviAqFnRCWyD+A+5nNuN3OZjNyf8LZZ0bQUC
        8oAyuGV4mLBLvE8LE4wCYfxfK1qSfcJyFQw0aR1o=
X-Received: by 2002:a17:90b:2348:b0:263:ac11:c6d2 with SMTP id ms8-20020a17090b234800b00263ac11c6d2mr2819604pjb.25.1692587298090;
        Sun, 20 Aug 2023 20:08:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv8ECyBDQPnvmQjSO3+v6FXa+AzDdilOFrfgVCApWUFDJlXXHn2w9yd20OFGqOTVpexGgnUdUIPIayu2DlJeE=
X-Received: by 2002:a17:90b:2348:b0:263:ac11:c6d2 with SMTP id
 ms8-20020a17090b234800b00263ac11c6d2mr2819598pjb.25.1692587297791; Sun, 20
 Aug 2023 20:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAGVVp+Xiz99dpFPn5RYjFfA-8tZH0cSvsmydB=1k08GfbViAFw@mail.gmail.com>
 <cffead50-032a-46d3-bc9e-ace6586a69d5@kernel.dk> <CAGVVp+VRcQs1qvsEeKyvmOXz=8KTybHpNDAwS9GzVMVw+FvTUg@mail.gmail.com>
 <f0c0937f-485c-d317-8bd9-b7d32ace4e1f@bytedance.com>
In-Reply-To: <f0c0937f-485c-d317-8bd9-b7d32ace4e1f@bytedance.com>
From:   Changhui Zhong <czhong@redhat.com>
Date:   Mon, 21 Aug 2023 11:08:06 +0800
Message-ID: <CAGVVp+X=sxRR15CSTr+OfzA06EojqpDeTCdBc0sQfXMiiK2EwQ@mail.gmail.com>
Subject: Re: [bug report] WARNING: CPU: 12 PID: 51497 at block/mq-deadline.c:679
 dd_exit_sched+0xd5/0xe0
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 21, 2023 at 10:36=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2023/8/21 10:17, Changhui Zhong wrote:
> > On Mon, Aug 21, 2023 at 9:56=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wr=
ote:
> >>
> >> On 8/20/23 7:43 PM, Changhui Zhong wrote:
> >>> Hello,
> >>>
> >>> triggered below warning issue with branch 'block-6.5',
> >>
> >> What sha? Please always include that in bug reports, people don't know
> >> when you pulled it.
> >>
> >
> > ok,I pulled the whole branch of block-6.5, I don't know which patch
> > caused the issue=EF=BC=8Cthe HEAD is=EF=BC=9A
>
> Hi, this problem should be fixed in the latest block-6.5 branch,
> specifically including this commit:
>
> commit e5c0ca13659e9d18f53368d651ed7e6e433ec1cf
>
>     blk-mq: release scheduler resource when request completes
>
>
> Could you please help to check again?


ok,I will try the current branch  block-6.5

>
>
> Thanks!
>

