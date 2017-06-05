Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58646 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEVbN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2017 17:31:13 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v4 04/11] blk-mq: introduce blk_mq_unquiesce_queue
Date: Mon, 5 Jun 2017 21:31:10 +0000
Message-ID: <1496698269.2623.26.camel@sandisk.com>
References: <20170605155925.7896-1-ming.lei@redhat.com>
         <20170605155925.7896-5-ming.lei@redhat.com>
In-Reply-To: <20170605155925.7896-5-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2017-06-05 at 23:59 +0800, Ming Lei wrote:
> blk_mq_start_stopped_hw_queues() is used implictely
                                           ^^^^^^^^^^
                                           implicitly?
> as counterpart of blk_mq_quiesce_queue() for unquiescing queue,
> so we introduce blk_mq_unquiesce_queue() and make it
> as counterpart of blk_mq_quiesce_queue() explicitely.
                                           ^^^^^^^^^^^
                                           explicitly?

Anyway:

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>
