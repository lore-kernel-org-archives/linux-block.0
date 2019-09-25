Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27BEC432C2
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 22:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A4320673
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 22:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="RcAnulDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbfIYWxb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 18:53:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42736 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbfIYWxb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 18:53:31 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so1231599iod.9
        for <linux-block@vger.kernel.org>; Wed, 25 Sep 2019 15:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NgdVnypXV4KSvmqLrClLGHf8ETf2mlCO+2hqkwlCY7g=;
        b=RcAnulDB3F+hSgfwPTI5JwQzfOnANj8F4GXVIQTsNo+ZuDA351WlPFblb7uamtt302
         gDtaoeQvr/UKzOrAW6BrCHaHa2RZ20Mn4zrxBB6Xt4bFnfW3TchJ5DMGgAYstSj8wPQL
         5XnEuSMJmsHN8lga/+JYsv2TLZjxvYU0sv/GQYHuo6+IlxL/RDC8B9Bjz/Od/9Ud/f0o
         kORCM/n13WdQpk7fKAYKDvrg8Mlq5BydX67sl5GRk5DYu8a+6RQzwvaifP/ryLoAxRnR
         +EhkcX1FRU6FYxj/Dux6wbKz8qivICiPCkA/xupMmhJM+fa/7XKZ/8nClqIGy6b+5sXg
         K0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgdVnypXV4KSvmqLrClLGHf8ETf2mlCO+2hqkwlCY7g=;
        b=CnxdYR6j0cJbHpuDcKozBIeaMoh1e6QFdKRNpa30d1eKMMUFo9qP7VydHRbuwIZGzx
         e59ewrA9b0N6O2p4ahrm1JUOGW86x7vcibbH9fmgm7m6vRVhW2InQSLfOamtsT1zTwbR
         yKYeQ+eOIU6VHFRDRa1ZFRBRpYG1+P38bdhl7IgBQvPCmn6GLhsnK24wkHAmIv2GVGZ4
         mal3WrvxganidYhkaSlDNsJ1G8t7PTJ9fmsBCgp6A9Htt1gXTWXj3rMowAZcQ7Xj0mZl
         MWvWvuDfRbkYEZrLLViovRPM4l+AuqXvV9fRfpguUkSefEejsAEyMPk7ba4DXCyUQe89
         xDqQ==
X-Gm-Message-State: APjAAAV6Op9K2IEokmllH5ppESDkx/RneCo7jW8TKPiWVYVrzyNh2SzW
        roAMflme5rHHO7sGt1iahtCucmzmRhTuSqAw4VlO
X-Google-Smtp-Source: APXvYqy7H1DLLF9NFPqCfEmk0idBJhTirLKNRbjFHMaUqXAjZoKqVPQxb+JY2UFC5+n7Q8VnzjZPYmCoYnU5oOmfByg=
X-Received: by 2002:a6b:db0a:: with SMTP id t10mr470533ioc.300.1569452008914;
 Wed, 25 Sep 2019 15:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-7-jinpuwang@gmail.com>
 <d0bc1253-4f3d-981b-97f1-e44900fffb44@acm.org> <CAHg0HuzDGgmFKykAmBuAwJXoP1OGq-pQteS=vYMjcbp=cwu9GQ@mail.gmail.com>
 <ee692ec2-7f65-19f5-f122-fed544074f5f@acm.org> <CAHg0HuyMekqFehsU+-O_X8-1j1Bwu6rJzvuAwVV4LQs06ZJsFw@mail.gmail.com>
 <befbe2d4-d37e-0e67-3bf5-01024663082f@acm.org>
In-Reply-To: <befbe2d4-d37e-0e67-3bf5-01024663082f@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 26 Sep 2019 00:53:17 +0200
Message-ID: <CAHg0Huzuw=O2CJvUGJYO0whUE6tx34iPm7ScWRn-uRafRYp5aQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/25] ibtrs: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 25, 2019 at 11:08 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/25/19 1:50 PM, Danil Kipnis wrote:
> > On Wed, Sep 25, 2019 at 8:55 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >> There is plenty of code under drivers/base that calls get_device() and
> >> put_device(). Are you sure that none of the code under drivers/base will
> >> ever call get_device() and put_device() for the ibtrs client device?
> >
> > You mean how could multiple kernel modules share the same ibtrs
> > session...? I really never thought that far...
>
> I meant something else: device_register() registers struct device
> instances in multiple lists. The driver core may decide to iterate over
> these lists and to call get_device() / put_device() on the devices it
> finds in these lists.
Oh, you mean we just need stub functions for those, so that nobody
steps on a null?
