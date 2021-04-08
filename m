Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69861C433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 21:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E6F61007
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 21:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhDHVl4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 17:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231862AbhDHVl4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Apr 2021 17:41:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD96E610C9;
        Thu,  8 Apr 2021 21:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617918104;
        bh=Vw82UKy5Mw510FUGoQt9O5e2f5wo+dTcftxisATg7C0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oX1wIVYhwOnVD9sopCaqUbEHlSvTn3RqDGIRLaB22yorNwdtU7N9wxbIM+3SHu2Qh
         CAMGZmzvwS6sxg0WiM+iHs167UaisH4GuT8NoW9Nt8CCXRSr3fX6UugYNAgJoQtViV
         cgnhs7ZoIur+ZJNy07mxlbsU856udlvAyEQ9KSNipgXjc7LheeZyl7hbrjUvwQg/Ya
         x1yif/+1/P/7uu1JojPLfb/VoiiIC562sBN4AfeEScCBY7/omVEYEPTAPc6cmDqOMd
         CeZl5cNXQPFt5f31Y5F908Jzu8UKKc6Wbt7mdj7z0RnbMlK/0ySZ2ICZZUxgnrWsKb
         N0Ej+GwHVHsHg==
Date:   Fri, 9 Apr 2021 06:41:41 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] block: initialize ret in bdev_disk_changed
Message-ID: <20210408214141.GB4727@redsun51.ssa.fujisawa.hgst.com>
References: <20210408194140.1816537-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408194140.1816537-1-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 08, 2021 at 09:41:40PM +0200, Christoph Hellwig wrote:
> Avoid a potentially initialized variabe in the invalidate case.

That should say "uninitialized variable", otherwise looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
