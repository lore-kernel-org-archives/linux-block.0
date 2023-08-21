Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A361FEE49A4
	for <linux-block@archiver.kernel.org>; Mon, 21 Aug 2023 02:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjHUCSo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Aug 2023 22:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHUCSo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Aug 2023 22:18:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C641C9C
        for <linux-block@vger.kernel.org>; Sun, 20 Aug 2023 19:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692584276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKcNoQraWJ0P+a1zEL4im+fBnNulMUVy8nTKcttSRz8=;
        b=c4M0ZuRhNs29+AIoBgnANS8pYCdd91VKRqQ8pxQyoOunoRAaO+rGjxyYfoZwV8EvEAIsPM
        s4ieVPbY+h0TaglmMFLskaoWnOEkr12mC7NcAVX2ME5JCYEhcIwiG3RQ172El61l+km8ue
        AXJxbr6oCfC+KElByuXhZ9DOzeKSfZo=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-wE1D7fVqNZG3cOpe4jjHwg-1; Sun, 20 Aug 2023 22:17:54 -0400
X-MC-Unique: wE1D7fVqNZG3cOpe4jjHwg-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b9c82f64b7so2878543a34.3
        for <linux-block@vger.kernel.org>; Sun, 20 Aug 2023 19:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692584274; x=1693189074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKcNoQraWJ0P+a1zEL4im+fBnNulMUVy8nTKcttSRz8=;
        b=R6W1sO4oen6aBeJ0jelHG66F1Rx05YWQa7/Q/dJkzdvuYQiv5+AshdLmzzY3B9gX6v
         E4ajNlHaWATBElGaAr35PqnhbMgqlPCFVGvvlpWIklAk4y0CgPgfzNs8tfsCGtCi0FYF
         nIZBkmzWWh4h/YIlCS031LpxjEKvUfw48o4qI/FRvrw5lZekFnDixqVyVGG2NOqSVO83
         l12RMhR2jFeQaL3w/yasU4jW7MSfT6UpPOlW4X0bQhBWFge+qtdcnOBwdeJvzk4I9Pxr
         4zEhlhNvyilfw3/Dq1esI1D0IpEqsgiX8KartYknEeVJqQGIWTZ7jcXad/OuyMvAZO0O
         8Arg==
X-Gm-Message-State: AOJu0YxjuybZpPFhnMpGibHOSLhQq/1ekrLJ3SL9nLv1mnpB6MVgRWti
        C/kBYqwtg2TcDduTz0jg0U57QpXHaIef4nO662VgnrXftPN7V0b9VS3xgsKZeKrL1ihNo9gcPH1
        DqdBPADccbfO16/HcdX1bw6wUP/o6IyjNuTz2ibE=
X-Received: by 2002:a05:6870:971f:b0:1c8:c909:893a with SMTP id n31-20020a056870971f00b001c8c909893amr6034837oaq.50.1692584273741;
        Sun, 20 Aug 2023 19:17:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESTH/sB3M/rHeYlwgo/qO3oNtSnKRv6ZuzSLvbshIwsPNG/hHBKMJIpaRBNtlYaZwIhce9UDHTc3moJB3Eyas=
X-Received: by 2002:a05:6870:971f:b0:1c8:c909:893a with SMTP id
 n31-20020a056870971f00b001c8c909893amr6034829oaq.50.1692584273461; Sun, 20
 Aug 2023 19:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAGVVp+Xiz99dpFPn5RYjFfA-8tZH0cSvsmydB=1k08GfbViAFw@mail.gmail.com>
 <cffead50-032a-46d3-bc9e-ace6586a69d5@kernel.dk>
In-Reply-To: <cffead50-032a-46d3-bc9e-ace6586a69d5@kernel.dk>
From:   Changhui Zhong <czhong@redhat.com>
Date:   Mon, 21 Aug 2023 10:17:42 +0800
Message-ID: <CAGVVp+VRcQs1qvsEeKyvmOXz=8KTybHpNDAwS9GzVMVw+FvTUg@mail.gmail.com>
Subject: Re: [bug report] WARNING: CPU: 12 PID: 51497 at block/mq-deadline.c:679
 dd_exit_sched+0xd5/0xe0
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 21, 2023 at 9:56=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/20/23 7:43 PM, Changhui Zhong wrote:
> > Hello,
> >
> > triggered below warning issue with branch 'block-6.5',
>
> What sha? Please always include that in bug reports, people don't know
> when you pulled it.
>

ok,I pulled the whole branch of block-6.5, I don't know which patch
caused the issue=EF=BC=8Cthe HEAD is=EF=BC=9A
"
INFO: HEAD of cloned kernel
/mnt/tests/kernel/distribution/upstream-kernel/install/kernel
/mnt/tests/kernel/distribution/upstream-kernel/install
/mnt/tests/kernel/distribution/upstream-kernel/install
commit cc7de17e2fe6b778a836032e7e5f9991dec40a25
Author: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Date:   Thu Aug 17 10:15:56 2023 -0400

    blk-crypto: dynamically allocate fallback profile

    blk_crypto_profile_init() calls lockdep_register_key(), which warns and
    does not register if the provided memory is a static object.
    blk-crypto-fallback currently has a static blk_crypto_profile and calls
    blk_crypto_profile_init() thereupon, resulting in the warning and
    failure to register.

    Fortunately it is simple enough to use a dynamically allocated profile
    and make lockdep function correctly.

    Fixes: 2fb48d88e77f ("blk-crypto: use dynamic lock class for
blk_crypto_profile::lock")
    Cc: stable@vger.kernel.org
    Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
    Reviewed-by: Eric Biggers <ebiggers@google.com>
    Link: https://lore.kernel.org/r/20230817141615.15387-1-sweettea-kernel@=
dorminy.me
    Signed-off-by: Jens Axboe <axboe@kernel.dk>
"

