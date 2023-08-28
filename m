Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9CFC83F14
	for <linux-block@archiver.kernel.org>; Mon, 28 Aug 2023 01:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjH1A7z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Aug 2023 20:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjH1A73 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Aug 2023 20:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F12131
        for <linux-block@vger.kernel.org>; Sun, 27 Aug 2023 17:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693184323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vmal4hn0XBHdSL8GzE89VF+dr7kcGENPa2m8SJGidbg=;
        b=bAyEj4y6/c6GsNB6VrZQRXcAoxHI0Gye3lZZtDjRZKM6pB3mky6KChOOdMDgpLe3QswSDB
        gj33awiXTFHYMwANeqPqfrwQZMrKaVvt3x2dcAQ9Pb5+HFP6ZRxDMzSMvQyuP7fmv7UT84
        c59X4XzyRo81S42jgMbMkJnqe4x9+PU=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-BNSOdw1APEOFL6fWAjBMzw-1; Sun, 27 Aug 2023 20:58:41 -0400
X-MC-Unique: BNSOdw1APEOFL6fWAjBMzw-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-48fa8d86dedso217398e0c.1
        for <linux-block@vger.kernel.org>; Sun, 27 Aug 2023 17:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693184321; x=1693789121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vmal4hn0XBHdSL8GzE89VF+dr7kcGENPa2m8SJGidbg=;
        b=YqOv7QnT4jBJvK9CXCpPG+y76s/t6xBXEp+YN+YtWAdbnW2Nqlxq3eIFAkggU9adfL
         V/BOg5l/BBHUo8bN2HIpxRX7ZkWojHOV5NqkhwVIExtoxodo4gPUCr8nSXiYHYeeJk31
         4Nr7VibzFlLX7CAtn54HUs9HC1zhIXbUK08phVGqsOD+RcyWhMQw7TheHvWbATO6mVDc
         aPRYrUwjernHi2OIjihQ9rPYpj7x2Khd74PHQNL+BBxccT41Zhl+aRu+2yUK4ftUXPeO
         AetY1p3lc20hcbi2zTUEwBNDWaPkoP5ZUgdyBkfkVU6WzObrMiNmqifaQa2itXUAVrVm
         NcDQ==
X-Gm-Message-State: AOJu0YydTOv/MSHOHxEsu7lRaQCzyysPuEhX62cbGz22lG9U9Zm4UzJ8
        FFG2K86Mf3u5LWIDj8AwYxHRHTIe0fqDbxbICgO5OsNnjS8iBZX/P2vCVFPR+Yy6dvKbeoFiVsi
        3zMTtC31xNVZHHAa3Qd4wgYywdc89i/2OkiFYc1o=
X-Received: by 2002:a05:6102:3082:b0:44d:626a:f079 with SMTP id l2-20020a056102308200b0044d626af079mr11011478vsb.3.1693184319865;
        Sun, 27 Aug 2023 17:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk8x4y0ZS8y62BRq47uQm/s83tXzZyWyVZwGWwniyN2eYrb2TIg9cR3GcQ+RXT4nTqSvOaZ2XdGbeTF7tcLfI=
X-Received: by 2002:a05:6102:3082:b0:44d:626a:f079 with SMTP id
 l2-20020a056102308200b0044d626af079mr11011470vsb.3.1693184319657; Sun, 27 Aug
 2023 17:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230818140145.1229805-1-ming.lei@redhat.com>
In-Reply-To: <20230818140145.1229805-1-ming.lei@redhat.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Mon, 28 Aug 2023 08:58:28 +0800
Message-ID: <CAFj5m9LGi4zxvDYqTvSHYh=Ra3YHUMe3nePZqJsMfEXttbrgMA@mail.gmail.com>
Subject: Re: [PATCH V3] lib/group_cpus.c: avoid to acquire cpu hotplug lock in group_cpus_evenly
To:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>,
        Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 18, 2023 at 10:01=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> group_cpus_evenly() could be part of storage driver's error handler,
> such as nvme driver, when may happen during CPU hotplug, in which
> storage queue has to drain its pending IOs because all CPUs associated
> with the queue are offline and the queue is becoming inactive. And
> handling IO needs error handler to provide forward progress.
>
> Then dead lock is caused:
>
> 1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
> handler is waiting for inflight IO
>
> 2) error handler is waiting for CPU hotplug lock
>
> 3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
> error handling can't provide forward progress.
>
> Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly()=
,
> in which two stage spreads are taken: 1) the 1st stage is over all presen=
t
> CPUs; 2) the end stage is over all other CPUs.
>
> Turns out the two stage spread just needs consistent 'cpu_present_mask', =
and
> remove the CPU hotplug lock by storing it into one local cache. This way
> doesn't change correctness, because all CPUs are still covered.
>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: linux-nvme@lists.infradead.org
> Cc: linux-block@vger.kernel.org
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Reported-by: Guangwu Zhang <guazhang@redhat.com>
> Tested-by: Guangwu Zhang <guazhang@redhat.com>
> Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V3:
>         - reuse `npresmsk`, and avoid to allocate new variable, suggested=
 by
>         Chengming Zhou

Hello Thomas and Jens,

Ping...

Thanks,
Ming

