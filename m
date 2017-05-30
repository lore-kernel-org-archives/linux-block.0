Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:48673 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdE3ROz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2017 13:14:55 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v2 5/8] blk-mq: update comments on blk_mq_quiesce_queue()
Date: Tue, 30 May 2017 17:14:44 +0000
Message-ID: <1496164482.2627.13.camel@sandisk.com>
References: <20170527142126.26079-1-ming.lei@redhat.com>
         <20170527142126.26079-6-ming.lei@redhat.com>
In-Reply-To: <20170527142126.26079-6-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, 2017-05-27 at 22:21 +0800, Ming Lei wrote:
>  /**
> - * blk_mq_quiesce_queue() - wait until all ongoing queue_rq calls have f=
inished
> + * blk_mq_quiesce_queue() - wait until all ongoing dispatching have fini=
shed
>   * @q: request queue.
>   *

Hello Ming,

The concept of dispatching does not have a meaning to block driver authors =
who are
not familiar with the block layer internals. However, every author of a blk=
-mq driver
knows what the .queue_rq() function is. Additionally, the new comment is gr=
ammatically
incorrect. So the above change looks like a step in the wrong direction to =
me.

Bart.=
