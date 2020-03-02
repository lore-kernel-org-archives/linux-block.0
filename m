Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C38C3F2CD
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 16:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17540217F4
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 16:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="UIY+zNvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCBQSn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:18:43 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33161 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgCBQSn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Mar 2020 11:18:43 -0500
Received: by mail-io1-f65.google.com with SMTP id r15so27372iog.0
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2020 08:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QoJBOzsSDvcA2tn9M+h3AKpf0S01wAffIbTzZfpZ94=;
        b=UIY+zNvRhdIQ8pA8uOiET5s+VmUKuguaxRXjmWChn91z5VbI2RFQwpl0t2WN3IcPuN
         wPfupFz7SjlhwHpk3ZjPqeI/rBxVUtnUnpFpy4FBP+Y4BjUb/ZF6sLo7ouNwKqNefwSU
         aLqkOSa+Utz++BTearn9xChZmVWxa5S/BLi6kNUtIPJdvjWF5EDptcdJhVdXe6+/SvZj
         EZhUu0EkaISrmenNMxbnEFEDqwn9NB73vYeIaJhP6CetnAO6jLx0v8Rhu3+jJUgDYDXC
         SooR/1Okqh02R6W1HPTUPwRbPN3cVHXaFyzAWZwvky4Ptu0Y0VomAPxDFMKfCoLlnudM
         Bo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QoJBOzsSDvcA2tn9M+h3AKpf0S01wAffIbTzZfpZ94=;
        b=WobOQyCpeY1c1qK6mLudoAv616Kp0p51Cc1WLjWZkgd4UJ3GRT/mtLgaSnstF143pp
         dK8FQ+Xw534yHXpgyuWV3Av2v3JzWw5dMvoHI1bAXsdnXVr+hpFxzM7sMjFOc59+asTm
         vHgufkSdVsMJJfNkmjoqy2sqBuBDDKLNvKBXHbvji7g22PniV9K+WURQo7M/zQ755Skm
         suIqL6AbdZgtayJtGwCggrnsxcm51LTs5AA69xyI+IIuUIiFHOPS5YlLdgReKxlgVWzd
         kU4yZpyJTGoBuatPFjDLm49Crlyx0Y7uR08BkNc0mg64RdcNxvC5lqO5ecFEkWZFixec
         Ae/w==
X-Gm-Message-State: ANhLgQ3gvDXhe1qO4wIfaMcBGOSQrioBk3hqIgHpfm5RM3QSL//a5BR3
        DvSxc8/a9VgSaJy6X1vUhVBnjRDqDvn6KuddNJDJqw==
X-Google-Smtp-Source: ADFU+vtq0yIRjcizQ63TSnvTjrv4AE/Cl+VOuKnjaVBsW3PmF1xbM+AZxLAfYV/SDJ42V6Y60hUagYEZjZfmGzooJmA=
X-Received: by 2002:a6b:5a06:: with SMTP id o6mr269046iob.54.1583165922611;
 Mon, 02 Mar 2020 08:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-6-jinpuwang@gmail.com>
 <eb1759a7-c51b-eaeb-f353-4b948b1d64e3@acm.org> <CAMGffEmM8dtcO=uYg5drafaz5FjGV4ynQBpyGZFZwVMptgxcBw@mail.gmail.com>
 <fc0c1962-d5d6-96c0-cd5b-3e51a1aeb98e@acm.org>
In-Reply-To: <fc0c1962-d5d6-96c0-cd5b-3e51a1aeb98e@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 17:18:31 +0100
Message-ID: <CAMGffEncM6JDoQcGt5wuXAhOqc3qsB03cxKqd741VNpyU1sWPg@mail.gmail.com>
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

On Mon, Mar 2, 2020 at 5:13 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 3/2/20 5:49 AM, Jinpu Wang wrote:
> > On Sun, Mar 1, 2020 at 1:51 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >>
> >> On 2020-02-21 02:47, Jack Wang wrote:
> >>> +struct rtrs_clt {
> >>> +     struct list_head   /* __rcu */ paths_list;
> >>
> >> The commented out __rcu is confusing. Please remove it and add an
> >> elaborate comment if paths_list is a list head with nonstandard behavior.
> > Will change to a normal comment, we want to use rculist, but no such
> > annotation usage for normal list_head, only hlist_head in kernel tree,
> > Do you know why?
>
> Hi Jack,
>
> I'm not aware of any annotation for RCU lists nor for RCU list elements
> that is recognized by sparse. What I do myself is to add a comment to
> each list_head that explains whether it represents a list head or a list
> element and also what the strategy is for ensuring thread-safety.
>
> Thanks,
>
> Bart.
>
Got it, thanks Bart!
