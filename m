Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C155CC43444
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 20:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1E520851
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 20:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfAQUDo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:03:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbfAQUDo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 15:03:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A18E58DFFA;
        Thu, 17 Jan 2019 20:03:43 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0E3D607AD;
        Thu, 17 Jan 2019 20:03:42 +0000 (UTC)
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
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 17 Jan 2019 15:03:41 -0500
In-Reply-To: <af41e99c-54f2-a94c-a876-d673fe477e0a@kernel.dk> (Jens Axboe's
        message of "Thu, 17 Jan 2019 07:01:07 -0700")
Message-ID: <x49bm4f831e.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 17 Jan 2019 20:03:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 1/17/19 5:48 AM, Roman Penyaev wrote:
>> On 2019-01-16 18:49, Jens Axboe wrote:
>> 
>> [...]
>> 
>>> +static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
>>> +				  struct io_uring_params *p)
>>> +{
>>> +	struct io_sq_ring *sq_ring;
>>> +	struct io_cq_ring *cq_ring;
>>> +	size_t size;
>>> +	int ret;
>>> +
>>> +	sq_ring = io_mem_alloc(struct_size(sq_ring, array, p->sq_entries));
>> 
>> It seems that sq_entries, cq_entries are not limited at all.  Can nasty
>> app consume a lot of kernel pages calling io_setup_uring() from a loop
>> passing random entries number? (or even better: decreasing entries 
>> number,
>> in order to consume all pages orders with min number of loops).
>
> Yes, that's an oversight, we should have a limit in place. I'll add that.

Can we charge the ring memory to the RLIMIT_MEMLOCK as well?  I'd prefer
not to repeat the mistake of fs.aio-max-nr.

-Jeff
