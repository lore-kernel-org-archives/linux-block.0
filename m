Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DF7C27C76
	for <linux-block@archiver.kernel.org>; Sat, 28 Jan 2023 15:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjA1PNL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Jan 2023 10:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjA1PNK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jan 2023 10:13:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5F1252B9
        for <linux-block@vger.kernel.org>; Sat, 28 Jan 2023 07:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674918745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g0QUGzoJoebh4v+PZGDYLFFagPOPP/ZNw/+BWJ9IUG4=;
        b=jA1Bi/0QFMudeRnQsH8J8zeTP0xVabpZkyVMVo8iVaHRaE9HAvTN9lk1OEZvd47tsnNPZ0
        4GOvROMdG27J5w2F1KSMNVN4aXVbHkYBSroDtLQMNCsLOG0mK5Sl6yndUi8WR0Pypdxjv+
        NFPESMcardyF+c+MBKF6tYv5mYeg/f0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-3YvVqecpMmKM5D9dPwkZGw-1; Sat, 28 Jan 2023 10:12:24 -0500
X-MC-Unique: 3YvVqecpMmKM5D9dPwkZGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B95681C05143;
        Sat, 28 Jan 2023 15:12:23 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B86153AA;
        Sat, 28 Jan 2023 15:12:18 +0000 (UTC)
Date:   Sat, 28 Jan 2023 23:12:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>, ming.lei@redhat.com
Subject: Re: [PATCH 01/15] blk-cgroup: don't defer blkg_free to a workqueue
Message-ID: <Y9U7TZQtjnMd6snm@T590>
References: <20230124065716.152286-1-hch@lst.de>
 <20230124065716.152286-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124065716.152286-2-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 24, 2023 at 07:57:01AM +0100, Christoph Hellwig wrote:
> Now that blk_put_queue can be called from process context, there is no

s/process/atomic?

> need for the asynchronous execution.
> 
> This effectively reverts commit d578c770c85233af592e54537f93f3831bde7e9a.

blkg_free() can be called with ->queue_lock, and:

- del_timer_sync(&tg->service_queue.pending_timer) is called from throtl_pd_free().

- queue_lock is required by throtl_pending_timer_fn

So there is deadlock risk if the above commit is reverted.

Thanks,
Ming

