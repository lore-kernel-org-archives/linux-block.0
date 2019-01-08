Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C505C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 13:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14208206BB
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 13:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfAHNtL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:49:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfAHNtL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jan 2019 08:49:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03D9341A59;
        Tue,  8 Jan 2019 13:49:11 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51BB45ED53;
        Tue,  8 Jan 2019 13:49:10 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Regression in v5.0-rc1: Panic at boot
References: <da851333-eadd-163a-8c78-e1f4ec5ec857@deltatee.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 08 Jan 2019 08:49:07 -0500
In-Reply-To: <da851333-eadd-163a-8c78-e1f4ec5ec857@deltatee.com> (Logan
        Gunthorpe's message of "Mon, 7 Jan 2019 12:41:06 -0700")
Message-ID: <x49y37v8dkc.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 08 Jan 2019 13:49:11 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Logan,

Logan Gunthorpe <logang@deltatee.com> writes:

> Hey,
>
> I found a regression in v5.0-rc1 this morning. My system panics on boot.
> I've attached a log of the panic.
>
> I bisected to find the problematic commit is:
>
> Fixes: 9d037ad707ed ("block: remove req->timeout_list")
>
> But it makes no sense to me why this commit would cause a problem like
> this. I've attached a bisect log. I've also tested v5.0-rc1 with this
> commit reverted and that boots fine.
>
> The traceback seems to indicate the problem is on the bip_get_seed()
> line in t10_pi_complete(). Which suggests that bio_integrity() is
> returning NULL.

Does your hardware actually support protection information?

-Jeff
