Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F52EC433EF
	for <linux-block@archiver.kernel.org>; Tue, 25 Jan 2022 15:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiAYPnD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jan 2022 10:43:03 -0500
Received: from verein.lst.de ([213.95.11.211]:36096 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1582101AbiAYPk2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jan 2022 10:40:28 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 61B1467373; Tue, 25 Jan 2022 16:40:19 +0100 (CET)
Date:   Tue, 25 Jan 2022 16:40:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
        Pei Zhang <pezhang@redhat.com>
Subject: Re: [PATCH V2] block: loop:use kstatfs.f_bsize of backing file to
 set discard granularity
Message-ID: <20220125154019.GA4536@lst.de>
References: <20220125044005.211943-1-ming.lei@redhat.com> <20220125061057.GA26444@lst.de> <Ye/CiFZSHmHQ3Pfu@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye/CiFZSHmHQ3Pfu@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 25, 2022 at 05:27:36PM +0800, Ming Lei wrote:
> 
> But it is configure code path, even though vfs_statfs() fails,
> loop_config_discard() still need to keep discard setting consistent.
> 
> Setting granularity as PAGE_SIZE is just for making discard granularity
> matched with max_discard_sectors. Or you have better/simpler handling?

I'd fail the entire configuration preferably. Or at least not support
discard at all.
