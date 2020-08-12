Return-Path: <SRS0=wHaM=BW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C794C433E1
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 09:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFE920675
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 09:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ufn50U2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgHLJBF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Aug 2020 05:01:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44256 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726618AbgHLJBF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 05:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597222863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P9SH4zs6bYGoVk6Zl3euYE37Cx5b4umaTEKRb90euIo=;
        b=Ufn50U2+We8mHSrWBBHGLh4bgoeVdm+XTeBJQQtxrOicnIyfILwo+vWSrHkqsc7Hu9vcGZ
        TXrXOyA6oppxqtZSM/lrMgG2FfdIIypTs9AT2FMC9rVxZSEANgRbeVr1v/z//3tCpwYqhk
        7Th8FHBY367PX1XMsNmsGssBoDRyqpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-9v9RQZ7ZPO2fxIZYV7nNHQ-1; Wed, 12 Aug 2020 05:00:51 -0400
X-MC-Unique: 9v9RQZ7ZPO2fxIZYV7nNHQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4810D802B45;
        Wed, 12 Aug 2020 09:00:50 +0000 (UTC)
Received: from T590 (ovpn-13-156.pek2.redhat.com [10.72.13.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E12560BE5;
        Wed, 12 Aug 2020 09:00:43 +0000 (UTC)
Date:   Wed, 12 Aug 2020 17:00:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH] block: allow for_each_bvec to support zero len bvec
Message-ID: <20200812090039.GA2317340@T590>
References: <20200810031915.2209658-1-ming.lei@redhat.com>
 <db57f8ca-b3c3-76ec-1e49-d8f8161ba78d@i-love.sakura.ne.jp>
 <20200810162331.GA2215158@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810162331.GA2215158@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 11, 2020 at 12:23:31AM +0800, Ming Lei wrote:
> On Mon, Aug 10, 2020 at 04:52:17PM +0900, Tetsuo Handa wrote:
> > On 2020/08/10 12:19, Ming Lei wrote:
> > > Block layer usually doesn't support or allow zero-length bvec. Since
> > > commit 1bdc76aea115 ("iov_iter: use bvec iterator to implement
> > > iterate_bvec()"), iterate_bvec() switches to bvec iterator. However,
> > > Al mentioned that 'Zero-length segments are not disallowed' in iov_iter.
> > > 
> > > Fixes for_each_bvec() so that it can move on after seeing one zero
> > > length bvec.
> > > 
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > Link: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2262077.html
> > > Fixes: 1bdc76aea115 ("iov_iter: use bvec iterator to implement iterate_bvec()")
> > 
> > Is this Fixes: correct? That commit should be in RHEL8's 4.18 kernel but that kernel
> > does not hit this bug.
> 
> Yeah, it is correct, see the following link:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.8&id=1bdc76aea1159a750846c2fc98e404403eb7d51c
> 
> Commit 1bdc76aea115 was merged to v4.8, so it is definitely in both RHEL8's
> 4.18 based kernel and upstream kernel.
> 
> > 
> > Moreover, maybe nobody cares, but behavior of splice() differs when there are only 
> > zero-length pages. With this fix, splice() returns 0 despite there is still pipe writers.
> 
> It is another new issue, which isn't related with Commit 1bdc76aea115,
> see below.
> 
> > Man page seems to say that splice() returns 0 when there is no pipe writers...
> > 
> >     A return value of 0 means end of input.  If fd_in refers to a pipe,
> >     then this means that there was no data to transfer, and it would not
> >     make sense to block because there are no writers connected to the
> >     write end of the pipe.
> > 
> > ----- test case -----
> > #define _GNU_SOURCE
> > #include <stdio.h>
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <fcntl.h>
> > #include <unistd.h>
> > #include <string.h>
> > 
> > int main(int argc, char *argv[])
> > {
> >         static char buffer[4096];
> >         const int fd = open("/tmp/testfile", O_WRONLY | O_CREAT, 0600);
> >         int pipe_fd[2] = { EOF, EOF };
> >         pipe(pipe_fd);
> >         write(pipe_fd[1], NULL, sizeof(buffer));
> >         write(pipe_fd[1], NULL, sizeof(buffer));
> >         memset(buffer, 'a', sizeof(buffer));
> >         //write(pipe_fd[1], buffer, sizeof(buffer));
> >         write(pipe_fd[1], NULL, sizeof(buffer));
> >         write(pipe_fd[1], NULL, sizeof(buffer));
> >         memset(buffer, 'b', sizeof(buffer));
> >         //write(pipe_fd[1], buffer, sizeof(buffer));
> >         write(pipe_fd[1], NULL, sizeof(buffer));
> >         write(pipe_fd[1], NULL, sizeof(buffer));
> >         memset(buffer, 'c', sizeof(buffer));
> >         //write(pipe_fd[1], buffer, sizeof(buffer));
> >         write(pipe_fd[1], NULL, sizeof(buffer));
> >         write(pipe_fd[1], NULL, sizeof(buffer));
> >         memset(buffer, 'd', sizeof(buffer));
> >         //write(pipe_fd[1], buffer, sizeof(buffer));
> >         write(pipe_fd[1], NULL, sizeof(buffer));
> >         write(pipe_fd[1], NULL, sizeof(buffer));
> >         splice(pipe_fd[0], NULL, fd, NULL, 65536, 0);
> >         return 0;
> > }
> 
> The above test doesn't trigger the reported lockup issue, so this patch
> isn't related with the new issue you described.

BTW, for_each_bvec won't be called in the above splice test code.


Thanks,
Ming

