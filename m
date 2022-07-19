Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA55C43334
	for <linux-block@archiver.kernel.org>; Tue, 19 Jul 2022 16:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiGSQIt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jul 2022 12:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbiGSQIs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 12:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20FE548CAB
        for <linux-block@vger.kernel.org>; Tue, 19 Jul 2022 09:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658246924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z76mMAyVNcgpMhl/2GZ2y9kb595oDvGwQFD+Z+iCvTw=;
        b=VSnS+czuHH5t4FEDdFTtkyXd03EyEhYLyRKUQSmunLRxq/Is9+DjO8AnEC0lZHEsoKKoeb
        80+n65UkcYEyTVAZCEsg/j6M/WhwvkZ7sEZ3Etad2dy8QSuYNVJxZfZmpLv0iywawsOf2b
        xZlR9eUgXYs2C6pgQGCFlguTEH8F5F0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-3bjiuFoOOcOAI2LhTXI2qQ-1; Tue, 19 Jul 2022 12:08:42 -0400
X-MC-Unique: 3bjiuFoOOcOAI2LhTXI2qQ-1
Received: by mail-pg1-f199.google.com with SMTP id e123-20020a636981000000b0041a3e675844so2036501pgc.23
        for <linux-block@vger.kernel.org>; Tue, 19 Jul 2022 09:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z76mMAyVNcgpMhl/2GZ2y9kb595oDvGwQFD+Z+iCvTw=;
        b=6cjDUlcJ8catzj2YdYUqPNCLEuo8WqA8VhpcuzsKaVTssQ7eEywtIsJvymM6yi6T6B
         9vzlLJgcJcCDpThFqu9/hKtSFiyqZlx6lRBbAechZfS/hRplvL1uEIwUum5fYfxc7Sxv
         qMP9Bnjs8KIU0RRILyzDx6RSmMbkx7QZuujVhIw4cItxLijRi4xDAYlY6jb6NT1KvCUQ
         pOfdsnGIU42c2NExDGE7dLCNnsuA7+BkurVcZw+jQhLiZCVuqfEUgPldTVddjLWJNg0A
         tdtQxrkWME4CnNSGDas4925OZFaq/HduFLlDqa1T3plLF+qSgaK6TzDnfwaBzT6ov16J
         of0Q==
X-Gm-Message-State: AJIora+VL/iCn3xGf+UXS/cBHsY27Zgta8zerP3i2NlxInIfToQKSPNw
        Y4l+EGywmpg1BlwlO3xjRl/i8vaZBoldWZeZ612gAR4qWTtsZVLitaOjmGdRdBNtmTydMZAL2mB
        QrmIdE9oY9ESAULgVPsu73VUvXZTBzkOOl7LvaGg=
X-Received: by 2002:a63:500d:0:b0:415:e89e:42b7 with SMTP id e13-20020a63500d000000b00415e89e42b7mr29518009pgb.140.1658246921814;
        Tue, 19 Jul 2022 09:08:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vHmONF19r9mTSu7JDXjXG1Ig0+0UD70/k1vnuYGjD3w/OR7oS2grLIG/db08d6jG//hRIChZrjzqzvaVaW4yc=
X-Received: by 2002:a63:500d:0:b0:415:e89e:42b7 with SMTP id
 e13-20020a63500d000000b00415e89e42b7mr29517988pgb.140.1658246921505; Tue, 19
 Jul 2022 09:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
 <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me>
In-Reply-To: <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 20 Jul 2022 00:08:30 +0800
Message-ID: <CAHj4cs_zp2oewNqsK-X1bygCGDcp4rOEmwqftjAFzVsyxG7_8Q@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/tcp triggered WARNING at
 kernel/workqueue.c:2628 check_flush_dependency+0x110/0x14c
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 10, 2022 at 5:41 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Hello
> >
> > I reproduced this issue on the linux-block/for-next, pls help check
> > it, feel free to let me know if you need info/test, thanks.
>
>
> These reports are making me tired... Should we just remove
> MEM_RECLAIM from all nvme/nvmet workqueues are be done with
> it?
>
> The only downside is that nvme reset/error-recovery will
> also be susceptible for low-memory situation...
>
> Christoph, Keith, what are your thoughts?
>

Hi Christoph, Keith

Ping, in case you missed Sagi's comment. :)



--
Best Regards,
  Yi Zhang

