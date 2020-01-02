Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8E8C3276D
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 08:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F7521D7D
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 08:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="X2kf9+Re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgABIsd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 03:48:33 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44703 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgABIsd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 03:48:33 -0500
Received: by mail-io1-f67.google.com with SMTP id b10so37624584iof.11
        for <linux-block@vger.kernel.org>; Thu, 02 Jan 2020 00:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGdvfwI0N2dXwMiREKHR8LaHPAeurpQfYNu9ngSFvdw=;
        b=X2kf9+ReB0xjBrrA+VotjAkS7NmpdehXJuzpZgT7m3Jqp0xkNF8aJfTqH5mCab2dqB
         7GDj4njuKQVRexjFsbU6VPqwSe3pz9eG8SKbBFTJSZEwL1f2cUuEJRLhw3MSYyNn/ZWZ
         hjk1oVVOlcSUg0OwZXG3RL7G7cd+WjJjdI6uMjbP6ujUw+XmyIYChKZMb29MfhnLJEfI
         QZIxfCtD7JqhmDrDgyH+ZParzwC1wwl3kfMzteV4bW7ZsiMPyDmcxpXp2TQ397LP7t6c
         G5lt0c/wXFdIRHM70sLH3C0+4y/oH5C3h2L9uRNuy0Ghcao48WQc3+l9qRU/OfITEXQ1
         tj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGdvfwI0N2dXwMiREKHR8LaHPAeurpQfYNu9ngSFvdw=;
        b=QXFrL7BLCH1RLIG8O5NzTtZwNsu3AoKIWwsJGiXGZ6Q/FWZUS8kARS11n/s3zb354D
         RypRLf7XaonspbZB3zTH9m3olOquj7JTp+ekJm1HSmKmHAAMNRQTpLLVmgzGSBYkXQh0
         DLtHh9kzzqMjf+miLWO2W+8P1nUEAXANf0zfy06KZRiPOAV/5R1frJQmTkUWScHu9YWx
         99cHck96EDnhpanyQPfCHt1lz8kSCtq0E9urm9oAapL2uZ+Y7S3PpJouQIwDGagTjxu5
         87ggLv296auOaBom5cn/Ly7tiz4qyz9NUyA9lTy/t/ep+Ez0kSkJt/Yx3H0faGvFFt/7
         342Q==
X-Gm-Message-State: APjAAAVJvBzbQUGqD9B7U2MufjDEU7iEhfr28rE92qBCHKAuhQuPQNrc
        Ong9+aMTelh4o3jRqTzXp5KElvYfWSNJIN3WacRlsQ==
X-Google-Smtp-Source: APXvYqxF2egn1EHT8hvNqinjRpr2NxD0/7RVBNJYxBativ8eR+j5X97PUpXEI/WBTgnfM7P55D83/RiZpRYc4R3Sutw=
X-Received: by 2002:a5d:9158:: with SMTP id y24mr33713508ioq.298.1577954912690;
 Thu, 02 Jan 2020 00:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <2aa1afb8-3797-e8b6-456e-fda3a2a0c9b2@acm.org>
In-Reply-To: <2aa1afb8-3797-e8b6-456e-fda3a2a0c9b2@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 2 Jan 2020 09:48:24 +0100
Message-ID: <CAMGffEnkrQJfAO2=y1bUeT-R_c-wivicV-LvDTkV+xsBXQUaiw@mail.gmail.com>
Subject: Re: [PATCH v6 00/25] RTRS (former IBTRS) rdma transport library and
 RNBD (former IBNBD) rdma network block device
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 31, 2019 at 1:11 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2019-12-30 02:29, Jack Wang wrote:
> > here is V6 of the RTRS (former IBTRS) rdma transport library and the
> > corresponding RNBD (former IBNBD) rdma network block device.
>
> Please provide more information about the RTRS_IO_RSP_IMM and
> RTRS_IO_RSP_W_INV_IMM server to client message types. Does one of these
> message types perhaps mean that the receiver of the message is
> responsible for invalidating the rkey associated with the RDMA transfer?
>
> Thanks,
>
> Bart.
Hi Bart,

You're right, RTRS_IO_RSP_W_INV_IMM means the client upon receiving
the message should invalidate
the rkey associated with the RDMA transfer.

We will document it in README PROTOCOL part.

Thanks,
Jack
