Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C658C4332F
	for <linux-block@archiver.kernel.org>; Thu, 22 Dec 2022 15:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLVPk7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLVPk6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2022 10:40:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2AA101E9
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 07:40:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9A4CB80185
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 15:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4483C433EF;
        Thu, 22 Dec 2022 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671723653;
        bh=3G8J3NGAdEV/fAxUA1maNE2MCIdBM/v/woyjqgjUT7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cZ9kchb0aJujeiLGu7VMueXrTokKF4xWban4gh6hAKpfzHwfzLNLqMul2MOmxcW8r
         c6alWKo/+0pD8aD4DCifMgATJuRxO2A9XasWJmVGvJqnVRf0SEhIu9E+yvo+sQ720r
         DpEXF5+oIPkl7soll2DSUVbrss5mYFXdsOcDZvQyjpgjXa+NqcPHxZHAnDC8qKAR2f
         3d3lO0c3vWUX8LUgkVIhKa2WpPwhm5Eu6i3dHR3E9/qT7q5j1nFzBHRBfRtH6KtB+L
         u45abuQdArxCcdiEi5hH9/2LvWAuRWs37SnbcMZJQb5ib2fsrESyy11zzOtsEJmbIr
         SvML/w+0TBHQg==
Date:   Thu, 22 Dec 2022 08:40:49 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <lkp@intel.com>, Keith Busch <kbusch@meta.com>,
        linux-block@vger.kernel.org, axboe@kernel.dk, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, martin.petersen@oracle.com
Subject: Re: [PATCH] block: save user max_sectors limit
Message-ID: <Y6R6geqKfvV5/jBU@kbusch-mbp.dhcp.thefacebook.com>
References: <20221221162758.407742-1-kbusch@meta.com>
 <202212221657.yQawgPsu-lkp@intel.com>
 <20221222084011.GA12920@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222084011.GA12920@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 22, 2022 at 09:40:11AM +0100, Christoph Hellwig wrote:
> On Thu, Dec 22, 2022 at 04:32:10PM +0800, kernel test robot wrote:
> > >> block/blk-settings.c:138:49: warning: comparison of distinct pointer types ('typeof (limits->max_sectors) *' (aka 'unsigned int *') and 'typeof (BLK_DEF_MAX_SECTORS) *' (aka 'int *')) [-Wcompare-distinct-pointer-types]
> 
> Yeah, that's not going to work.  BLK_DEF_MAX_SECTORS should probably
> become an unsigned constant to fix this.

Hm, I should have used max_t() instead of max().

But thinking on this again, we probably want to respect the user setting
even if it's lower than the default too, not just if its larger. I
believe that will require a new queue limit to save that value.
