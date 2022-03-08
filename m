Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3363CC433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 23:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiCHXKy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 18:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiCHXKx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 18:10:53 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA8846F4AE;
        Tue,  8 Mar 2022 15:09:52 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C5563530E0C;
        Wed,  9 Mar 2022 10:09:50 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nRixh-003AYW-Vw; Wed, 09 Mar 2022 10:09:50 +1100
Date:   Wed, 9 Mar 2022 10:09:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: remove kiocb.ki_hint
Message-ID: <20220308230949.GT3927073@dread.disaster.area>
References: <20220308060529.736277-1-hch@lst.de>
 <20220308060529.736277-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308060529.736277-2-hch@lst.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6227e240
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=cQYyiwRS5gC6baOvy5UA:9 a=CjuIK1q_8ugA:10 a=OunuuIp3J4_2X_e7vt2U:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 08, 2022 at 07:05:28AM +0100, Christoph Hellwig wrote:
> This field is entirely unused now except for a tracepoint in f2fs, so
> remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
