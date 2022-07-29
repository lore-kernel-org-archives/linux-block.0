Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B56FC00144
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 07:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbiG2HhZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 03:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbiG2HhY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 03:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D62B721E04
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 00:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659080243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dy2kNKL1JhMWWnuIBBMhcLAKU8xcYvN5JWPftmW9fQY=;
        b=hl6nKBOAladG11PjgEvHkrP27O62CtLmYv2ioh9JqRrNlkpSXq7utxECGXfcrKaptDjSn6
        6tsEyy6oS1LSNruevC8BASHFv0FyGSEwejpDfXyBE+7p0ioF01zYjukrWK7t0NQCuYZ+RC
        oNBpZ7fgQXsirheXagEgJltOUTVhJ1w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-jeYqnt5MNOy1_XkuYnlPEQ-1; Fri, 29 Jul 2022 03:37:21 -0400
X-MC-Unique: jeYqnt5MNOy1_XkuYnlPEQ-1
Received: by mail-ej1-f69.google.com with SMTP id qk18-20020a1709077f9200b0072b95d9eea3so1457907ejc.4
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 00:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dy2kNKL1JhMWWnuIBBMhcLAKU8xcYvN5JWPftmW9fQY=;
        b=HGxszHsBmEr1OlrDNtB3w/UcbVWMJDXrkhMGdrklVaD7Sv2RbiMzatpWjooY/ylrHw
         jMZybN97m8Jhvhi2nEY2TYEkYxu18BxL/MStOmSVUyGIsj/SIhMjWD0WVtMSU7sUDrAG
         yprWDpoWsXw00gNsTIn0Xb8KRsDptrLC8MwFchSxSVtQkz2CHkyowskYwKDHVzHaGaWl
         Uo8L5MwTI+NFA2syzhKGQOE+kk3RhSRTWAmQohY5I0IzRLZFLXAUGXFBIPGxCyw3iPIT
         xa3/eIbS9HPHRq9cNwUwZE9B87Xke8sNhEf18OiV3Ks9K7Z3k061IMPe9JQ3y503i2xb
         fO4A==
X-Gm-Message-State: AJIora9QxrUQgJPhIWVXDgBflpKIRw6DZzpEgA9Y8aeN9uw/s/Iq3GkD
        iNZbQP6gQcW3P4/SqEnodjnCNlNrznft4jSH9dhDgOg7wsWS5S2Rz1uE/Yg+BiTVWEbNDPrJ+N9
        LLTTuwNIOso/zbNrPaOwcNMxKWW3Basy+O6URK5U=
X-Received: by 2002:a17:907:9612:b0:72e:56bd:2b9a with SMTP id gb18-20020a170907961200b0072e56bd2b9amr1962352ejc.526.1659080240348;
        Fri, 29 Jul 2022 00:37:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vcOwVtg9ZNSypqnyzQpoYneT+Bc3aZjIXbOnZugGXRgMTg/1a7c3QhrtouZNuay5TaHkpZ1RIy1tdkCprE5sw=
X-Received: by 2002:a17:907:9612:b0:72e:56bd:2b9a with SMTP id
 gb18-20020a170907961200b0072e56bd2b9amr1962336ejc.526.1659080240006; Fri, 29
 Jul 2022 00:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
 <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me> <YteeHq8TJBncRvZu@infradead.org>
 <bd233bf9-d554-89cc-4498-c15a45fe860b@grimberg.me> <YtoriAQGW8+p4pFe@infradead.org>
 <472156f4-ff58-aeba-64eb-b8e5815e9c29@grimberg.me>
In-Reply-To: <472156f4-ff58-aeba-64eb-b8e5815e9c29@grimberg.me>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 29 Jul 2022 15:37:07 +0800
Message-ID: <CAHj4cs_y9WtRDSpc27axBMpuzN55G7LE_MxMf5NUbePWyg1QXg@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/tcp triggered WARNING at
 kernel/workqueue.c:2628 check_flush_dependency+0x110/0x14c
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 24, 2022 at 4:21 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >> The problem is that nvme_wq is MEM_RECLAIM, and nvme_tcp_wq is
> >> for the socket threads, that does not need to be MEM_RECLAIM workqueue.
> >
> > Why don't we need MEM_RECLAIM for the socket threads?
> >
> >> But reset/error-recovery that take place on nvme_wq, stop nvme-tcp
> >> queues, and that must involve flushing queue->io_work in order to
> >> fence concurrent execution.
> >>
> >> So what is the solution? make nvme_tcp_wq MEM_RECLAIM?
> >
> > I think so.
>
> OK.
>
> Yi, does this patch makes the issue go away?

I tried to find one server to manually reproduce the issue but with no
luck reproducing it, since it has been merged, I will keep monitoring
this issue from the CKI tests.

> --
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 0a9542599ad1..dc3b4dc8fe08 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1839,7 +1839,8 @@ static int __init nvmet_tcp_init(void)
>   {
>          int ret;
>
> -       nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq", WQ_HIGHPRI, 0);
> +       nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
> +                               WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
>          if (!nvmet_tcp_wq)
>                  return -ENOMEM;
> --
>


-- 
Best Regards,
  Yi Zhang

