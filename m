Return-Path: <SRS0=Ukdl=Y7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE6AC43331
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 17:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B2F2166E
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 17:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ug2YjOpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfKGRQW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:16:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46949 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730537AbfKGRQW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Nov 2019 12:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573146980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SEdWQaGFryuTv/nsU1+nEbvt9xnFrBLM9hi5OTh5uI=;
        b=Ug2YjOpbemAtEK0xo6oE0X5Zl1KFwdKrbEufnk+Hl05puqleYDDpfBd7ocQUqqJuHB0k0F
        zutKB4brLKKWUaYxXdhJdTYeGVz5Hqvg2W0BAK7dxOv5ZTzh3i0Mnp4oLos/tpdwclHyZx
        L6ZQuqcrnFr6AdMaeX11tf3sQ2ugiWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-cIIWMNoZMgeVRr0hN4Mq8A-1; Thu, 07 Nov 2019 12:16:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F06C1005500;
        Thu,  7 Nov 2019 17:16:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 597AB608B3;
        Thu,  7 Nov 2019 17:16:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <157313376558.29677.12389078014886241663.stgit@warthog.procyon.org.uk>
References: <157313376558.29677.12389078014886241663.stgit@warthog.procyon.org.uk> <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 05/14] pipe: Add general notification queue support [ver #2]
MIME-Version: 1.0
Content-ID: <28292.1573146969.1@warthog.procyon.org.uk>
Date:   Thu, 07 Nov 2019 17:16:09 +0000
Message-ID: <28293.1573146969@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: cIIWMNoZMgeVRr0hN4Mq8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sigh.  I forgot to build it with the new config options disabled.  I've fix=
ed
that up and pushed it to the git tree.

David

