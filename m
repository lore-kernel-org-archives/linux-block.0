Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06312C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4B820660
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4B820660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeLAJPT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:15:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33443 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbeLAJPT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Dec 2018 04:15:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2271F3002E09;
        Fri, 30 Nov 2018 22:04:36 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8106618C69;
        Fri, 30 Nov 2018 22:04:35 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
Subject: Re: [PATCH 27/27] aio: add support for pre-mapped user IO buffers
References: <20181130165646.27341-1-axboe@kernel.dk>
        <20181130165646.27341-28-axboe@kernel.dk>
        <x49pnum5jfv.fsf@segfault.boston.devel.redhat.com>
        <8dc2ea1d-b6a4-728b-7550-87d32240989c@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 30 Nov 2018 17:04:34 -0500
In-Reply-To: <8dc2ea1d-b6a4-728b-7550-87d32240989c@kernel.dk> (Jens Axboe's
        message of "Fri, 30 Nov 2018 14:57:58 -0700")
Message-ID: <x49k1ku5ij1.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 30 Nov 2018 22:04:36 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

>>> A limit of 4M is imposed as the largest buffer we currently support.
>>> There's nothing preventing us from going larger, but we need some cap,
>>> and 4M seemed like it would definitely be big enough.
>> 
>> Doesn't this mean that a user can pin a bunch of memory?  Something like
>> 4MB * aio_max_nr?
>> 
>> $ sysctl fs.aio-max-nr
>> fs.aio-max-nr = 1048576
>> 
>> If so, it may be a good idea to account the memory under RLIMIT_MEMLOCK.
>
> Yes, it'll need some kind of limiting, right now the limit would indeed
> be aio-max-nr * 4MB. 4G isn't terrible, but...

Unless my math's wrong, that's 4TiB on my system.  ;-)

> RLIMIT_MEMLOCK isn't a bad idea.
>
>> I'm not sure how close you are to proposing this patch set for realz.
>> If it's soon (now?), then CC-ing linux-api and writing man pages would
>> be a good idea.  I can help out with the libaio bits if you'd like.  I
>> haven't yet had time to take this stuff for a spin, sorry.  I'll try to
>> get to that soonish.
>
> I am proposing it for real, not sure how long it'll take to get it
> reviewed and moved forward. Unless I get lucky. 4.22 seems like a more
> viable version than 4.21.
>
> I'll take any help I can get on the API/man page parts. And/or testing!

OK, I'll add libaio support (including unit tests), write the man page,
and I'll definitely do some testing.  I'll start on all that probably in
the latter half of next week.

>> The speedups are pretty impressive!
>
> That's why I put them in there, maybe that'd get peoples attention :-)

Indeed.  :)

Cheers,
Jeff
