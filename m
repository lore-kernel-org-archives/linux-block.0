Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29436 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdE3TXl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2017 15:23:41 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v2 4/8] blk-mq: fix blk_mq_quiesce_queue
Date: Tue, 30 May 2017 19:23:31 +0000
Message-ID: <1496172210.2627.24.camel@sandisk.com>
References: <20170527142126.26079-1-ming.lei@redhat.com>
         <20170527142126.26079-5-ming.lei@redhat.com>
         <1495921605.13651.2.camel@sandisk.com> <20170528104400.GB6488@ming.t460p>
In-Reply-To: <20170528104400.GB6488@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, 2017-05-28 at 18:44 +0800, Ming Lei wrote:
> First it is really a fix, and then a improvement, so could you tell me
> where is wrong with the title and the description?

Hello Ming,

Can you explain me why you want to keep the=A0blk_mq_stop_hw_queues() call =
in
nvme_suspend_queue()? Since immediately after that call the NVMe driver sta=
rts
freeing resources, shouldn't that call be changed into a call of
blk_mq_quiesce_queue()? I think the same comment also applies to the
blk_mq_stop_hw_queues() calls in nvme_rdma_error_recovery_work() and
nvme_rdma_shutdown_ctrl().

Bart.=
