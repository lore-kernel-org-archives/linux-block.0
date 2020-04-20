Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A26C3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 17:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78EA2145D
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 17:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgDTR0G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:26:06 -0400
Received: from verein.lst.de ([213.95.11.211]:42044 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgDTR0G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 13:26:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5E0E868C4E; Mon, 20 Apr 2020 19:26:04 +0200 (CEST)
Date:   Mon, 20 Apr 2020 19:26:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: more partition handling cleanups v2
Message-ID: <20200420172604.GA1562@lst.de>
References: <20200414072902.324936-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414072902.324936-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 14, 2020 at 09:28:52AM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up more lose ends in the partitioning code.  It also
> removes a rather annoying use of ioctl_by_bdev in the s390 dasd driver.
> 
> Changes since v1:
>  - fix a brown paperbag typo in blkpg_do_ioctl
>  - fix a commit message typo

ping?  This is the first of a few series to eventually kill
ioctl_by_bdev, so I'd like to get things moving.
