Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E0EC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4677021873
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 16:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeLRQsW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:48:22 -0500
Received: from verein.lst.de ([213.95.11.211]:41850 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbeLRQsW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 11:48:22 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3D95368D8D; Tue, 18 Dec 2018 17:48:21 +0100 (CET)
Date:   Tue, 18 Dec 2018 17:48:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/6] restore nvme-rdma polling
Message-ID: <20181218164821.GA13193@lst.de>
References: <20181214190610.20086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214190610.20086-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks,

applied to nvme-4.21.
