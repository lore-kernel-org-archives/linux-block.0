Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9223BC43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E8320855
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfAQVVn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:21:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfAQVVn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 16:21:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55EBF2CD816;
        Thu, 17 Jan 2019 21:21:43 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A67A60933;
        Thu, 17 Jan 2019 21:21:42 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Roman Penyaev <rpenyaev@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-arch@vger.kernel.org, hch@lst.de, avi@scylladb.com,
        linux-block-owner@vger.kernel.org
Subject: Re: [PATCH 05/15] Add io_uring IO interface
References: <20190116175003.17880-1-axboe@kernel.dk>
        <20190116175003.17880-6-axboe@kernel.dk>
        <718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
        <af41e99c-54f2-a94c-a876-d673fe477e0a@kernel.dk>
        <x49bm4f831e.fsf@segfault.boston.devel.redhat.com>
        <f5ecdead-ea0f-6b79-5f70-b002a103e503@kernel.dk>
        <02568485-cd10-182d-98e3-619077cf9bdc@kernel.dk>
        <x4936pr80uw.fsf@segfault.boston.devel.redhat.com>
        <3180aa85-68a6-0eb2-082b-f177344cefa9@kernel.dk>
        <x49y37j6lqi.fsf@segfault.boston.devel.redhat.com>
        <c86dbb69-1937-5a0d-11ff-98d933f6581a@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 17 Jan 2019 16:21:41 -0500
In-Reply-To: <c86dbb69-1937-5a0d-11ff-98d933f6581a@kernel.dk> (Jens Axboe's
        message of "Thu, 17 Jan 2019 14:17:05 -0700")
Message-ID: <x49tvi76kuy.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 17 Jan 2019 21:21:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

>> So all we need to do is modify gpg2 so that is requires more locked
>> memory, and we're golden!  ;-)
>
> Haha, that's some nice digging there!
>
> Yes, we could bump it, but with the default, we can get a 512 sized
> ring per user, that's 13 pages (rounded up). Probably good enough to
> get things off the ground?

Agreed.  I'll work on bloating gpg as a background task.  =P  Or I guess
we could add instructions for modifying /etc/security/limits.conf to the
man pages.

Cheers,
Jeff
