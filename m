Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87699C433DB
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 21:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567BF221F9
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 21:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgLVVHr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Dec 2020 16:07:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbgLVVHq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Dec 2020 16:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608671180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9bn1JYbMxk5cmELKh20sbfobuiV+1RVOI1Ppix+Ly8E=;
        b=EA95Rb9ALs8usdxB7URohzdLSMHf3JyoaWeP4KZPZwTfwThr1C6f6IWcGJNORlUvpHUu73
        UE5ROQecf7QocWAOuImVxGVfGbwBuXSypczcOYSViMdAEgtLBZv4pBArl37oFEaiZSHgzE
        fwsyVecBZezGnCKKcXvxhtStA63RWE0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-F7SXmEoDNbii6xj-gw2fcA-1; Tue, 22 Dec 2020 16:06:16 -0500
X-MC-Unique: F7SXmEoDNbii6xj-gw2fcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C0151005504;
        Tue, 22 Dec 2020 21:06:15 +0000 (UTC)
Received: from agk.fab.redhat.com (agk-dp.fab.redhat.com [10.33.15.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 130E060BF1;
        Tue, 22 Dec 2020 21:06:06 +0000 (UTC)
Received: from agk by agk.fab.redhat.com with local (Exim 4.34)
        id 1kror6-0008DP-Kd; Tue, 22 Dec 2020 21:06:04 +0000
Date:   Tue, 22 Dec 2020 21:06:04 +0000
From:   Alasdair G Kergon <agk@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alasdair G Kergon <agk@redhat.com>
Subject: Re: [dm-devel] DM's filesystem lookup in dm_get_dev_t() [was: Re: linux-next: manual merge of the device-mapper tree with Linus' tree]
Message-ID: <20201222210604.GD29336@agk.fab.redhat.com>
Mail-Followup-To: Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alasdair G Kergon <agk@redhat.com>
References: <20201222095056.7a5ac0a0@canb.auug.org.au> <20201222131528.GA29822@lst.de> <20201222145327.GC12885@redhat.com> <288d1c58-c0e2-9d6f-4816-48c66536fe8b@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <288d1c58-c0e2-9d6f-4816-48c66536fe8b@suse.de>
User-Agent: Mutt/1.4.1i
Organization: Red Hat UK Ltd. Registered in England and Wales, number 03798903. Registered Office: Amberley Place, 107-111 Peascod Street, Windsor, Berkshire, SL4 1TE.
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 22, 2020 at 06:24:09PM +0100, Hannes Reinecke wrote:
> However, lookup_bdev() now always recurses into the filesystem, causing 
> multipath to stall in an all-paths-down scenario.
 
I have not read the background about whatever the new problem is - I'm
jumping in cold seeing this message - but from the very beginning of
device-mapper we have strongly recommended that userspace supplies the
block device in the form MAJOR:MINOR and all our own tools do that.  We
guarantee not to deadlock in these places when this is done.

We also accept the device in the form of a path name as we know there
are times when this is safe and convenient, but then we offer no
guarantees - we place the responsibility upon userspace only to do this
when it knows it is safe to do so i.e. no race and no deadlock.

Alasdair

