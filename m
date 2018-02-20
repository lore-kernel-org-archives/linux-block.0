Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750884AbeBTKNM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Feb 2018 05:13:12 -0500
Date: Tue, 20 Feb 2018 11:13:11 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, Ming Lei <ming.lei@redhat.com>,
        linux-nvme@lists.infradead.org
Subject: Re: how can one drain MQ request queue ?
Message-ID: <20180220101311.aoe7m57kwm5ejb2a@linux-x5ow.site>
References: <a8d50fdf-1ed9-1f10-1ac9-4cbbf223cb8b@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <a8d50fdf-1ed9-1f10-1ac9-4cbbf223cb8b@mellanox.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Feb 20, 2018 at 11:56:07AM +0200, Max Gurtovoy wrote:
> hi all,
> is there a way to drain a blk-mq based request queue (similar to
> blk_drain_queue for non MQ) ?

I _think_ you can do a echo run >
/sys/kernel/debug/block/nvmeXnX/hctxX/state and that should trigger
it.

Hope that helps.

Byte,
     Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
