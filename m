Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25972C433F5
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 08:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbiAQIP6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:15:58 -0500
Received: from verein.lst.de ([213.95.11.211]:58939 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237985AbiAQIP5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 03:15:57 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3A86A68AFE; Mon, 17 Jan 2022 09:15:54 +0100 (CET)
Date:   Mon, 17 Jan 2022 09:15:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Message-ID: <20220117081554.GA22708@lst.de>
References: <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp> <20220110103057.h775jv2br2xr2l5k@quack3.lan> <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp> <20220110134234.qebxn5gghqupsc7t@quack3.lan> <d1ca4fa4-ac3e-1354-3d94-1bf55f2000a9@I-love.SAKURA.ne.jp> <20220112131615.qsdxx6r7xvnvlwgx@quack3.lan> <20220113104424.u6fj3z2zd34ohthc@quack3.lan> <f893638a-2109-c197-9783-c5e6dced23e5@I-love.SAKURA.ne.jp> <20220114195840.kdzegicjx7uyscoq@quack3.lan> <33f360ca-d3e1-7070-654e-26ef22109a61@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33f360ca-d3e1-7070-654e-26ef22109a61@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 15, 2022 at 09:34:10AM +0900, Tetsuo Handa wrote:
> Christoph is not a fan of proliferating the use of task_work_add(). Can we go with exporting task_work_add()

Not a fan != NAK.  If we can't think of anything better we'll have to do
that.  Note that I also have a task_work_add API cleanup pending that makes
it a lot less ugly.

> for this release cycle? Or instead can we go with providing release() callback without disk->open_mutex held
> ( https://lkml.kernel.org/r/08d703d1-8b32-ec9b-2b50-54b8376d3d40@i-love.sakura.ne.jp ) ?

This one OTOH is a hard NAK as this is an API that will just cause a lot
of problems.
