Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97970C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F0020868
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F0020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbeLFTig (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:38:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeLFTig (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Dec 2018 14:38:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F96E2D7F2;
        Thu,  6 Dec 2018 19:38:36 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC9192CFAB;
        Thu,  6 Dec 2018 19:38:35 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
Subject: Re: [PATCH 08/26] aio: don't zero entire aio_kiocb aio_get_req()
References: <20181204233729.26776-1-axboe@kernel.dk>
        <20181204233729.26776-9-axboe@kernel.dk>
        <x49y392fobn.fsf@segfault.boston.devel.redhat.com>
        <99b52953-091d-007c-43aa-41198b0ed747@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 06 Dec 2018 14:38:35 -0500
In-Reply-To: <99b52953-091d-007c-43aa-41198b0ed747@kernel.dk> (Jens Axboe's
        message of "Thu, 6 Dec 2018 12:28:37 -0700")
Message-ID: <x49pnuefnt0.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 06 Dec 2018 19:38:36 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 12/6/18 12:27 PM, Jeff Moyer wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>> 
>>> It's 192 bytes, fairly substantial. Most items don't need to be cleared,
>>> especially not upfront. Clear the ones we do need to clear, and leave
>>> the other ones for setup when the iocb is prepared and submitted.
>> 
>> What performance gains do you see from this?
>
> Before this, I had 1% in memset doing high IOPS. With it, that's gone.
> 1% is a lot, when you have just one thread doing everything from submission
> to completion.

I'm used to customers complaining about fractions of a percent, so I get
it.  :-)  I just wanted to know we had some measurable impact, as I've
seen bugs crop up from code like this in the past.

Thanks!
Jeff
