Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4895FC433DB
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 08:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015D9207C9
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 08:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgLWIHg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Dec 2020 03:07:36 -0500
Received: from verein.lst.de ([213.95.11.211]:33710 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbgLWIHg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Dec 2020 03:07:36 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 407DE67373; Wed, 23 Dec 2020 09:06:54 +0100 (CET)
Date:   Wed, 23 Dec 2020 09:06:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alasdair G Kergon <agk@redhat.com>
Subject: Re: [dm-devel] DM's filesystem lookup in dm_get_dev_t() [was: Re:
 linux-next: manual merge of the device-mapper tree with Linus' tree]
Message-ID: <20201223080653.GB4974@lst.de>
References: <20201222095056.7a5ac0a0@canb.auug.org.au> <20201222131528.GA29822@lst.de> <20201222145327.GC12885@redhat.com> <288d1c58-c0e2-9d6f-4816-48c66536fe8b@suse.de> <20201222210604.GD29336@agk.fab.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222210604.GD29336@agk.fab.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 22, 2020 at 09:06:04PM +0000, Alasdair G Kergon wrote:
> I have not read the background about whatever the new problem is - I'm
> jumping in cold seeing this message - but from the very beginning of
> device-mapper we have strongly recommended that userspace supplies the
> block device in the form MAJOR:MINOR and all our own tools do that.  We
> guarantee not to deadlock in these places when this is done.
> 
> We also accept the device in the form of a path name as we know there
> are times when this is safe and convenient, but then we offer no
> guarantees - we place the responsibility upon userspace only to do this
> when it knows it is safe to do so i.e. no race and no deadlock.

644bda6f346038bce7ad3ed48f7044c10dde6d47 changes that by accepting all
kinds of weirdo formats :(
