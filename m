Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A51CC43334
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 00:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiGEAoB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jul 2022 20:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiGEAoA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 20:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F2BD2BEA
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 17:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656981839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oF0QO8DwOtMi/m6eY8VVXn1mNF5UvzD8IXdAmBCXuIM=;
        b=gL/Az07i+bOyCXuZMgr3wl4d0gEpT5/Q0duF37g5+lib2UGQ3NBJ3QBZVeSI0B4DMPQVX/
        NzMrBXGmqAahI4xa6MqAUhoPjlpTIjiBKgEUcsfcRO4OzL0pUDhsv035vU/XYwX5FhD+DT
        XgmWBtyHQX2cZ1kpwi6LzSiQaZsA2wE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-cL5MEu1POz6lL-W-D0aWWA-1; Mon, 04 Jul 2022 20:43:56 -0400
X-MC-Unique: cL5MEu1POz6lL-W-D0aWWA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C08742999B52;
        Tue,  5 Jul 2022 00:43:55 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0641C2166B26;
        Tue,  5 Jul 2022 00:43:48 +0000 (UTC)
Date:   Tue, 5 Jul 2022 08:43:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Harris James R <james.r.harris@intel.com>,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, ming.lei@redhat.com
Subject: Re: [PATCH V3 1/1] ublk: add io_uring based userspace block driver
Message-ID: <YsOJP9BaD0LUpsgg@T590>
References: <20220628160807.148853-1-ming.lei@redhat.com>
 <20220628160807.148853-2-ming.lei@redhat.com>
 <da861bbb-1506-7598-fa06-32201456967d@grimberg.me>
 <YsLeR1QWPmqfNAQY@T590>
 <8cf1aef0-ea5b-a3df-266d-ae67674c96ae@grimberg.me>
 <87a69oamap.fsf@collabora.com>
 <c2053491-abb6-dc75-923d-bfea81431afa@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2053491-abb6-dc75-923d-bfea81431afa@grimberg.me>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 04, 2022 at 07:19:09PM +0300, Sagi Grimberg wrote:
> 
> > > > > > diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> > > > > > index fdb81f2794cd..d218089cdbec 100644
> > > > > > --- a/drivers/block/Kconfig
> > > > > > +++ b/drivers/block/Kconfig
> > > > > > @@ -408,6 +408,12 @@ config BLK_DEV_RBD
> > > > > >     	  If unsure, say N.
> > > > > > +config BLK_DEV_UBLK
> > > > > > +	bool "Userspace block driver"
> > > > > 
> > > > > Really? why compile this to the kernel and not tristate as loadable
> > > > > module?
> > > > So far, this is only one reason: task_work_add() is required, which
> > > > isn't exported for modules.
> > > 
> > > So why not exporting it?
> > > Doesn't seem like a good justification to build it into the kernel.
> > 
> > Sagi,
> > 
> > If I understand correctly, the task_work_add function is quite a core
> > API that we probably want to avoid exposing directly to (out-of-tree)
> > modules?  I agree, though, it would be great to have this buildable as a
> > module for general use cases.  Would it make sense to have it exposed
> > through a thin built-in wrapper, specific to UBD, which is exported, and
> > therefore able to invoke that function?  Is it a reasonable approach?
> 
> All I'm saying is that either we should expose it (or an interface to
> it) if it has merit, or use something else (use a workqueue).

There isn't replacement for task_work_add().

If module has to be supported, we can add one command for running the
work function in the ubq context, that will add some cost.

> Having a block driver driver builtin is probably not the answer.

Not sure, there are at least two drivers which use the API.


Thanks,
Ming

