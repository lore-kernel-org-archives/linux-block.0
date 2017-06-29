Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41389 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752042AbdF2Ia0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2017 04:30:26 -0400
Date: Thu, 29 Jun 2017 10:30:22 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, axboe@fb.com, hch@lst.de,
        bvanassche@acm.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, vladimirk@mellanox.com
Subject: Re: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
Message-ID: <20170629083022.GD3808@linux-x5ow.site>
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
 <37fea86b-ce87-ac03-e465-5daf62a456c4@grimberg.me>
 <1cc73f8d-3e9d-0f9f-2b71-60d2bc6ce7b5@mellanox.com>
 <81fe8f2a-1fba-730e-a4af-047a4e06bd1a@grimberg.me>
 <a681644a-95ed-c9c0-99fe-96f8529ec991@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <a681644a-95ed-c9c0-99fe-96f8529ec991@mellanox.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 28, 2017 at 08:11:23PM +0300, Max Gurtovoy wrote:
> Nevertheless, we should review and consider pushing my fixes to the block
> layer for other users of this mapping function.

Totally agree with it and it's easier to backport to let's say stable kernels.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
