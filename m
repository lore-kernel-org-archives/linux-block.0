Return-Path: <SRS0=DC0a=XA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9892C43331
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 23:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB52206B8
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 23:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfIEXSd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Sep 2019 19:18:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfIEXSd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Sep 2019 19:18:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08B4DC057E9A;
        Thu,  5 Sep 2019 23:18:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AB5E60BE1;
        Thu,  5 Sep 2019 23:18:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wgbCXea1a9OTWgMMvcsCGGiNiPp+ty-edZrBWn63NCYdw@mail.gmail.com>
References: <CAHk-=wgbCXea1a9OTWgMMvcsCGGiNiPp+ty-edZrBWn63NCYdw@mail.gmail.com> <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk> <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com> <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com> <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com> <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com> <5396.1567719164@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Ray Strode <rstrode@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Ray, Debarshi" <debarshi.ray@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>
Subject: Re: Why add the general notification queue and its sources
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14882.1567725508.1@warthog.procyon.org.uk>
Date:   Fri, 06 Sep 2019 00:18:28 +0100
Message-ID: <14883.1567725508@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 05 Sep 2019 23:18:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> But I know - we *have* one of those. There's already a system call for
> it, and has been forever. One that we then extended to allow people to
> change the buffer size, and do a lot of other things with.
> 
> It's called "pipe()". And you can give the writing side to other user
> space processes too, in case you are running an older kernel that
> didn't have some "event pipe support". It comes with resource
> management, because people already use those things.

Can you write into a pipe from softirq context and/or with spinlocks held
and/or with the RCU read lock held?  That is a requirement.  Another is that
messages get inserted whole or not at all (or if they are truncated, the size
field gets updated).

Since one end would certainly be attached to an fd, it looks on the face of it
that writing into the pipe would require taking pipe->mutex.

David
