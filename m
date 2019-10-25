Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9867CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 12:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0AF20679
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 12:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWpsPeYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438947AbfJYMbx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:31:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46408 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726484AbfJYMbx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 08:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572006712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3GtRbvaClYlQykY0Z7o12Bv2rGhYajK3yHEhiEL6vi4=;
        b=AWpsPeYyPP9T1ZpgrFr0MsUsroQV3RODfMYt0WD+0d93WTceo1KtBXvx5nHJdfCrUg8SlO
        fi5Q6MkACsXGr7eN/xbiXRxr3z3UFWf2r51WtcVznMTkgGmIy+3c3IX2ZLlBkhrjwWV/4C
        JUiZd6yKXdah+eeEB7JXtqgfJHVwAqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272--yb27Mj2PeeINj1X_RQKbg-1; Fri, 25 Oct 2019 08:31:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBA46800D41;
        Fri, 25 Oct 2019 12:31:47 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BFBB5C1B5;
        Fri, 25 Oct 2019 12:31:42 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>
Subject: Re: liburing 0.2 release?
References: <20191009083406.GA4327@stefanha-x1.localdomain>
        <414ccf6c-8591-a82b-9ae7-9b0f270d18e8@kernel.dk>
        <x49k18ygkxy.fsf@segfault.boston.devel.redhat.com>
        <e4a6052d-b101-cb0b-949b-110c96dba131@kernel.dk>
        <568a4400-94d9-8b31-43bd-bd28e405f36f@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 25 Oct 2019 08:31:41 -0400
In-Reply-To: <568a4400-94d9-8b31-43bd-bd28e405f36f@kernel.dk> (Jens Axboe's
        message of "Thu, 24 Oct 2019 20:24:30 -0600")
Message-ID: <x49h83xc8gi.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: -yb27Mj2PeeINj1X_RQKbg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 10/21/19 9:49 AM, Jens Axboe wrote:
>> On 10/21/19 9:47 AM, Jeff Moyer wrote:
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>
>>>> On 10/9/19 2:34 AM, Stefan Hajnoczi wrote:
>>>>> Hi Jens,
>>>>> I would like to add a liburing package to Fedora.  The liburing 0.1
>>>>> release was in January and there have been many changes since then.  =
Is
>>>>> now a good time for a 0.2 release?
>>>>
>>>> I've been thinking the same. I'll need to go over the 0.1..0.2 additio=
ns
>>>> and ensure I'm happy with all of it (before it's set in stone), then w=
e
>>>> can tag 0.2.
>>>>
>>>> Let's aim for a 0.2 next week at the latest.
>>>
>>> ping?
>>=20
>> Still on the radar, just got dragged out a bit with the changes last wee=
k.
>> Let's aim for this week :-)
>
> OK, I think we're good to go. I tagged and pushed out 0.2 just now.

Thanks!
Jeff

