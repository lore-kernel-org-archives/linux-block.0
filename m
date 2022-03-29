Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF91AC433F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 00:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiC2Acz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Mar 2022 20:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiC2Acy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Mar 2022 20:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6123551301
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 17:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648513871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=blF6aoqmnGTPE5i6PlDYbGpXTGI+hCBbEnyGdUhGGI4=;
        b=JvUys+/yFEymTc39Me2XNVpDleRLDfrFYO+lJKSwlBLkLxcbu0PrFdBjh6nXo9O3BwRGDR
        8JglSTnlAEpQSyXd8Ezg/gk6fKVFrMLvtgDrQcMydtGgvDjTl6w6vBOC3a9YFLYX+Nocx2
        0crFAthiDUpR/mZw1NVVTqtllo7Hgd4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-b6Cn8ebHOiiE0yx5HG7zLQ-1; Mon, 28 Mar 2022 20:31:08 -0400
X-MC-Unique: b6Cn8ebHOiiE0yx5HG7zLQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 950CE101A54C;
        Tue, 29 Mar 2022 00:31:07 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32C2F401DAD;
        Tue, 29 Mar 2022 00:31:02 +0000 (UTC)
Date:   Tue, 29 Mar 2022 08:30:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org,
        linux-block@vger.kernel.org,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Message-ID: <YkJTQW7aAjDGKL9p@T590>
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de>
 <YkCSVSk1SwvtABIW@T590>
 <87o81prfrg.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o81prfrg.fsf@collabora.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 28, 2022 at 04:20:03PM -0400, Gabriel Krisman Bertazi wrote:
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > IMO it needn't 'inverse io_uring', the normal io_uring SQE/CQE model
> > does cover this case, the userspace part can submit SQEs beforehand
> > for getting notification of each incoming io request from kernel driver,
> > then after one io request is queued to the driver, the driver can
> > queue a CQE for the previous submitted SQE. Recent posted patch of
> > IORING_OP_URING_CMD[1] is perfect for such purpose.
> >
> > I have written one such userspace block driver recently, and [2] is the
> > kernel part blk-mq driver(ubd driver), the userspace part is ubdsrv[3].
> > Both the two parts look quite simple, but still in very early stage, so
> > far only ubd-loop and ubd-null targets are implemented in [3]. Not only
> > the io command communication channel is done via IORING_OP_URING_CMD, but
> > also IO handling for ubd-loop is implemented via plain io_uring too.
> >
> > It is basically working, for ubd-loop, not see regression in 'xfstests -g auto'
> > on the ubd block device compared with same xfstests on underlying disk, and
> > my simple performance test on VM shows the result isn't worse than kernel loop
> > driver with dio, or even much better on some test situations.
> 
> Thanks for sharing.  This is a very interesting implementation that
> seems to cover quite well the original use case.  I'm giving it a try and
> will report back.
> 
> > Wrt. this userspace block driver things, I am more interested in the following
> > sub-topics:
> >
> > 1) zero copy
> > - the ubd driver[2] needs one data copy: for WRITE request, copy pages
> >   in io request to userspace buffer before handling the WRITE IO by ubdsrv;
> >   for READ request, the reverse copy is done after READ request is
> >   handled by ubdsrv
> >
> > - I tried to apply zero copy via remap_pfn_range() for avoiding this
> >   data copy, but looks it can't work for ubd driver, since pages in the
> >   remapped vm area can't be retrieved by get_user_pages_*() which is called in
> >   direct io code path
> >
> > - recently Xiaoguang Wang posted one RFC patch[4] for support zero copy on
> >   tcmu, and vm_insert_page(s)_mkspecial() is added for such purpose, but
> >   it has same limit of remap_pfn_range; Also Xiaoguang mentioned that
> >   vm_insert_pages may work, but anonymous pages can not be remapped by
> >   vm_insert_pages.
> >
> > - here the requirement is to remap either anonymous pages or page cache
> >   pages into userspace vm, and the mapping/unmapping can be done for
> >   each IO runtime. Is this requirement reasonable? If yes, is there any
> >   easy way to implement it in kernel?
> 
> I've run into the same issue with my fd implementation and haven't been
> able to workaround it.
> 
> > 4) apply eBPF in userspace block driver
> > - it is one open topic, still not have specific or exact idea yet,
> >
> > - is there chance to apply ebpf for mapping ubd io into its target handling
> > for avoiding data copy and remapping cost for zero copy?
> 
> I was thinking of something like this, or having a way for the server to
> only operate on the fds and do splice/sendfile.  But, I don't know if it
> would be useful for many use cases.  We also want to be able to send the
> data to userspace, for instance, for userspace networking.

I understand the big point is that how to pass the io data to ubd driver's
request/bio pages. But splice/sendfile just transfers data between two FDs,
then how can the block request/bio's pages get filled with expected data?
Can you explain a bit in detail?

If block layer is bypassed, it won't be exposed as block disk to userspace.


thanks,
Ming

