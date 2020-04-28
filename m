Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9CCC83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 14:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8D3206D7
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 14:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgD1OVz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:21:55 -0400
Received: from verein.lst.de ([213.95.11.211]:56535 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbgD1OVz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 10:21:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 67E6D68CEC; Tue, 28 Apr 2020 16:21:52 +0200 (CEST)
Date:   Tue, 28 Apr 2020 16:21:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/4] block: cleanup the memory stall accounting in
 submit_bio
Message-ID: <20200428142152.GA5439@lst.de>
References: <20200428112756.1892137-1-hch@lst.de> <20200428112756.1892137-3-hch@lst.de> <SN4PR0401MB3598CF483E12950DE63C1B719BAC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598CF483E12950DE63C1B719BAC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 28, 2020 at 02:12:49PM +0000, Johannes Thumshirn wrote:
> On 28/04/2020 13:28, Christoph Hellwig wrote:
> > Instead of a convoluted chain just check for REQ_OP_READ directly,
> > and keep all the memory stall code together in a single unlikely
> > branch.
> 
> Looks good, I just have one question, why the 'unlikely' annotation for 
> the psi code?
> 
> In the current code, the psi path is not "unlikely" (only 
> REQ_OP_WRITE_SAME is). Is there any measurable benefit coming from the 
> annotation?

Following the unlikely check in __bio_add_page that Johanness added
there with the original addition.
