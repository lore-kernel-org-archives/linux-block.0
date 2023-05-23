Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03037C7EE23
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 08:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjEWIVC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 04:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbjEWIU1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 04:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B98CE7C
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 01:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684829872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z1vsmwu9wQdhBpyHX1ifgdxNF2LF4XNn6NhplHQRK/k=;
        b=WScbaKC06jVOppeYg5UeBuJcluvLAW6B1bfR+gFotHZlAdB8zi752+sUFC2OQjxE2fbdkw
        fL3+4mr9Mx5XF6bbKnN/7bO1nsEdsaR3+we/3tellX1h8UBtrkNldu/f/N/jtEniIKTPco
        TKqqwLiraGrum2jOTiPkuDPrU9fKET4=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-2AgwCG1VPPCeL9GMi9OMBQ-1; Tue, 23 May 2023 04:17:51 -0400
X-MC-Unique: 2AgwCG1VPPCeL9GMi9OMBQ-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4393a83487eso34423137.0
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 01:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684829870; x=1687421870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1vsmwu9wQdhBpyHX1ifgdxNF2LF4XNn6NhplHQRK/k=;
        b=h7e02Q3yGU3NoLAAUvBoSWaAwOnyzLziECYwQmswoFn1wPCC3/5He/ECwfRX6TX4Ln
         YrH2dCx2x3yqAdbmPVejRsRSHxV1sLEZFhT9n2YpDXrVlt52OuS3osYjO5tAH9lgorwx
         QEd/EHRzlpz8APmY89sr2nz8/qPv1Zwr+4qJU2+twSaWVSQF/SlYNan7BTZYsJrO4z78
         IcH8RBdeA53m44NPEwz1noHFcBdmSUGz5GSESVorPy/20o/zkR2yb8u0MnY+J3UAh/yp
         TGZ7Y3s8pVFrSB+64KJtQwteV+r51O3jtSpkpe7Gp+HdshrqV7Vsga6niD4vGMHRSN6/
         Py5g==
X-Gm-Message-State: AC+VfDxfeyukcX+lUyAeptwHrDWEkvM280OReMNmdTXTN+zcmZZfDZyZ
        erV2Vvgd+jEsIg62+3HuqU2I3AcvnSPHbQrTWR34qiPZWwzkFDJPrgeR2Vzg0ltWv6Fc0PtxigN
        /IOl6ZTnv6X+Uxty/BhaE+y4IuAumbNDBO9Rgpao=
X-Received: by 2002:a05:6102:3d94:b0:439:3d9d:1713 with SMTP id h20-20020a0561023d9400b004393d9d1713mr2479837vsv.0.1684829870417;
        Tue, 23 May 2023 01:17:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6k8tewbt6DI/6nU4+WEhIZEROD7Dk4KpgdDQqi5gQA7gIawb1BVHikyBhNU2948fhomrW55OBZ2L9i1r1hjaQ=
X-Received: by 2002:a05:6102:3d94:b0:439:3d9d:1713 with SMTP id
 h20-20020a0561023d9400b004393d9d1713mr2479831vsv.0.1684829870147; Tue, 23 May
 2023 01:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230522183845.354920-1-bvanassche@acm.org> <20230522183845.354920-4-bvanassche@acm.org>
In-Reply-To: <20230522183845.354920-4-bvanassche@acm.org>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Tue, 23 May 2023 16:17:39 +0800
Message-ID: <CAFj5m9+dhpqYSOVBQ+H0tCb1Y2i1wpFqn_anbDsfs=mYCTqgCg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] block: Requeue requests if a CPU is unplugged
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23, 2023 at 2:39=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> Requeue requests instead of sending these to the dispatch list if a CPU
> is unplugged. This gives the I/O scheduler the chance to preserve the
> order of zoned write requests.

But the affected code path is only for queue with none scheduler, do you
think none can maintain the order for write requests?

Thanks,

