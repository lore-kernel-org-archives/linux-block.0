Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B4AC4332F
	for <linux-block@archiver.kernel.org>; Fri,  3 Nov 2023 08:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjKCIL6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Nov 2023 04:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjKCILy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Nov 2023 04:11:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CD8123;
        Fri,  3 Nov 2023 01:11:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8DFE767373; Fri,  3 Nov 2023 09:11:47 +0100 (CET)
Date:   Fri, 3 Nov 2023 09:11:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Li Dongyang <dongyangli@ddn.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@lst.de, adilger.kernel@dilger.ca
Subject: Re: [PATCH] mm: folio_wait_stable() should check for bdev
Message-ID: <20231103081146.GA16854@lst.de>
References: <20231103050949.480892-1-dongyangli@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103050949.480892-1-dongyangli@ddn.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 03, 2023 at 04:09:49PM +1100, Li Dongyang wrote:
> folio_wait_stable() now checks SB_I_STABLE_WRITES
> flag on the superblock instead of backing_dev_info,
> this could trigger a false block integrity error when
> doing buffered write directly to the block device,
> as folio_wait_stable() is a noop for bdev and the
> content could be modified during writeback.
> 
> Check if the folio's superblock is bdev and wait for
> writeback if the backing device requires stables_writes.

https://lore.kernel.org/lkml/CAOi1vP9Zit-A9rRk9jy+d1itaBzUSBzFBuhXE+EDfBtF-Mf0og@mail.gmail.com/T/#t

https://lore.kernel.org/all/20231024064416.897956-1-hch@lst.de/

