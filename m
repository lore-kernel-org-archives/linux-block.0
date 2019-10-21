Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308A5CA9EAF
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 21:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5812084B
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 21:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eI67CDaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfJUVnR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 17:43:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56224 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727264AbfJUVnR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 17:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571694196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7TGeLaJHLQfa3EPhpXyQnizlrqhS05at+Cg3a1T6joA=;
        b=eI67CDaVBZaKHdyjqF6rBw5ctlPjMKoH2j48Z4TcMynmlH549L4UXxMqbbkR0c/XkAzPbU
        LWBS9oviG37PUZ45Io6OdCbW2ZcezExZe1Ri8JmUKhKLM1fd2Vdh2Zbg9PqnmPnpJZW6R8
        MSaTAjNbZKxtWY3VfJFp5ZsaI5vm0HQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-zdn-zzpYOuiyX0UgVCM5ug-1; Mon, 21 Oct 2019 17:43:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90009800D41;
        Mon, 21 Oct 2019 21:43:11 +0000 (UTC)
Received: from [10.10.123.171] (ovpn-123-171.rdu2.redhat.com [10.10.123.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB3DD60CD0;
        Mon, 21 Oct 2019 21:43:10 +0000 (UTC)
Subject: Re: [PATCH 0/2] fix double completion of timed out commands
To:     Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk,
        nbd@other.debian.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
References: <20191021195628.19849-1-josef@toxicpanda.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5DAE266E.9020004@redhat.com>
Date:   Mon, 21 Oct 2019 16:43:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20191021195628.19849-1-josef@toxicpanda.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: zdn-zzpYOuiyX0UgVCM5ug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/2019 02:56 PM, Josef Bacik wrote:
> We noticed a problem where NBD sometimes double completes the same reques=
t when
> things go wrong and we time out the request.  If the other side goes out =
to
> lunch but happens to reply just as we're timing out the requests we can e=
nd up
> with a double completion on the request.
>=20
> We already keep track of the command status, we just need to make sure we
> protect all cases where we set cmd->status with the cmd->lock, which is p=
atch
> #1.  Patch #2 is the fix for the problem, which catches the case where we=
 race
> with the timeout handler and the reply handler.  Thanks,
>=20

Patches look ok and tested ok for me.

Reviewed-by: Mike Christie <mchristi@redhat.com>

