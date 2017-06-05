Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36941 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEVb4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2017 17:31:56 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v4 05/11] blk-mq: use the introduced
 blk_mq_unquiesce_queue()
Date: Mon, 5 Jun 2017 21:31:52 +0000
Message-ID: <1496698311.2623.27.camel@sandisk.com>
References: <20170605155925.7896-1-ming.lei@redhat.com>
         <20170605155925.7896-6-ming.lei@redhat.com>
In-Reply-To: <20170605155925.7896-6-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2017-06-05 at 23:59 +0800, Ming Lei wrote:
> blk_mq_unquiesce_queue() is used for unquiescing the
> queue explicitly, so replace blk_mq_start_stopped_hw_queues()
> with it.

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
