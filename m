Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81217C12002
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 07:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574146101B
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 07:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhGUHGP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 03:06:15 -0400
Received: from verein.lst.de ([213.95.11.211]:57725 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234706AbhGUHGH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 03:06:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 25C3967373; Wed, 21 Jul 2021 09:46:43 +0200 (CEST)
Date:   Wed, 21 Jul 2021 09:46:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] block: delay freeing the gendisk
Message-ID: <20210721074642.GA12442@lst.de>
References: <20210719093544.431845-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719093544.431845-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Meh, as-is this doesn't even compile.  I had accidentally commited the
fixup in the following patch.  I'll send the whole series in a bit,
but the this particule patch once fixed is probably still a 5.14
candidate.
