Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD4EC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 08:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E492075D
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 08:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbfC0ISL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:18:11 -0400
Received: from verein.lst.de ([213.95.11.211]:40436 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfC0ISL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 04:18:11 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 239D668B05; Wed, 27 Mar 2019 09:18:02 +0100 (CET)
Date:   Wed, 27 Mar 2019 09:18:01 +0100
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
Subject: Re: [PATCH RESEND v2 1/5] block: genhd: remove async_events field
Message-ID: <20190327081801.GH20525@lst.de>
References: <20190322224353.11088-1-mwilck@suse.com> <20190322224353.11088-2-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322224353.11088-2-mwilck@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 22, 2019 at 11:43:49PM +0100, Martin Wilck wrote:
> The async_events field, intended to be used for drivers that
> support asynchronous notifications about disk events (aka
> media change events), isn't currently used by any driver,
> and apparently that has been that way for a long time
> (if not forever). Remove it.

Please use up all the available 72 lines for the changelog.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
