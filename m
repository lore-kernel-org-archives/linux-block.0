Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55705 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751698AbdF1NHI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 09:07:08 -0400
Date: Wed, 28 Jun 2017 15:07:02 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me, bvanassche@acm.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        vladimirk@mellanox.com
Subject: Re: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
Message-ID: <20170628130702.GQ4185@linux-x5ow.site>
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 28, 2017 at 03:44:40PM +0300, Max Gurtovoy wrote:
> This patch performs sequential mapping between CPUs and queues.
> In case the system has more CPUs than HWQs then there are still
> CPUs to map to HWQs. In hyperthreaded system, map the unmapped CPUs
> and their siblings to the same HWQ.
> This actually fixes a bug that found unmapped HWQs in a system with
> 2 sockets, 18 cores per socket, 2 threads per core (total 72 CPUs)
> running NVMEoF (opens upto maximum of 64 HWQs).

>From a first look at it, it looks good.
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
