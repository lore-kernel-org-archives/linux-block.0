Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44417C4332F
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 16:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiKVQk2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 11:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKVQk0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 11:40:26 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7D51E3EE
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 08:40:26 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-36cbcda2157so149452677b3.11
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 08:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D2zYvqvXjbGs5C4WInuhh3U2C66flVl4taaDYYUBAVA=;
        b=UaPYWxjEdnLjXhU3WdNH0ejVKdY6kJXtscrlYGI69kfDiXTFnkEFSR46W2T3RsVTP5
         txRxDRJTQ5DGe1K0fZYS21f3clsrdGw1OmUM57d/xnboggySp77gI/he4O487ft97Vme
         WjL5PCnk+w6qZV6gSZ5h2mCoCKhm4FCXTP2xmNiSQtU3F3GIbxDFq7JKpYSU6wP2r8aj
         XF3xQD/+sfPTM13ufbByfB62otc+u+lBsqKTJ7YGmdX62IlF6ErreeTKbQsO0GDLWdSb
         uJoPEapG5MKQI1G39sCxzblmndinWn12RMatkEK5M/uOEUhP2wtZt9eh0uL14R7rZ3Tb
         XQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2zYvqvXjbGs5C4WInuhh3U2C66flVl4taaDYYUBAVA=;
        b=Nui+A349/eC65oMV5Iq7KljpE32Vusb2O5f9xHxpLFDPGJXuproQc1/hrdaNbYbC8X
         sy3paaIQRcJKruxZTpf69txt9/5lLBXywlAbCgjyYmaCO4lW1KB/x1DmJbSyhMedyUtq
         c5A4e8itu63CCVUp/KxOfjsZqFpVa0fgadS1q4jhDS6ve+wUQiCbyo4ZzPOMUlj1b5Nr
         QZ25MgvdrBJc/DMlZgMFCsG8kgktp0kfvLQBRrr4SUk80Mr6ZcAbu4jW/r/AT8H5zY9g
         RvuHEHcS9AoJhfB10b7xVh7IeGzmN0ZONPatweih0A9nuJFdApRWlLfK7Q+iO0HY54p/
         vn5w==
X-Gm-Message-State: ANoB5pmGFJGzZ+dF2/gzwNRHqBWamzGmsUUzpXRGjY7zkbhehzfTExFQ
        yQl0Fqq6t+GlyKSFzWmjjkrcr+u05a4++wNEURxlng==
X-Google-Smtp-Source: AA0mqf4mkW4nuiEh4N+hOrMH9u/+FRLT0Zho1JaAfLTjdPVXW3dNj6y1yEg0KGDKXO2qAlyN170k/W4HmBBv8EvuyBs=
X-Received: by 2002:a81:acf:0:b0:391:48c6:3eb with SMTP id 198-20020a810acf000000b0039148c603ebmr22657111ywk.93.1669135225214;
 Tue, 22 Nov 2022 08:40:25 -0800 (PST)
MIME-Version: 1.0
References: <20221101150050.3510-1-hch@lst.de> <20221101150050.3510-15-hch@lst.de>
 <20221121204450.6vyg6gixsz4unpaz@google.com> <a8e3d7a4-c5f6-13d0-a517-72097daa2a7b@huawei.com>
 <20221122060855.GA14111@lst.de>
In-Reply-To: <20221122060855.GA14111@lst.de>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 22 Nov 2022 08:40:13 -0800
Message-ID: <CALvZod7AFOSyN7pz0+B2rbQrzepTD+QLwmSYSNUa5jyaXEfKfg@mail.gmail.com>
Subject: Re: [PATCH 14/14] nvme: use blk_mq_[un]quiesce_tagset
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chao Leng <lengchao@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 21, 2022 at 10:08 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Nov 22, 2022 at 10:53:17AM +0800, Chao Leng wrote:
> >> This patch is causing the following crash at the boot and reverting it
> >> fixes the issue. This is next-20221121 kernel.
> > This patch can fix it.
> > https://lore.kernel.org/linux-nvme/20221116072711.1903536-1-hch@lst.de/
>
> Yes,  But I'm a little curious how it happened.  Shakeel, do you
> have a genuine admin controller that does not have any I/O queues
> to start with, or did we have other setup time errors?  Can youpost the
> full dmesg?

Sorry, I don't know about the admin controller and its I/O queues. For
dmesg, it was an early crash, so not in /var/log/message. I was able
to get the crash dump through the remote serial console but there is
no easy way to get it to give full dmesg. I will see if I can get more
info.
