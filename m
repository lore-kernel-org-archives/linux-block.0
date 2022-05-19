Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBECFC433EF
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 02:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiESCmm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 22:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiESCml (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 22:42:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48B13A30BA
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 19:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652928159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OLLmfXiXzvWZFrGfu99utiSX147UCnqhw6D8tGfkdG0=;
        b=ASKcwNkPAgIy8gaSBF5l163dQrexe/DOBWfqRfhpQVXcbezz7rODlPAiBzO2WPwk27cADh
        v+9hLXwvBIUv4+mQRDAPOJMysXfJUupyJhD6q71ZfG0gLpngTgWxuO4210yWvxLbvWHETK
        JwhhXLxuBJ4s7d4l05PwFhqUyxuNWsE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-4kio-BwRMTSeYgIXtcsBrA-1; Wed, 18 May 2022 22:42:36 -0400
X-MC-Unique: 4kio-BwRMTSeYgIXtcsBrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1096101AA42;
        Thu, 19 May 2022 02:42:35 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A36061410DD5;
        Thu, 19 May 2022 02:42:29 +0000 (UTC)
Date:   Thu, 19 May 2022 10:42:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Harris James R <james.r.harris@intel.com>,
        io-uring@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        ming.lei@redhat.com
Subject: Re: [PATCH V2 0/1] ubd: add io_uring based userspace block driver
Message-ID: <YoWujjFArHaXuqYS@T590>
References: <20220517055358.3164431-1-ming.lei@redhat.com>
 <YoOr6jBfgVm8GvWg@stefanha-x1.localdomain>
 <YoSbuvT88sG5UkfG@T590>
 <YoTOTCooQfQQxyA8@stefanha-x1.localdomain>
 <YoTsYvnACbCNIMPE@T590>
 <YoUVb8CeWRIErJBY@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoUVb8CeWRIErJBY@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 18, 2022 at 04:49:03PM +0100, Stefan Hajnoczi wrote:
> On Wed, May 18, 2022 at 08:53:54PM +0800, Ming Lei wrote:
> > On Wed, May 18, 2022 at 11:45:32AM +0100, Stefan Hajnoczi wrote:
> > > On Wed, May 18, 2022 at 03:09:46PM +0800, Ming Lei wrote:
> > > > On Tue, May 17, 2022 at 03:06:34PM +0100, Stefan Hajnoczi wrote:
> > > > > Here are some more thoughts on the ubd-control device:
> > > > > 
> > > > > The current patch provides a ubd-control device for processes with
> > > > > suitable permissions (i.e. root) to create, start, stop, and fetch
> > > > > information about devices.
> > > > > 
> > > > > There is no isolation between devices created by one process and those
> > > > 
> > > > I understand linux hasn't device namespace yet, so can you share the
> > > > rational behind the idea of device isolation, is it because ubd device
> > > > is served by ubd daemon which belongs to one pid NS? Or the user creating
> > > > /dev/ubdbN belongs to one user NS?
> > > 
> > > With the current model a process with access to ubd-control has control
> > > over all ubd devices. This is not desirable for most container use cases
> > > because ubd-control usage within a container means that container could
> > > stop any ubd device on the system.
> > > 
> > > Even for non-container use cases it's problematic that two applications
> > > that use ubd can interfere with each other. If an application passes the
> > > wrong device ID they can stop the other application's device, for
> > > example.
> > > 
> > > I think it's worth supporting a model where there are multiple ubd
> > > daemons that are not cooperating/aware of each other. They should be
> > > isolated from each other.
> > 
> > Maybe I didn't mention it clearly, I meant the following model in last email:
> > 
> > 1) every user can send UBD_CMD_ADD_DEV to /dev/ubd-control
> > 
> > 2) the created /dev/ubdcN & /dev/udcbN are owned by the user who creates
> > it
> 
> How does this work? Does userspace (udev) somehow get the uid/gid from
> the uevent so it can set the device node permissions?

We can let 'ubd list' export the owner info, then udev may override the default
owner with exported info.

Or it can be done inside devtmpfs_create_node() by passing ubd's uid/gid
at default.

For /dev/ubdcN, I think it is safe, since the driver is only
communicating with the userspace daemon, and both belong to same owner.
Also ubd driver is simple enough to get full audited.

For /dev/ubdbN, even though FS isn't allowed to mount, there is still
lots of kernel code path involved, and some code path may not be run
with unprivileged user before, that needs careful audit.

So the biggest problem is if it is safe to export block disk to unprivileged
user, and that is the one which can't be bypassed for any approach.




Thanks, 
Ming

