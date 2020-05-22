Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CC7C433DF
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 05:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E737A20757
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 05:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Lr2U5tw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgEVFNX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 01:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgEVFNW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 01:13:22 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1054FC061A0E
        for <linux-block@vger.kernel.org>; Thu, 21 May 2020 22:13:21 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e2so11470276eje.13
        for <linux-block@vger.kernel.org>; Thu, 21 May 2020 22:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MWHQvFpaWXA6nLt3wiLhFrrphRE3s7yxYwyGrpAyCCM=;
        b=Lr2U5tw3AowCbUkTYoqFdKDRVE1y5tShPYT2nKRYPcQSFbe7yLJBuUDAhTM+megEwA
         aivo5+nWC+g53adSl4NUU0zFcsrVFR7lPcz/Cy0K406aPEMkZOC9zcT8D4rcFJIRASpa
         JmP0U6C0zTVigc+48r7GpI20gLcm4zgApshrNPruaAS9utb7qEjrxXq9FiJMqzU4oSxK
         NiTidua7XbaVUmo+hoMpgJMOV8KzYuBT7tAU9KJfFZ3RLcvg7l7i04NK6TNQ4FQLTtea
         lblwWAlyOOwFH/D/8wAked+Wt6Iv1wS0sY9FscTihu3339ZpKG1Vhx32cG4vK8byv3MK
         NTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MWHQvFpaWXA6nLt3wiLhFrrphRE3s7yxYwyGrpAyCCM=;
        b=iZQ9Dv+6vfAA93uzR1Zv5XOorBR0rvnsSEZ0nxQvTiuQ1UBOSrEHEYrqKYAL1oVbYd
         T207FPcZvURai2A14jLeYOnYXB9j2wU+H2x6XeZ+3CNFBQEm1N/k3bVmZekhoNrNvY5Z
         qUkJf0hLP/SfdrJZDUhwASC97LavY4uM6Pe4nmrndPmt0CdUcSNHoEptzlI8F/uY4e19
         cuYdsip4h1YjV+MNd/MvpirS4Xfhlt66vsoCw9E0QQESjA7cDQHdLqEU33V6OlCCi3Rx
         hX2Seq2T4wQFZTlpwBlLwkJ2fk9MhZ54mz6VmM1EdpivR9m4wsrtdO2ktuSEkSNae5vs
         PThw==
X-Gm-Message-State: AOAM531mRUyu2tzDeg5wpuZAoyMGJHpGVKO+ad/XDC2EyGVT9b6MXFYu
        3ZUetXHj58UmB345ZI5bbrO69603F7tczTdkzGzNrg==
X-Google-Smtp-Source: ABdhPJzZxiF70JkXGmjOELNN0LmRH4kyPtlEx4e9CMFAS4mjQopoe0fUhygSewFtJRDauvv9xcgvb103OXHkbfqDMAQ=
X-Received: by 2002:a17:907:36d:: with SMTP id rs13mr6765653ejb.478.1590124399660;
 Thu, 21 May 2020 22:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200519120347.GD42765@mwanda> <CAMGffEnuk2WfWmwjKy_Sqcuf_xKwzrPpE_o8j3nHM30ADr8HVw@mail.gmail.com>
In-Reply-To: <CAMGffEnuk2WfWmwjKy_Sqcuf_xKwzrPpE_o8j3nHM30ADr8HVw@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 22 May 2020 07:13:08 +0200
Message-ID: <CAMGffEmC215iOmtT_iZizey=jnbgWneE5f5zapYvdJi5WYDM1w@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: Fix an IS_ERR() vs NULL check in find_or_create_sess()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 19, 2020 at 2:52 PM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
>
> On Tue, May 19, 2020 at 2:04 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > The alloc_sess() function returns error pointers, it never returns NULL.
> >
> > Fixes: f7a7a5c228d4 ("block/rnbd: client: main functionality")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Thanks Dan,
> Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>

Hi Jason,

Could you also queue this fix for for-next?

Thanks
