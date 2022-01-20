Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344B5C433F5
	for <linux-block@archiver.kernel.org>; Thu, 20 Jan 2022 14:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiATOUS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jan 2022 09:20:18 -0500
Received: from verein.lst.de ([213.95.11.211]:44824 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234745AbiATOUS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jan 2022 09:20:18 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C4F2668BEB; Thu, 20 Jan 2022 15:20:14 +0100 (CET)
Date:   Thu, 20 Jan 2022 15:20:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Message-ID: <20220120142014.GA11879@lst.de>
References: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp> <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp> <20220110103057.h775jv2br2xr2l5k@quack3.lan> <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp> <20220110134234.qebxn5gghqupsc7t@quack3.lan> <d1ca4fa4-ac3e-1354-3d94-1bf55f2000a9@I-love.SAKURA.ne.jp> <20220112131615.qsdxx6r7xvnvlwgx@quack3.lan> <20220113104424.u6fj3z2zd34ohthc@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113104424.u6fj3z2zd34ohthc@quack3.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 13, 2022 at 11:44:24AM +0100, Jan Kara wrote:
> Maybe the most disputable thing in this locking chain seems to be splicing
> from sysfs files. That does not seem terribly useful and due to special
> locking and behavior of sysfs files it allows for creating interesting lock
> dependencies. OTOH maybe there is someone out there who (possibly
> inadvertedly through some library) ends up using splice on sysfs files so
> chances for userspace breakage, if we disable splice for sysfs, would be
> non-negligible. Hum, tough.

People were using sendfile on sysfs files, that is why support for this
got added back after it was removed for a while as part of the set_fs()
removal.

The real question for me is why do we need freeing and writer counts on
sysfs or any other pure in-memory file system to start with?
