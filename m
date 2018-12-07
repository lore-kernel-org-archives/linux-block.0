Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB232C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 19:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C9720868
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 19:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C9720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeLGTeI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:34:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeLGTeH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Dec 2018 14:34:07 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2F097BDB9;
        Fri,  7 Dec 2018 19:34:07 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 051DE17BBD;
        Fri,  7 Dec 2018 19:34:06 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
Subject: Re: [PATCHSET v5] Support for polled aio
References: <20181204233729.26776-1-axboe@kernel.dk>
        <x49muphrx4u.fsf@segfault.boston.devel.redhat.com>
        <4bf3dfe4-b157-88b6-f9a3-60ad1f76328a@kernel.dk>
        <9747f14b-8361-08c0-5a1f-d4f26509083e@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 07 Dec 2018 14:34:06 -0500
In-Reply-To: <9747f14b-8361-08c0-5a1f-d4f26509083e@kernel.dk> (Jens Axboe's
        message of "Fri, 7 Dec 2018 11:55:11 -0700")
Message-ID: <x49a7lhrv0x.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 07 Dec 2018 19:34:07 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> BTW, quick guess is that it doesn't work so well with fixed buffers, as that
> hasn't been tested. You could try and remove IOCTX_FLAG_FIXEDBUFS from the
> test program and see if that works.

That results in a NULL pointer dereference.  I'll stick to block device
testing for now.  :)

-Jeff
