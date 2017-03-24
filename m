Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:33840 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbdCXR3o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2017 13:29:44 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "axboe@fb.com" <axboe@fb.com>
CC: "hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH v2 3/4] block: rename blk_mq_freeze_queue_start()
Date: Fri, 24 Mar 2017 17:29:24 +0000
Message-ID: <1490376549.3312.3.camel@sandisk.com>
References: <20170324123621.5227-1-tom.leiming@gmail.com>
         <20170324123621.5227-4-tom.leiming@gmail.com>
In-Reply-To: <20170324123621.5227-4-tom.leiming@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-03-24 at 20:36 +0800, Ming Lei wrote:
> As the .q_usage_counter is used by both legacy and
> mq path, we need to block new I/O if queue becomes
> dead in blk_queue_enter().
>=20
> So rename it and we can use this function in both
> pathes.

Should "pathes" be changed into "paths" in the commit message? Additionally=
,
this patch breaks the symmetry the comment in blk_mq_freeze_queue() refers
to. Anyway:

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=
