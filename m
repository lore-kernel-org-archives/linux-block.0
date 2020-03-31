Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18E2C2D0E8
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 07:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88D5206F6
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 07:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="KRLxEykP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgCaHNT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:13:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42930 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgCaHNT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 03:13:19 -0400
Received: by mail-io1-f66.google.com with SMTP id q128so20563409iof.9
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 00:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q6vgJdAZ89ozStkYrjfd7BJEU9NXvocN/bsECgDGewg=;
        b=KRLxEykPXgAZxv80UQdsD+hUH1MSMUcppDC0CHddQ+S+BDUIQ4utaMPFTrdx6BN//V
         GMsH4YveCgbgt4ZCBjv6n+5rZc02LM6bEf7aZYLZ6d1RN+Obt62G2+hSdx3863JAqQ9s
         swQKqydIImi9KkbIJCnQjYxQ539P9h/6RpqtngCh9NQ74Ev04B/aJcMecIlt+Qt1dnOt
         GeeyTg5l1VWmb3odR4s6GQhN4xh1nxS9YJt8UMFW43qVWfc6L293jmtTz6fNxa3wWLA/
         6jGB+tU2/2HbNZtmfLQAuJVVVFUKvIRO0Zy6LwO3cdX2PcU9BoD8s/pxlvJaZ4iQ2R5H
         ydbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6vgJdAZ89ozStkYrjfd7BJEU9NXvocN/bsECgDGewg=;
        b=Qsgr9n9FOe0Gge056h7Yy5NCXefazCyO8jwk4knLp9RMNIQfWx0wq+Y5IVgwy2xrqI
         W3HvjN5wCUBpptfYw2kPWjMbVNtUWaSMb8+pDifQqjvMkQYLs/7hWusVU8q59+zTBA30
         HTkkl02+GGZpiaFZzEcWB6an/YxmlQAdikndOBrxA1ElAmKTgmIFeQkB8ZtKRDmTn/cq
         jfWRnvl5g8bmejmN5mq0iXYTjmOeHLeugrDivuI82K6jJVW1cm4OnbFBSWliisVKKWBI
         NqbG9k07inif3iNGUv/akZkvuTEHNrNUPrKp54NO5TmYMtHXk2dd2AbVqkIWceXrjYw3
         Aoew==
X-Gm-Message-State: ANhLgQ1AmW+MYu8Sd39vSIlom3O++JG/anAbkWqFGd/O8NYQzpZO3HGC
        N0hPsRbEKc7DOveM5EPRdusBLgdq5xptZYEkCmBDbLav
X-Google-Smtp-Source: ADFU+vuRkzNkkHa4LdGVy9jE/I0zEoqT0skNgUuQPdihENGuuiv27aCbuPj1QF5xAbO8ssxqAb823TT2ni2XDJ3VGBE=
X-Received: by 2002:a6b:b70a:: with SMTP id h10mr14387625iof.54.1585638796881;
 Tue, 31 Mar 2020 00:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-13-jinpu.wang@cloud.ionos.com> <9ecaaa54-9aa2-958e-e741-c908fee60a83@acm.org>
In-Reply-To: <9ecaaa54-9aa2-958e-e741-c908fee60a83@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 09:13:06 +0200
Message-ID: <CAMGffEnBBAPEoLqaD0PMZ38LYx+F2_qUNNe-_Oy2JH-R5_Wkaw@mail.gmail.com>
Subject: Re: [PATCH v11 12/26] RDMA/rtrs: server: sysfs interface functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 31, 2020 at 12:29 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > +static struct kobj_type ktype = {
> > +     .sysfs_ops      = &kobj_sysfs_ops,
> > +};
>
> It seems like a release method is missing here.
Will fix, thanks Bart!
