Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:46468 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965576AbdACScg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2017 13:32:36 -0500
Date: Tue, 3 Jan 2017 19:32:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
        Tejun Heo <tj@kernel.org>, Omar Sandoval <osandov@osandov.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        baolin.wang@linaro.org, riteshh@codeaurora.org, arnd@arndb.de,
        zhang.chunyan@linaro.org, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH PoCv2 1/2] Revert "mmc: queue: Share mmc request array
 between partitions"
Message-ID: <20170103183253.GB4699@kroah.com>
References: <1483464618-16133-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170103173119epcas5p32d141b74cc44c2eb5197695d66829720@epcas5p3.samsung.com>
 <1483464618-16133-2-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1483464618-16133-2-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 03, 2017 at 06:30:17PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Shared mmc queue changes break mmc-mq ones currently.
> 
> This reverts commit 6540ce8420b7790ef0696ccfd6e911df7ba84c33.
> 
> Conflicts:
> 	drivers/mmc/core/queue.c

Why are these lines in your changelog?

Please remove...

