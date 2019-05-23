Return-Path: <SRS0=5kok=TX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1BBC282DD
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 14:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519162175B
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 14:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfEWOHf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 May 2019 10:07:35 -0400
Received: from verein.lst.de ([213.95.11.211]:47070 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbfEWOHf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 May 2019 10:07:35 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 80A5968AFE; Thu, 23 May 2019 16:07:12 +0200 (CEST)
Date:   Thu, 23 May 2019 16:07:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/2] nvme: reset request timeouts during fw activation
Message-ID: <20190523140712.GA19598@lst.de>
References: <20190522174812.5597-1-keith.busch@intel.com> <20190522174812.5597-3-keith.busch@intel.com> <20190523101953.GA18805@ming.t460p> <20190523133428.GC14049@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523133428.GC14049@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 23, 2019 at 07:34:29AM -0600, Keith Busch wrote:
> Doh! Didn't hit that in testing, but point taken.
>  
> > Also reset still may come during activating FW, is that a problem?
> 
> IO timeout and user initiated resets should be avoided. A state machine
> addition may be useful here.

Yep.  It almost sounds like we'd want a PAUSED state where resets just
keep returning RESET_TIMER without any other action.
