Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA73FC4360D
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 02:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C4E20854
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 02:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567996565;
	bh=M/1TbTP9mfOo3u50WkONGsi+kXptt+utDG37rlbXPAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nX/uke67GGRxaRNh3mYdiasqMpGIv/8UjEih8EfnIt9teUyrc19v6CDDAdzG+QD5z
	 4ObknXQyR9cHL+xtSd0cZx47HyBkvJsH9GkAIhG6egjDnn6nZyl4jiC1F0agRcyPM/
	 S1adh5V3tn3ZALrrmUka9U/eyPYDW7bEgHHEB3cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732945AbfIICgF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Sep 2019 22:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731928AbfIICgF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 8 Sep 2019 22:36:05 -0400
Received: from keith-busch (unknown [8.36.226.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20FFE2067B;
        Mon,  9 Sep 2019 02:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567996564;
        bh=M/1TbTP9mfOo3u50WkONGsi+kXptt+utDG37rlbXPAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1g871uDgcV/OZzDuwcu3tBLqjoHt9jNWbx/Zg3cNq9IdK02GlCbSwxxvlv3KgQVEF
         Dy+U4c+UP0sjbM/J/yKT2taiMTAsQXGwyQJ6yOZqp5DBcuDmXiSzAx3WCBGkOovufD
         6K6ZNzkiGmWMRUahUx605/Jo4twjP9v9ZZAgnA2s=
Date:   Sun, 8 Sep 2019 20:36:02 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, axboe@kernel.dk,
        keith.busch@intel.com, sagi@grimberg.me, israelr@mellanox.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        shlomin@mellanox.com, hch@lst.de
Subject: Re: [PATCH v4 2/3] block: don't remap ref tag for T10 PI type 0
Message-ID: <20190909023601.GA6772@keith-busch>
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
 <1567956405-5585-2-git-send-email-maxg@mellanox.com>
 <yq1ftl6i4xx.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1ftl6i4xx.fsf@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 08, 2019 at 10:22:50PM -0400, Martin K. Petersen wrote:
> 
> Max,
> 
> > Only type 1 and type 2 have a reference tag by definition.
> 
> DIX Type 0 needs remapping so this assertion is not correct.

At least for nvme, type 0 means you have meta data but not for protection
information, so remapping the place the where reference tag exists for
other PI types corrupts the metadata.
