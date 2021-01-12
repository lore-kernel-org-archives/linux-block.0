Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0A4C433E0
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 07:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE86822AAF
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 07:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbhALHfp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 02:35:45 -0500
Received: from verein.lst.de ([213.95.11.211]:54172 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbhALHfp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 02:35:45 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96D3767373; Tue, 12 Jan 2021 08:35:03 +0100 (CET)
Date:   Tue, 12 Jan 2021 08:35:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com
Subject: Re: [PATCH V9 8/9] nvmet: add common I/O length check helper
Message-ID: <20210112073503.GC24288@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <20210112042623.6316-9-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112042623.6316-9-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I can't say I like this helper.  The semantics are a little confusing,
not helped by the name.
