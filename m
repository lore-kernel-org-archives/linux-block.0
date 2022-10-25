Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C49C38A2D
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 14:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiJYOBl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiJYOBF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 10:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7706025C66
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 06:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666706391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fg4c2IfqsecglBST76jUR+Fcrkj0nMXmV/e6ikwWED4=;
        b=ZB2O18OADudtUqL383a5XKZydy+zFPKB79Mcpg36XpSw3GAslmkngTcn5ONoJttfs1qjkG
        3CA7P9uySB/MNQg8wwc6/4LDiQErLsVIZFIFLBtVwdphqmUz7qxOY+G9qwhAkb5ab9dVw/
        2Nak5jdOfwFRywLQv0VwK4Sp+rq05Wk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-64-QwY4qtItO1CGZdFj_xHG7w-1; Tue, 25 Oct 2022 09:59:50 -0400
X-MC-Unique: QwY4qtItO1CGZdFj_xHG7w-1
Received: by mail-ej1-f71.google.com with SMTP id hr26-20020a1709073f9a00b007a20c586f1eso1736566ejc.20
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 06:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fg4c2IfqsecglBST76jUR+Fcrkj0nMXmV/e6ikwWED4=;
        b=f/cgrIQ+p/qWnYo7rnZuZp0ZtlaOwJuFgNf9i5SW9Nny1vLUNrTuZarNPpC9wQh64t
         qf5GNAdxZ3Tqco1VCfHZffog95dpxaVbtKtMg8kHzVGhID/h46BIMi8OE3m0esPdRQrf
         Av78jGmdDEvAlmEf7+wgS2eJ0JSM0xDRmKF8/PN0Hh5z+S0TSzdMILTQ2dMymmGlXxOP
         jTzxdYr/mZDvossIQk+dPKWao+MFyWD4Y3n78bGlqmL0i0JBGv3WvbS7UWGXigb0hjKZ
         S+yHUsRUFl7jcpy6SGiBhYkns19Wx1vtFlc9LWhO1rvLBOMTTEkfLH8m9zqFNdiv06ex
         y7cQ==
X-Gm-Message-State: ACrzQf0jk/DuNzkaGHdlFI8KLGJhVYV2/hclwMq7zstVaRYY2YoSzEqo
        UDqgr9ZaP+otGcfs/vGkQzRJwxSiG2+jrwrjlFlRWVWS/JWkwzCb5m6D0TQ86ds7xIznfqmVz8J
        Eu8VsYshbSZr8vVQRGTY1Lxd1bpJuyjx0OttvngE=
X-Received: by 2002:a05:6402:2791:b0:461:c5b4:d114 with SMTP id b17-20020a056402279100b00461c5b4d114mr9750298ede.357.1666706389215;
        Tue, 25 Oct 2022 06:59:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Ip77E5WsrckgwLdMVxaJsmlv8LG+3r80D5S4vRMIgzHJKWHla3EeuPMapmjVPe3k2GwPhhG/Kzi4/yGdjahs=
X-Received: by 2002:a05:6402:2791:b0:461:c5b4:d114 with SMTP id
 b17-20020a056402279100b00461c5b4d114mr9750281ede.357.1666706389051; Tue, 25
 Oct 2022 06:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221025005501.281460-1-ming.lei@redhat.com>
In-Reply-To: <20221025005501.281460-1-ming.lei@redhat.com>
From:   David Jeffery <djeffery@redhat.com>
Date:   Tue, 25 Oct 2022 09:59:37 -0400
Message-ID: <CA+-xHTEwZFuhQLPTKQ-9dq5Oz=PkPxa_AzjupAgpO7cnFvniXg@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: avoid double ->queue_rq() because of early timeout
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 24, 2022 at 8:55 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> From: David Jeffery <djeffery@redhat.com>
>
> David Jeffery found one double ->queue_rq() issue, so far it can
> be triggered in VM use case because of long vmexit latency or preempt
> latency of vCPU pthread or long page fault in vCPU pthread, then block
> IO req could be timed out before queuing the request to hardware but after
> calling blk_mq_start_request() during ->queue_rq(), then timeout handler
> may handle it by requeue, then double ->queue_rq() is caused, and kernel
> panic.
>
> So far, it is driver's responsibility to cover the race between timeout
> and completion, so it seems supposed to be solved in driver in theory,
> given driver has enough knowledge.
>
> But it is really one common problem, lots of driver could have similar
> issue, and could be hard to fix all affected drivers, even it isn't easy
> for driver to handle the race. So David suggests this patch by draining
> in-progress ->queue_rq() for solving this issue.
>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: David Jeffery <djeffery@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---

Thank you for your help and patience, Ming.

Signed-off-by: David Jeffery <djeffery@redhat.com>

