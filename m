Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A986AC31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807A220449
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbfFMPNM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:13:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732268AbfFMNfB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 09:35:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C97C330C7E65;
        Thu, 13 Jun 2019 13:34:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-109.rdu2.redhat.com [10.10.120.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8B695C3F8;
        Thu, 13 Jun 2019 13:34:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <6b6f5bb0-1426-239b-ac9f-281e31ddcd04@infradead.org>
References: <6b6f5bb0-1426-239b-ac9f-281e31ddcd04@infradead.org> <20190607151228.GA1872258@magnolia> <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk> <155991706083.15579.16359443779582362339.stgit@warthog.procyon.org.uk> <29222.1559922719@warthog.procyon.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     dhowells@redhat.com, "Darrick J. Wong" <darrick.wong@oracle.com>,
        viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] uapi: General notification ring definitions [ver #4]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30225.1560432885.1@warthog.procyon.org.uk>
Date:   Thu, 13 Jun 2019 14:34:45 +0100
Message-ID: <30226.1560432885@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 13 Jun 2019 13:35:01 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:

> What is the problem with inline functions in UAPI headers?

It makes compiler problems more likely; it increases the potential for name
collisions with userspace; it makes for more potential problems if the headers
are imported into some other language; and it's not easy to fix a bug in one
if userspace uses it, just in case fixing the bug breaks userspace.

Further, in this case, the first of Darrick's functions (calculating the
length) is probably reasonable, but the second is not.  It should crank the
tail pointer and then use that, but that requires 

> >> Also, weird multiline comment style.
> > 
> > Not really.
> 
> Yes really.

No.  It's not weird.  If anything, the default style is less good for several
reasons.  I'm going to deal with this separately as I need to generate some
stats first.

David
