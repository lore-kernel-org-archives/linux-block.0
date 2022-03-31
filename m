Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A95C433F5
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 01:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242633AbiCaBkw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiCaBkw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 21:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AD7113FAA
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 18:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648690741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y8Nl6IVJz52qLjtsdIKMYIIiAxLgZRhsgfke4NcZajo=;
        b=Me4U9P4CuYVp6ael6WWlDzwBn6htKl6aiT2Yl9VRmC0Njy9q/pmdEqkZALVOs5qOdFFDvh
        GRKtePJKIBdQ9WqYe/8nJP1lpS6ViHizGh8S6idKHRHscwvfR+R1Yg80ceIhHMG9QcIIUF
        uBiMW/vLGLgIfRZf73xn6dGYXYHSF68=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-IEkfCVYUMNuNuB92XtdZfA-1; Wed, 30 Mar 2022 21:38:55 -0400
X-MC-Unique: IEkfCVYUMNuNuB92XtdZfA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A7F31C05AAA;
        Thu, 31 Mar 2022 01:38:54 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAD96401E29;
        Thu, 31 Mar 2022 01:38:48 +0000 (UTC)
Date:   Thu, 31 Mar 2022 09:38:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org,
        linux-block@vger.kernel.org,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Message-ID: <YkUGImrOCAzMT2t5@T590>
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de>
 <YkCSVSk1SwvtABIW@T590>
 <87o81prfrg.fsf@collabora.com>
 <YkJTQW7aAjDGKL9p@T590>
 <87bkxor7ye.fsf@collabora.com>
 <YkO4rFBHCdjCJndV@T590>
 <87tubfpag3.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tubfpag3.fsf@collabora.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 30, 2022 at 02:22:20PM -0400, Gabriel Krisman Bertazi wrote:
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > On Tue, Mar 29, 2022 at 01:20:57PM -0400, Gabriel Krisman Bertazi wrote:
> >> Ming Lei <ming.lei@redhat.com> writes:
> >> 
> >> >> I was thinking of something like this, or having a way for the server to
> >> >> only operate on the fds and do splice/sendfile.  But, I don't know if it
> >> >> would be useful for many use cases.  We also want to be able to send the
> >> >> data to userspace, for instance, for userspace networking.
> >> >
> >> > I understand the big point is that how to pass the io data to ubd driver's
> >> > request/bio pages. But splice/sendfile just transfers data between two FDs,
> >> > then how can the block request/bio's pages get filled with expected data?
> >> > Can you explain a bit in detail?
> >> 
> >> Hi Ming,
> >> 
> >> My idea was to split the control and dataplanes in different file
> >> descriptors.
> >> 
> >> A queue has a fd that is mapped to a shared memory area where the
> >> request descriptors are.  Submission/completion are done by read/writing
> >> the index of the request on the shared memory area.
> >> 
> >> For the data plane, each request descriptor in the queue has an
> >> associated file descriptor to be used for data transfer, which is
> >> preallocated at queue creation time.  I'm mapping the bio linearly, from
> >> offset 0, on these descriptors on .queue_rq().  Userspace operates on
> >> these data file descriptors with regular RW syscalls, direct splice to
> >> another fd or pipe, or mmap it to move data around. The data is
> >> available on that fd until IO is completed through the queue fd.  After
> >> an operation is completed, the fds are reused for the next IO on that
> >> queue position.
> >> 
> >> Hannes has pointed out the issues with fd limits. :)
> >
> > OK, thanks for the detailed explanation!
> >
> > Also you may switch to map each request queue/disk into a FD, and every
> > request is mapped to one fixed extent of the 'file' via rq->tag since we
> > have max sectors limit for each request, then fd limits can be avoided.
> >
> > But I am wondering if this way is friendly to userspace side implementation,
> > since there isn't buffer, only FDs visible to userspace.
> 
> The advantages would be not mapping the request data in userspace if we
> could avoid it, since it would be possible to just forward the data
> inside the kernel.  But my latest understanding is that most use cases
> will want to directly manipulate the data anyway, maybe to checksum, or
> even for sending through userspace networking.  It is not clear to me
> anymore that we'd benefit from not always mapping the requests to
> userspace.

Yeah, I think it is more flexible or usable to allow userspace to
operate on data directly as one generic solution, such as, implement one disk
to read/write on qcow2 image, or read from/write to network by parsing
protocol, or whatever.

> I've been looking at your implementation and I really like how simple it
> is. I think it's the most promising approach for this feature I've
> reviewed so far.  I'd like to send you a few patches for bugs I found
> when testing it and keep working on making it upstreamable.  How can I
> send you those patches?  Is it fine to just email you or should I also
> cc linux-block, even though this is yet out-of-tree code?

The topic has been discussed for a bit long, and looks people are still
interested in it, so I prefer to send out patches on linux-block if no
one objects. Then we can still discuss further when reviewing patches.

Thanks,
Ming

