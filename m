Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBE4C7618E
	for <linux-block@archiver.kernel.org>; Fri, 21 Apr 2023 00:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjDUA3S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 20:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDUA3R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 20:29:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB85468A
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 17:29:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A64F6144D
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2023 00:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7BFC4339B;
        Fri, 21 Apr 2023 00:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682036954;
        bh=DVIpfpEfRnQPbQovpPkz14y31eafz3HvawMnzlvMuyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RiAYFZV6yQ7ThjMzh4m7YPSOWbxbXvbQSWFUiMrtFKKnfNpC4qn+tMDACDoFlAU8X
         Xos9CYDpyudN//gs0nWYcVTczno0LFqWfxHUAqZ6kv3WkSag9VROeUTcQSJaqaM8L6
         jHTeUHL+EFu7RghgGPl1RwHqkmOK9MffqIcI4zzr0wrVlmtI3isse8HIEmOATbI3zN
         troA/kYvY/OF8xl3+zf/gca36sWvXI45wrdYxDwNtyhmvxlAExdpiHH3wspPI1eqdE
         3U60DeU6ZX7HeslsrmLqA4XL4j3NFOjFjuWp2jSR8HEWIb7uCWpDixsnD6ffIlwo+z
         OsNky0VqQerpw==
Date:   Thu, 20 Apr 2023 17:29:12 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <nks@flawful.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <mb@lightnvm.io>
Subject: Re: [PATCH v2 10/11] block: Add support for the zone capacity concept
Message-ID: <ZEHY2PIRCCLOZsC4@google.com>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-11-bvanassche@acm.org>
 <ZEEEm/5+i7x2i8a5@x1-carbon>
 <f9d35d19-d0ba-fcb7-e44b-f0b8c55ba399@acm.org>
 <141aee35-4288-1670-6424-e6c41c8ef4c9@kernel.org>
 <ec7cdc7d-9eb7-65a4-6ba9-1ae6cf6f43d2@acm.org>
 <a5d9a370-6264-ebdf-f9f8-7b3263c2b6f0@kernel.org>
 <490ed061-6d82-f9fb-2050-4a386e2e4c8e@acm.org>
 <c4a52bff-5cab-5029-ad7f-e5f9452bc0e2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4a52bff-5cab-5029-ad7f-e5f9452bc0e2@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/21, Damien Le Moal wrote:
> On 4/21/23 08:44, Bart Van Assche wrote:
> > On 4/20/23 16:37, Damien Le Moal wrote:
> >> Why would you need to handle the max active zone number restriction in the
> >> scheduler ? That is the user responsibility. btrfs does it (that is still buggy
> >> though, working on it).
> > 
> > Hi Damien,
> > 
> > If the user (filesystem) restricts the number of active zones, the code 
> > for restricting the number of active zones will have to be duplicated 
> > into every filesystem that supports zoned devices. Wouldn't it be better 
> > if the I/O scheduler tracks the number of active zones?
> 
> I do not think so. The reason is that for a file system, the block allocator
> must be aware of any active zone limit of the underlying device to make the best
> decision possible regarding where to allocate blocks for files and metadata. For

Well, I'm wondering what kind of decision FS can make when allocating zones?

> btrfs, we added "active block groups" management for that purpose. And we have
> tracking of a block group active state so that the block allocator can start
> using new block groups (inactive ones) when previously used ones become full. We
> also have a "finish block group" for cases when there is not enough remaining
> free blocks in a group/zone (this does a finish zone operation to make a
> non-full zone full, that is, inactive).
> 
> Even if the block IO scheduler were to track active zones, the FS would still
> need to do its own tracking (e.g. to be able to finish zones when needed). So I

Why does FS also need to track the # of open zones redundantly? I have two
concerns if FS needs to force it:
1) performance - waiting for finish_zone before allocating a new zone can break
the IO pipeline and block FS operations.
2) multiple partition support - if F2FS uses two partitions, one on conventional
partition while the other on zoned partition, we have to maintain such tracking
mechanism on zoned partition only which gives some code complexity.

In general, doesn't it make sense that FS (not zoned-device FS) just needs to
guarantee sequential writes per zone, while IO scheduler needs to limit the #
of open zones gracefully?

> do not see the point in having the block scheduler doing anything about active
> zones.
> 
