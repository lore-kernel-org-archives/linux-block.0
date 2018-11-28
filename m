Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5D8C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAE22082F
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAE22082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeK1SAs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:00:48 -0500
Received: from verein.lst.de ([213.95.11.211]:35054 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727463AbeK1SAs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 13:00:48 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A0CE468C46; Wed, 28 Nov 2018 08:00:10 +0100 (CET)
Date:   Wed, 28 Nov 2018 08:00:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv4 0/3] scsi timeout handling updates
Message-ID: <20181128070010.GA20369@lst.de>
References: <20181126165430.4519-1-keith.busch@intel.com> <b9813c10-776f-46fc-15d4-bbd675edc402@kernel.dk> <20181128021959.GG11128@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128021959.GG11128@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 10:20:01AM +0800, Ming Lei wrote:
> On Mon, Nov 26, 2018 at 10:33:32AM -0700, Jens Axboe wrote:
> > On 11/26/18 9:54 AM, Keith Busch wrote:
> > > The iterative update to the previous version taking into account review
> > > comments.
> > > 
> > > Background:
> > > 
> > > The main objective is to remove the generic block layer's lock prefix
> > > currently required to transition a request to its completed state by
> > > shifting that expense to lower level drivers that actually need it,
> > > and removing the software layering violation that was required to use
> > > that mechnaism.
> > 
> > Thanks Keith, added for 4.21.
> 
> Hi Jens & Keith,
> 
> Seems this patchset causes the following kernel panic, since not see
> this issue with commit 4ab32bf3305e

Is this the nvme target on top of null_blk?
