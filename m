Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9FFC4360D
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 22:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0043F208C3
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 22:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="V66aROos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfIYW03 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 18:26:29 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:37204 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfIYW02 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 18:26:28 -0400
Received: by mail-io1-f51.google.com with SMTP id b19so1166076iob.4
        for <linux-block@vger.kernel.org>; Wed, 25 Sep 2019 15:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/DJUCljRILck0Po37+hrFOa0sfqWuVOPAKCUrIr84k=;
        b=V66aROosIMb5jBBfnluQ/ChzYYbV6SY6ODVcdVVDEGqvsGFciqGq4DuLnrFmOChuAc
         D+00HfAJi05ypBpkaukMnrYj1gmW3PMGDBeYbZQ6RDlf99pji/qetNlKZ2kMGRjDmIT4
         ugHrYmSGX19gY6ydjvzlUb9F4RWS3DEAThFPC1t0Ri7AOvujQAsi5/ZQ0qzUh+Mbj6TB
         +g/ppjZyei7njxPGFgQ5rJ/Cgxtg9Hxd+oQQRCVC+gMM7j0DETVqDGocimqft/rMHAwg
         qQdU7xpxmzX9ExZfOrWiQVhEPrWuyzIegtq/sBe8m5vuraX35pSF8qwWBNHsehi0aPUp
         VKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/DJUCljRILck0Po37+hrFOa0sfqWuVOPAKCUrIr84k=;
        b=WY7wCthMYTNlpxgVtvat/OAdQ9DQWsoqVeSooZ3Vj2jRwT0dbQugfEXPshlLqBwRQG
         nVwrNe1iBA/b6bPpzlRjndn2fqrAs0vFmKy8JDQLloWts2I0M+ZmAn6L58kKS3sH7+5r
         zUEcOn6kZmgqVaWzTJrBXt3y5YObXapWw6caJsLNQm07FBqrJZTbH98Rd9oe2GPGHkkd
         OKL1/BSxksx6R0HZC8dWTIkH0sfivXVXtNS5G5yYLotwo0kA9/fmTS7Zx9g1Mp+7JrEn
         7jRw3/6S//Rpub7p8hEVSoKCU5lBwu6nH4KbGZbqTaTQprR4essq5gbYII2jcj8+vv7e
         6p7Q==
X-Gm-Message-State: APjAAAX/k+WjQpHKLtMZX1XaAGis/gFvdmHrJU8RZ28qFtOOV0WLBXpC
        SkxPcMPsA/7tcY2EQxL5swsJB/W4riHEKE7MAg4FRrUvaw==
X-Google-Smtp-Source: APXvYqzmOrF9c5VHfSpju2N8flft/cTD7TG3CwX/rT27e1wK7P7lE0eImlkdroqKZji80vJDyR9L0D6s4qLhtkWaWJ0=
X-Received: by 2002:a02:e47:: with SMTP id 68mr677176jae.126.1569450387555;
 Wed, 25 Sep 2019 15:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org> <CAHg0HuwzHnzPQAqjtYFTZb7BhzFagJ0NJ=pW=VkTqn5HML-0Vw@mail.gmail.com>
 <5c5ff7df-2cce-ec26-7893-55911e4d8595@acm.org> <CAHg0HuwFTVsCNHbiXW20P6hQ3c-P_p5tB6dYKtOW=_euWEvLnA@mail.gmail.com>
 <CAHg0HuzQOH4ZCe+v-GHu8jOYm-wUbh1fFRK75Muq+DPpQGAH8A@mail.gmail.com> <6f677d56-82b3-a321-f338-cbf8ff4e83eb@acm.org>
In-Reply-To: <6f677d56-82b3-a321-f338-cbf8ff4e83eb@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 26 Sep 2019 00:26:16 +0200
Message-ID: <CAHg0HuxvKZVjROMM7YmYJ0kOU5Y4UeE+a3V==LNkWpLFy8wqtw@mail.gmail.com>
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>,
        Roman Pen <r.peniaev@gmail.com>
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

On Wed, Sep 18, 2019 at 5:47 PM Bart Van Assche <bvanassche@acm.org> wrote:
> Combining multiple queues (a) into a single queue (b) that is smaller
> than the combined source queues without sacrificing performance is
> tricky. We already have one such implementation in the block layer core
> and it took considerable time to get that implementation right. See e.g.
> blk_mq_sched_mark_restart_hctx() and blk_mq_sched_restart().

Roma, can you please estimate the performance impact in case we switch to it?
