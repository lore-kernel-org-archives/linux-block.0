Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA359C4360C
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 16:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B104420873
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 16:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389835AbfJDQRG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:17:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389131AbfJDQRG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Oct 2019 12:17:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D53B7315C01F;
        Fri,  4 Oct 2019 16:17:05 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7946D60BE1;
        Fri,  4 Oct 2019 16:17:05 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] io_uring: add support for IORING_REGISTER_FILES_UPDATE
References: <a7bc8d7f-2379-7492-93af-6ca0353c5eab@kernel.dk>
        <x49d0fcmsn8.fsf@segfault.boston.devel.redhat.com>
        <bbf022a4-9091-1e65-8516-aab39942e958@kernel.dk>
        <x498sq0mram.fsf@segfault.boston.devel.redhat.com>
        <fa43a684-77e7-7f4f-6fce-8fe1b0df6455@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 04 Oct 2019 12:17:04 -0400
In-Reply-To: <fa43a684-77e7-7f4f-6fce-8fe1b0df6455@kernel.dk> (Jens Axboe's
        message of "Fri, 4 Oct 2019 10:11:38 -0600")
Message-ID: <x494l0omqnz.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 04 Oct 2019 16:17:05 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 10/4/19 10:03 AM, Jeff Moyer wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>> 
>>> On 10/4/19 9:34 AM, Jeff Moyer wrote:
>>>> If I'm reading this (and the code) right, that means you can't add files
>>>> to a set.  Wouldn't that be a useful thing to do, instead of just
>>>> replacing existing ones?
>>>
>>> You can add files to a set, you just can't grow a set beyond the size
>>> you originally registered. I actually forgot to post the pre-patch for
>>> this, which is:
>>>
>>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring&id=fb3e60f87aa43f4f047f01243d6be54dadd9d67a
>>>
>>> This allows registering -1 as the fd, so you could register 10 files,
>>> but an array of size 500 (for example), and the last 490 fds are just
>>> -1. Then you can use the IORING_REGISTER_FILES_UPDATE to replace those
>>> empty fds with real files later on.
>> 
>> That makes more sense, but still requires a priori knowledge of how many
>> files you'll need to work with, otherwise you're back to
>> unregister/register dance.  Is it really that hard to grow on demand?
>
> It's not, it's just more efficient to add a file through replace, than it
> is to alloc a new array, copy things over, free it. That also impacts the
> application side of things, since that has to maintain an array of
> descriptors so that it knows what fd maps to what index.

Yeah, that's a good point about the application side.

> If you expose growing, you also have some kind of obligation to make it
> efficient, and I just don't think that's possible. But there's nothing
> preventing this API from supporting it, you'd just do an update with
> offset == current_array_size, and then nr_args as what to grow with.
> Currently that would -EINVAL, but it could be added as a feature.

OK, I'm fine with the API as-is.  If someone asks, growing can be added
later.

Cheers,
Jeff
