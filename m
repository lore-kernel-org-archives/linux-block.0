Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54774C433FE
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 08:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiKUI1V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Nov 2022 03:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiKUI1U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 03:27:20 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2847860F7
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 00:27:20 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 469C068AA6; Mon, 21 Nov 2022 09:27:17 +0100 (CET)
Date:   Mon, 21 Nov 2022 09:27:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: untangle the request_queue refcounting from the queue kobject
 v2
Message-ID: <20221121082717.GA27080@lst.de>
References: <20221114042637.1009333-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114042637.1009333-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Any comments on the actual series?
