Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59145 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdFFQWL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jun 2017 12:22:11 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v5 11/12] blk-mq: clarify dispatch may not be
 drained/blocked by stopping queue
Date: Tue, 6 Jun 2017 16:07:48 +0000
Message-ID: <1496765266.2692.10.camel@sandisk.com>
References: <20170606152210.22806-1-ming.lei@redhat.com>
         <20170606152210.22806-12-ming.lei@redhat.com>
In-Reply-To: <20170606152210.22806-12-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2017-06-06 at 23:22 +0800, Ming Lei wrote:
> BLK_MQ_S_STOPPED may not be observed in other concurrent I/O paths,
> we can't guarantee that dispatching won't happen after returning
> from the APIs of stopping queue.
>=20
> So clarify the fact and avoid potential misuse.

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
