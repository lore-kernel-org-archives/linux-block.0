Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84957C47082
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 08:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64CC06103E
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 08:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhEaIYX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 May 2021 04:24:23 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:32901 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhEaIYW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 May 2021 04:24:22 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQMm9-1m19q83Uav-00MK4X for <linux-block@vger.kernel.org>; Mon, 31 May 2021
 10:22:37 +0200
Received: by mail-wr1-f51.google.com with SMTP id z8so4882513wrp.12
        for <linux-block@vger.kernel.org>; Mon, 31 May 2021 01:22:37 -0700 (PDT)
X-Gm-Message-State: AOAM531askt3faAp5WK9RoBF57q0BAUjLnuoSszUWQ6815TTYciTuPYJ
        azHTLnkR3b44ij4SA6Qyxm3rFpx9jdUDIQ1h6cQ=
X-Google-Smtp-Source: ABdhPJxOYtsOixNCZiK/8HlnT3HHFZ2l8YEwvKBqAheSyPF6MziazabvRPY06vDT8xNIJ6jI18dOJqKsS+M2N4Dgd60=
X-Received: by 2002:adf:a28c:: with SMTP id s12mr21969150wra.105.1622449357396;
 Mon, 31 May 2021 01:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210531072526.97052-1-hch@lst.de> <YLSSgyznnaUPmRaT@kroah.com>
In-Reply-To: <YLSSgyznnaUPmRaT@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 31 May 2021 10:21:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0sctUYZnRBxS+PLted8_O1mT8JisLqO4jMHQaU=Q5iNw@mail.gmail.com>
Message-ID: <CAK8P3a0sctUYZnRBxS+PLted8_O1mT8JisLqO4jMHQaU=Q5iNw@mail.gmail.com>
Subject: Re: [PATCH] remove the raw driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wiSyxuayVQKCIoB8sVijJ+wwAeT8wxxYze+S22Fd9CKzfSfkDUk
 RulzfMWYTOBvVoGSOl98csRZPCJyrs+twKtHxAvrSDazdUzU172QE1SNYDpUhjXp7Yuk4of
 MhP7Y2ogEhTuDh2IrB9ASfqJ+tJE4194Vozs2Hyu4FEPOPWTPBh6mW/+7PWubOMGPVh7AKl
 KPl0eb4Ru4FkC+z0kpSzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dmnHFlkSKVw=:iTZe3OP+Eglk8nGq/o4YDS
 yOYkVJJF/+RA7kFw8Dqm4+7jtEec2kf3bj3T6Bl4HGzM2/IqBrHEFsXJq6XI5DSZNjtB3WXwE
 4Mg3oFIEeI/31Qttw6VIaXj1yDYNlJE7xGR8J+lp1ZKNi2c8K+5L1QIku02IlueOvBKn/lKji
 SjKc2/0m1Qk4BG7bxO9psNp5qaOm5Gar18V0vjOFTdJg5WcbJYjzg5KbiYs0mNqfnmHDHNuDh
 2SfsSry6dP6WWUsPJCoFzN9V4+rx+RvO/db0dkDBJ10K+Q36PKRc7sop84qr+HKyk5wREt9wP
 92rEzTBrfjvCtwen/s5tE8VQJxCcjvkL/S8Eu8ZhuU6ELnmuZ3rPvr5byPWSVBVcdew+z93z3
 siwhexBqe/dWaePQTjtNhtnMYxc5Y+/HgCbjQROZUDRaRvgXARazrhZ734kmAXb+Kj4j+Tr8L
 wdAp8/0cjj3ZjbndA4ybB0TIW0sebff5PohHAWGbTAeSzNf4TBECNVYAc5RkQdDKA3g6jCTTf
 fHIyljzmdftQL0wkQlqA4c=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 31, 2021 at 9:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, May 31, 2021 at 10:25:26AM +0300, Christoph Hellwig wrote:
> > The raw driver used to provide direct unbuffered access to block devices
> > before O_DIRECT was invented.  It has been obsolete for more than a
> > decade.
>
> What?  Really?  We can finally do this?  Yes!
>
> For some reason, I thought there was some IBM userspace tools that
> relied on this device, if not, then great!
>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/lkml/Pine.LNX.4.64.0703180754060.6605@CPE00045a9c397f-CM001225dbafb6/

The discussion from 2007 is the last one I could find on lore that has
useful information on when and why this was not removed in the past.
The driver was scheduled from a 2005 removal in 2004, but not removed
because both Red Hat and SuSE relied on the feature in their distros.

From what I could find out, this continued to be the case in Red Hat
Enterprise Linux 6 and SUSE Linux Enterprise server 11 that were
supported between 2009 and 2020, but the following versions dropped
the support.

       Arnd
