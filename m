Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:13737 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbdE3Qyt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2017 12:54:49 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v2 4/8] blk-mq: fix blk_mq_quiesce_queue
Date: Tue, 30 May 2017 16:54:47 +0000
Message-ID: <1496163285.2627.9.camel@sandisk.com>
References: <20170527142126.26079-1-ming.lei@redhat.com>
         <20170527142126.26079-5-ming.lei@redhat.com>
         <1495921605.13651.2.camel@sandisk.com> <20170528104400.GB6488@ming.t460p>
         <1495987808.2849.5.camel@sandisk.com> <20170530002227.GA29253@ming.t460p>
In-Reply-To: <20170530002227.GA29253@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2017-05-30 at 08:22 +0800, Ming Lei wrote:
> On Sun, May 28, 2017 at 04:10:09PM +0000, Bart Van Assche wrote:
> > I really would like to see the blk_queue_quiesced() tests as close as p=
ossible to
> > the blk_mq_hctx_stopped() tests. But I agree that we need a way to docu=
ment and/or
>=20
> Could you explain why we have to do that? And checking on stopped state
> doesn't need to hold RCU/SRCU read lock, and that two states are really
> different.

I'm really surprised that you ask me why ... It's because the purpose of th=
e
"stopped" and "quiesced" flags is similar, namely preventing that dispatchi=
ng
requests happens. It doesn't matter that with your patches applied it is no
longer needed to hold an RCU / SRCU lock when testing the stopped flag.

> > verify that these tests occur with an RCU read-side lock held. Have you=
 considered
> > to use rcu_read_lock_held() to document this?
>=20
> Then we need to check if it is RCU or SRCU, and make code ugly as
> current check on BLOCKING.

How about introducing a macro or inline function in the block layer that te=
sts
whether either the RCU read lock or an SRCU read lock is held depending on =
the
value of the BLK_MQ_F_BLOCKING flag?

Bart.=
