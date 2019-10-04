Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68177C47404
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 15:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B6D222C0
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 15:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389812AbfJDPeV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:34:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389318AbfJDPeU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Oct 2019 11:34:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DCDB930860D5;
        Fri,  4 Oct 2019 15:34:20 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 855E810018FF;
        Fri,  4 Oct 2019 15:34:20 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] io_uring: add support for IORING_REGISTER_FILES_UPDATE
References: <a7bc8d7f-2379-7492-93af-6ca0353c5eab@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 04 Oct 2019 11:34:19 -0400
In-Reply-To: <a7bc8d7f-2379-7492-93af-6ca0353c5eab@kernel.dk> (Jens Axboe's
        message of "Fri, 4 Oct 2019 08:52:52 -0600")
Message-ID: <x49d0fcmsn8.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 04 Oct 2019 15:34:20 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> Allows the application to remove/replace/add files to/from a file set.
> Passes in a struct:
>
> struct io_uring_files_update {
>         __u32 offset;
>         __s32 *fds;
> };
>
> that holds an array of fds, size of array passed in through the usual
> nr_args part of the io_uring_register() system call. The logic is as
> follows:
>
> 1) If ->fds[i] is -1, the existing file at i + ->offset is removed from
>    the set.
> 2) If ->fds[i] is a valid fd, the existing file at i + ->offset is
>    replaced with ->fds[i].
>
> For case #2, is the existing file is currently empty (fd == -1), the
> new fd is simply added to the array.

If I'm reading this (and the code) right, that means you can't add files
to a set.  Wouldn't that be a useful thing to do, instead of just
replacing existing ones?

Can you post the man page update along with this?

Thanks,
Jeff
