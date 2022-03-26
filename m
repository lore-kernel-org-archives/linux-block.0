Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBC4C433F5
	for <linux-block@archiver.kernel.org>; Sat, 26 Mar 2022 08:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiCZI7i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Mar 2022 04:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiCZI7g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Mar 2022 04:59:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638872963F2
        for <linux-block@vger.kernel.org>; Sat, 26 Mar 2022 01:58:00 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nY2FB-0002cj-KB; Sat, 26 Mar 2022 09:57:57 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nY2F9-0001JP-Jh; Sat, 26 Mar 2022 09:57:55 +0100
Date:   Sat, 26 Mar 2022 09:57:55 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 4/4] block/mq-deadline: Prioritize high-priority
 requests
Message-ID: <20220326085755.GB27264@pengutronix.de>
References: <20210927220328.1410161-1-bvanassche@acm.org>
 <20210927220328.1410161-5-bvanassche@acm.org>
 <Yj22kLrsw+z7sj7R@pengutronix.de>
 <180dc22b-4fee-93c2-9813-1b4f109b5dc7@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <180dc22b-4fee-93c2-9813-1b4f109b5dc7@acm.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:50:39 up 105 days, 17:36, 57 users,  load average: 0.10, 0.07,
 0.07
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-block@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 25, 2022 at 10:05:43AM -0700, Bart Van Assche wrote:
> On 3/25/22 05:33, Oleksij Rempel wrote:
> > I have regression on iMX6 + USB storage device with this patch.
> > After plugging USB Flash driver (in my case USB3 Intenso 32GB) and
> > running mount /dev/sda1 /mnt, the command will never exit.
> > 
> > Reverting this patchs (322cff70d46) on top of v5.17 solves it for me.
> > 
> > How can I help you to debug this issue?
> 
> That is unexpected. Is there perhaps something special about the USB
> stick for which the hang occurs, e.g. the queue depth it supports is
> low? Can you please share the output of the following commands after
> having inserted the USB stick that triggers the hang?
> 
> (cd /sys/class && grep -aH . scsi_host/*/can_queue scsi_device/*/device/{blacklist,inquiry,model,queue*,vendor}) | sort

Here it is:
root@test:/sys/class cat scsi_host/*/can_queue
1
root@test:/sys/class cat scsi_device/*/device/blacklist
root@test:/sys/class cat scsi_device/*/device/inquiry
Intenso Speed Line      1.00
root@test:/sys/class cat scsi_device/*/device/model
Speed Line      
root@test:/sys/class cat scsi_device/*/device/queue*
1
none
root@test:/sys/class cat scsi_device/*/device/vendor
Intenso 

I do not know, if there is something special about it. If needed, i can
take it apart to see what controller is used.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
