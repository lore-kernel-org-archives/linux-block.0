Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:42026 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbdCOVe6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2017 17:34:58 -0400
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
Date: Wed, 15 Mar 2017 21:34:50 +0000
Message-ID: <1489613676.2660.8.camel@sandisk.com>
References: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
         <1489064578-17305-3-git-send-email-tom.leiming@gmail.com>
         <1489536441.2676.21.camel@sandisk.com> <20170315121851.GA15807@ming.t460p>
In-Reply-To: <20170315121851.GA15807@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-03-15 at 20:18 +0800, Ming Lei wrote:
> On Wed, Mar 15, 2017 at 12:07:37AM +0000, Bart Van Assche wrote:
> > Both the old and the new check look racy to me. The REQ_ATOM_STARTED bi=
t can
> > be changed concurrently by blk_mq_start_request(), __blk_mq_finish_requ=
est()
>=20
> blk_mq_start_request() and __blk_mq_finish_request() won't be run concurr=
ently.
>=20
> From view of __blk_mq_finish_request():
>=20
> 	- if it is run from merge queue io path(blk_mq_merge_queue_io()),
> 	blk_mq_start_request() can't be run at all, and the COMPLETE flag
> 	is kept as previous value(zero)
>=20
> 	- if it is run from normal complete path, COMPLETE flag is cleared
> 	before the req/tag is released to tag set.
>=20
> so there isn't race in blk_mq_start_request() vs. __blk_mq_finish_request=
()
> wrt. timeout.
>=20
> > or __blk_mq_requeue_request(). Another issue with this function is that=
 the
>=20
> __blk_mq_requeue_request() can be run from two pathes:
>=20
> 	- dispatch failure, in which case the req/tag isn't released to tag set
> =09
> 	- IO completion path, in which COMPLETE flag is cleared before requeue.
> =09
> so I can't see races with timeout in case of start rq vs. requeue rq.=20
>=20
> > request passed to this function can be reinitialized concurrently.

Hello Ming,

You misinterpret what I wrote. I was referring to manipulation of
REQ_ATOM_STARTED from different contexts and not to what you explained.

Bart.=
