Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD07CA9EAF
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 15:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444F920873
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 15:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBJUQoe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfJUPrM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:47:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21051 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727607AbfJUPrM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 11:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571672831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQad8ZrBKkdbujoK1dYRLHqnQJLjhtrDGjV8AqMgwho=;
        b=cBJUQoe4aPIllmTHCsqwRpkjvkjnK+aFWDSBRxHsNhg3fVeJXSCrzV+oVSdg+cXX5w9Uvf
        BOXB/gufo67mlgBrDRfoZYSfvsoNdexvrhr5hzLmY+/2Ov2K02kw/Mqhe0HDiRHhgZR5qH
        GZlyuCBYk0vslbj7deMGc8tVrb77BpU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-XVodZtcLP8aBuz8eneI1SQ-1; Mon, 21 Oct 2019 11:47:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D29B47B;
        Mon, 21 Oct 2019 15:47:07 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA93F5C240;
        Mon, 21 Oct 2019 15:47:06 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>
Subject: Re: liburing 0.2 release?
References: <20191009083406.GA4327@stefanha-x1.localdomain>
        <414ccf6c-8591-a82b-9ae7-9b0f270d18e8@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 21 Oct 2019 11:47:05 -0400
In-Reply-To: <414ccf6c-8591-a82b-9ae7-9b0f270d18e8@kernel.dk> (Jens Axboe's
        message of "Wed, 9 Oct 2019 05:40:16 -0600")
Message-ID: <x49k18ygkxy.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: XVodZtcLP8aBuz8eneI1SQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 10/9/19 2:34 AM, Stefan Hajnoczi wrote:
>> Hi Jens,
>> I would like to add a liburing package to Fedora.  The liburing 0.1
>> release was in January and there have been many changes since then.  Is
>> now a good time for a 0.2 release?
>
> I've been thinking the same. I'll need to go over the 0.1..0.2 additions
> and ensure I'm happy with all of it (before it's set in stone), then we
> can tag 0.2.
>
> Let's aim for a 0.2 next week at the latest.

ping?

-Jeff

