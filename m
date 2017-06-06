Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3495 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbdFFQQX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jun 2017 12:16:23 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v5 02/12] blk-mq: fix direct issue
Date: Tue, 6 Jun 2017 16:02:52 +0000
Message-ID: <1496764970.2692.7.camel@sandisk.com>
References: <20170606152210.22806-1-ming.lei@redhat.com>
         <20170606152210.22806-3-ming.lei@redhat.com>
In-Reply-To: <20170606152210.22806-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2017-06-06 at 23:22 +0800, Ming Lei wrote:
> If queue is stopped, we shouldn't dispatch request into driver and
> hardware, unfortunately the check is removed in bd166ef183c2(blk-mq-sched=
:
> add framework for MQ capable IO schedulers).
>=20
> This patch fixes the issue by moving the check back into
> __blk_mq_try_issue_directly().
>=20
> This patch fixes request use-after-free[1][2] during canceling requets
> of NVMe in nvme_dev_disable(), which can be triggered easily during
> NVMe reset & remove test.

Although I'm not convinced that this patch fixes [2], the patch itself look=
s
fine to me. Hence:

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
