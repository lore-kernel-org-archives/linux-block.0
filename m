Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAD0C4332F
	for <linux-block@archiver.kernel.org>; Thu,  3 Nov 2022 03:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiKCDFc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 23:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiKCDFX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 23:05:23 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01048140AC
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 20:05:22 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l2so517506qtq.11
        for <linux-block@vger.kernel.org>; Wed, 02 Nov 2022 20:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R64KECUzDbqJo0RRKWL4JjLGKACzWeVJPV2fXxBJdHw=;
        b=ju3Dknz07FXV4Eja1inVQbLV5EziVz/npKT2GwOg4qm60L2iFaIP9e04iZ9gYRFvIy
         oLMsDFaAW7PVgBNfjby2i8fQZmp6MrvbXW7hJDHFovM3Vh8EV1cy5UAVhJbBGIOvh6T8
         UcwlOuYb0iPCKfeXAhU54nmrjwFKxudH6BQFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R64KECUzDbqJo0RRKWL4JjLGKACzWeVJPV2fXxBJdHw=;
        b=VEb4A4/ZwMtgKzXy9s67ddXaygliXSdkOCzxY0g1t+cUakUd+FMaxIl5bFli3KN9xJ
         MpXa2Kgafw5DAbRctc5wxn95qj46JssQeWQC/8+GkUVx4g061YrgJlSaBECwbSYPuPS2
         tMk93yqWNqpULaSVR31+lvB8IbVI1JOtvFFslOC8Ij1CG6x9KijEqtZ8iIvdK2pLYaer
         ptERCn/GFcY1C/+EkrKM+JvABnyrasBIvvnkkUpfFbnnSQBBzMA6tWk1yHLS0z2v9BM+
         0664oM7RysT0AWZYIyljX0P1xGLVJSVXfpro2XqWN9snFnHhE16NG+BddBbHbWA0ktZ3
         X6qA==
X-Gm-Message-State: ACrzQf1p3nGXVtwijUBuU1ci8IE8ToUAJZI6TUZa9aDRyKAu0bBk4E5E
        9+yQKzRhOmciZfU97yx7ZlVjNoRR5cJp6g==
X-Google-Smtp-Source: AMsMyM6GWt1B50i8JQcYfK+Dz7O7DyoGRSyRT+902kGVXII34TcbBKjKpLEeqw0OSKzAJZdTxUUHjw==
X-Received: by 2002:ac8:48d7:0:b0:3a5:3ec4:7a31 with SMTP id l23-20020ac848d7000000b003a53ec47a31mr9000212qtr.375.1667444720851;
        Wed, 02 Nov 2022 20:05:20 -0700 (PDT)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id o6-20020a05620a2a0600b006ce3f1af120sm1949497qkp.44.2022.11.02.20.05.20
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 20:05:20 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id i12so348286qvs.2
        for <linux-block@vger.kernel.org>; Wed, 02 Nov 2022 20:05:20 -0700 (PDT)
X-Received: by 2002:a05:6214:f23:b0:4bb:f5db:39b3 with SMTP id
 iw3-20020a0562140f2300b004bbf5db39b3mr18157941qvb.117.1667444720007; Wed, 02
 Nov 2022 20:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221103013937.603626-1-khazhy@google.com> <3c0df3fa-8731-5863-ccc5-f2e60601dbf9@huaweicloud.com>
In-Reply-To: <3c0df3fa-8731-5863-ccc5-f2e60601dbf9@huaweicloud.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Wed, 2 Nov 2022 20:05:08 -0700
X-Gmail-Original-Message-ID: <CACGdZYJ0WH+Y9sdchXy30UVTQgPCEo=fW+W9atZh1Ki7Ov4_Gw@mail.gmail.com>
Message-ID: <CACGdZYJ0WH+Y9sdchXy30UVTQgPCEo=fW+W9atZh1Ki7Ov4_Gw@mail.gmail.com>
Subject: Re: [RFC PATCH] bfq: fix waker_bfqq inconsistency crash
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 2, 2022 at 7:56 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>
> Hi,
>
> =E5=9C=A8 2022/11/03 9:39, Khazhismel Kumykov =E5=86=99=E9=81=93:
> > This fixes crashes in bfq_add_bfqq_busy due to waker_bfqq being NULL,
> > but woken_list_node still being hashed. This would happen when
> > bfq_init_rq() expects a brand new allocated queue to be returned from
>
>  From what I see, bfqq->waker_bfqq is updated in bfq_init_rq() only if
> 'new_queue' is false, but if 'new_queue' is false, the returned 'bfqq'
> from bfq_get_bfqq_handle_split() will never be oom_bfqq, so I'm confused
> here...
There's two calls for bfq_get_bfqq_handle_split in this function - the
second one is after the check you mentioned, and is the problematic
one.
>
> > bfq_get_bfqq_handle_split() and unconditionally updates waker_bfqq
> > without resetting woken_list_node. Since we can always return oom_bfqq
> > when attempting to allocate, we cannot assume waker_bfqq starts as NULL=
.
> > We must either reset woken_list_node, or avoid setting woken_list at al=
l
> > for oom_bfqq - opt to do the former.
>
> Once oom_bfqq is used, I think the io is treated as issued from root
> group. Hence I don't think it's necessary to set woken_list or
> waker_bfqq for oom_bfqq.
Ack, I was wondering what's right here since, evidently, *someone* had
already set oom_bfqq->waker_bfqq to *something* (although... maybe it
was an earlier init_rq). But maybe it's better to do nothing if we
*know* it's oom_bfqq.

Is it a correct interpretation here that setting waker_bfqq won't
accomplish anything anyways on oom_bfqq, so better off not?

>
> Thanks,
> Kuai
