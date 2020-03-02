Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E540C3F2D2
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 09:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B88246BE
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 09:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="g15Sio73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgCBJ6w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:58:52 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43543 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCBJ6w (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Mar 2020 04:58:52 -0500
Received: by mail-io1-f68.google.com with SMTP id n21so10795429ioo.10
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2020 01:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CgZRkqKTlqTPulCP/Z/qQC513Xv4FPfpHxLuqBbnjAk=;
        b=g15Sio73VOBgipZ8AqV6rXMyYIH/FjaISdLiWSdC0XmkFQK+jkP4oZSNp6y/GdqjvG
         Vk69oGdMYQnk1lUJZ5SlEM1Mg+lKO1i+ZTC9DtuG4tW8F+uQ3BYFah4NT+Qj+gASTqoO
         ABFI0wguzqgwePZGt9Pz36/0A9sc+SgdBXMOCNw+PSIlEI+maRoa/Gw7pVf4+vyxciIv
         OL7f6Lln0QoTsRidgU1ktWoemibzEbYsgjvUspDQP3o6V1ME5QJ0AVvGRQQjwW5UOWGi
         3b5sFXoEGc4prtPB9Rj3ZcN5YUMNwqnvJyJ/9qnffZCK2a7h3uCuWzYo3NYy9sR7a3I1
         2jUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgZRkqKTlqTPulCP/Z/qQC513Xv4FPfpHxLuqBbnjAk=;
        b=gYutlZ4GpqpdijzKF0aS6LVk9BhwEDUAkvWC+bi2d8/ESq5QlA8og+XrLZ8w8epqJm
         9DmQ8uIava0ErXGBHfB696W1/GjmhQhroXP+Kd/m9PFoct1FWtBIv5yH3hmMEL9UEk2/
         NScDejmRkXhu9BHCO8nW+1BwE9WpwQvlNtUDCqPmjmzYus8ccSAO5FOBftlo8M649sqO
         XJFIlpP0gvIM2aVueiHYhgi0Bp0UNyhJkFQ26r+t+Bo3xEjBXzo7ICEHIJEHKL2/HzZ0
         7778uq7GujWJ3Sl7zaVmsv0TFFX3D0DlWN5YqKZOpOG/GmmvLjGIFlvBq7zjVqRk+80X
         FDgQ==
X-Gm-Message-State: APjAAAVG6Yzzy1MqI+ehh6dx3r49HId4CAiMfEB7WbYv5gpLXeodl/My
        VyUo5cl1E09y4dOIaZYmIAUrLTXRUWrtY6FNXm4f
X-Google-Smtp-Source: APXvYqyIpuywT4gaQSZZrGI4CtG5X618MR1wirAOy2xoXfW/vaZpNm0TtwxRfClkClwj0az1I5CQ1qO0+duuQ8nfLG8=
X-Received: by 2002:a02:caa8:: with SMTP id e8mr6403877jap.126.1583143131655;
 Mon, 02 Mar 2020 01:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-21-jinpuwang@gmail.com>
 <33864f54-62af-cb5f-45fa-55a283dcd434@acm.org>
In-Reply-To: <33864f54-62af-cb5f-45fa-55a283dcd434@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 10:58:40 +0100
Message-ID: <CAHg0HuwvdYNB=C4yi4_tXeOWkj9rjTsV0B59Ea+_axLAuZ98Zg@mail.gmail.com>
Subject: Re: [PATCH v9 20/25] block/rnbd: server: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 1, 2020 at 3:58 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:47, Jack Wang wrote:
> > +static int dev_search_path_set(const char *val, const struct kernel_param *kp)
> > +{
> > +     char *dup;
> > +
> > +     if (strlen(val) >= sizeof(dev_search_path))
> > +             return -EINVAL;
> > +
> > +     dup = kstrdup(val, GFP_KERNEL);
> > +
> > +     if (dup[strlen(dup) - 1] == '\n')
> > +             dup[strlen(dup) - 1] = '\0';
> > +
> > +     strlcpy(dev_search_path, dup, sizeof(dev_search_path));
> > +
> > +     kfree(dup);
> > +     pr_info("dev_search_path changed to '%s'\n", dev_search_path);
> > +
> > +     return 0;
> > +}
>
> It is not necessary in this function to do memory allocation. Something
> like the following (untested) code should be sufficient:
>
>         const char *p = strrchr(val, '\n') ? : val + strlen(val);
>
>         snprintf(dev_search_path, sizeof(dev_search_path), "%.*s",
>                 (int)(p - val), val);
>
> How are concurrent attempts to change dev_search_path serialized?
>
Hi Bart,

thanks a lot for your comments. Will try to avoid the allocation. The
module parameter is readonly. It's only set during module init - I
guess we don't need to handle concurrent access?

Best,
Danil.


> Thanks,
>
> Bart.
