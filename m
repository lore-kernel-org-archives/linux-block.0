Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C27C4360F
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 08:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4232075D
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 08:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbfC0IU5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:20:57 -0400
Received: from verein.lst.de ([213.95.11.211]:40472 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfC0IU5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 04:20:57 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3C48268B05; Wed, 27 Mar 2019 09:20:47 +0100 (CET)
Date:   Wed, 27 Mar 2019 09:20:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Martin Wilck <mwilck@suse.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/5] block: disk_events: introduce event flags
Message-ID: <20190327082047.GI20525@lst.de>
References: <20190322224353.11088-1-mwilck@suse.com> <20190322224353.11088-3-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322224353.11088-3-mwilck@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Abusing the same field for the events and flags seems to be asking
for trouble, an you please split it into separate fields?

>  	for (i = 0; i < ARRAY_SIZE(disk_uevents); i++)
> -		if (events & disk->events & (1 << i))
> +		if (events & disk->events & (1 << i) &&
> +		    disk->events & DISK_EVENT_FLAG_UEVENT)

I think this wants some braces around the flag check as well.
