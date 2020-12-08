Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D7AC4167B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 09:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E356423A81
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 09:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgLHJ03 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 04:26:29 -0500
Received: from verein.lst.de ([213.95.11.211]:45451 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728710AbgLHJ03 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Dec 2020 04:26:29 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 588796736F; Tue,  8 Dec 2020 10:25:45 +0100 (CET)
Date:   Tue, 8 Dec 2020 10:25:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/6] block: propagate BLKROSET on the whole device to
 all partitions
Message-ID: <20201208092545.GA13901@lst.de>
References: <20201207131918.2252553-1-hch@lst.de> <20201207131918.2252553-5-hch@lst.de> <yq1y2i8x42d.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1y2i8x42d.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 08, 2020 at 12:27:41AM -0500, Martin K. Petersen wrote:
> 
> Christoph,
> 
> > The existing behavior is inconsistent in the sense that doing:
> >
> > permits writes. But:
> >
> > <something triggers revalidate>
> >
> > doesn't.
> >
> > And a subsequent:
> 
> Looks like the command line pieces got zapped from the commit
> description.

Yeah.  It seems like git commit just removed them after I pasted them,
weird.
