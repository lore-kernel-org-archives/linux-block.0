Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E183AC77B73
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 01:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjEVBJx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 May 2023 21:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjEVBJw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 May 2023 21:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1192CBB
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 18:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684717744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZ7OJfH5sSxGHOD8/qYWYtgSnHQyOyKPEDPunOpiEmM=;
        b=KtcpaHCLr0z9QXdI1Ryc9CStpwJklr8ZovZixKQjCIwZxYqFdP55f6g4j5YXFq2tvDqnqK
        XqEGzCql7oUlNUiDe1Gt0USm+VgHrQ4HQykqBmbxjwQn5WhWH7WGqxc5V2jjNPWFXfWSkK
        fPuDFHrC75sY6CQCP5mWWW0kZH8LmlE=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-YmZ4D7l9N-K-ulVveZie1A-1; Sun, 21 May 2023 21:08:55 -0400
X-MC-Unique: YmZ4D7l9N-K-ulVveZie1A-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4361139e9f9so53312137.1
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 18:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684717734; x=1687309734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZ7OJfH5sSxGHOD8/qYWYtgSnHQyOyKPEDPunOpiEmM=;
        b=T67etNYVhU1vjz5FEAzked8+AnUMir3qtNAV98b8VacpNXIioRvwYMMuACAYRzyz5+
         jmcEGH8RWTk39Mqc/QdZg18NLl8PXoE1gP8zb092FsEw/LydAu/1GmTqlRCuD12AWxMn
         nwh74G0Bt80k/sLZaFAL2Ze5xGIfg31RApntJAjN5WnA8CmODfmDefURnrNjH5ivbCqx
         TC6o/LlcrI3BPJWt9SQYOt9FOc6y6jkgp57cB1j1XDOrBnSJGdCKjtkjs5uDGHoyA4Vk
         IOhkQZZAg9fbTTBeP47FgYC7jUgiqLFqBRtYSjT9AQsw+wzEIzPwpr/rGxroWO17FPP0
         sfaw==
X-Gm-Message-State: AC+VfDzZsgod3BpRjdEB/tXFfXaJuSBnlYLbfWtIRy8sQT5jcLh+0IBf
        mfd4Tvquy2WHz72MpH9GPPE0fRGD5/HHuup9TxPZEfs26Ym+8CAcRn4GgAu5lt4tp7Xz3UxiOUH
        +R9d4m9mCC6CF+wFuKjTR/818EyE44RV2VdzpRng=
X-Received: by 2002:a05:6102:441f:b0:436:156:82f2 with SMTP id df31-20020a056102441f00b00436015682f2mr2969270vsb.3.1684717734709;
        Sun, 21 May 2023 18:08:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7PhMavQd1SPygWp7n43uoYKQR9A8V92MFBOr1ximZu5bCzSNCnZqZe8O+1IACOxuPlx04xod3NFvlf+Xx1tC0=
X-Received: by 2002:a05:6102:441f:b0:436:156:82f2 with SMTP id
 df31-20020a056102441f00b00436015682f2mr2969267vsb.3.1684717734485; Sun, 21
 May 2023 18:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230522004328.760024-1-tilan7663@gmail.com>
In-Reply-To: <20230522004328.760024-1-tilan7663@gmail.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Mon, 22 May 2023 09:08:43 +0800
Message-ID: <CAFj5m9LfZ=CATGUz-KFE3YFd04XV2Zmu7kPMdbbyXLg-KnsPeg@mail.gmail.com>
Subject: Re: [PATCH 1/1] blk-mq: fix race condition in active queue accounting
To:     Tian Lan <tilan7663@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Tian Lan <tian.lan@twosigma.com>,
        Liu Song <liusong@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 22, 2023 at 8:45=E2=80=AFAM Tian Lan <tilan7663@gmail.com> wrot=
e:
>
> From: Tian Lan <tian.lan@twosigma.com>
>
> If multiple CPUs are sharing the same hardware queue, it can
> cause leak in the active queue counter tracking when __blk_mq_tag_busy()
> is executed simultaneously.
>
> Fixes: ee78ec1077d3 ("blk-mq: blk_mq_tag_busy is no need to return a valu=
e")
> Signed-off-by: Tian Lan <tian.lan@twosigma.com>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

