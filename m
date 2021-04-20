Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FB1C433ED
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 15:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB461613B8
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 15:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhDTPrI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 11:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233039AbhDTPrC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 11:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618933590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j1INruBx24Ua8mW5n6gn035HvblxXMh5qaFfcyHwj6A=;
        b=ZnaGW4VotYN/TUFZrVqiD4At4amctXRWpYomKC7ccAuo8/5+SHYcdmaBawhpt9GXVspx9D
        GAxa5DyO8Fr0YyobctOI8E7og26ohEAYVueGBqRsqOIMQoYBffrXcrjCGi620dYCyag4nq
        D/nYKQ8ZY61qhpM0GC/EYYc+yTW8ROE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-guHP0H5QNketTaNyOfavrw-1; Tue, 20 Apr 2021 11:46:28 -0400
X-MC-Unique: guHP0H5QNketTaNyOfavrw-1
Received: by mail-qk1-f199.google.com with SMTP id w186-20020a3762c30000b02902e385de333fso7017089qkb.8
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 08:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j1INruBx24Ua8mW5n6gn035HvblxXMh5qaFfcyHwj6A=;
        b=d+z6ylYzIcXkMcu+pQlTDu03OG5IYOfgQED8Z7VGuyN/Hm/ARqcXHGo3pkbJfYrcQs
         45aJNTBXHZWp/c1WecDu1y3FP5yoz1TwtOPcV4n0vb4IX5LSiZ6tzxOMV8vheZx9yxt6
         qkNMHjemwxhTQk3o+9BMpCdN+wZbNWuGhS6GeZX3IJ1jAhNR6CktRXxGkVj03rxYSniv
         L80arT19uP0NvvlRKK90dC5+jqPzZifQ6RdPF7Pp1ofz6cQu3UfFLPzrwz84+Y89q5aQ
         CG+ckPq1MsHh0tSsauLftp956Us15n6LnL8Ja2EGaPqN38hnwFQI4KsyIVOM8vZO4s2W
         QDIw==
X-Gm-Message-State: AOAM531vxRRRJV4/UUaDEedNZQK6L4NbehlxlhIE38zzqIaQDW3Fn6W5
        tLlM6UoElf3KXW6yp+y317oIuGdN48fCxyVDF1Q/PemFtnYdR1TXuGBXjn5GotfuJCaDNN77SaO
        jc425Vuruz8oKHRkHkWoKqEw=
X-Received: by 2002:a37:38f:: with SMTP id 137mr17412121qkd.498.1618933588210;
        Tue, 20 Apr 2021 08:46:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6NYuKtuKMEt8biboxN/WNrnfdnbDSXSGpiw0EYoPPbYA8ddcMRMsZxP29zxNos+pDvYXujw==
X-Received: by 2002:a37:38f:: with SMTP id 137mr17412079qkd.498.1618933587905;
        Tue, 20 Apr 2021 08:46:27 -0700 (PDT)
Received: from loberhel7laptop ([2600:6c64:4e7f:cee0:ccad:a4ca:9a69:d8bc])
        by smtp.gmail.com with ESMTPSA id k22sm12373407qkh.28.2021.04.20.08.46.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Apr 2021 08:46:27 -0700 (PDT)
Message-ID: <6a22337b0d15830d9117640bd227711ba8c8aef8.camel@redhat.com>
Subject: Re: [PATCH v3 0/4] nvme: improve error handling and ana_state to
 work well with dm-multipath
From:   Laurence Oberman <loberman@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Date:   Tue, 20 Apr 2021 11:46:26 -0400
In-Reply-To: <20210420143852.GB14523@redhat.com>
References: <20210416235329.49234-1-snitzer@redhat.com>
         <20210420093720.GA28874@lst.de> <20210420143852.GB14523@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2021-04-20 at 10:38 -0400, Mike Snitzer wrote:
> On Tue, Apr 20 2021 at  5:37am -0400,
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > > RHEL9 is coming, would really prefer that these changes land
> > > upstream
> > > rather than carry them within RHEL.
> > 
> > We've told from the very beginning that dm-multipth on nvme is not
> > a support configuration.
> 
> You have some high quality revisionist history there. But other than
> pointing that out I'm not going to dwell on our past discussions on
> how
> NVMe multipathing would be.
> 
> > Red Hat decided to ignore that and live with the pain.
> 
> Red Hat supports both native nvme-multipath _and_ DM-multipath on
> NVMe.
> 
> The only "pain" I've been living with is trying to get you to be
> impartial and allow others to provide Linux multipathing as they see
> fit.
> 
> > Your major version change is a chance to fix this up on the Red Hat
> > side, not to resubmit bogus patches upstream.
> 
> Please spare me the vapid and baseless assertion about patches you
> refuse to review technically without political motivation.
> 
> > In other words: please get your house in order NOW.
> 
> My simple 3 patch submission was an attempt to do so. Reality is the
> Linux NVMe maintainers need to get their collective house in order.
> 
> Until sanity prevails these NVMe changes will be carried in RHEL. And
> if
> you go out of your way to cause trivial, or elaborate, conflicts now
> that you _know_ that changes that are being carried it will be
> handled
> without issue.
> 
> Sad this is where we are but it is what it is.
> 
> Linux is about choice that is founded upon need. Hostile action that
> unilaterally limits choice is antithetical to Linux and Open Source.
> 
> Mike
> 

Hello

Let me add some reasons why as primarily a support person that this is
important and try avoid another combative situation. 

Customers depend on managing device-mapper-multipath the way it is now
even with the advent of nvme-over-F/C. Years of administration and
management for multiple Enterprise O/S vendor customers (Suse/Red Hat,
Oracle) all depend on managing multipath access in a transparent way.

I respect everybody's point of view here but native does change log
alerting and recovery and that is what will take time for customers to
adopt. 

It is going to take time for Enterprise customers to transition so all
we want is an option for them. At some point they will move to native
but we always like to keep in step with upstream as much as possible.

Of course we could live with RHEL-only for while but that defeats our
intention to be as close to upstream as possible.

If we could have this accepted upstream for now perhaps when customers
are ready to move to native only we could phase this out.

Any technical reason why this would not fly is of course important to
consider but perhaps for now we have a parallel option until we dont.

With due respect to all concerned.

Laurence Oberman

