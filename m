Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99858C77B7F
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 15:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjECPZ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 11:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjECPZ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 11:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2A54EEE
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 08:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B010062E5E
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 15:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE0AC433D2;
        Wed,  3 May 2023 15:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683127524;
        bh=m5KN/uga1cR5DT3s6A2yKst0ppY6IrvIVVJeBzPUqDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rXPhCMUysZP++jugHo0ckwJ7pEp371F0cuPyu1tF7IuGkBGqOIX/w/y+QV2ZoIuyn
         TvWVtQwtq1qLv0WsHfXi0HXZzmWT1KUrWRykLe7dj4Y4ZWLua0gAC9DgfcMNkkfpqh
         JvpcDM5i6X12WdCdNtNnYnXEKMu3wdz9n2Cz8wggf0difgeEtg10xATnoJu35t9UZU
         MFoqozdegKEGRfLIn8os5T/xfaeioS2CiIrPeF6G7/1WwImyhzezGUcWZVBFH/jWBt
         4ixtgAiZyOkcn6O2IgGiVY/bNeBNiILUWhxIo4ZNGtMDpZ8hxntcblD0DotVu0A796
         RE8tVaxzG4c+A==
Date:   Wed, 3 May 2023 09:25:21 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, joshi.k@samsung.com, axboe@kernel.dk,
        xiaoguang.wang@linux.alibaba.com
Subject: Re: [RFC 1/3] nvme: skip block cgroups for passthrough commands
Message-ID: <ZFJ84dD1FRNXJIcm@kbusch-mbp.dhcp.thefacebook.com>
References: <20230501153306.537124-1-kbusch@meta.com>
 <20230501153306.537124-2-kbusch@meta.com>
 <20230503050414.GA19301@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503050414.GA19301@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 03, 2023 at 07:04:14AM +0200, Christoph Hellwig wrote:
> On Mon, May 01, 2023 at 08:33:04AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Passthrough requests don't go through the submit_bio() path, so all the
> > overhead of setting up the bio's cgroup is wasted cycles. Provide a path
> > to skip this setup.
> 
> These days we should not need to set bi_bdev at all for passthrough,
> so I think we can just drop the assingment.

We can't really skip it for polling since that needs a bio with a
bdev. I'll take another shot at detandling that requirement.
 
> But instead of just optimizing for passthrough we really need to optimize
> this assignment and get rid of the cost entirely.  What is so expensive
> about the cgroup lookup?  Is this even for a device that uses cgroups
> at all, or could we come up with a flag to bypass all the lookup unless
> cgroup are anbled?

It's not super expensive. It's just unnecessary for this usage and
this seemed like the easiest way to avoid it.
