Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E8FC43334
	for <linux-block@archiver.kernel.org>; Sun, 24 Jul 2022 08:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiGXIV0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Jul 2022 04:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGXIVZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jul 2022 04:21:25 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6A817070
        for <linux-block@vger.kernel.org>; Sun, 24 Jul 2022 01:21:24 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id b6so5050780wmq.5
        for <linux-block@vger.kernel.org>; Sun, 24 Jul 2022 01:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VKItlKqeQzUeLjsSOboxbZBwuf6Jv/NlZDlxQtu9aBY=;
        b=Vn2C29toli/A75zLr+rsjAYo0sNRVsPD/QmkEftDllHCz7Xg1LUpG8JrA2mdhNBsgl
         w1eN/3TEtM+8cAnliQvDApE0wnJujvrqfPJfZ3TZcq3sOHL7JsYwxTYfuVhWUj6myklR
         JPPCZ32Rt8+Pr9mpiYrEjWv+b9JlHJvzOEcLPGpmmUzhxyG3tzJrNtO7t3yg/XohGNHq
         rR06Zr57wSjHYXlrDBldIwRNc7LBSG7f5tdMEj/DPfQXigTORdMsD+bwj3vb+yKA3JN1
         feA03ZMs8mHPQw7ILJZ1cjY4Ya8k/ZlByYxpHPfznHDvgZawaiJ43k0OEmBbewAA2ofr
         TFzg==
X-Gm-Message-State: AJIora/h+KvBY0fLxvw0Hh4396mWrOgvDMtUY5QGGf9Jdr+fIY/yk3vm
        8YZcIL/CrBWO2xbdXQOt1bM=
X-Google-Smtp-Source: AGRyM1vkJHWKG/flWuUgZLrFPARge0QuHbIawiWSLWyzfzm3ZkH7TuRJKNn5TWS0oZkewMVe+YPuwA==
X-Received: by 2002:a05:600c:4e88:b0:3a3:1bdc:cb72 with SMTP id f8-20020a05600c4e8800b003a31bdccb72mr17784171wmq.59.1658650882597;
        Sun, 24 Jul 2022 01:21:22 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b003976fbfbf00sm11119183wmq.30.2022.07.24.01.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 01:21:22 -0700 (PDT)
Message-ID: <472156f4-ff58-aeba-64eb-b8e5815e9c29@grimberg.me>
Date:   Sun, 24 Jul 2022 11:21:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bug report] blktests nvme/tcp triggered WARNING at
 kernel/workqueue.c:2628 check_flush_dependency+0x110/0x14c
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
 <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me>
 <YteeHq8TJBncRvZu@infradead.org>
 <bd233bf9-d554-89cc-4498-c15a45fe860b@grimberg.me>
 <YtoriAQGW8+p4pFe@infradead.org>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YtoriAQGW8+p4pFe@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> The problem is that nvme_wq is MEM_RECLAIM, and nvme_tcp_wq is
>> for the socket threads, that does not need to be MEM_RECLAIM workqueue.
> 
> Why don't we need MEM_RECLAIM for the socket threads?
> 
>> But reset/error-recovery that take place on nvme_wq, stop nvme-tcp
>> queues, and that must involve flushing queue->io_work in order to
>> fence concurrent execution.
>>
>> So what is the solution? make nvme_tcp_wq MEM_RECLAIM?
> 
> I think so.

OK.

Yi, does this patch makes the issue go away?
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 0a9542599ad1..dc3b4dc8fe08 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1839,7 +1839,8 @@ static int __init nvmet_tcp_init(void)
  {
         int ret;

-       nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq", WQ_HIGHPRI, 0);
+       nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
+                               WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
         if (!nvmet_tcp_wq)
                 return -ENOMEM;
--
