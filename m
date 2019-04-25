Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019A6C10F03
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 08:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1F2208E4
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 08:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfDYI2A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:28:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:46042 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfDYI2A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 04:28:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E505AABD0;
        Thu, 25 Apr 2019 08:27:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 64668DA847; Thu, 25 Apr 2019 10:29:03 +0200 (CEST)
Date:   Thu, 25 Apr 2019 10:29:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 2/2] block: remove the i argument to
 bio_for_each_segment_all
Message-ID: <20190425082903.GG20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20190425070300.3388-1-hch@lst.de>
 <20190425070300.3388-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425070300.3388-3-hch@lst.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 25, 2019 at 09:03:00AM +0200, Christoph Hellwig wrote:
> We only have two callers that need the integer loop iterator, and they
> can easily maintain it themselves.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---

For the btrfs bits

>  fs/btrfs/compression.c            |  3 +--
>  fs/btrfs/disk-io.c                |  4 ++--
>  fs/btrfs/extent_io.c              | 10 ++++------
>  fs/btrfs/inode.c                  |  8 ++++----
>  fs/btrfs/raid56.c                 |  3 +--

Acked-by: David Sterba <dsterba@suse.com>
