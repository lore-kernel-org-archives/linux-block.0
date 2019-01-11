Return-Path: <SRS0=DRnZ=PT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6828C43387
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 16:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A225F2177B
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 16:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbfAKQjh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:39:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:43374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731998AbfAKQjg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jan 2019 11:39:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B753AEF5;
        Fri, 11 Jan 2019 16:39:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Jan 2019 17:39:33 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, linux-block <linux-block@vger.kernel.org>,
        linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        jmoyer@redhat.com, avi@scylladb.com,
        linux-block-owner@vger.kernel.org
Subject: Re: [PATCHSET v2] io_uring IO interface
In-Reply-To: <CAOi1vP9B7Z5jm4vcLux8eOvixgWmC7V=zKBzGnOOJHYO1AhVwA@mail.gmail.com>
References: <20190110024404.25372-1-axboe@kernel.dk>
 <fe686e4316f9746c46b91fd58c984531@suse.de>
 <CAOi1vP9B7Z5jm4vcLux8eOvixgWmC7V=zKBzGnOOJHYO1AhVwA@mail.gmail.com>
Message-ID: <43189f1be5f03697f750631d31ffaed5@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-01-11 17:11, Ilya Dryomov wrote:
> On Fri, Jan 11, 2019 at 10:51 AM Roman Penyaev <rpenyaev@suse.de> 
> wrote:
>> 
>> Hi Jens,
>> 
>> That is interesting.  Recently I sent an rfc related to epoll uring:
>> 
>> https://lore.kernel.org/lkml/20190109164025.24554-1-rpenyaev@suse.de
>> 
>> which can be mapped to userspace and all ready events can be consumed
>> from it directly.  I am wondering, is it possible to make some common
>> API for all kind of ready events / urings, or it doesn't make any
>> sense?
> 
> I think you can use the new IOCB_CMD_POLL from Christoph and avoid
> epoll_wait() in favor of aio/io_uring interface, at least in new high
> performance applications.

Yeah, I saw this extension for aio from Christoph.  I was motivated to
extend epoll with uring to avoid constant recharging of file 
descriptors,
i.e. once you inserted descriptor to epoll you just consume events from
uring (of course in that particular case only edge triggered events are
supported).

Also recently for epoll I fixed contention on event callback making hot
path completely lockless, i.e. with uring epoll can become a nice thingy
in terms of performance.

But can any descriptor (on vfs layer) be extended to have a uring? To 
have
some common API? Then if event source (say socket) has a uring (do not
know how, just thoughts) and event destination (aio, epoll) has a uring,
then reading on userside can be a matter of traversing urings.

> Reaping events entirely in userspace (i.e.
> performing io_getevents() without entering the kernel) has been
> possible for a long time even with the existing aio interface.

True.

--
Roman
