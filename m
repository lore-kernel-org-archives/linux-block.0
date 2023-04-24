Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6923AC77B61
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 17:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjDXR6z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 13:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXR6y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 13:58:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF5C7D89
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 10:58:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AA2F627AD
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 17:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1C3C433D2;
        Mon, 24 Apr 2023 17:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682359132;
        bh=OzG5UUjuMjhuuuqra88kr4OGbAu/y+YHSDCBCSKPy3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgJrnttpEYDcWlFLU9HlCsJqkoCqamcGb0Q6M7uexxHqqOQxnENmCDVX51kZmfoY+
         zSGYZ08faCdme37m1FcbdHIkowesJl/+hk2NbJA1/yt+ubzVsArhJfZr0R3vcai6BU
         WShToh3e3zQjg4CSN+4EkJ8ZPmuSfwOLpVLiNIQU2FuOTNOJVINPzcHOr48NgPgNJS
         JLrNKMsoFdfWy0bXKd+isc7AdykGJ9zG0tDyXjh/3NKvPPwYxDlyVFSsP8WNVis7S1
         rDo6Pqp3S/yCWqFS+9M9bGgyjYnuqDBNpTaRsCXD+olbo8RRDa+UJ9yp/9aRLqdubM
         TVUVguu8NkVKg==
Date:   Mon, 24 Apr 2023 10:58:50 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <nks@flawful.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <mb@lightnvm.io>
Subject: Re: [PATCH v2 10/11] block: Add support for the zone capacity concept
Message-ID: <ZEbDWqdU8hXVLYhD@google.com>
References: <141aee35-4288-1670-6424-e6c41c8ef4c9@kernel.org>
 <ec7cdc7d-9eb7-65a4-6ba9-1ae6cf6f43d2@acm.org>
 <a5d9a370-6264-ebdf-f9f8-7b3263c2b6f0@kernel.org>
 <490ed061-6d82-f9fb-2050-4a386e2e4c8e@acm.org>
 <c4a52bff-5cab-5029-ad7f-e5f9452bc0e2@kernel.org>
 <ZEHY2PIRCCLOZsC4@google.com>
 <c12582e0-f2c8-d001-1fc1-6f7e17eeba7c@kernel.org>
 <ZELu0yKwnGg3iBmA@google.com>
 <335b63b0-5a9e-472d-2cce-c0158ae93cf3@kernel.org>
 <20230424060139.GA9805@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424060139.GA9805@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/24, Christoph Hellwig wrote:
> On Sat, Apr 22, 2023 at 07:25:33AM +0900, Damien Le Moal wrote:
> > >> for allocating blocks. This is a resource management issue.
> > > 
> > > Ok, so it seems I overlooked there might be something in the zone allocation
> > > policy. So, f2fs already manages 6 open zones by design.
> > 
> > Yes, so as long as the device allows for at least 6 active zones, there are no
> > issues with f2fs.
> 
> I don't think it's quite as rosy, because f2fs can still schedule
> I/O to the old zone after already scheduling I/O to a new zone for
> any of these 6 slots.  It'll need code to wait for all I/O to the old
> zone to finish first, similar to btrfs.

F2FS should serialize all the writes across 6 active open zones. If not, I think
it's a bug. The problem here is 1) open zone#1 through zone #6, 2) allocate all
blocks in zone #1, 3) submit all writes in zone #1, 4) allocate blocks in zone
#7, 5) submit all writes in zone #7, and so on.

In this scenario, I'm asking why F2FS needs to wait for entire write completion
between 3) and 4), which will impact performance a lot since 4) blocks syscalls.
