Return-Path: <SRS0=leUH=UL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E0BC31E44
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 02:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E93F20673
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 02:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406521AbfFLC4z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 22:56:55 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:43266 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405061AbfFLC4z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 22:56:55 -0400
Received: by mail-qk1-f175.google.com with SMTP id m14so9067836qka.10
        for <linux-block@vger.kernel.org>; Tue, 11 Jun 2019 19:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1Qi48oLh9iihq2LkIgrDslGg/Vx8JGXFp2UzVtaaTY=;
        b=RMQH4BWHqjq0RC4v9ylnfi17XF0ibDNjTLhUooo+XTisCJ3K4g4WQRfr9liqf4mVRh
         fEsIuJTP1CkaIzM/qag4OhmpdLJsyB8HuGySKRe9WhZSKae+YMI/XiJ+N8JpHKOtZScv
         PZPWm6FQZuCDi7eRMAp4d4PBoj/GEmuoXzJ28zLcsZtyKyKvNK+7/LBT8gkNuQGpd7u/
         UQJPe6A6ou9/MrQAvW6fJJzosw9sck2EeC4SeHKLlLqHBkVjHH/Cg5ATRLX8VyXtbI2R
         0ybHqQpVMJnrONdRWcb9aZ9Uytygqx76WA1xVLzXsDrMX+HHeShBwO7+QQf/4XtYiGqF
         2S0A==
X-Gm-Message-State: APjAAAVtClV+ddomam/8o5ZCOb8oXKtf2yL26zE33DnlnLYXfXAggNLA
        oSafzYGmJr7UiDNPMKzHkm/LlNjFvWZC5a95EUit2g==
X-Google-Smtp-Source: APXvYqxctTUcbUUwKEwCDb+kAVsNlcPeMauTITiiVl5q4wHU5Gq3T5KxTJd5OAfYva1ulpddSUg3/ykgbXPYx9uR294=
X-Received: by 2002:a37:6708:: with SMTP id b8mr61258505qkc.141.1560308214695;
 Tue, 11 Jun 2019 19:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <70cda2a3-f246-d45b-f600-1f9d15ba22ff@gmail.com>
 <87eflmpqkb.fsf@notabene.neil.brown.name> <20190222211006.GA10987@redhat.com>
 <7f0aeb7b-fdaa-0625-f785-05c342047550@kernel.dk> <20190222235459.GA11726@redhat.com>
 <CAMeeMh-2ANOr_Sb66EyA_HULkVRudD7fyOZsDbpRpDrshwnR2w@mail.gmail.com>
 <20190223024402.GA12407@redhat.com> <CAMeeMh9qLkTByWJewPR4o844wPkA-g5Hnm7aGjszuPopPAe8vA@mail.gmail.com>
In-Reply-To: <CAMeeMh9qLkTByWJewPR4o844wPkA-g5Hnm7aGjszuPopPAe8vA@mail.gmail.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Tue, 11 Jun 2019 22:56:42 -0400
Message-ID: <CAMeeMh-6KMLgriX_7KT52ynjBMyT9yDWSMKv6YXW+yDpvv0=wA@mail.gmail.com>
Subject: Re: block: be more careful about status in __bio_chain_endio
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, NeilBrown <neilb@suse.com>,
        linux-block@vger.kernel.org,
        device-mapper development <dm-devel@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Having studied the code in question more thoroughly, my first email's
scenario can't occur, I believe. bio_put() contains a
atomic_dec_and_test(), which (according to
Documentation/atomic_t.txt), having a return value, are fully ordered
and therefore impose a general memory barrier. A general memory
barrier means that no value set before bio_put() may be observed
afterwards, if I accurately understand
Documentation/memory_barriers.txt. Thus, the scenario I imagined, with
a load from inside __bio_chain_endio() being visible in bi_end_io(),
cannot occur.

However, the second email's scenario, of a compiler making two stores
out of a conditional store, is still accurate according to my
understanding. I continue to believe setting parent->bi_status needs
to be a WRITE_ONCE() and any reading of parent->bi_status before
bio_put() needs to be at least a READ_ONCE(). The last thing in that
email is wrong for the same reason that the first email couldn't
happen: the bio_put() general barrier means later accesses to the
field from a single thread will freshly read the field and thereby not
get an incorrectly cached value.

As a concrete proposal, I believe either of the following work and fix
the race NeilB described, as well as the compiler (or CPU) race I
described:

 -     if (!parent->bi_status)
 -               parent->bi_status = bio->bi_status;
 +     if (bio->bi_status)
 +               WRITE_ONCE(parent->bi_status, bio->bi_status);

--or--

 -     if (!parent->bi_status)
 -               parent->bi_status = bio->bi_status;
 +     if (!READ_ONCE(parent->bi_status) && bio->bi_status)
 +               WRITE_ONCE(parent->bi_status, bio->bi_status);

I believe the second of these might, but is not guaranteed to,
preserve the first error observed in a child; I believe if you want to
definitely save the first error you need an atomic.
