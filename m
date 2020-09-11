Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2588CC433E2
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 23:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A4B21D40
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 23:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9B4DbNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgIKX3I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 19:29:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49880 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725873AbgIKX3G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 19:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599866943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CRV2zfO50p3gtciWQXm6qslUoZUnBFQUVofw94w9HCY=;
        b=K9B4DbNEdqZYMQq19MCEy8i06jugYhEIia4mpJUTV4XE3wklLr7sAm69V5YWfirapgKWC6
        dzFzigJEZux6PPUKgBEqzdLrxYvXDxiRlmJyDd9AqfP3N1Agk3HTJdmrXOuwaijkSyCSsz
        CPMBqAegSSsm9k6aI4Jmhweukd7Jy/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-zyEZ5B87Pve9x4zzmCqFlA-1; Fri, 11 Sep 2020 19:29:01 -0400
X-MC-Unique: zyEZ5B87Pve9x4zzmCqFlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43CAF18A2244;
        Fri, 11 Sep 2020 23:28:59 +0000 (UTC)
Received: from T590 (ovpn-12-16.pek2.redhat.com [10.72.12.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FF2460C04;
        Fri, 11 Sep 2020 23:28:48 +0000 (UTC)
Date:   Sat, 12 Sep 2020 07:28:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Chao Leng <lengchao@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200911232844.GA172054@T590>
References: <20200911024117.62480-1-ming.lei@redhat.com>
 <4fb604fd-c081-5eb1-cb3a-860746b6952a@grimberg.me>
 <09d5cb96-b442-6965-96b3-d884c95a3ca7@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09d5cb96-b442-6965-96b3-d884c95a3ca7@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 11, 2020 at 11:34:45AM -0700, Sagi Grimberg wrote:
> 
> > > Hi Jens,
> > > 
> > > The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
> > > and prepares for replacing srcu with percpu_ref.
> > > 
> > > The 2nd patch replaces srcu with percpu_ref.
> > > 
> > > The 3rd patch adds tagset quiesce interface.
> > > 
> > > The 4th patch applies tagset quiesce interface for NVMe subsystem.
> > 
> > Tested some reset storms and target restarts during traffic with
> > nvme-tcp.
> > 
> > Seems that no apparent breakage.
> > 
> > So:
> > 
> > Tested-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Probably unrelated to this patches, but I do see new
> kmemleak complaints in the form of:
> --
> unreferenced object 0xffff9440dbf3c240 (size 64):
>   comm "systemd", pid 1, jiffies 4306444056 (age 25034.440s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 b0 fe 13 99 ff ff ff ff  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000f1d0b20e>] percpu_ref_init+0x5f/0xf0
>     [<000000009598103f>] cgroup_mkdir+0xe9/0x440
>     [<0000000001b93c19>] kernfs_iop_mkdir+0x57/0x80
>     [<000000001ed0f985>] vfs_mkdir+0x10e/0x1d0
>     [<00000000cac65f7e>] do_mkdirat+0xec/0x120
>     [<00000000956db630>] do_syscall_64+0x33/0x80
>     [<000000001c2b0e1a>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Hello Sagi,

Could you test the following patch and see if the leak is fixed?

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index dd247747ec14..e8b7a8b66415 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4962,6 +4962,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 			psi_cgroup_free(cgrp);
 			if (cgroup_on_dfl(cgrp))
 				cgroup_rstat_exit(cgrp);
+			percpu_ref_exit(&cgrp->self.refcnt);
 			kfree(cgrp);
 		} else {
 			/*

Thanks, 
Ming

