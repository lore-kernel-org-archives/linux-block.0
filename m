Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A93C001DF
	for <linux-block@archiver.kernel.org>; Fri,  4 Aug 2023 13:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjHDNnL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Aug 2023 09:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjHDNmx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Aug 2023 09:42:53 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF488CC;
        Fri,  4 Aug 2023 06:42:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9DCE568AA6; Fri,  4 Aug 2023 15:42:48 +0200 (CEST)
Date:   Fri, 4 Aug 2023 15:42:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Dusty Mabe <dusty@dustymabe.com>, Hannes Reinecke <hare@suse.de>,
        wq@lst.de, Minchan Kim <minchan@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>, marmijo@redhat.com
Subject: Re: XFS metadata CRC errors on zram block device on ppc64le
 architecture
Message-ID: <20230804134248.GA26611@lst.de>
References: <b2d40565-7868-ba15-4bb1-fca6f0df076b@dustymabe.com> <20230802094106.GA28187@lst.de> <3f36882c-b429-3ece-989b-a6899c001cbd@suse.de> <43843fec-f30a-1edc-b428-1d38ddb1050f@dustymabe.com> <a0f05188-d142-82f2-74aa-6c9a6ae2bbc9@dustymabe.com> <20230804032523.GA81493@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804032523.GA81493@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

FYI, I've found an arm64 system with 16k page size support, and while
I can't reproduce the exact issue, I do see corruption with I/O test
on zram that don't show on the same system with 4k pages.  I'm trying
to understand the details at the moment.

