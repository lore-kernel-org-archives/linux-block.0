Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57856C7EE20
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 06:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjDXGDG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 02:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjDXGC3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 02:02:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEEF49CB
        for <linux-block@vger.kernel.org>; Sun, 23 Apr 2023 23:01:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D1E0C67373; Mon, 24 Apr 2023 08:01:39 +0200 (CEST)
Date:   Mon, 24 Apr 2023 08:01:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <nks@flawful.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <mb@lightnvm.io>
Subject: Re: [PATCH v2 10/11] block: Add support for the zone capacity
 concept
Message-ID: <20230424060139.GA9805@lst.de>
References: <f9d35d19-d0ba-fcb7-e44b-f0b8c55ba399@acm.org> <141aee35-4288-1670-6424-e6c41c8ef4c9@kernel.org> <ec7cdc7d-9eb7-65a4-6ba9-1ae6cf6f43d2@acm.org> <a5d9a370-6264-ebdf-f9f8-7b3263c2b6f0@kernel.org> <490ed061-6d82-f9fb-2050-4a386e2e4c8e@acm.org> <c4a52bff-5cab-5029-ad7f-e5f9452bc0e2@kernel.org> <ZEHY2PIRCCLOZsC4@google.com> <c12582e0-f2c8-d001-1fc1-6f7e17eeba7c@kernel.org> <ZELu0yKwnGg3iBmA@google.com> <335b63b0-5a9e-472d-2cce-c0158ae93cf3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335b63b0-5a9e-472d-2cce-c0158ae93cf3@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 22, 2023 at 07:25:33AM +0900, Damien Le Moal wrote:
> >> for allocating blocks. This is a resource management issue.
> > 
> > Ok, so it seems I overlooked there might be something in the zone allocation
> > policy. So, f2fs already manages 6 open zones by design.
> 
> Yes, so as long as the device allows for at least 6 active zones, there are no
> issues with f2fs.

I don't think it's quite as rosy, because f2fs can still schedule
I/O to the old zone after already scheduling I/O to a new zone for
any of these 6 slots.  It'll need code to wait for all I/O to the old
zone to finish first, similar to btrfs.
