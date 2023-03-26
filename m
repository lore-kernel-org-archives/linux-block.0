Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E7CC7619A
	for <linux-block@archiver.kernel.org>; Sun, 26 Mar 2023 23:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCZXoe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Mar 2023 19:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCZXoe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Mar 2023 19:44:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A1449C1
        for <linux-block@vger.kernel.org>; Sun, 26 Mar 2023 16:44:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F27CE68BEB; Mon, 27 Mar 2023 01:44:29 +0200 (CEST)
Date:   Mon, 27 Mar 2023 01:44:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/2] Submit split bios in LBA order
Message-ID: <20230326234429.GB20017@lst.de>
References: <20230317195938.1745318-1-bvanassche@acm.org> <20230318062909.GB24880@lst.de> <da0c7538-1a51-61dd-6359-8c618fde6c1b@acm.org> <20230323082756.GD21977@lst.de> <80988a60-f340-529a-0931-30689599e724@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80988a60-f340-529a-0931-30689599e724@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 24, 2023 at 10:05:48AM -0700, Bart Van Assche wrote:
> If someone else wants to work on this that would be great. I do not plan to 
> work on this because I do not expect that a SCSI zone append command would 
> be standardized by the time we need it. Although there are references to 
> T10 drafts in the UFS standard, since a few months JEDEC strongly prefers 
> to refer to finalized external standards in its own standards. Hence, 
> standardizing zoned storage for UFS would have to wait until T10 has 
> published a standard that supports a zone append command. INCITS published 
> ZBC-1 in 2016, two years after the first ZBC-1 draft was uploaded to the 
> T10 servers. INCITS approved ZBC-2 this month, six years after the first 
> ZBC-2 draft was uploaded to the T10 servers. Because of the long time it 
> takes to complete new versions of T10 standards we plan not to wait until 
> T10 has standardized a zone append operation.

Which is why we need to start the work now.  Note that I don't think
your time frames matter too much - the first draft of zbc2 is where
people opened up the process again.  The more relevant time frame is
between getting the main new feature in and publusing, which is way
shorter.
