Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:57204 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdFEXzY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2017 19:55:24 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v4 10/11] blk-mq: clarify dispatch may not be
 drained/blocked by stopping queue
Date: Mon, 5 Jun 2017 23:55:20 +0000
Message-ID: <1496706919.2623.36.camel@sandisk.com>
References: <20170605155925.7896-1-ming.lei@redhat.com>
         <20170605155925.7896-11-ming.lei@redhat.com>
In-Reply-To: <20170605155925.7896-11-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2017-06-05 at 23:59 +0800, Ming Lei wrote:
> +/*
> + * We do not guarantee that dispatch can be drained or blocked
> + * after blk_mq_stop_hw_queue() returns. Please use
> + * blk_mq_quiesce_queue() for that requirement.
> + */

Hello Ming,

This is comment explains what blk_mq_stop_hw_queue() should not be used for
and may leave the reader wondering what it is useful for. How about mention=
ing
first that this function is useful to pause .queue_rq() calls as long as th=
e
block driver it will have to return BUSY if .queue_rq() is called?

Bart.=
