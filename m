Return-Path: <SRS0=cbU1=EJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405FBC2D0A3
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 18:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55F82076E
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 18:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgKCScu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Nov 2020 13:32:50 -0500
Received: from verein.lst.de ([213.95.11.211]:38602 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgKCScu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Nov 2020 13:32:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 26CA66736F; Tue,  3 Nov 2020 19:32:47 +0100 (CET)
Date:   Tue, 3 Nov 2020 19:32:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
        logang@deltatee.com
Subject: Re: [PATCH V3 0/6] nvmet: passthru fixes and improvements
Message-ID: <20201103183246.GA23697@lst.de>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Btw, what is fixed by the series?  It looks like just (useful) cleanups
to me.
