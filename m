Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17058 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbdFFP7j (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jun 2017 11:59:39 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v5 01/12] blk-mq: pass correct hctx to
 blk_mq_try_issue_directly
Date: Tue, 6 Jun 2017 15:59:30 +0000
Message-ID: <1496764769.2692.6.camel@sandisk.com>
References: <20170606152210.22806-1-ming.lei@redhat.com>
         <20170606152210.22806-2-ming.lei@redhat.com>
In-Reply-To: <20170606152210.22806-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2017-06-06 at 23:21 +0800, Ming Lei wrote:
> When direct issue is done on request picked up from plug list,
> the hctx need to be updated with the actual hw queue, otherwise
> wrong hctx is used and may hurt performance, especially when
> wrong SRCU readlock is acquired/released

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
