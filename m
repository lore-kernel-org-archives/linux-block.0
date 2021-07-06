Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047ADC07E96
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 05:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9BDD6198F
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 05:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhGFFqC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jul 2021 01:46:02 -0400
Received: from verein.lst.de ([213.95.11.211]:59184 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230050AbhGFFqB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jul 2021 01:46:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5509D68BEB; Tue,  6 Jul 2021 07:43:22 +0200 (CEST)
Date:   Tue, 6 Jul 2021 07:43:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Arjan van de Ven <arjan@linux.intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] loop: reintroduce global lock for safe
 loop_validate_file() traversal
Message-ID: <20210706054322.GD17027@lst.de>
References: <20210702153036.8089-1-penguin-kernel@I-love.SAKURA.ne.jp> <258f1892-bbbe-67e2-ead9-3287a3d7578b@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <258f1892-bbbe-67e2-ead9-3287a3d7578b@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 04, 2021 at 02:42:10PM +0900, Tetsuo Handa wrote:
> It is not clear why the size of old and new image files need to be the same.

To simplify things.  And given that no one is asking for lifting the
restriction I'd rather not make the code even more hairy.
