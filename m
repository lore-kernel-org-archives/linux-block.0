Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:40311 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdGMRop (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2017 13:44:45 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH 2/6] SCSI: use blk_mq_run_hw_queues() in scsi_kick_queue()
Date: Thu, 13 Jul 2017 17:44:41 +0000
Message-ID: <1499967879.2740.8.camel@wdc.com>
References: <20170711182103.11461-1-ming.lei@redhat.com>
         <20170711182103.11461-3-ming.lei@redhat.com>
         <1499803071.2586.29.camel@wdc.com> <20170712031503.GG13036@ming.t460p>
         <1499872355.2554.1.camel@wdc.com> <20170713102343.GA19857@ming.t460p>
In-Reply-To: <20170713102343.GA19857@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-07-13 at 18:23 +0800, Ming Lei wrote:
> Please discuss the congestion control in patch 4 and 5.

Hello Ming,

Since there is a significant risk that this patch series will introduce
performance and/or functional regressions, I will wait with reviewing this
patch series further until it has been shown that there is no less risky
alternative to realize the same performance improvement. I think Jens had
already suggested a possible alternative, namely by only starting a queue
if it really has to be started.

Bart.=
