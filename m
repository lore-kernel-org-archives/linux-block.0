Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1179CA9EAF
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 13:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2973214AE
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571666141;
	bh=9xG00Cs4w+lEsaZ67H86HMtwcgJo+NjnOqwm8alRtnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RNfgyupE5fzmErQZPcQ3KA45fwdZ11QjevvjgeOw5rWmBSikTdR3maOsBDCQyqg61
	 KSxFjpTRGrgKQFWoe8rmH/PkimegJPtdQ6ZqHihy9sDfGv7ve3Zo1x77+zs7RF8LjI
	 Pv2Fy9orbuF/wwfjWAOH62ixCZtwBPjzFQAjAz4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfJUNzl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728670AbfJUNzk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 09:55:40 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 886132089C;
        Mon, 21 Oct 2019 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571666140;
        bh=9xG00Cs4w+lEsaZ67H86HMtwcgJo+NjnOqwm8alRtnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vw9Q+Y9sI89YJagP3TtStQt+niz5HRkUke6B8aDzhDrYSyK0Fm0c5xxTm0nUE5GYY
         hFPrt6jBEZOxFramLOjNamYkrz2W9F+QB2yJk4P9/d8kds0PzNKdj+CEYrOXDKsLqM
         t/ze353WIiJPDmf5rXEGPlg8RDGYpAKXgShyUK+4=
Date:   Mon, 21 Oct 2019 22:55:35 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/2 v2] Small cleanups
Message-ID: <20191021135535.GA12633@redsun51.ssa.fujisawa.hgst.com>
References: <20191021034004.11063-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021034004.11063-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 21, 2019 at 12:40:02PM +0900, Damien Le Moal wrote:
> This is series is a couple of cleanup patches. The first one cleans up
> the helper function nvme_block_nr() using SECTOR_SHIFT instead of the
> hard coded value 9 and clarifies the helper role by renaming it to
> nvme_sect_to_lba(). The second patch introduces the nvme_lba_to_sect()
> helper to convert a device logical block number into a 512B sector
> value.

Thank you, patches applied to nvme-5.5 with the reviews.
