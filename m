Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25C0C3A5A2
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 16:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0DE2343A
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 16:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbfICQ30 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:29:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730333AbfICQ30 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Sep 2019 12:29:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 563E187521B;
        Tue,  3 Sep 2019 16:29:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57C0A19C78;
        Tue,  3 Sep 2019 16:29:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190903161202.GB22754@roeck-us.net>
References: <20190903161202.GB22754@roeck-us.net> <20190903125129.GA18838@roeck-us.net> <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk> <156717350329.2204.7056537095039252263.stgit@warthog.procyon.org.uk> <7481.1567526867@warthog.procyon.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] usb: Add USB subsystem notifications [ver #7]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29418.1567528161.1@warthog.procyon.org.uk>
Date:   Tue, 03 Sep 2019 17:29:21 +0100
Message-ID: <29419.1567528161@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Tue, 03 Sep 2019 16:29:25 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> wrote:

> > > This added call to usbdev_remove() results in a crash when running
> > > the qemu "tosa" emulation. Removing the call fixes the problem.
> > 
> > Yeah - I'm going to drop the bus notification messages for now.
> > 
> It is not the bus notification itself causing problems. It is the
> call to usbdev_remove().

Unfortunately, I don't know how to fix it and don't have much time to
investigate it right now - and it's something that can be added back later.

David
