Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36137 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933053AbdAHCRO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 Jan 2017 21:17:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170108020200.GA16312@cmpxchg.org>
References: <20161221221638.GD4758@dastard> <CA+55aFyb1jcdpavyZgZ4nedA0=6tLognyWcJXfOJjMPFTm5GWA@mail.gmail.com>
 <20161222001303.nvrtm22szn3hgxar@straylight.hirudinean.org>
 <20161222051322.GF4758@dastard> <CA+55aFza=cv6TGYh+Be1xz2x-G-U=vruhbmfGpHSqY1ocZrBeg@mail.gmail.com>
 <alpine.LSU.2.11.1612221204510.4476@eggly.anvils> <20161223073241.GA13584@cmpxchg.org>
 <20161223083329.GA13952@cmpxchg.org> <20170102211136.GA3189@cmpxchg.org>
 <20170103122825.GC3780@quack2.suse.cz> <20170108020200.GA16312@cmpxchg.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Jan 2017 18:17:12 -0800
Message-ID: <CA+55aFz8O1zxateQH0VZyi=vgTJvmzNVURae1nshSkkzsQynGA@mail.gmail.com>
Subject: Re: [4.10, panic, regression] iscsi: null pointer deref at iscsi_tcp_segment_done+0x20d/0x2e0
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Chris Leech <cleech@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Duncan <lduncan@suse.com>, open-iscsi@googlegroups.com,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dave Jones <davej@codemonkey.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Jan 7, 2017 at 6:02 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Linus? Andrew?

Looks fine to me. Will apply.

               Linus
