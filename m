Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39717 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEVdC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2017 17:33:02 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v4 07/11] blk-mq: use QUEUE_FLAG_QUIESCED to quiesce queue
Date: Mon, 5 Jun 2017 21:32:59 +0000
Message-ID: <1496698378.2623.28.camel@sandisk.com>
References: <20170605155925.7896-1-ming.lei@redhat.com>
         <20170605155925.7896-8-ming.lei@redhat.com>
In-Reply-To: <20170605155925.7896-8-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2017-06-05 at 23:59 +0800, Ming Lei wrote:
> It is required that no dispatch can happen any more once
> blk_mq_quiesce_queue() returns, and we don't have such requirement
> on APIs of stopping queue.
>=20
> But blk_mq_quiesce_queue() still may not block/drain dispatch in the
> the case of BLK_MQ_S_START_ON_RUN, so use the new introduced flag of
> QUEUE_FLAG_QUIESCED and evaluate it inside RCU read-side critical
> sections for fixing this issue.
>=20
> Also blk_mq_quiesce_queue() is implemented via stopping queue, which
> limits its uses, and easy to cause race, because any queue restart in
> other paths may break blk_mq_quiesce_queue(). With the introduced
> flag of QUEUE_FLAG_QUIESCED, we don't need to depend on stopping queue
> for quiescing any more.

Hello Ming,

Since this patch depends on patch 1 I will wait with reviewing this patch
until there is agreement about patch 1 in this series.

Bart.=
