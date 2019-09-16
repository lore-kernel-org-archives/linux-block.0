Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92017C49ED7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 07:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9A320650
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 07:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfIPH7a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 03:59:30 -0400
Received: from verein.lst.de ([213.95.11.211]:42946 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfIPH73 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 03:59:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3E90D68B05; Mon, 16 Sep 2019 09:59:26 +0200 (CEST)
Date:   Mon, 16 Sep 2019 09:59:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH 2/2] block: centralize PI remapping logic to the block
 layer
Message-ID: <20190916075925.GB25796@lst.de>
References: <1568493253-18142-1-git-send-email-maxg@mellanox.com> <1568493253-18142-2-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568493253-18142-2-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
