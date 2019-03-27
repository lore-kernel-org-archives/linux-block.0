Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013ACC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 08:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D027A2075D
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 08:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbfC0IV5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:21:57 -0400
Received: from verein.lst.de ([213.95.11.211]:40496 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfC0IV5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 04:21:57 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C4A5368C4E; Wed, 27 Mar 2019 09:21:47 +0100 (CET)
Date:   Wed, 27 Mar 2019 09:21:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Martin Wilck <mwilck@suse.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH RESEND v2 4/5] Revert "block: unexport
 DISK_EVENT_MEDIA_CHANGE for legacy/fringe drivers"
Message-ID: <20190327082147.GK20525@lst.de>
References: <20190322224353.11088-1-mwilck@suse.com> <20190322224353.11088-5-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322224353.11088-5-mwilck@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 22, 2019 at 11:43:52PM +0100, Martin Wilck wrote:
> This reverts commit 9fd097b14918875bd6f125ed699d7bbbba5893ee.
> 
> Instead of leaving disk->events completely empty, we now export the
> supported events again, and tell the block layer not to forward events to
> user space by not setting DISK_EVENT_FLAG_UEVENT. This allows the block
> layer to distinguish between devices that for which events should be
> handled in kernel only, and devices which don't support any meda change
> events at all.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
