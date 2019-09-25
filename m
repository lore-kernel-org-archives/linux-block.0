Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE2EC432C2
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 20:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBE621D7F
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 20:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="W5Qm2AFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbfIYUuY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:50:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37553 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfIYUuX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 16:50:23 -0400
Received: by mail-io1-f67.google.com with SMTP id b19so547606iob.4
        for <linux-block@vger.kernel.org>; Wed, 25 Sep 2019 13:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcFUvFaH4ulivYzeGS479DJAENi2H4dlEkA8NFTiWc0=;
        b=W5Qm2AFqUYSvhuhK7ZqZOPrzToQu1C/VZ+y13OxYJu35LWB64zEI/409nj4rz6l6sG
         6hHSXfqdzzUIk5EsOKOFAQxffpdqrSrjCgOD3KMdUlcB342AzLrRZ3SC9dGq+Fu5wifz
         nOvObF3QG3fM+OPgopuWkv/P/ZbqoVPQDPGswcUNpBwYxdPI0V/sOf4fLUWghAZolLRU
         m8hK+a8MOZxr65A9QXJPzkBeS5UefIdU7aoEe9cLgkW3b1wolobPK0mKDLZwa7Cco4Pb
         PmkktCZfHso5tEIYdkBj0Rd1wtrf3Thnq7NBBkPMM946PQiVRRFKWbn702rKn++sEJlZ
         NK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcFUvFaH4ulivYzeGS479DJAENi2H4dlEkA8NFTiWc0=;
        b=qEwraaX4wYXVgupf8s1WnA9IzTvYLCBawi/7b7W/apAUK5xZXoC+DzPyji6ApVlmap
         qaMxUkDPR6VgiNyIuzSfk1V+CocgAivwyvKFQTlSzpr0PS3vmLfnjJxIQEnBdYRTrkHK
         sRNrQtx908WbJRF/lJtJzY8kkrZwGt/zIY8LMPsTnQnAHe61WI2k1DAcjGEQeJ9u3ZLj
         4F9pWDcWCrElFpWzq29U1BHOPZMVJOkvnnf8GvzZOSIavm9RFb5AMs3PzuiMORHfc1S5
         CgSSa7n8LeQmEBaMZ8IcSiWYucTlivxKw46qQ6mRxdsA8C9NXc8liYVw046zqmUfqO2f
         tw7w==
X-Gm-Message-State: APjAAAUoC+krr+s2pNrk64ZpGUwLXraPJszzEZpSmB4rf0lOc9mEr3Ef
        30y7sX0zt1GJL44QKjrludJaRc9IPNSpQw/TcRcu
X-Google-Smtp-Source: APXvYqwHES/K3I4GpIgMIDafwi7SGBRgVz3/wmDIAHguQHK4gfin6SB67ILVzXnUEqiF8G6tIFOF+N3Oey8gTAnYnbE=
X-Received: by 2002:a6b:c348:: with SMTP id t69mr1550460iof.66.1569444623081;
 Wed, 25 Sep 2019 13:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-7-jinpuwang@gmail.com>
 <d0bc1253-4f3d-981b-97f1-e44900fffb44@acm.org> <CAHg0HuzDGgmFKykAmBuAwJXoP1OGq-pQteS=vYMjcbp=cwu9GQ@mail.gmail.com>
 <ee692ec2-7f65-19f5-f122-fed544074f5f@acm.org>
In-Reply-To: <ee692ec2-7f65-19f5-f122-fed544074f5f@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 25 Sep 2019 22:50:12 +0200
Message-ID: <CAHg0HuyMekqFehsU+-O_X8-1j1Bwu6rJzvuAwVV4LQs06ZJsFw@mail.gmail.com>
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

On Wed, Sep 25, 2019 at 8:55 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/25/19 10:36 AM, Danil Kipnis wrote:
> > On Mon, Sep 23, 2019 at 11:51 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >> On 6/20/19 8:03 AM, Jack Wang wrote:
> >>> +static void ibtrs_clt_dev_release(struct device *dev)
> >>> +{
> >>> +     /* Nobody plays with device references, so nop */
> >>> +}
> >>
> >> That comment sounds wrong. Have you reviewed all of the device driver
> >> core code and checked that there is no code in there that manipulates
> >> struct device refcounts? I think the code that frees struct ibtrs_clt
> >> should be moved from free_clt() into the above function.
> >
> > We only use the device to create an entry under /sys/class. free_clt()
> > is destroying sysfs first and unregisters the device afterwards. I
> > don't really see the need to free from the callback instead... Will
> > make it clear in the comment.
>
> There is plenty of code under drivers/base that calls get_device() and
> put_device(). Are you sure that none of the code under drivers/base will
> ever call get_device() and put_device() for the ibtrs client device?
You mean how could multiple kernel modules share the same ibtrs
session...? I really never thought that far...

> Thanks,
>
> Bart.
>
