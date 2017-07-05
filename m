Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41916 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751654AbdGEIPY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jul 2017 04:15:24 -0400
Date: Wed, 5 Jul 2017 10:15:17 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: hch@lst.de, sagi@grimberg.me, Keith Busch <keith.busch@intel.com>,
        axboe@fb.com, bvanassche@acm.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, vladimirk@mellanox.com
Subject: Re: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
Message-ID: <20170705081517.GC4076@linux-x5ow.site>
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
 <20170705075905.GB4076@linux-x5ow.site>
 <fcc21db2-c3fe-48d7-a33a-5eedac00c2bd@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <fcc21db2-c3fe-48d7-a33a-5eedac00c2bd@mellanox.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jul 05, 2017 at 11:11:36AM +0300, Max Gurtovoy wrote:
> Hi Johannes,
> this was merge already to the main tree (Jens add it to his pull request)

Oops, sorry for the noise.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
