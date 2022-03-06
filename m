Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619E5C433F5
	for <linux-block@archiver.kernel.org>; Sun,  6 Mar 2022 09:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiCFJ2n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Mar 2022 04:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiCFJ2n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Mar 2022 04:28:43 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4611090
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 01:27:51 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6D9DC68B05; Sun,  6 Mar 2022 10:27:48 +0100 (CET)
Date:   Sun, 6 Mar 2022 10:27:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v5 1/2] block: add ->poll_bio to block_device_operations
Message-ID: <20220306092748.GB22883@lst.de>
References: <20220305020804.54010-1-snitzer@redhat.com> <20220305020804.54010-2-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305020804.54010-2-snitzer@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
