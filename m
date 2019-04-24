Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D66AC10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 17:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EC920675
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 17:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbfDXRUv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:20:51 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33527 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389213AbfDXRUu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 13:20:50 -0400
Received: by mail-ot1-f66.google.com with SMTP id j10so16877453otq.0
        for <linux-block@vger.kernel.org>; Wed, 24 Apr 2019 10:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7fP1oDe6kuz4UXqnZRDbca6CuA5rLxVk2MLBFviUJOw=;
        b=d6j0CftYxHujbMZhwfEXqOTT4QqUjkSraz0cyTiLhQIE5Dcy5BfefF8/NZ8T3The75
         XYDSPggMX6Hf2J7oAWgbFKpPef+RBckANZyxHmATd4wGYWr6e2rW+qiwAFQBfWKrMMsa
         0WnPnFKEJx4P1E+q+Q2aJmsisudBijidvS/kkX7s1iaMt00rQBb7yyngR3hKtWdS5NGj
         wnG3r5dX2ZoH1F701Fw40SMB2Srq5G5ib03wUGbZfw/xYyVAoG2WSmTsA1fVNxFk3y7m
         KUQSCthWPF86+E/vlkn/JvMawrsj+re2mUPCIm4fHJyQCKCWrkhNg2fzGC2B6K5ZHJjM
         Hfpg==
X-Gm-Message-State: APjAAAXWGnlhZuJIjBas9c/nt4HPxvdzCghqUiK8oAly4v9O7IT+44n3
        BFnVa0F1Su+4wlBOuBnFu1A=
X-Google-Smtp-Source: APXvYqyjwxY3va3DOfoxLBQ7BXV6mn2zNZHqBk+mYtBC39FOIM/bHsLh5mkWapBH6JTHHDc1OjlPZQ==
X-Received: by 2002:a9d:7a57:: with SMTP id z23mr635769otm.66.1556126449246;
        Wed, 24 Apr 2019 10:20:49 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id v123sm8410953oie.25.2019.04.24.10.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:20:48 -0700 (PDT)
Subject: Re: [PATCH] block: use static bio_set for bio_split() calls
To:     Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        Bart van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@gmail.com>, neilb@suse.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20190418140632.60606-1-hare@suse.de>
 <20190418143429.GA19175@ming.t460p>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <98d8549a-2663-b404-e38a-6f55dfb575bf@grimberg.me>
Date:   Wed, 24 Apr 2019 10:20:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418143429.GA19175@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> per-queue bioset is used originally for avoiding deadlock, are you
> sure the static bioset is safe?

Can you explain this? I didn't find any indication of that in the change
log history...

Originally introduced by Kent:
--
commit 54efd50bfd873e2dbf784e0b21a8027ba4299a3e
Author: Kent Overstreet <kent.overstreet@gmail.com>
Date:   Thu Apr 23 22:37:18 2015 -0700

     block: make generic_make_request handle arbitrarily sized bios

     The way the block layer is currently written, it goes to great lengths
     to avoid having to split bios; upper layer code (such as 
bio_add_page())
     checks what the underlying device can handle and tries to always create
     bios that don't need to be split.

     But this approach becomes unwieldy and eventually breaks down with
     stacked devices and devices with dynamic limits, and it adds a lot of
     complexity. If the block layer could split bios as needed, we could
     eliminate a lot of complexity elsewhere - particularly in stacked
     drivers. Code that creates bios can then create whatever size bios are
     convenient, and more importantly stacked drivers don't have to deal 
with
     both their own bio size limitations and the limitations of the
     (potentially multiple) devices underneath them.  In the future this 
will
     let us delete merge_bvec_fn and a bunch of other code.

     We do this by adding calls to blk_queue_split() to the various
     make_request functions that need it - a few can already handle 
arbitrary
     size bios. Note that we add the call _after_ any call to
     blk_queue_bounce(); this means that blk_queue_split() and
     blk_recalc_rq_segments() don't need to be concerned with bouncing
     affecting segment merging.

     Some make_request_fn() callbacks were simple enough to audit and verify
     they don't need blk_queue_split() calls. The skipped ones are:

      * nfhd_make_request (arch/m68k/emu/nfblock.c)
      * axon_ram_make_request (arch/powerpc/sysdev/axonram.c)
      * simdisk_make_request (arch/xtensa/platforms/iss/simdisk.c)
      * brd_make_request (ramdisk - drivers/block/brd.c)
      * mtip_submit_request (drivers/block/mtip32xx/mtip32xx.c)
      * loop_make_request
      * null_queue_bio
      * bcache's make_request fns

     Some others are almost certainly safe to remove now, but will be left
     for future patches.
--
