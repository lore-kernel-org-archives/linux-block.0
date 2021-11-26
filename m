Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D217C433F5
	for <linux-block@archiver.kernel.org>; Fri, 26 Nov 2021 02:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243672AbhKZCdT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 21:33:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357642AbhKZCbQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 21:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637893683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bpqpk+A6MWDqeCE+Wx9fqhfdeDYKPkiWWGLmDWm0KV8=;
        b=O5g4AsfsvCH5ZbiAXKnnWeOfftqL0nQIekyHKjfCw6h34dOidet/SmetGLN/Ebqj3dNfsU
        BUrFmE8xIvfas9HQ3nNKeSQKwBcf+tafQhiz+c5F2DeruJGJJ9RneWwNvICxVDRKRzQDD9
        corH/NsIWVvw5rwY+zhwgU8wFC+xQTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-GzfM0-iHOiia8Hn7zibt1g-1; Thu, 25 Nov 2021 21:28:02 -0500
X-MC-Unique: GzfM0-iHOiia8Hn7zibt1g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42B2F1006AA2
        for <linux-block@vger.kernel.org>; Fri, 26 Nov 2021 02:28:01 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8794604CC;
        Fri, 26 Nov 2021 02:27:52 +0000 (UTC)
Date:   Fri, 26 Nov 2021 10:27:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>
Subject: Re: [bug report] WARNING at block/mq-deadline.c:600
 dd_exit_sched+0x1c6/0x260 triggered with blktests block/031
Message-ID: <YaBGI7bR/9ot514F@T590>
References: <CAHj4cs8=xDxBZF62-OekAGtHDtP6ynALKXm7fK2D2ChpNXnGAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs8=xDxBZF62-OekAGtHDtP6ynALKXm7fK2D2ChpNXnGAw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Yi,

On Thu, Nov 25, 2021 at 07:02:43PM +0800, Yi Zhang wrote:
> Hello
> 
> blktests block/031 triggered below WARNING with latest
> linux-block/for-next[1], pls check it.
> 
> [1]
> f0afafc21027 (HEAD, origin/for-next) Merge branch 'for-5.17/io_uring'
> into for-next

After running block/031 for several times in today's linus tree, not
reproduce the issue:

[root@ktest-09 blktests]# uname -a
Linux ktest-09 5.16.0-rc2_up+ #47 SMP PREEMPT Thu Nov 25 21:14:38 EST 2021 x86_64 x86_64 x86_64 GNU/Linux
[root@ktest-09 blktests]# ./check block/031
block/031 (do IO on null-blk with a host tag set)            [passed]
    runtime  30.302s  ...  30.298s

Both for-5.17/block and for-5.17/io_uring have been rebased on v5.16-rc2,
maybe you can try the test again with latest block tree and see if it
can be reproduced.


Thanks, 
Ming

