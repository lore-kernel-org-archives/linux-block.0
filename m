Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EA6C636D4
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 10:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjBQKtP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 05:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjBQKtN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 05:49:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABEA3770B
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 02:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676630835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nwUbTMbbHG2T6u8qpzssOLb6gYft08svkJ0HnI5nE1g=;
        b=Kdgz4wU3yEnlkkCp/mhhHJUZYDDoReu5devJPai1GE8MIaVLCwK7PlA1wGsBD3AjKWzEhv
        dKK7WYjdZXPZcjUkXgPVh/7OXGAw9roVx8smDdi++MMUjcmuRgEUZvQ+P1QNr+lIVHKQMv
        4b3dDcepUAvXl7hqwKuUwDtQGXbg2OA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-yG6cCmpsM6qrrdZ_Vy_vUg-1; Fri, 17 Feb 2023 05:47:11 -0500
X-MC-Unique: yG6cCmpsM6qrrdZ_Vy_vUg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32EEA3C0DDA6;
        Fri, 17 Feb 2023 10:47:11 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49188C15BA0;
        Fri, 17 Feb 2023 10:47:00 +0000 (UTC)
Date:   Fri, 17 Feb 2023 18:46:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, io-uring@vger.kernel.org,
        bpf@vger.kernel.org, axboe@kernel.dk, asml.silence@gmail.com,
        ZiyangZhang@linux.alibaba.com, ming.lei@redhat.com
Subject: Re: [RFC 3/3] ublk_drv: add ebpf support
Message-ID: <Y+9bH9QXe2HPAJrZ@T590>
References: <20230215004122.28917-1-xiaoguang.wang@linux.alibaba.com>
 <20230215004122.28917-4-xiaoguang.wang@linux.alibaba.com>
 <Y+3lOn04pdFtdGbr@T590>
 <54043113-e524-6ca2-ce77-08d45099aff2@linux.alibaba.com>
 <Y+7uNpw7QBpJ4GHA@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+7uNpw7QBpJ4GHA@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 17, 2023 at 11:02:14AM +0800, Ming Lei wrote:
> On Thu, Feb 16, 2023 at 08:12:18PM +0800, Xiaoguang Wang wrote:
> > hello,

...

> > io_prep_prog is called when ublk_queue_rq() is called, this bpf
> > prog will initialize one or more sqes according to user logic, and
> > io_prep_prog will put these sqes in an ebpf map structure, then
> > execute a task_work_add() to notify ubq_daemon to execute
> > io_submit_prog. Note, we can not call io_uring_submit_sqe()
> > in task context that calls ublk_queue_rq(), that context does not
> > have io_uring instance owned by ubq_daemon.
> > Later ubq_daemon will call io_submit_prog to submit sqes.
> 
> Submitting sqe from kernel looks interesting, but I guess
> performance may be hurt, given plugging(batching) can't be applied
> any more, which is supposed to affect io perf a lot.

If submitting SQE in kernel is really doable, maybe we can add another
command, such as, UBLK_IO_SUBMIT_SQE(just like UBLK_IO_NEED_GET_DATA),
and pass the built SQE(which represents part of user logic result) as
io_uring command payload, and ask ublk driver to build buffer for this
SQE, then submit this SQE in kernel.

But there is SQE order problem, net usually requires SQEs to be linked
and submitted in order, with this way, it becomes not easy to maintain
SQEs order(some linked in user, and some in kernel).

Thanks,
Ming

