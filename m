Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6317AC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 20:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7D02087E
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 20:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfA2Ufc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:35:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbfA2Ufc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 15:35:32 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0180080503;
        Tue, 29 Jan 2019 20:35:32 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BFF519062;
        Tue, 29 Jan 2019 20:35:31 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, avi@scylladb.com
Subject: Re: [PATCH 07/18] io_uring: support for IO polling
References: <20190128213538.13486-1-axboe@kernel.dk>
        <20190128213538.13486-8-axboe@kernel.dk>
        <20190129172414.GA15347@lst.de>
        <f21fc281-bbaa-3af5-3d64-a55933f1cbfb@kernel.dk>
        <cd1b43b7-7116-e53c-91fa-168e6c249e63@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 29 Jan 2019 15:35:30 -0500
In-Reply-To: <cd1b43b7-7116-e53c-91fa-168e6c249e63@kernel.dk> (Jens Axboe's
        message of "Tue, 29 Jan 2019 12:10:08 -0700")
Message-ID: <x49o97zi4ml.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 29 Jan 2019 20:35:32 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 1/29/19 11:31 AM, Jens Axboe wrote:
>>> The code looks a little clumsy to me.  Why not:
>>>
>>> 	while (!list_empty(&ctx->poll_list)) {
>>> 		int ret = io_do_iopoll(ctx, nr_events, min);
>>> 		if (ret)
>>> 			return ret;
>>>
>>> 		if (!min || *nr_events >= min)
>>> 			return 0;
>>> 	}
>>>
>>> 	return 1;
>> 
>> I think you messed up the 0/1 here, how about this:
>> 
>> 	while (!list_empty(&ctx->poll_list)) {
>> 		int ret;
>> 
>> 		ret = io_do_iopoll(ctx, nr_events, min);
>> 		if (ret < 0)
>> 			return ret;
>> 		if (!min || *nr_events >= min)
>> 			return 1;
>> 	}
>> 
>> 	return 0;
>
> Or I did... I think yours is correct.

maybe document the return code?  ;-)

-Jeff
