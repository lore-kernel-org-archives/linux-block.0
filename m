Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B710FC432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 16:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0DC208CC
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 16:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pkp37pRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfKSQqI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:46:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54061 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727560AbfKSQqI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Nov 2019 11:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574181967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=goFlWtu6657uFH0FTG7Kqe2ghLRVHCFg1wiXEeK4vRA=;
        b=Pkp37pRIv8TBeyem1CEW4wN6pjFHiblWSfrPPQ21jw5lbAHxkQdTlXwMTqQtL02wjnaJTk
        u0OG16WUpC+bTHHtvublkqQCBJNeVFdiSF6NbZH8Kvsqys9Zy6Zf7fJ5VtG4lX/EaZWRCq
        nISWrz63BJeBQ2VHNxieeKi6gfC8Kuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-zvdIGgUkMg-PRDObvulrRQ-1; Tue, 19 Nov 2019 11:46:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91D38107ACC4;
        Tue, 19 Nov 2019 16:46:02 +0000 (UTC)
Received: from [10.10.121.199] (ovpn-121-199.rdu2.redhat.com [10.10.121.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB8D71B42F;
        Tue, 19 Nov 2019 16:46:01 +0000 (UTC)
Subject: Re: [PATCH 0/2] nbd: local daemon restart support
To:     nbd@other.debian.org, axboe@kernel.dk, josef@toxicpanda.com,
        linux-block@vger.kernel.org
References: <20191116055017.6253-1-mchristi@redhat.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5DD41C49.3080209@redhat.com>
Date:   Tue, 19 Nov 2019 10:46:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20191116055017.6253-1-mchristi@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: zvdIGgUkMg-PRDObvulrRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/15/2019 11:50 PM, Mike Christie wrote:
> The following patches made over Linus's tree allow setups that are
> using AF_UNIX sockets with a local daemon to recover from crashes
> or to upgrade the daemon while IO is running without having to
> disrupt the application (no need to reopen the device or handle IO
> errors). They basically just use the existing failover
> infrastructure, but to failover to a new socket from a non-dead
> socket.

Josef and Jens,

I am dropping this patchset. Do not bother reviewing it. I will post
something else later.


