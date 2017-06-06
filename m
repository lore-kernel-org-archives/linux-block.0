Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:2665 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdFFQGw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jun 2017 12:06:52 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v5 03/12] blk-mq: move blk_mq_quiesce_queue() into
 include/linux/blk-mq.h
Date: Tue, 6 Jun 2017 16:06:49 +0000
Message-ID: <1496765208.2692.9.camel@sandisk.com>
References: <20170606152210.22806-1-ming.lei@redhat.com>
         <20170606152210.22806-4-ming.lei@redhat.com>
In-Reply-To: <20170606152210.22806-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2017-06-06 at 23:22 +0800, Ming Lei wrote:
> We usually put blk_mq_*() into include/linux/blk-mq.h, so
> move this API into there.

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
