Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F153EC3F2D2
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 13:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C227020870
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 13:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="hn5XKMrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCBNtr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:49:47 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38824 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgCBNtr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Mar 2020 08:49:47 -0500
Received: by mail-io1-f65.google.com with SMTP id s24so11570096iog.5
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2020 05:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qt5W59GV75NLVJZQK0Qu2jsiSd6N+uS6VYOGY0Zp0Uw=;
        b=hn5XKMrl5BRb0p9seiiCfMhDDOgOLi9urHuUU/l5ZfU1VdvKg4LsNko+C4jALK+55C
         rZI5SFZho+7r5nbJrtDdF+93YJmHeixvNFFvxnxeK6J8ypect+yqDmFLXHmudwdIbpZF
         C/yHq9hjVsRKzBDWfCyIBn2vBVfb4gNkF4VYZMe7YkcLxczU4N8OP/sCjiXsCTiSDZN4
         pJFJh7Ld59UsZmH9nAgh6Zscg57DtTbF4qZyqoksizZozaJmjBdRjZ/vga/twkwiEbUO
         i44k4cYImzMWlLkN68cJOrGs6L87B9/wrLqzB4Cy0Ok1gXXNHLECnqSgJOjx7NRFb98Z
         JfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qt5W59GV75NLVJZQK0Qu2jsiSd6N+uS6VYOGY0Zp0Uw=;
        b=nI8kuayskyAbwrRd4rv51hDI0bKbknmTduIp9dTTaeGvaaBzuVdpN7CN7W6ph1yrdY
         FAcpqETu7N/XF9dbWZq0rfulHi0QFJp+6W+R+DoNrnx4QrVATRiRJHRUabannSYdMR4U
         evuMru1sSzLz6HtdDh/3333L2PcHPO+YNCq5cUghI31m6hqz0D4+wfbk63Pq82vANflr
         OmqnyIm7PRH16CMM6Q8/J602T+uh50rF9iyCMbFzhO67SwEnwrvByj2lbDZsLAYBAft+
         K+kK7UivCkiMFVMV+Zl9AJlaU59ONPMuNkvHn+o7ykeQCYH8wwXmbNwFKLzR3TnEzUbc
         xhBA==
X-Gm-Message-State: APjAAAX1ypj5eSPgv9Xb+QclEau+Zrktc//umKVmX9M0nhhuVzMzPCNP
        rI/79xvLLgUx2NLzNDqEK/FGBE5soNKl87eEi9By1g==
X-Google-Smtp-Source: APXvYqx2qMlRQKda67ZNog4NkQcSMzTJN6tLlhWDJYk2TaSNmPRkqgoWVUWhaI9vdhPbqKhcVH+xLnHk25qOqudaJnc=
X-Received: by 2002:a6b:6814:: with SMTP id d20mr13088638ioc.71.1583156986385;
 Mon, 02 Mar 2020 05:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-6-jinpuwang@gmail.com>
 <eb1759a7-c51b-eaeb-f353-4b948b1d64e3@acm.org>
In-Reply-To: <eb1759a7-c51b-eaeb-f353-4b948b1d64e3@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 14:49:35 +0100
Message-ID: <CAMGffEmM8dtcO=uYg5drafaz5FjGV4ynQBpyGZFZwVMptgxcBw@mail.gmail.com>
Subject: Re: [PATCH v9 05/25] RDMA/rtrs: client: private header with client
 structs and functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
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

On Sun, Mar 1, 2020 at 1:51 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:47, Jack Wang wrote:
> > +struct rtrs_clt {
> > +     struct list_head   /* __rcu */ paths_list;
>
> The commented out __rcu is confusing. Please remove it and add an
> elaborate comment if paths_list is a list head with nonstandard behavior.
Will change to a normal comment, we want to use rculist, but no such
annotation usage for normal list_head, only hlist_head in kernel tree,
Do you know why?



>
> > +#define PERMIT_SIZE(clt) (sizeof(struct rtrs_permit) + (clt)->pdu_sz)
> > +#define GET_PERMIT(clt, idx) ((clt)->permits + PERMIT_SIZE(clt) * (idx))
>
> Can these macros be changed into inline functions?
will try.
>
> > +static inline void rtrs_clt_decrease_inflight(struct rtrs_clt_stats *s)
> > +{
> > +     atomic_dec(&s->inflight);
> > +}
>
> The name of this function is longer than its implementation. Consider to
> inline this function.

Ok, we can use the atomic_dec directly.
>
> Thanks,
>
> Bart.
Thanks!
