Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C9EC64E8A
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 09:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC2522249
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 09:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbgLBJLB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 04:11:01 -0500
Received: from verein.lst.de ([213.95.11.211]:53078 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387891AbgLBJLB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 04:11:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9196E67373; Wed,  2 Dec 2020 10:10:19 +0100 (CET)
Date:   Wed, 2 Dec 2020 10:10:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        johannes.thumshirn@wdc.com
Subject: Re: [PATCH V4 5/9] nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
Message-ID: <20201202091018.GD2952@lst.de>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com> <20201202062227.9826-6-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202062227.9826-6-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 01, 2020 at 10:22:23PM -0800, Chaitanya Kulkarni wrote:
> Update the nvmet_execute_identify() such that it can now handle
> NVME_ID_CNS_CS_CTRL when identify.cis is set to ZNS. This allows
> host to identify the support for ZNS.

The changs in this and all following patches really belong into the current
patch 2.
