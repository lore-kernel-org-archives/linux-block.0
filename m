Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBEDC433F5
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 06:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242326AbiA1GPA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 01:15:00 -0500
Received: from verein.lst.de ([213.95.11.211]:46935 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235649AbiA1GO6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 01:14:58 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2A4C668AA6; Fri, 28 Jan 2022 07:14:56 +0100 (CET)
Date:   Fri, 28 Jan 2022 07:14:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     axboe@kernel.dk, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dm: properly fix redundant bio-based IO
 accounting
Message-ID: <20220128061456.GB1477@lst.de>
References: <20220128041753.32195-1-snitzer@redhat.com> <20220128041753.32195-4-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128041753.32195-4-snitzer@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 27, 2022 at 11:17:53PM -0500, Mike Snitzer wrote:
> Record the start_time for a bio but defer the starting block core's IO
> accounting until after IO is submitted using bio_start_io_acct_time().
> 
> This approach avoids the need to mess around with any of the
> individual IO stats in response to a bio_split() that follows bio
> submission.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
