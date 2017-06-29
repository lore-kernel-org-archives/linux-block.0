Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:55174 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753350AbdF2Ob2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2017 10:31:28 -0400
Date: Thu, 29 Jun 2017 16:31:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me, bvanassche@acm.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        vladimirk@mellanox.com
Subject: Re: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
Message-ID: <20170629143125.GA16129@lst.de>
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
