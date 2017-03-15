Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:25996 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753144AbdCOPgq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2017 11:36:46 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "tom.leiming@gmail.com" <tom.leiming@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "yizhan@redhat.com" <yizhan@redhat.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] blk-mq: don't complete un-started request in
 timeout handler
Date: Wed, 15 Mar 2017 15:36:31 +0000
Message-ID: <1489592177.2660.1.camel@sandisk.com>
References: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
         <1489064578-17305-3-git-send-email-tom.leiming@gmail.com>
         <1489536441.2676.21.camel@sandisk.com> <20170315121851.GA15807@ming.t460p>
         <20170315124024.GA16549@ming.t460p>
In-Reply-To: <20170315124024.GA16549@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-03-15 at 20:40 +0800, Ming Lei wrote:
> On Wed, Mar 15, 2017 at 08:18:53PM +0800, Ming Lei wrote:
> > On Wed, Mar 15, 2017 at 12:07:37AM +0000, Bart Van Assche wrote:
> >=20
> > > or __blk_mq_requeue_request(). Another issue with this function is th=
at the
> >=20
> > __blk_mq_requeue_request() can be run from two pathes:
> >=20
> > 	- dispatch failure, in which case the req/tag isn't released to tag se=
t
> > =09
> > 	- IO completion path, in which COMPLETE flag is cleared before requeue=
.
> > =09
> > so I can't see races with timeout in case of start rq vs. requeue rq.=20
>=20
> Actually rq/tag won't be released to tag set if it will be requeued, so
> the timeout race is nothing to do with requeue.

Hello Ming,

Please have another look at __blk_mq_requeue_request(). In that function
the following code occurs: if (test_and_clear_bit(REQ_ATOM_STARTED,
&rq->atomic_flags)) { ... }

I think the=A0REQ_ATOM_STARTED check in blk_mq_check_expired() races with t=
he
test_and_clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags) call in
__blk_mq_requeue_request().

Bart.=
