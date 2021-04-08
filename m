Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73903C433ED
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 17:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D48B610CB
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 17:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhDHRHE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 13:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbhDHRGj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 13:06:39 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB520C061761
        for <linux-block@vger.kernel.org>; Thu,  8 Apr 2021 10:06:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b4so5219777lfi.6
        for <linux-block@vger.kernel.org>; Thu, 08 Apr 2021 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVjNyA0Mj7PbXbzSlBgeKLuNXXO3LkuDtz825m68Ul8=;
        b=XysbBaAtL4mNLcsyfMCbbRlAcw/aVaESD37Vof5fn7N/M11NVrDDJhCjei3NpBLgaT
         UUIfauXU8uxbGghGY/maOGk8JYQMupmnmg8mRNC5T/+PwNoPmLa92UG/+lHFdE3vwIlH
         //DkXD61W3Ra1K8pCiwoc7xMm0NIZn9gGcVDKyWbm6mg5yDO77YdaJ70+fmpU6mrxH/O
         DKQQGpYOsEYi2JDuU4BtUQMDe3NbxB9HlPIYt71dIW85GGcZncUiUcFnk+1ObsYhL2vS
         mVtEoZ7l9slc27+lEC/d72HGbhRdzWgsIJcOup/NL6wbIEVeHlHC2ulWEb7fW8Ctjt/w
         rqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVjNyA0Mj7PbXbzSlBgeKLuNXXO3LkuDtz825m68Ul8=;
        b=HWgdDhxp8OgeD2716m01bx68d6E9YJDLgBxRu1P0QuRgM/vFf/nzCQnkYK5NXvH211
         eiHLcvlg9RDjcpzaXpQPkJ1NeRJc4Hi/ehlj9Br5BTMojJVl6gslMPg6Xt4JN/qDiRAY
         Tx+dBirVx2TGxryO/Utckd+iDj4jhReCVBkapjvAlp/05uXwsxgIuL+Xvlu8guUkYQVm
         +2OglYsecBVB6DWnaRtzidT9EwGwxt/0bfPXGVfYILYHJSJPKXieZdQHBdoB7l2Mjk5p
         DyYNqE4wS6sLKMP+trzeaeAyFu/pY14uS22B0lfEuivmDPRPgXABNzSsCP4IsgTLblwv
         MYAw==
X-Gm-Message-State: AOAM533dxs8bvWXXx1ojD3zujRy9E9VWc7w5bmg96qJZvHYVEf+gWwYX
        UmtlsA4Q0XHgHPp2SDKQE1z2ODTfchUgdN3CFz4evQ==
X-Google-Smtp-Source: ABdhPJxBVAkFJ64WZ0MwH2D3FUSZjtHEjVQlCSPz3exDRLWnAwh8uIyoHxU4NR631Ybrrisdmjbtl15TSHUWIV3vV3A=
X-Received: by 2002:a19:e50:: with SMTP id 77mr324440lfo.367.1617901585882;
 Thu, 08 Apr 2021 10:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210408135840.386076-1-haris.iqbal@ionos.com>
 <20210408135840.386076-3-haris.iqbal@ionos.com> <20210408165208.GA3944028@infradead.org>
In-Reply-To: <20210408165208.GA3944028@infradead.org>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Thu, 8 Apr 2021 19:06:14 +0200
Message-ID: <CAJpMwyjs_O9wAi-JMdaH8Ln_Trm_w8HggQM01cGRtSYdrOim8g@mail.gmail.com>
Subject: Re: [PATCH V5 2/3] block: add a statistic table for io latency
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Guoqing Jiang <jgq516@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 8, 2021 at 6:52 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +static ssize_t io_latency_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +     struct block_device *bdev = dev_to_bdev(dev);
> > +     size_t count = 0;
> > +     int i, sgrp;
> > +
> > +     for (i = 0; i < ADD_STAT_NUM; i++) {
> > +             unsigned int from, to;
> > +
> > +             if (i == ADD_STAT_NUM - 1) {
> > +                     count += scnprintf(buf + count, PAGE_SIZE - count, "      >= %5d  ms: ",
>
> Please fix your overly long lines all over this code.

Sure, will do.

>
