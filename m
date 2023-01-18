Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B563C32793
	for <linux-block@archiver.kernel.org>; Wed, 18 Jan 2023 22:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjARWOX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Jan 2023 17:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjARWOW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2023 17:14:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8077065EDB
        for <linux-block@vger.kernel.org>; Wed, 18 Jan 2023 14:14:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E6B761A5F
        for <linux-block@vger.kernel.org>; Wed, 18 Jan 2023 22:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C75C433EF;
        Wed, 18 Jan 2023 22:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674080057;
        bh=7ZVHrmFuhcTTsxU/5F6Zot2MiaTb9msyW5hSlnxeNM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kvEpSKbAy5E8hV0JSlEZXPt3+d+nA225GXGSQrDzq/UsNxLrszMpv334fwChRVyiL
         GQ6AfN10PsdkD42L7HM8Qky8srD/gn6gjaNnJtT9qwegMETNVTo2kULUE1VJV3xDyC
         wUO8sO/2s7pFhZ7GMur8q6EMJmygfzAKw4i7KdJS90452V0yUAiKlkZ/U6a23MJTEZ
         omE+XauYXsh9m3gGRA2DWFojp6QRMOdhbyTEah8QrB2vWVFZnqt8Z1UE39yJmBl6Ko
         VXrXFVLpkO4CVzYOUJqA7etYLKX69+gI0wGNKTD+zthN5m0TEHDAShw+7mSyBSeHuV
         up9DQEOeT6tiA==
Date:   Wed, 18 Jan 2023 15:14:14 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: Re: [PATCH v2] block: Improve shared tag set performance
Message-ID: <Y8hvNmyR3U1ge3H3@kbusch-mbp>
References: <20230103195337.158625-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103195337.158625-1-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 03, 2023 at 11:53:37AM -0800, Bart Van Assche wrote:
> Remove the code for fair tag sharing because it significantly hurts
> performance for UFS devices. Removing this code is safe because the
> legacy block layer worked fine without any equivalent fairness
> algorithm.

The legacy block layer didn't have a limited tag resource that can block
request allocations though, so I don't think we can appeal to that
example to conclude removing this is safe. As much as I'd like to get
rid of this code, I honestly have no idea if this isn't helping anyone.
 
> This algorithm hurts performance for UFS devices because UFS devices
> have multiple logical units. One of these logical units (WLUN) is used
> to submit control commands, e.g. START STOP UNIT. If any request is
> submitted to the WLUN, the queue depth is reduced from 31 to 15 or
> lower for data LUNs.

Can you give the WLUN it's own tagset instead?
