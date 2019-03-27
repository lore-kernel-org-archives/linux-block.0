Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930BEC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 14:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDA02082F
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 14:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfC0OY7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:24:59 -0400
Received: from verein.lst.de ([213.95.11.211]:42063 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfC0OY6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 10:24:58 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B5FBA68C4E; Wed, 27 Mar 2019 15:24:49 +0100 (CET)
Date:   Wed, 27 Mar 2019 15:24:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC] optimize nvme single segment I/O
Message-ID: <20190327142449.GE26200@lst.de>
References: <20190321231037.25104-1-hch@lst.de> <302780ee-8721-2039-63b9-0d64bf3b519b@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <302780ee-8721-2039-63b9-0d64bf3b519b@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

FYI, I've pulled the series including the block helpers into nvme-5.2,
with a few tiny changes for the review comments from Chaitanya.
