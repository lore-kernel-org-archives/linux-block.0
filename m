Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7517FC433F5
	for <linux-block@archiver.kernel.org>; Tue, 18 Jan 2022 16:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiARQQW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jan 2022 11:16:22 -0500
Received: from verein.lst.de ([213.95.11.211]:37620 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348492AbiARQPb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jan 2022 11:15:31 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BD52D68AA6; Tue, 18 Jan 2022 17:15:26 +0100 (CET)
Date:   Tue, 18 Jan 2022 17:15:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Message-ID: <20220118161526.GA30337@lst.de>
References: <d1ca4fa4-ac3e-1354-3d94-1bf55f2000a9@I-love.SAKURA.ne.jp> <20220112131615.qsdxx6r7xvnvlwgx@quack3.lan> <20220113104424.u6fj3z2zd34ohthc@quack3.lan> <f893638a-2109-c197-9783-c5e6dced23e5@I-love.SAKURA.ne.jp> <20220114195840.kdzegicjx7uyscoq@quack3.lan> <33f360ca-d3e1-7070-654e-26ef22109a61@I-love.SAKURA.ne.jp> <20220117081554.GA22708@lst.de> <cdaf1346-2885-f0da-8878-12264bd48348@I-love.SAKURA.ne.jp> <1c400c45-1427-6c8c-8053-a4e1e7e92b81@I-love.SAKURA.ne.jp> <f6b947d0-1047-66b3-0243-af5017c9ab55@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6b947d0-1047-66b3-0243-af5017c9ab55@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'll try to take a look.  I've been busy today coming up with a scheme
that avoids taking ->open_mutex outside the open/release path at all,
which should also help, but it's not quite ready.
