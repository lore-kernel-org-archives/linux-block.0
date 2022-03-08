Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788C5C433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 23:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiCHXMQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 18:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiCHXMO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 18:12:14 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 987DB12A87;
        Tue,  8 Mar 2022 15:11:10 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E252C10E23D8;
        Wed,  9 Mar 2022 10:11:05 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nRiyv-003AZn-Bo; Wed, 09 Mar 2022 10:11:05 +1100
Date:   Wed, 9 Mar 2022 10:11:05 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: remove fs.f_write_hint
Message-ID: <20220308231105.GU3927073@dread.disaster.area>
References: <20220308060529.736277-1-hch@lst.de>
 <20220308060529.736277-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308060529.736277-3-hch@lst.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6227e28a
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=gyyHpoLcVL96gDFDU4sA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 08, 2022 at 07:05:29AM +0100, Christoph Hellwig wrote:
> The value is now completely unused except for reporting it back through
> the F_GET_FILE_RW_HINT ioctl, so remove the value and the two ioctls
> for it.
> 
> Trying to use the F_SET_FILE_RW_HINT and F_GET_FILE_RW_HINT fcntls will
> now return EINVAL, just like it would on a kernel that never supported
> this functionality in the first place.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

LGTM.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
