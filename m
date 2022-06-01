Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2906CC433EF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 05:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349629AbiFAFbo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 01:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348502AbiFAFbn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 01:31:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B64218;
        Tue, 31 May 2022 22:31:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 89D0F68AFE; Wed,  1 Jun 2022 07:31:39 +0200 (CEST)
Date:   Wed, 1 Jun 2022 07:31:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 10/11] block: relax direct io memory alignment
Message-ID: <20220601053139.GD21743@lst.de>
References: <20220531191137.2291467-1-kbusch@fb.com> <20220531191137.2291467-11-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531191137.2291467-11-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
