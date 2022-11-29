Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E44AC4321E
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 14:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiK2OpQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 09:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbiK2OpQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 09:45:16 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F24B55C8D
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 06:45:15 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1A7976732D; Tue, 29 Nov 2022 15:45:11 +0100 (CET)
Date:   Tue, 29 Nov 2022 15:45:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 0/2] nvme-mpath: Add IO stats support
Message-ID: <20221129144510.GA18909@lst.de>
References: <20221003094344.242593-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003094344.242593-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I've applied this with nvme_start_request changed to an inline
funtion.
