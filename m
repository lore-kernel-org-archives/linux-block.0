Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2093C433EF
	for <linux-block@archiver.kernel.org>; Thu, 20 Jan 2022 15:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376650AbiATPm4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:42:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58566 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiATPmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jan 2022 10:42:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CA18A1F394;
        Thu, 20 Jan 2022 15:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642693374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PWUKBq0/dMYv0MqWyaiHtHc2XPqegj3c/pp1sj1xy6Y=;
        b=avRUtaaUJzkOEmekqVhwYbR7NvCbSlDyy1gpTunxDZstw/owjNIpNY7uKqfwowSRL/4+W4
        iCrTlcDrao0TYBPiVpQkJrTXoz0kJyxAxlrk5WSkvKZiXR42cG75oQyk6J1Gvlp63mcNVf
        7bwbodT/qDRc5g/U9cpoD1pERhm2qUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642693374;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PWUKBq0/dMYv0MqWyaiHtHc2XPqegj3c/pp1sj1xy6Y=;
        b=XGHfpNNeHZ9eCK+0MjWPqBfxghpt16JLxjqy7SlyiDS9CWz1BsA5WFAInoELySXGb4IfYy
        L4pff9GxMuqzWaDg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 92399A3B85;
        Thu, 20 Jan 2022 15:42:54 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B32D5A05D3; Thu, 20 Jan 2022 16:42:52 +0100 (CET)
Date:   Thu, 20 Jan 2022 16:42:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jens Axboe <axboe@kernel.dk>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Message-ID: <20220120154252.cmh57rrhyy22t6de@quack3.lan>
References: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp>
 <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
 <20220110103057.h775jv2br2xr2l5k@quack3.lan>
 <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp>
 <20220110134234.qebxn5gghqupsc7t@quack3.lan>
 <d1ca4fa4-ac3e-1354-3d94-1bf55f2000a9@I-love.SAKURA.ne.jp>
 <20220112131615.qsdxx6r7xvnvlwgx@quack3.lan>
 <20220113104424.u6fj3z2zd34ohthc@quack3.lan>
 <20220120142014.GA11879@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120142014.GA11879@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 20-01-22 15:20:14, Christoph Hellwig wrote:
> On Thu, Jan 13, 2022 at 11:44:24AM +0100, Jan Kara wrote:
> > Maybe the most disputable thing in this locking chain seems to be splicing
> > from sysfs files. That does not seem terribly useful and due to special
> > locking and behavior of sysfs files it allows for creating interesting lock
> > dependencies. OTOH maybe there is someone out there who (possibly
> > inadvertedly through some library) ends up using splice on sysfs files so
> > chances for userspace breakage, if we disable splice for sysfs, would be
> > non-negligible. Hum, tough.
> 
> People were using sendfile on sysfs files, that is why support for this
> got added back after it was removed for a while as part of the set_fs()
> removal.
> 
> The real question for me is why do we need freeing and writer counts on
> sysfs or any other pure in-memory file system to start with?

We don't. But freezing of sysfs is not part of the locking chain. Only
freezing of the filesystem holding loopback backing file is (let's call
that fs F). And splice from sysfs to some file in F is what ties freezing of
F with a file lock in sysfs...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
