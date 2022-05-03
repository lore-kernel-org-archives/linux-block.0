Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29C2C433F5
	for <linux-block@archiver.kernel.org>; Tue,  3 May 2022 08:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiECIG0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 May 2022 04:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiECIG0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 May 2022 04:06:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 808E518378
        for <linux-block@vger.kernel.org>; Tue,  3 May 2022 01:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651564973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IOZZ3fUarYwYytTh1u1wnLcOaPYbQt1FRXFI/xLb9gM=;
        b=gVeX9/W+gy+Z4p8wcTKov5CZN5JwzHhU6eT29XZRReHmSflCLKgBPhCTmaUEv/FOI2O/wv
        EszURrcKaILgL96V4yCRUIaA9A/nkzMv3pJFaEanmtQ2j9ublIf0Uvqvc8SrkPkqBmY5rP
        eYNf25EiNUW84zjKqJ1NmEsPFo5ESes=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-KdxE8ATjMiinCY1gVO5xkQ-1; Tue, 03 May 2022 04:02:50 -0400
X-MC-Unique: KdxE8ATjMiinCY1gVO5xkQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 034AC805F46;
        Tue,  3 May 2022 08:02:50 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F1B30568621;
        Tue,  3 May 2022 08:02:47 +0000 (UTC)
Date:   Tue, 3 May 2022 16:02:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: Follow up on UBD discussion
Message-ID: <YnDhorlKgOKiWkiz@T590>
References: <874k27rfwm.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k27rfwm.fsf@collabora.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Gabriel,

CC linux-block and hope you don't mind, :-)

On Mon, May 02, 2022 at 01:41:13PM -0400, Gabriel Krisman Bertazi wrote:
> 
> Hi Ming,
> 
> First of all, I hope I didn't put you on the spot too much during the
> discussion.  My original proposal was to propose my design, but your
> implementation quite solved the questions I had. :)

I think that is open source, then we can put efforts together to make things
better.

> 
> I'd like to follow up to restart the communication and see
> where I can help more with UBD.  As I said during the talk, I've
> done some fio runs and I was able to saturate NBD much faster than UBD:
> 
> https://people.collabora.com/~krisman/mingl-ubd/bw.png

Yeah, that is true since NBD has extra socket communication cost which
can't be efficient as io_uring.

> 
> I've also wrote some fixes to the initialization path, which I
> planned to send to you as soon as you published your code, but I think
> you might want to take a look already and see if you want to just squash
> it into your code base.
> 
> I pushed those fixes here:
> 
>   https://gitlab.collabora.com/krisman/linux/-/tree/mingl-ubd

I have added the 1st fix and 3rd patch into my tree:

https://github.com/ming1/linux/commits/v5.17-ubd-dev

The added check in 2nd patch is done lockless, which may not be reliable
enough, so I didn't add it. Also adding device is in slow path, and no
necessary to improve in that code path.

I also cleaned up ubd driver a bit: debug code cleanup, remove zero copy
code, remove command of UBD_IO_GET_DATA and always make ubd driver
builtin.

ubdsrv part has been cleaned up too:

https://github.com/ming1/ubdsrv

> 
> I'm looking into adding support for multiple driver queues next, and
> should be able to share some patches on that shortly.

OK, please post them on linux-block so that more eyes can look at the
code, meantime the ubdsrv side needs to handle MQ too.

Sooner or later, the single ubdsrv task may be saturated by copying data and
io_uring command communication only, which can be shown by running io on
ubd-null target. In my lattop, the ubdsrv cpu utilization is close to
90% when IOPS is > 500K. So MQ may help some fast backing cases.


Thanks,
Ming

