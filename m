Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF71EB64DD
	for <linux-block@archiver.kernel.org>; Mon, 24 Jul 2023 21:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjGXVVY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jul 2023 17:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjGXVVY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 17:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA02E7E
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 14:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690233634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CVwkfPUpFSXUbI4e0RCN90tgfefnC8zInlyZN7AoFF4=;
        b=VZZvmIi24oxyjfWgzb8b9tsftRiRlr5GLfkbFrm5jDud+PoN5IARcHn+cOr1V59KHsbPIF
        hd8wXMfdAXmT7aHnrKmcidG0UhlE/KyqSlf3flmup9/HoB/ts7X5n7gQg+z8jjXSnIwn89
        f4L3MM5qEE2zQ8+OUsR8q0gZBZI8+Jc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-I_GAWX1eN7ij9MzPAOoN7g-1; Mon, 24 Jul 2023 17:20:33 -0400
X-MC-Unique: I_GAWX1eN7ij9MzPAOoN7g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A01B11C068D8;
        Mon, 24 Jul 2023 21:20:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69BB2200BA63;
        Mon, 24 Jul 2023 21:20:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000836b2805fffd6d7e@google.com>
References: <000000000000836b2805fffd6d7e@google.com>
To:     syzbot <syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org, axboe@kernel.dk,
        herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] KASAN: slab-out-of-bounds Read in bio_split_rw
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20205.1690233630.1@warthog.procyon.org.uk>
Date:   Mon, 24 Jul 2023 22:20:30 +0100
Message-ID: <20206.1690233630@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

#syz fix: crypto: algif_hash - Fix race between MORE and non-MORE sends

