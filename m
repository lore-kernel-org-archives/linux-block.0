Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:8065 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdEBRes (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 May 2017 13:34:48 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH] block: don't call blk_mq_quiesce_queue() after queue is
 freezed
Date: Tue, 2 May 2017 17:34:46 +0000
Message-ID: <1493746485.2552.7.camel@sandisk.com>
References: <20170501232802.27219-1-ming.lei@redhat.com>
In-Reply-To: <20170501232802.27219-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2017-05-02 at 07:28 +0800, Ming Lei wrote:
> After queue is freezed, no request in this queue can be in use
> at all, so there can't be any .queue_rq() is running on this queue.
> It isn't necessary to call blk_mq_quiesce_queue() any more, so
> remove it in both elevator_switch_mq() and blk_mq_update_nr_requests().

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
