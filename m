Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0005C43334
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 08:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354990AbiFVIgk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 04:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354999AbiFVIgP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 04:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CC9E38BC2
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 01:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655886959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DOpjyIfABcFKo3NOpd9BX6FFoMiCwQP3/YkoovLHsu8=;
        b=gUkdiZ9XbG76MshLybp2ZtXJQf9lDiVEp1eLyrXc4Ue0H04qJQ7yA4mazPb2TjMLA8uHIr
        BGyA+IrWzDhIimsHvffJh8thvFNvp+ZpoBiVYYzy9Yfi3LO8I5xGsstITMqgATiOBPkDmq
        uuaC2Qcvz3hFZYcJayvZUNkkkvZSH1U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-EhiE0YIUMH2DzIZrucC8bQ-1; Wed, 22 Jun 2022 04:35:56 -0400
X-MC-Unique: EhiE0YIUMH2DzIZrucC8bQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA35180013E;
        Wed, 22 Jun 2022 08:35:55 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D28240334D;
        Wed, 22 Jun 2022 08:35:51 +0000 (UTC)
Date:   Wed, 22 Jun 2022 16:35:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] blk-mq: Don't disable preemption around
 __blk_mq_run_hw_queue().
Message-ID: <YrLUYvEaKeW6Mmfd@T590>
References: <YrF1p2n0MxHQ3fcJ@linutronix.de>
 <YrF5uf4ZL7Oh7LVJ@T590>
 <YrLSEiNvagKJaDs5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrLSEiNvagKJaDs5@linutronix.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 22, 2022 at 10:25:54AM +0200, Sebastian Andrzej Siewior wrote:
> __blk_mq_delay_run_hw_queue() disables preemption to get a stable
> current CPU number and then invokes __blk_mq_run_hw_queue() if the CPU
> number is part the mask.
> 
> __blk_mq_run_hw_queue() acquires a spin_lock_t which is a sleeping lock
> on PREEMPT_RT and can't be acquired with disabled preemption.
> 
> It is not required for correctness to invoke __blk_mq_run_hw_queue() on
> a CPU matching hctx->cpumask. Both (async and direct requests) can run
> on a CPU not matching hctx->cpumask.
> 
> The CPU mask without disabling preemption and invoking
> __blk_mq_run_hw_queue().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

