Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DB9C54FC9
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 11:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5604620780
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 11:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="XkEhAU5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgDULsO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726741AbgDULsO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 07:48:14 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965D6C061A0F
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2020 04:48:13 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u6so13655673ljl.6
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2020 04:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hr0urbAhdYYXsm2dSDM+ijiOf6geNis17wmxjM94cEM=;
        b=XkEhAU5R5PYd4McD+1unOUpGqJ+vG8hqHZerVpdqaxtNv/lweY2dl7oRy19/HKkxBt
         Sx3x5ca1ZStLuJy+AdQbI8yJ9B4iqaGI1ocVw0Bcpeq2QiHZZ51nGYIeNPHDUgYwHvN4
         7D4gjQaQDPKW/NoJP3m/YyjSVuv/iV/QMLFN/MEcU3VKj+Budv9l9GZ4FuWv6ZYPlv99
         PxLX/JENwG3COtZUNYNrQO8pQj2qEjjnSrJrTzrsCWddSkdKvU9JeE7O3QW2CoY1r4pp
         wg6IjnuFPY74IfKjviVQ/splfUr6HVn+OvYVztelLIGqihWmWCwCCdlREIeWnlvi6Tjs
         gI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hr0urbAhdYYXsm2dSDM+ijiOf6geNis17wmxjM94cEM=;
        b=uIO0Ptw65i3wpm6EJv6iKOAWEbQV/h2BwlilEG7pqf+2lfp/FhjIe2KDd05QIX0Ehr
         ToYHDCGh7z0QsiMNAVGkNFJ0RR8lbUR0Rrncol2c6oqm2teU2iGpG7adbxlFzbQimGsa
         UG0MWhx3JNcovOjZjt5NH0T/kLzhwB234Rh9vkYVRVOuwE9Us6ZLBGocBQTYvj3Iv5Zl
         LXy8vfoYM0n3jSA28GiA4wxZOg0Wk8SdGvsA2+4PWvjZN1vD1gJsebSmHZ5VvUwDktCv
         CCKd+IhYrDDm4sr0vwWX7xCHJAEZYqF1Y5XitxdxMqDleAcTeLlCCgzZ8ZFWLezauIoX
         B5Mg==
X-Gm-Message-State: AGi0PubJ+7EMp62ubdu2MnHoLsyCfpfWefKd9XIlf6hVBgVH8soR63cu
        0X5GY9E0vcsc8MI46ISNIDJePksTuPFFPyszmoRR0Q==
X-Google-Smtp-Source: APiQypLcKHjcdphSZ9nRGKZ2ueyTjflZeCK32oJlzvi4dYlpx1i0PUweOppmGjOEfSA8LIjTtsPU7HYnWrcKMM0x2zI=
X-Received: by 2002:a2e:585a:: with SMTP id x26mr14023189ljd.179.1587469691923;
 Tue, 21 Apr 2020 04:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200420080409.111693-1-maco@android.com> <20200420080409.111693-2-maco@android.com>
 <b546eff4-616a-8488-fc11-9b7e23d44bcf@acm.org>
In-Reply-To: <b546eff4-616a-8488-fc11-9b7e23d44bcf@acm.org>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 21 Apr 2020 13:48:01 +0200
Message-ID: <CAB0TPYHXCRq-SVGsNBviyCAyP75oKam77W9vdsyri9fzA2tp+g@mail.gmail.com>
Subject: Re: [PATCH 1/4] loop: Refactor size calculation.
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 20, 2020 at 3:22 PM Bart Van Assche <bvanassche@acm.org> wrote:
> How about using the SECTOR_SHIFT constant instead of "9"?

Ack, will do.

> Please also change the "kill_bdev should have truncated all the pages"
> comment into something like "return -EAGAIN if any pages have been
> dirtied after kill_bdev() returned".

Sure - would you prefer this to be in a separate change?

Thanks,
Martijn

>
> Thanks,
>
> Bart.
