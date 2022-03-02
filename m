Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6052DC433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 15:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243424AbiCBPUY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 10:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiCBPUX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 10:20:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D76DFC6258
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 07:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646234378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ss+f+RADfTVm1TaAGMxnunJihZ0Q5aGV0Ws8tGhjrZI=;
        b=XMS/3u9IPcNI2/z6aa9DdbnFGTBNU8GK7NCaQQ2bQ90jd1MXHuX4LWrK7nUqCtyMVjCBL2
        pGM1b4BYzGftHqALQN73WB2aqT3l8vtmc5can1929An14Nj7RuP5uJJ4Bkf56qjo1rRP+P
        S1z3292wtSPBcRXsdzLMfs09Sf1reQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-AbUz4eUSNw6ECWZ2gnLwqg-1; Wed, 02 Mar 2022 10:19:35 -0500
X-MC-Unique: AbUz4eUSNw6ECWZ2gnLwqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59AC8100B3AC;
        Wed,  2 Mar 2022 15:19:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F319583BFA;
        Wed,  2 Mar 2022 15:19:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Yh1swsJLXvLLIQ0e@bombadil.infradead.org>
References: <Yh1swsJLXvLLIQ0e@bombadil.infradead.org> <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com> <1476917.1643724793@warthog.procyon.org.uk>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     dhowells@redhat.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] configfd as a replacement for both ioctls and fsconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3570400.1646234372.1@warthog.procyon.org.uk>
Date:   Wed, 02 Mar 2022 15:19:32 +0000
Message-ID: <3570401.1646234372@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> wrote:

> > It'd be nice to be able to set up a 'configuration transaction' and then
> > do a commit to apply it all in one go.
> 
> Can't io-uring cmd effort help here?

I don't know.  Wouldn't that want to apply each element as a separate thing?

But you might want to do something more akin to a db transaction, where you
start a transaction, read stuff, consider your changes, propose your changes
and then commit - which would mean io_uring wouldn't help.

David

