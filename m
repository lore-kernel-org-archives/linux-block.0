Return-Path: <SRS0=otcQ=3E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B675CC32771
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 21:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FA72084D
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 21:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUtAoghN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAOVHn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:07:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30660 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728903AbgAOVHn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 16:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579122462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LdDxJ4TaImd6q6K/Midoj6ftwyCpFTFDZIo2bBl0h+Y=;
        b=FUtAoghNpFoQ/pYbsQUaBJaAJsazv9ag2BvveRlmncoMeJesW4AJko+8Min24MZDyuMebx
        fNcSzqYRTti16HEzQolEkEDE2xvU5EdekBjQjf9xKr5+diC0RUS8x9whP4F1g+xlCJBBKn
        HqS3Zx3chhhN7SbN0AXHi13EA41nJvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-Nm7f_jTgN36eBJiQzWf3_A-1; Wed, 15 Jan 2020 16:07:41 -0500
X-MC-Unique: Nm7f_jTgN36eBJiQzWf3_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4A13801E6C;
        Wed, 15 Jan 2020 21:07:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97A721000329;
        Wed, 15 Jan 2020 21:07:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjrrOgznCy3yUmcmQY1z_7vXVr6GbvKiy8cLvWbxpmzcw@mail.gmail.com>
References: <CAHk-=wjrrOgznCy3yUmcmQY1z_7vXVr6GbvKiy8cLvWbxpmzcw@mail.gmail.com> <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/14] pipe: Keyrings, Block and USB notifications [ver #3]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24898.1579122454.1@warthog.procyon.org.uk>
Date:   Wed, 15 Jan 2020 21:07:34 +0000
Message-ID: <24899.1579122454@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So I no longer hate the implementation, but I do want to see the
> actual user space users come out of the woodwork and try this out for
> their use cases.

I'll see if I can get someone to help fix this:

	https://bugzilla.redhat.com/show_bug.cgi?id=1551648

for the KEYRING kerberos cache using notifications.  Note that the primary
thrust of this BZ is with KCM cache, but it affects KEYRING as well.

Also, I'll poke Greg, since he was interested in using it for USB
notifications.

David

