Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8764C4338F
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 09:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B556101E
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 09:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbhHLJRI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 05:17:08 -0400
Received: from verein.lst.de ([213.95.11.211]:43585 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235954AbhHLJRG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 05:17:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5AB5667373; Thu, 12 Aug 2021 11:16:39 +0200 (CEST)
Date:   Thu, 12 Aug 2021 11:16:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, hch@lst.de,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org,
        syzbot+9937dc42271cd87d4b98@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: nbd: add sanity check for first_minor
Message-ID: <20210812091639.GA4695@lst.de>
References: <20210812091501.22648-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812091501.22648-1-paskripkin@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
