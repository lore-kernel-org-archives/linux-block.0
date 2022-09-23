Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA88ECAAD8
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 13:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiIWNuy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 09:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiIWNuv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 09:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88953132D71
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663941043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1UCrnIiJHXHNqsN3S35cn3dnzyzc2EF3aYigy2M2Wvk=;
        b=VXJmHO3qf7pKLuwKpIjxAGTDRXCyuT5qQb6K5I0r3sS4gksj43c9Oy6vzlZuQ+5VbrYZtO
        3w5731jZ/IPgzsFuIsX9NQwPFoHTIYGPgEk/3pwJuARSn//uXpuFsz11SL2G31hoQAshrn
        KTDJYqg3W21YVFdq4UU6bAhQge8bMlM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-7c4uVgBeMyysQ2vmI9n-Mw-1; Fri, 23 Sep 2022 09:50:39 -0400
X-MC-Unique: 7c4uVgBeMyysQ2vmI9n-Mw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56FB3101E157;
        Fri, 23 Sep 2022 13:50:39 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA81E2166B40;
        Fri, 23 Sep 2022 13:50:34 +0000 (UTC)
Date:   Fri, 23 Sep 2022 21:50:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [RESEND PATCH V5 6/7] ublk_drv: add START_USER_RECOVERY and
 END_USER_RECOVERY support
Message-ID: <Yy25paEXnUwLnvkp@T590>
References: <20220923061505.52007-1-ZiyangZhang@linux.alibaba.com>
 <20220923061505.52007-7-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923061505.52007-7-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 23, 2022 at 02:15:04PM +0800, ZiyangZhang wrote:
> START_USER_RECOVERY and END_USER_RECOVERY are two new control commands
> to support user recovery feature.
> 
> After a crash, user should send START_USER_RECOVERY, it will:
> (1) check if (a)current ublk_device is UBLK_S_DEV_QUIESCED which was
>     set by quiesce_work and (b)chardev is released
> (2) reinit all ubqs, including:
>     (a) put the task_struct and reset ->ubq_daemon to NULL.
>     (b) reset all ublk_io.
> (3) reset ub->mm to NULL.
> 
> Then, user should start a new process and send FETCH_REQ on each
> ubq_daemon.
> 
> Finally, user should send END_USER_RECOVERY, it will:
> (1) wait for all new ubq_daemons getting ready.
> (2) update ublksrv_pid
> (3) unquiesce the request queue and expect incoming ublk_queue_rq()
> (4) convert ub's state to UBLK_S_DEV_LIVE
> 
> Note: we can handle STOP_DEV between START_USER_RECOVERY and
> END_USER_RECOVERY. This is helpful to users who cannot start new process
> after sending START_USER_RECOVERY ctrl-cmd.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

