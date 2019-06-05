Return-Path: <SRS0=Ij7C=UE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2DDC28D18
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 16:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DBD2075B
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 16:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfFEQ5C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:57:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728753AbfFEQ5C (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jun 2019 12:57:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCF5730833B2;
        Wed,  5 Jun 2019 16:56:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E1CF1019606;
        Wed,  5 Jun 2019 16:56:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <e4c19d1b-9827-5949-ecb8-6c3cb4648f58@schaufler-ca.com>
References: <e4c19d1b-9827-5949-ecb8-6c3cb4648f58@schaufler-ca.com> <50c2ea19-6ae8-1f42-97ef-ba5c95e40475@schaufler-ca.com> <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk> <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com> <20192.1559724094@warthog.procyon.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Rational model for UID based controls
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18356.1559753807.1@warthog.procyon.org.uk>
Date:   Wed, 05 Jun 2019 17:56:47 +0100
Message-ID: <18357.1559753807@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 05 Jun 2019 16:57:02 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> YES!

I'm trying to decide if that's fervour or irritation at this point ;-)

> And it would be really great if you put some thought into what
> a rational model would be for UID based controls, too.

I have put some thought into it, but I don't see a single rational model.  It
depends very much on the situation.

In any case, that's what I was referring to when I said I might need to call
inode_permission().  But UIDs don't exist for all filesystems, for example,
and there are no UIDs on superblocks, mount objects or hardware events.

Now, I could see that you ignore UIDs on things like keys and
hardware-triggered events, but how does this interact with things like mount
watches that see directories that have UIDs?

Are you advocating making it such that process B can only see events triggered
by process A if they have the same UID, for example?

David
