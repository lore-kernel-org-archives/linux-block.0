Return-Path: <SRS0=C1jc=Q6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DBEC43381
	for <linux-block@archiver.kernel.org>; Sat, 23 Feb 2019 02:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8185C2070D
	for <linux-block@archiver.kernel.org>; Sat, 23 Feb 2019 02:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfBWCoJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Feb 2019 21:44:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBWCoI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Feb 2019 21:44:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 879493003B34;
        Sat, 23 Feb 2019 02:44:08 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7362600CD;
        Sat, 23 Feb 2019 02:44:03 +0000 (UTC)
Date:   Fri, 22 Feb 2019 21:44:02 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     John Dorminy <jdorminy@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, NeilBrown <neilb@suse.com>,
        linux-block@vger.kernel.org,
        device-mapper development <dm-devel@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: block: be more careful about status in __bio_chain_endio
Message-ID: <20190223024402.GA12407@redhat.com>
References: <70cda2a3-f246-d45b-f600-1f9d15ba22ff@gmail.com>
 <87eflmpqkb.fsf@notabene.neil.brown.name>
 <20190222211006.GA10987@redhat.com>
 <7f0aeb7b-fdaa-0625-f785-05c342047550@kernel.dk>
 <20190222235459.GA11726@redhat.com>
 <CAMeeMh-2ANOr_Sb66EyA_HULkVRudD7fyOZsDbpRpDrshwnR2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMeeMh-2ANOr_Sb66EyA_HULkVRudD7fyOZsDbpRpDrshwnR2w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sat, 23 Feb 2019 02:44:08 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 22 2019 at  9:02pm -0500,
John Dorminy <jdorminy@redhat.com> wrote:

> I am perhaps not understanding the intricacies here, or not seeing a
> barrier protecting it, so forgive me if I'm off base. I think reading
> parent->bi_status here is unsafe.
> Consider the following sequence of events on two threads.
> 
> Thread 0                                 Thread 1
> In __bio_chain_endio:                    In __bio_chain_endio:
> [A] Child 0 reads parent->bi_status,
>     no error.
>                                          Child bio 1 reads parent, no error seen
>                                          It sets parent->bi_status to an error
>                                          It calls bio_put.
> Child bio 0 calls bio_put
> [end __bio_chain_endio]                  [end __bio_chain_endio]
>                                          In bio_chain_endio(), bio_endio(parent)
>                                          is called, calling bio_remaining_done()
>                                          which decrements __bi_remaining to 1
>                                          and returns false, so no further endio
>                                          stuff is done.
> In bio_chain_endio(), bio_endio(parent)
> is called, calling bio_remaining_done(),
> decrementing parent->__bi_remaining to
>  0, and continuing to finish parent.
> Either for block tracing or for parent's
> bi_end_io(), this thread tries to read
> parent->bi_status again.
> 
> The compiler or the CPU may cache the read from [A], and since there
> are no intervening barriers, parent->bi_status is still believed on
> thread 0 to be success. Thus the bio may still be falsely believed to
> have completed successfully, even though child 1 set an error in it.
> 
> Am I missing a subtlety here?

Either neilb's original or even Jens' suggestion would be fine though.

>       if (!parent->bi_status && bio->bi_status)
>               parent->bi_status = bio->bi_status;

Even if your scenario did play out (which I agree it looks possible)
it'd just degenerate to neilb's version:

>       if (bio->bi_status)
>               parent->bi_status = bio->bi_status;

Which also accomplishes fixing what Neil originally detailed in his
patch header.
