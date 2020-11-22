Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35156C5519F
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 16:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3862076E
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 16:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Eo76B3qt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgKVQIa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Nov 2020 11:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKVQI3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Nov 2020 11:08:29 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635DFC0613CF
        for <linux-block@vger.kernel.org>; Sun, 22 Nov 2020 08:08:29 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id a9so20401533lfh.2
        for <linux-block@vger.kernel.org>; Sun, 22 Nov 2020 08:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=safEzczHGHLXs45ryoEAbi+vFjxDiy4IY9/ZKygPeno=;
        b=Eo76B3qt1Iak9u+z31PtXQiZoVCKTWV2jZKDS91tXdNvEgzikGvFxeyOxH8UKgG9WF
         w6CAiu0PIqWisd1OOR6l/SUpvKxHdCcRWyNdbPjxj8V5vuuo4HvtZR9lbP+OivvlIu9B
         vR/ekmYVE43reG3CpC8eV5N+5ZRKQS7roSZgvWtUGpYvbfpEFYUCSFwg2l3Sx/JX3dXA
         AceERB9NkIUcIIM+FqNoPFSyMTB0BrvvFGwcS3VlclZuagdcL/EHCU+OVIHesWYcn4kB
         BtQfsuarcYnG9Cv0KO2Z7kHEtqInD0b5Sbmry2VWzqRGppsk9DpyG/5Ps3s5taCBHTfe
         juFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=safEzczHGHLXs45ryoEAbi+vFjxDiy4IY9/ZKygPeno=;
        b=taBPz8/pDZx1kgh9/ACx3PvezPE2TC7nG0ruDkFvNTsD7qxdR3/tdXu/YOj9oyfFhj
         kNYGBMnQU79EYOJG0K33lwn+J1qmeHUDbT53Z9wa/A0QWn9jI2Sfw/TS4q9P4R975H3f
         CkcXvUAfAil6uYudumAc6r6EhfEs3Jbj6ZOXfZWoa/Kkl2Bsd240KVxgLpWQY3WzyXpO
         ymgyNgaA8PRYxGXgGV6Otb8Kkdi6eu61PWpe8Y5WBSDE2d+pdFZQsTpRzM7IYRg8em1G
         nOENR2EWGd0x57FuyZ5jgXUjPAT6iW1bJkkYnKWah9V01ai8l8wFpCFf1vbPZ1Vy2p99
         PsbA==
X-Gm-Message-State: AOAM531/lyl9SOe5dP64nn6QjDqnMIqDIBKDWb4IXwl86BZ9Swq+lgQT
        Tyg0Lk3p4JsDKEYrMTReGpWt61rb6pU62fSXW9jwmT72PMxh
X-Google-Smtp-Source: ABdhPJxytEe46vZYdqpmquTHcqOtJ6iCost52VJxvqnFhXqqqLVsS0bJnFZk7HNiDucyLAFRUgZ/LmZWN0GCc44beEE=
X-Received: by 2002:a19:ca:: with SMTP id 193mr83210lfa.331.1606061307677;
 Sun, 22 Nov 2020 08:08:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHg0Huzvhg7ZizbCGQyyVNdnAWmQCsypRWvdBzm0GWwPzXD0dw@mail.gmail.com>
 <5438d63e-0879-1d7b-cac1-f20fa24ecedb@grimberg.me>
In-Reply-To: <5438d63e-0879-1d7b-cac1-f20fa24ecedb@grimberg.me>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Sun, 22 Nov 2020 17:08:16 +0100
Message-ID: <CAHg0Huzufxh1bjATpAy6PppTLFaj3N4S1HevNjpGwNE=zmqObQ@mail.gmail.com>
Subject: Re: [RFC] Reliable Multicast on top of RTRS
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Sagi,

On Fri, Sep 4, 2020 at 12:18 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Hi @,
> >
> > RTRS allows for reliable transmission of sg lists between two hosts
> > over rdma. It is optimised for block io. One can implement a client
> > and a server module on top of RTRS which would allow for reliable
> > transmission to a group of hosts.
> >
> > In the networking world this is called reliable multicast. I think one
> > can say that reliable multicast is an equivalent to what is called
> > "mirror" in the storage world.
>
> md-raid1

Exact

>
> > There is something called XoR network
> > coding which seems to be an equivalent of raid5.
>
> md-raid5

Exact

>
> > There is also Reed
> > Solomon network coding.
> >
> > Having a reliable multicast with coding rdma-based transport layer
> > would allow for very flexible and scalable designs of distributed
> > replication solutions based on different in-kernel transport, block
> > and replication drivers.
> >
> > What do you think?
>
> You should probably use the device-mapper stack or modify it to fit your
> needs.

Will look into the dm framework,
Thank you,
Danil.
