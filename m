Return-Path: <SRS0=T+5Q=ZA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33487FA372C
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 12:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AFE222C9
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 12:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pk3X2dXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfKHMb4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:31:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30373 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725933AbfKHMbz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Nov 2019 07:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573216314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vMJWjmHAn9oXmduAqxbr7ld97ARES8e+B/CT4q03C/U=;
        b=Pk3X2dXuQsrYnVohOyyATVZq4LL+KpF/o2zcgCU6/6KWXCBYFHOBPYHilMsRJ5/KSGtsqZ
        2I/xbcq/PCFNoIIUMfxU4V8JiZwGl96ePB7vEegFt1J5Cp8cnJ9GTc8bCRMAjQzgupkvBR
        e6nYkz1hURUnUCiymmd38cXNxvVt/Yg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-w8K278-eNPCBfHYDXkJI7g-1; Fri, 08 Nov 2019 07:31:50 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86A11107ACC3;
        Fri,  8 Nov 2019 12:31:48 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BEFA31001902;
        Fri,  8 Nov 2019 12:31:45 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id xA8CVjPD004476;
        Fri, 8 Nov 2019 07:31:45 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id xA8CViNb004472;
        Fri, 8 Nov 2019 07:31:44 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 8 Nov 2019 07:31:44 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Alessio Balsini <balsini@android.com>
cc:     Jens Axboe <axboe@kernel.dk>, Alasdair G Kergon <agk@redhat.com>,
        elsk@google.com, dvander@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: dm-snapshot for system updates in Android
In-Reply-To: <20191104164900.GA10934@google.com>
Message-ID: <alpine.LRH.2.02.1911080723130.3392@file01.intranet.prod.int.rdu2.redhat.com>
References: <20191025101624.GA61225@google.com> <alpine.LRH.2.02.1910290957220.25731@file01.intranet.prod.int.rdu2.redhat.com> <20191104164900.GA10934@google.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: w8K278-eNPCBfHYDXkJI7g-1
X-Mimecast-Spam-Score: 0
Content-Type: TEXT/PLAIN; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Mon, 4 Nov 2019, Alessio Balsini wrote:

> > > -- Alignment
> > >=20
> > > Our approach follows the solution proposed by Mikulas [1].
> > > Being the block alignment of file extents automatically managed by th=
e
> > > filesystem, using FIEMAP should have no alignment-related performance=
 issue.
> > > But in our implementation we hit a misalignment [2] branch which lead=
s to
> > > dmwarning messages [3, 4].
> > >=20
> > > I have a limited experience with the block layer and dm, so I'm still
> > > struggling in finding the root cause for this, either in user space o=
r kernel
> > > space.
> >=20
> > I don't know. What is the block size of the filesystem? Are all mapping=
s=20
> > aligned to this block size?
>=20
> Here follows a just generated warning coming from a Pixel 4 kernel (4.14)=
:
>=20
> [ 3093.443808] device-mapper: table: 253:16: adding target device dm-15
> caused an alignment inconsistency: physical_block_size=3D4096,
> logical_block_size=3D4096, alignment_offset=3D61440, start=3D0
>=20
> Does this contain all the info you asked for?

Look at the function blk_stack_limits - it has various checks that make it=
=20
return -1. Insert some debugging printk's there and find out which check=20
made the function return -1.

Based on this, we can find out which of the limits triggered the error=20
message.

> I started investigating this issue, but since we didn't notice any
> performance degradation, I prioritized other things. I'll be hopefully
> able to get back to this warning in the next months.
> Please let me know if I can help you with that or if you need additional
> information.

Mikulas

