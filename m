Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6611BC5B578
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 06:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40034208E4
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 06:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfGAGWn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 02:22:43 -0400
Received: from verein.lst.de ([213.95.11.211]:58460 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfGAGWn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jul 2019 02:22:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D459768CEE; Mon,  1 Jul 2019 08:22:41 +0200 (CEST)
Date:   Mon, 1 Jul 2019 08:22:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, hch@lst.de, bvanassche@acm.org,
        axboe@kernel.dk
Subject: Re: [PATCH 1/5] null_blk: create a helper for throttling
Message-ID: <20190701062241.GF20073@lst.de>
References: <20190629050442.8459-1-chaitanya.kulkarni@wdc.com> <20190629050442.8459-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629050442.8459-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	if (!test_bit(NULLB_DEV_FL_THROTTLED, &dev->flags))
> +		goto out;

Maybe keep this check in the caller to make it more obvious
when it actually does something?
