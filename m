Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02C5C433FE
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 16:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiK2Qna (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 11:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiK2Qn3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 11:43:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F278E391FA
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 08:43:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D3EBB816D5
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 16:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52DCC433D6;
        Tue, 29 Nov 2022 16:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669740206;
        bh=1O0UDq25m9AbVSAfrOCHfIqgVDXg13TfoncZ2aiq0s0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kV1OWyO0Y7rOm+5dkYluQVgHHYX+w9Gcy4Hq4SlyHBpd/8GX+p5DNS/giPGCe1gO+
         Vlf/E8KQBlAtDNDENAOmd42auMlqaaa4jKT6tMFLcUJgejwo4gHCe9U4e/uLkcr94Z
         eFbxv1sCV9FWExHNSXIhfLHYsnOtFl+nkJNGUSM9/vQLC1mAqyoF0+sIv7RTyVIu9V
         NgUs/1tdRZqlOO1v5D7iJi2f2LbiuJ0r6dHccnYB3FpRQmX+6jZqbvKZt/YD2DXfq6
         gQIZNBkAVzCpqFXCGvumHPYa8zZCqmCx5z21y1POzIwT+KhNdAaGJhoPeu6SfqURHk
         296eVLh6VltKw==
Date:   Tue, 29 Nov 2022 09:43:22 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 0/2] nvme-mpath: Add IO stats support
Message-ID: <Y4Y2qjDgtJucSOoK@kbusch-mbp.dhcp.thefacebook.com>
References: <20221003094344.242593-1-sagi@grimberg.me>
 <20221129144510.GA18909@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129144510.GA18909@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 29, 2022 at 03:45:10PM +0100, Christoph Hellwig wrote:
> I've applied this with nvme_start_request changed to an inline
> funtion.

You'll also need to change patch 2 with this inlined. That patch needs
to either inline nvme_mpath_start_request(), or add an
EXPORT_SYMBOL_GPL.
