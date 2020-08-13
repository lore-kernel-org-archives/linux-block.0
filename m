Return-Path: <SRS0=n79e=BX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C13C433E1
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 15:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E877F20781
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 15:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHMPsB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:48:01 -0400
Received: from verein.lst.de ([213.95.11.211]:46812 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgHMPsA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Aug 2020 11:48:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 21F4E68AFE; Thu, 13 Aug 2020 17:47:58 +0200 (CEST)
Date:   Thu, 13 Aug 2020 17:47:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
        axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, kbusch@kernel.org
Subject: Re: [PATCH 2/3] nvme-core: delete the dependency on blk status
Message-ID: <20200813154757.GA14486@lst.de>
References: <20200812081844.22224-1-lengchao@huawei.com> <20200812151035.GB29544@lst.de> <20200812202829.GA586@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812202829.GA586@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 12, 2020 at 04:28:30PM -0400, Mike Snitzer wrote:
> On Wed, Aug 12 2020 at 11:10am -0400,
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Wed, Aug 12, 2020 at 04:18:44PM +0800, Chao Leng wrote:
> > > nvme should not depend on blk status, just need check nvme status.
> > > Just need do translating nvme status to blk status for returning error.
> > 
> > While this doesn't look wrong it also doesn't save us a single
> > instruction and actually adds more lines of code.  Do you have a good
> > reason for this change?
> 
> It certainly saves nvme_error_status(nvme_req(req)->status if
> nvme_req_needs_retry().

Yeah, but the retry path isn't exactly the fast path, is it?

Not that I really care too much about this one..
