Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5078C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 13:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9882084F
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 13:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbfBUNhC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:37:02 -0500
Received: from verein.lst.de ([213.95.11.211]:36381 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUNhC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 08:37:02 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E0B1A68CEB; Thu, 21 Feb 2019 14:37:00 +0100 (CET)
Date:   Thu, 21 Feb 2019 14:37:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
Message-ID: <20190221133700.GA20189@lst.de>
References: <20190220031122.GA17298@ming.t460p> <20190220141701.GA26537@lst.de> <SN6PR04MB45276D80E3181896ABF39D1E867D0@SN6PR04MB4527.namprd04.prod.outlook.com> <yq1tvgyhxyv.fsf@oracle.com> <722BE5B7-B32B-4B2F-9AC2-E6F5AB5E12D4@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <722BE5B7-B32B-4B2F-9AC2-E6F5AB5E12D4@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 21, 2019 at 01:29:57AM +0000, Chaitanya Kulkarni wrote:
> Hi Martin,
> 
> I don't mind going though that route, here are some points about
> benefits of not using REQ_SPECIAL_PAYLOAD for write-zeroes :-
> 
> 1. We are using RQF_SPECIAL_PAYLOAD for only discard commands and not for
>      write-zeroes because it does not have any payload. Using this in the code will
>      trigger more code changes to handle in the completion path.

Yes.  And that is the big difference to SCSI where REQ_OP_WRITE_ZEROES
turns into a WRITE SAME command that has a payload.  So for SCSI
RQF_SPECIAL_PAYLOAD for REQ_OP_WRITE_ZEROES makes a lot of sense, for
NVMe it does not.
