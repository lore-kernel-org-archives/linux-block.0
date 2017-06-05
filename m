Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56972 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEVjZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2017 17:39:25 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v4 11/11] Revert "blk-mq: don't use sync workqueue
 flushing from drivers"
Date: Mon, 5 Jun 2017 21:39:23 +0000
Message-ID: <1496698761.2623.32.camel@sandisk.com>
References: <20170605155925.7896-1-ming.lei@redhat.com>
         <20170605155925.7896-12-ming.lei@redhat.com>
In-Reply-To: <20170605155925.7896-12-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2017-06-05 at 23:59 +0800, Ming Lei wrote:
> This patch reverts commit 2719aa217e0d02(blk-mq: don't use
> sync workqueue flushing from drivers) because only
> blk_mq_quiesce_queue() need the sync flush, and now
> we don't need to stop queue any more, so revert it.
>=20
> Also changes to cancel_delayed_work() in blk_mq_stop_hw_queue().

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>
