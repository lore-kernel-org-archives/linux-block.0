Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBB9C433F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 07:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiC2HIF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 03:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiC2HIF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 03:08:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605BB23D472;
        Tue, 29 Mar 2022 00:06:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 32E2668AFE; Tue, 29 Mar 2022 09:06:19 +0200 (CEST)
Date:   Tue, 29 Mar 2022 09:06:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: state of drbd in mainline
Message-ID: <20220329070618.GA20396@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

while I've been reworking large parts of the block layer over the
last months I've basically never gotten drbd reviews, and in general
drbd seems to be completely maintained upstream.  Do we even have users
for it?  Is it time to drop drbd from the kernel tree?

Thanks,
	Christoph
