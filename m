Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F61EC7EE2E
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 03:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjFMDw3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 23:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjFMDw1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 23:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21C61AD
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 20:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686628301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4C3Qet8pfbumCHeQRQJPhvf0fawkFBs8tKAQEcPXsl8=;
        b=DTUoDrRp/nVG1heljgxeDGdS0VIZj9yaftKKtoGSbhHW8TeJYUTqIHc+4P/ATKnWoUF765
        RxzaHVP2SsTNGkwcP7UAuNg49R85011tYFJ4kBA9Vq21IBPE2IvVF17EyKdKYuS8Z4pbEJ
        X+M8s0b4h3qpMbu1TeXkdp8QbnQan3k=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-tpLAkSCoP3y1tDfhhjz1wQ-1; Mon, 12 Jun 2023 23:51:39 -0400
X-MC-Unique: tpLAkSCoP3y1tDfhhjz1wQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f994c591bdso7658291cf.0
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 20:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686628298; x=1689220298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4C3Qet8pfbumCHeQRQJPhvf0fawkFBs8tKAQEcPXsl8=;
        b=l8r6HHDF0BSS6eAb4nw2cdOSsrzUaT7W7KdmyaF4M12H22lk4e+h8GDYoB6R/+wZHY
         e+ZNGQW3IV5VXjDC40XeySt9yccsX9+i+nr90aCCvascoAZt0zfEJwz1/voUTKuHYdjj
         g0LlwJB+bvwYjFbL7UXDiU30qx6BxutRON0lA5dJWxieoOa88hFzKcXYiPgeqlETf6Or
         GGZ+7/oNpcr+ReS8LdeRvT47v08qVCqr8j8bdGZzocFOLCI/yQmjRuiVYUq04LK6Myjj
         sTdETEjIWEJeNCa5/XWYgRez3ypJ33RmG4RNhKlLh0iRoomJLA07LnoKZgFSPL+AhcEj
         T7gA==
X-Gm-Message-State: AC+VfDzeTXXUJm63bbyim9hLA2hVNaMJ/eYuGJcwW7Lro1iF+rEFBOvd
        hVuflaxjfRFPkYl4Hu4JBylYXMBYV/ZectxsRNtep6ZpNPMwMXulblLMV69cXHRCXlblGZzUOwE
        wa6iKz/+PE3HdzPFW+gR6KMmWUIsTx+/0VTNI/w8=
X-Received: by 2002:a05:622a:58d:b0:3f0:ab4e:df6b with SMTP id c13-20020a05622a058d00b003f0ab4edf6bmr13376056qtb.67.1686628298180;
        Mon, 12 Jun 2023 20:51:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ77q9JM4D3nlwn+WSOng3WLkYEnk7ORFVxoz6Go1qcYYHvUtAhi0IrS4HeqbAYoiDffwJDzqdo9NagKfCPHwxI=
X-Received: by 2002:a05:622a:58d:b0:3f0:ab4e:df6b with SMTP id
 c13-20020a05622a058d00b003f0ab4edf6bmr13376041qtb.67.1686628297957; Mon, 12
 Jun 2023 20:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230520052957.798486-1-leobras@redhat.com>
In-Reply-To: <20230520052957.798486-1-leobras@redhat.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Tue, 13 Jun 2023 00:51:27 -0300
Message-ID: <CAJ6HWG6dK_-5jjoGJadOXqE=9c0Np-85r9-ymtAt241XrdwW=w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Move usages of struct __call_single_data to call_single_data_t
To:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Leonardo Bras <leobras@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Friendly ping

On Sat, May 20, 2023 at 2:30=E2=80=AFAM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> Changes since RFCv1:
> - request->csd moved to the middle of the struct, without size impact
> - type change happens in a different patch (thanks Jens Axboe!)
> - Improved the third patch to also update the .h file.
>
> Leonardo Bras (3):
>   blk-mq: Move csd inside struct request so it's 32-byte aligned
>   blk-mq: Change request->csd type to call_single_data_t
>   smp: Change signatures to use call_single_data_t
>
>  include/linux/blk-mq.h | 10 +++++-----
>  include/linux/smp.h    |  2 +-
>  kernel/smp.c           |  4 ++--
>  kernel/up.c            |  2 +-
>  4 files changed, 9 insertions(+), 9 deletions(-)
>
> --
> 2.40.1
>

