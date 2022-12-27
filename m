Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECECFC10F1B
	for <linux-block@archiver.kernel.org>; Tue, 27 Dec 2022 08:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiL0Ibt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Dec 2022 03:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiL0Ibs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2022 03:31:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969ECEB3
        for <linux-block@vger.kernel.org>; Tue, 27 Dec 2022 00:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672129864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ygKNifxpSWPvq9Kf37Ke59UL2kQv6QyF7TgCsh4wyxM=;
        b=IPw6h04hEhlGC9fw9PzMYmnJx+6b+SGS/EbM5u3ByRubD7oM3D8Pw4btBOg03c1l0PbMXp
        C2ColfjzyEPqZafvlsEsWbcnPy3GXgB6gHhE7uIvkdqDOOtkqsJMtkdRIWZBYfJC06KvsK
        Jxa+bmEqLnDIY3Ntzhq6hDpub2iGruY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-491-4wcW4tyjPNWiw_pXPgiW3A-1; Tue, 27 Dec 2022 03:31:02 -0500
X-MC-Unique: 4wcW4tyjPNWiw_pXPgiW3A-1
Received: by mail-ed1-f71.google.com with SMTP id b15-20020a056402350f00b0048477a5114bso3279962edd.2
        for <linux-block@vger.kernel.org>; Tue, 27 Dec 2022 00:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygKNifxpSWPvq9Kf37Ke59UL2kQv6QyF7TgCsh4wyxM=;
        b=wSfn5opFVkNgG3G+0zsqbaJDpfI6IQb1cCn4Qck1C1981iI9ZRnbk2oL26HUlwqAou
         agXeU13hbmbRI//6ryxP+EKhEjDrht/WVAJS2EcxUNFP7p+MJHZQBEpF3gnAM1g3Shnr
         byj8OwIS1Hzr1f+ns+9h6E8ArcNJ2MRVNnaIu8zWn37toUGHBC/J2T8o2KWKNjJi1sut
         LIo73UVKfxSHmhWKQH6jigPpsCQ+oPU4wCimLWOJvYxmg7LJEd053QLQxI86zlzGE+3W
         OSaK2EjzQTa7zgDGENFgcOnqWMj7Qds1NAPU0bAwDqt/QZdwa7nzMy2Jj8rtTvkB7o5S
         6/4w==
X-Gm-Message-State: AFqh2koCtbOur5npCQ9jVxRMld/pn6ZACHZqN+NTlRfk4HUp2DTAI187
        CsdXodEto+SlNp/G8vFOdzMUS2xwvil5wumTmB8W9s3blze+TslkDo9/LzZBu83ZmHBEQNbERfg
        kVtRB/8JDuoPaPyxbW0qf+5yJUtTYlSqSbVcCzVM=
X-Received: by 2002:a17:906:49d3:b0:7c0:a321:8df2 with SMTP id w19-20020a17090649d300b007c0a3218df2mr1794539ejv.308.1672129861628;
        Tue, 27 Dec 2022 00:31:01 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvIhAX3krYNuQU37+ASVlX/C/fVCDZeCg1Sixb/qTlxnqFt+3YXi68lmZIVprAYvWM5zO7hhv5IoMJWZ9wdFvY=
X-Received: by 2002:a17:906:49d3:b0:7c0:a321:8df2 with SMTP id
 w19-20020a17090649d300b007c0a3218df2mr1794503ejv.308.1672129861448; Tue, 27
 Dec 2022 00:31:01 -0800 (PST)
MIME-Version: 1.0
References: <CAGVVp+WS5aHiF2Odc-C+fO56qKyV7vPsPRz35v9eWsPJDNj=ng@mail.gmail.com>
 <Y6qmJT7H14Dfhn5y@T590>
In-Reply-To: <Y6qmJT7H14Dfhn5y@T590>
From:   Changhui Zhong <czhong@redhat.com>
Date:   Tue, 27 Dec 2022 16:30:49 +0800
Message-ID: <CAGVVp+VuvvjrWOihEEOi5WgiOn2zg-OVCFoHbKJT7+muxvC5uw@mail.gmail.com>
Subject: Re: [bug report] Unable to handle kernel NULL pointer dereference at
 virtual address 0000000000000058
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 27, 2022 at 4:00 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> Hi Changhui,
>
> On Mon, Dec 26, 2022 at 11:11:44AM +0800, Changhui Zhong wrote:
> > Hello,
> > Below issue was triggered with ( v6.0.15-996-g988abd970566), pls help c=
heck it
>
> There isn't commit 988abd970566 in linux-6.0.y, so I guess the above
> build must integrate other patches not in 6.0.y
>
> From the source code in cki build[1], looks commit 80bd4a7aab4c ("blk-mq:=
 move
> the srcu_struct used for quiescing to the tagset") is included, but
> commit 8537380bb988 ("blk-mq: skip non-mq queues in blk_mq_quiesce_queue"=
)
> is missed, that is why this panic is triggered.
>
> BTW, if possible, I'd suggest to share kernel tree being tested in cki te=
st
> if non official kernel is tested.
>
>
> [1] https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artif=
acts/731863135/build%20aarch64/3522994262/artifacts/kernel-stable-queue-red=
hat_731863135_aarch64.tar.gz
>
>
> thanks,
> Ming
>


Hi,Ming

thanks for your investigation,
I first saw this issue at
https://datawarehouse.cki-project.org/kcidb/checkouts/64206#issue-1783,
I'm not familiar with which repo CKI use to compile, but I see
repository is https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable-rc.git@queue/6.0

Thanks=EF=BC=8C
Changhui

