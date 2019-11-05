Return-Path: <SRS0=uUnX=Y5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD79C5DF60
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 15:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D413221928
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 15:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2AB0o04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389405AbfKEPWY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:22:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21027 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388844AbfKEPWY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Nov 2019 10:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572967343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kVcZsKsLgcJRdCvJGYV7h7t0uG4kQZHNkrqv8xzTgG4=;
        b=Q2AB0o04UqBU73bR180uY7aO1K2kYCSXaH76XuDh6NjWCTQ5FROBM53gh9e+eq5QEteSDh
        UReWHt+nZjE9ZWQhRQn6kpZeWUhhBYVEsBytEXHAWg1AFERsEGga3Bf1cR8/Lf3SNVu/pj
        sPpbucz1Yor1++RywFfIkZSUlQB58F4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-_MSt9ZvlPjCb1gwNQ46U4A-1; Tue, 05 Nov 2019 10:22:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CBD2477;
        Tue,  5 Nov 2019 15:22:21 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (unknown [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 545C71001902;
        Tue,  5 Nov 2019 15:22:15 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Julia Suvorova <jusual@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH liburing v3 0/3] Fedora 31 RPM improvements
References: <20191105073917.62557-1-stefanha@redhat.com>
        <x494kzibhbh.fsf@segfault.boston.devel.redhat.com>
        <a039c944-f282-f9cd-6ddf-6ffb49228f17@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 05 Nov 2019 10:22:14 -0500
In-Reply-To: <a039c944-f282-f9cd-6ddf-6ffb49228f17@kernel.dk> (Jens Axboe's
        message of "Tue, 5 Nov 2019 08:13:14 -0700")
Message-ID: <x49o8xq9wm1.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: _MSt9ZvlPjCb1gwNQ46U4A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 11/5/19 6:09 AM, Jeff Moyer wrote:
>> Acked-by: Jeff Moyer<jmoyer@redhat.com>
>
> Patch 3 is attributed to you, but not signed off by you. Can
> I add your SOB to it?

Yes.

