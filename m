Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC67FC38A2D
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 18:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJUSdo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 14:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJUSdh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 14:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0572828864C
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666377216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dLmiSkOFaJ+6V3LqgPTa0cZ4h6uaklJ08nilTBsNxQM=;
        b=d+fR4qShfMHx1d4ytX638AxC0una+QAO2dwSxnGvsQmO53A/OD0at5XnHLpiO4q8rwXZ2m
        3Grn/L0ImXeVHpC2VNGd/M9ToX9wq1JE/1cEQTmVtRy5GpSNQgRDdzjJw1tyJT4njlHqgQ
        /DvmOlfj7AhcyCgpXnxYDip6wPQDvZo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-395-Pf_jJgoRPXKQ9y_FmZw8Cw-1; Fri, 21 Oct 2022 14:33:34 -0400
X-MC-Unique: Pf_jJgoRPXKQ9y_FmZw8Cw-1
Received: by mail-ed1-f72.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so3412138eda.19
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 11:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLmiSkOFaJ+6V3LqgPTa0cZ4h6uaklJ08nilTBsNxQM=;
        b=k9ULjFpqOGnRJ3thUHFV6QAiTkJ1I2YUnBqTq3Q0JNxEDPjMAdxnq4whS6w3l+E6uX
         gr9yl7Ro3YJRU/Y3ti1+m9p0mOyaad1r9EN+lNQA4XSKXDihuT12w3LhdK1ZTcFAsx+P
         bCFz4x8Sn5Shh/P/dYENpmMLI/JXVBXUe1BOWbQ+dc0FpPndLmQ0JI/nx4fo+P9zdYTg
         dazVoSyW1cKvwxgzbjqxhIt+BvhcwDVbwn+oreZvU4pU9kIcOgDNZzV8sB17YkL/0JPo
         vN9XXJ9y6lmbgVMdGMAgjN/L0bDHB0bNdk4JCnbpw6cf63GMFwWMCPoNwPtsbccOCHDv
         otRA==
X-Gm-Message-State: ACrzQf3IYj4RWo6mJ0gGKBog9OuXzjuNm1Nj4qQN0aFhARATWpJTM80n
        dTar0dM4f/QTzFaqGkyFW+uhVyF4RuTiyqC8EnE3Ng1zptca5hyd6KE/DxgUaIgJtE+usoHiTzI
        5xw5V2iQfKUSEeX3nW4fDoLMIR629YdaU+hXuG1s=
X-Received: by 2002:a17:907:6e09:b0:78d:a326:49c6 with SMTP id sd9-20020a1709076e0900b0078da32649c6mr16637991ejc.507.1666377213474;
        Fri, 21 Oct 2022 11:33:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7NZHJKc03YC7LnDuTW7o+luE+PAom09rHSVMHty9srBMk8ve+2AMEfrLe7S9AFxjPyeW5ZCPc2NuaXhM2MKJo=
X-Received: by 2002:a17:907:6e09:b0:78d:a326:49c6 with SMTP id
 sd9-20020a1709076e0900b0078da32649c6mr16637970ejc.507.1666377213305; Fri, 21
 Oct 2022 11:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <Y1EQdafQlKNAsutk@T590> <Y1Ktf2jRTlPMQwJR@kbusch-mbp.dhcp.thefacebook.com>
 <Y1K5Oo7bIRlVTDnb@T590>
In-Reply-To: <Y1K5Oo7bIRlVTDnb@T590>
From:   David Jeffery <djeffery@redhat.com>
Date:   Fri, 21 Oct 2022 14:33:21 -0400
Message-ID: <CA+-xHTFp+gFVy6aKW2nj47+WY2+1vOLAE-X067C-hm4_8ngA6g@mail.gmail.com>
Subject: Re: [Bug] double ->queue_rq() because of timeout in ->queue_rq()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, stefanha@redhat.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 21, 2022 at 11:22 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Fri, Oct 21, 2022 at 08:32:31AM -0600, Keith Busch wrote:
> >
> > I agree with your idea that this is a lower level driver responsibility:
> > it should reclaim all started requests before allowing new queuing.
> > Perhaps the block layer should also raise a clear warning if it's
> > queueing a request that's already started.
>
> The thing is that it is one generic issue, lots of VM drivers could be
> affected, and it may not be easy for drivers to handle the race too.
>

While virtual systems are a common source of the problem, fully
preempt kernels (with or without real-time patches) can also trigger
this condition rather simply with a poorly behaved real-time task. The
involuntary preemption means the queue_rq call can be stopped to let
another task run. Poorly behaving tasks claiming the CPU for longer
than the request timeout when preempting a task in a queue_rq function
could cause the condition on real or virtual hardware. So it's not
just VM related drivers that are affected by the race.

David Jeffery

