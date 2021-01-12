Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B3CC433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 07:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD7622CB2
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 07:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404085AbhALHd6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 02:33:58 -0500
Received: from verein.lst.de ([213.95.11.211]:54162 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404075AbhALHd6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 02:33:58 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0525867373; Tue, 12 Jan 2021 08:33:16 +0100 (CET)
Date:   Tue, 12 Jan 2021 08:33:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com
Subject: Re: [PATCH V9 5/9] nvmet: add bio get helper for different backends
Message-ID: <20210112073315.GA24288@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <20210112042623.6316-6-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112042623.6316-6-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'm not a huge fan of this helper, especially as it sets an end_io
callback only for the allocated case, which is a weird calling
convention.
