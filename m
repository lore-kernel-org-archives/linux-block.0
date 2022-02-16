Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FA7C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 18:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbiBPSLA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 13:11:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237489AbiBPSK6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 13:10:58 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915952A4A30
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 10:10:44 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F027268B05; Wed, 16 Feb 2022 19:10:40 +0100 (CET)
Date:   Wed, 16 Feb 2022 19:10:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Markus =?iso-8859-1?Q?Bl=F6chl?= <Markus.Bloechl@ipetronik.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: fix surprise removal for drivers calling
 blk_set_queue_dying
Message-ID: <20220216181040.GA21665@lst.de>
References: <20220216150901.4166235-1-hch@lst.de> <20220216154950.q3uit4ucl6xupvhe@ipetronik.com> <20220216170919.GA20782@lst.de> <20220216180850.fjcmj5yinaqolskt@ipetronik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216180850.fjcmj5yinaqolskt@ipetronik.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 16, 2022 at 07:08:50PM +0100, Markus Blöchl wrote:
> I noticed that set_capacity() is also called most of the time when
> a disk is killed. Should we also move that into blk_mark_disk_dead()?
> Any reasons not to?

I thought about that and I think it is a good idea.  But for now I'd
keep the regression fix minimal and then do that as a next step.

