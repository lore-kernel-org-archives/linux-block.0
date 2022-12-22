Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856E9C4332F
	for <linux-block@archiver.kernel.org>; Thu, 22 Dec 2022 08:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiLVIkR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Dec 2022 03:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLVIkQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2022 03:40:16 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0A721277
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 00:40:15 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 55C9867373; Thu, 22 Dec 2022 09:40:11 +0100 (CET)
Date:   Thu, 22 Dec 2022 09:40:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, hch@lst.de,
        martin.petersen@oracle.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] block: save user max_sectors limit
Message-ID: <20221222084011.GA12920@lst.de>
References: <20221221162758.407742-1-kbusch@meta.com> <202212221657.yQawgPsu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212221657.yQawgPsu-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 22, 2022 at 04:32:10PM +0800, kernel test robot wrote:
> >> block/blk-settings.c:138:49: warning: comparison of distinct pointer types ('typeof (limits->max_sectors) *' (aka 'unsigned int *') and 'typeof (BLK_DEF_MAX_SECTORS) *' (aka 'int *')) [-Wcompare-distinct-pointer-types]

Yeah, that's not going to work.  BLK_DEF_MAX_SECTORS should probably
become an unsigned constant to fix this.
