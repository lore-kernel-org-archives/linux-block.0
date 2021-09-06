Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49527C433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 09:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3189F60F3A
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 09:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbhIFJ2N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Sep 2021 05:28:13 -0400
Received: from verein.lst.de ([213.95.11.211]:60744 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241166AbhIFJ2N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Sep 2021 05:28:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8E34767373; Mon,  6 Sep 2021 11:27:06 +0200 (CEST)
Date:   Mon, 6 Sep 2021 11:27:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org, hch@lst.de
Subject: Re: [PATCH v2 1/3] nbd: use pr_err to output error message
Message-ID: <20210906092706.GA30790@lst.de>
References: <20210904122519.1963983-1-houtao1@huawei.com> <20210904122519.1963983-2-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904122519.1963983-2-houtao1@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
