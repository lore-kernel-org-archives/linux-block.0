Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E564C54EBE
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 07:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbjAJHJu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 02:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbjAJHJs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 02:09:48 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9DA43A02;
        Mon,  9 Jan 2023 23:09:46 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1067468AFE; Tue, 10 Jan 2023 08:09:44 +0100 (CET)
Date:   Tue, 10 Jan 2023 08:09:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] blk-iolatency: s/blkcg_rq_qos/iolat_rq_qos/
Message-ID: <20230110070943.GI10289@lst.de>
References: <20230105212432.289569-1-tj@kernel.org> <20230105212432.289569-4-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105212432.289569-4-tj@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
