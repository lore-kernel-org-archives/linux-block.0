Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB60C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 01:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E0E20675
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 01:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfAQBbb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:31:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbfAQBbb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 20:31:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7669C059B77;
        Thu, 17 Jan 2019 01:31:31 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (unknown [10.18.25.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 21C7D5C22E;
        Thu, 17 Jan 2019 01:31:31 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [patch] io_uring: don't allow duplicate registrations
References: <x497ef4hzuj.fsf@segfault.boston.devel.redhat.com>
        <9965e26b-1490-7a18-e112-0d2318b8b23f@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 16 Jan 2019 20:31:30 -0500
In-Reply-To: <9965e26b-1490-7a18-e112-0d2318b8b23f@kernel.dk> (Jens Axboe's
        message of "Wed, 16 Jan 2019 18:23:16 -0700")
Message-ID: <x4936pshxxp.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 17 Jan 2019 01:31:31 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 1/16/19 5:50 PM, Jeff Moyer wrote:
>> Hi, Jens,
>> 
>> It looks to me like calling io_uring_register more than once (for either
>> IORING_REGISTER_BUFFERS or IORING_REGISTER_FILES) will leak the
>> references taken in previous calls.
>
> Oops, thanks for that. Let's make it -EBUSY though, everything ends up
> being -EINVAL and that sometimes makes it hard for an application to
> figure out wtf is going on.

Sounds good.

> I also added -EINVAL for unregister when not already setup.

Yep, I saw that.

-Jeff
