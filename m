Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4059CC433F5
	for <linux-block@archiver.kernel.org>; Sun, 27 Mar 2022 16:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbiC0Qh3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Mar 2022 12:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiC0Qh2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Mar 2022 12:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61B8413E3D
        for <linux-block@vger.kernel.org>; Sun, 27 Mar 2022 09:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648398948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+lQQjfFsQ51Od5mIf4Q3nNReRLr9i5dQC+GPcw/OCa4=;
        b=fI/FhGqEpChHbQTtsburPiD596gFbgYfTvPNltCLgpQKW8Dtav76JTy5sOpeAyAM45tKP2
        tnR3ZLTgAad6rAU8KNFfRrDA2y8DjR670MK6dvrWPkwRmXkkaDfaxe9jXNXYBHn/m2cKCJ
        eyE/BcuujhIIHrzyKE32U5xByn44/6g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-CwFRt_a3N6WRHIYUPi4CxQ-1; Sun, 27 Mar 2022 12:35:44 -0400
X-MC-Unique: CwFRt_a3N6WRHIYUPi4CxQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52AFE3C02181;
        Sun, 27 Mar 2022 16:35:44 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41F6A401E7E;
        Sun, 27 Mar 2022 16:35:38 +0000 (UTC)
Date:   Mon, 28 Mar 2022 00:35:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Message-ID: <YkCSVSk1SwvtABIW@T590>
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986caf55-65d1-0755-383b-73834ec04967@suse.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 22, 2022 at 07:57:27AM +0100, Hannes Reinecke wrote:
> On 2/21/22 20:59, Gabriel Krisman Bertazi wrote:
> > I'd like to discuss an interface to implement user space block devices,
> > while avoiding local network NBD solutions.  There has been reiterated
> > interest in the topic, both from researchers [1] and from the community,
> > including a proposed session in LSFMM2018 [2] (though I don't think it
> > happened).
> > 
> > I've been working on top of the Google iblock implementation to find
> > something upstreamable and would like to present my design and gather
> > feedback on some points, in particular zero-copy and overall user space
> > interface.
> > 
> > The design I'm pending towards uses special fds opened by the driver to
> > transfer data to/from the block driver, preferably through direct
> > splicing as much as possible, to keep data only in kernel space.  This
> > is because, in my use case, the driver usually only manipulates
> > metadata, while data is forwarded directly through the network, or
> > similar. It would be neat if we can leverage the existing
> > splice/copy_file_range syscalls such that we don't ever need to bring
> > disk data to user space, if we can avoid it.  I've also experimented
> > with regular pipes, But I found no way around keeping a lot of pipes
> > opened, one for each possible command 'slot'.
> > 
> > [1] https://dl.acm.org/doi/10.1145/3456727.3463768
> > [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html
> > 
> Actually, I'd rather have something like an 'inverse io_uring', where an
> application creates a memory region separated into several 'ring' for
> submission and completion.
> Then the kernel could write/map the incoming data onto the rings, and
> application can read from there.
> Maybe it'll be worthwhile to look at virtio here.

IMO it needn't 'inverse io_uring', the normal io_uring SQE/CQE model
does cover this case, the userspace part can submit SQEs beforehand
for getting notification of each incoming io request from kernel driver,
then after one io request is queued to the driver, the driver can
queue a CQE for the previous submitted SQE. Recent posted patch of
IORING_OP_URING_CMD[1] is perfect for such purpose.

I have written one such userspace block driver recently, and [2] is the
kernel part blk-mq driver(ubd driver), the userspace part is ubdsrv[3].
Both the two parts look quite simple, but still in very early stage, so
far only ubd-loop and ubd-null targets are implemented in [3]. Not only
the io command communication channel is done via IORING_OP_URING_CMD, but
also IO handling for ubd-loop is implemented via plain io_uring too.

It is basically working, for ubd-loop, not see regression in 'xfstests -g auto'
on the ubd block device compared with same xfstests on underlying disk, and
my simple performance test on VM shows the result isn't worse than kernel loop
driver with dio, or even much better on some test situations.

Wrt. this userspace block driver things, I am more interested in the following
sub-topics:

1) zero copy
- the ubd driver[2] needs one data copy: for WRITE request, copy pages
  in io request to userspace buffer before handling the WRITE IO by ubdsrv;
  for READ request, the reverse copy is done after READ request is
  handled by ubdsrv

- I tried to apply zero copy via remap_pfn_range() for avoiding this
  data copy, but looks it can't work for ubd driver, since pages in the
  remapped vm area can't be retrieved by get_user_pages_*() which is called in
  direct io code path

- recently Xiaoguang Wang posted one RFC patch[4] for support zero copy on
  tcmu, and vm_insert_page(s)_mkspecial() is added for such purpose, but
  it has same limit of remap_pfn_range; Also Xiaoguang mentioned that
  vm_insert_pages may work, but anonymous pages can not be remapped by
  vm_insert_pages.

- here the requirement is to remap either anonymous pages or page cache
  pages into userspace vm, and the mapping/unmapping can be done for
  each IO runtime. Is this requirement reasonable? If yes, is there any
  easy way to implement it in kernel?

2) batching queueing io_uring CQEs

- for ubd driver, batching is very sensitive to performance per my
  observation, if we can run batch queueing IORING_OP_URING_CMD CQEs,
  ubd_queue_rqs() can be wirted to the batching CQEs, then the whole batch
  only takes one io_uring_enter().

- not digging into io_uring code for this interface yet, but looks not
  see such interface

3) requirement on userspace block driver
- exact requirements from user viewpoint

4) apply eBPF in userspace block driver
- it is one open topic, still not have specific or exact idea yet,

- is there chance to apply ebpf for mapping ubd io into its target handling
for avoiding data copy and remapping cost for zero copy?

I am happy to join the virtual discussion on lsf/mm if there is and it
is possible.

[1] https://lore.kernel.org/linux-block/20220308152105.309618-1-joshi.k@samsung.com/#r
[2] https://github.com/ming1/linux/tree/v5.17-ubd-dev
[3] https://github.com/ming1/ubdsrv
[4] https://lore.kernel.org/linux-block/abbe51c4-873f-e96e-d421-85906689a55a@gmail.com/#r

Thanks,
Ming

