Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90977C61DA4
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 06:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBFGrX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 01:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBFGrW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 01:47:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57A2193C7
        for <linux-block@vger.kernel.org>; Sun,  5 Feb 2023 22:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675665994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cuz7MuH4XuS+WWvNsXkoHmcAVHoNGL+MeTjw76Vaf3Q=;
        b=jPOLxmCIuKbQJcaLGNw4n5f+gumCz0YF1vGu4WKgF08a6UVqEWeJSlmRp7r7MAj5GyOpNr
        SAMiTB217rVAAFwh0/ODdTaMeWlCXoKZi+zr1SKhKCFHXe3aJO+3qpEGoe4ag4ZACAA3Ws
        w5vJFHE9RF3jyS075F5m7hSzSrYsvic=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-311-cm_xqRWsOS60anZty6YA1A-1; Mon, 06 Feb 2023 01:46:31 -0500
X-MC-Unique: cm_xqRWsOS60anZty6YA1A-1
Received: by mail-pf1-f197.google.com with SMTP id u3-20020a056a00124300b0056d4ab0c7cbso5931158pfi.7
        for <linux-block@vger.kernel.org>; Sun, 05 Feb 2023 22:46:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cuz7MuH4XuS+WWvNsXkoHmcAVHoNGL+MeTjw76Vaf3Q=;
        b=r7ZYNwByIJBWmCRWBVlUDFgX5z6YYmClbniBrS6RkFG1k/LzN2rAEsaqcMhMw9xJx9
         nT36v54UqyS2aWf9WOp1oGu8lwqWksK9Adsc6qla8pcarXJYvJPLPBhM4+qLhSQiIWEn
         VLzWpMDEDXczw9r0C1LqvwCBjdlMi7erMt7TfCFfucwyStlgqs/2yZe1L5TgicDjfXy3
         TnH3xdcynXoKaLF2sR9q7DlQBj6TBsF2FEjlwAG0rjvb2lNFeJu3qqUEGz1PZ0f1O0Iu
         OV2O7ikSJiI6EE1MjM+ZgEQngQb5pzBMSSpC3CDYs/Y1Q3F/c9CWnf8YtdDTSkFjjBS0
         F22g==
X-Gm-Message-State: AO0yUKXO4wRskW8OGybbWokB0/keo+ZZ+eE6Qu6bwaNct8V9A2hOAhsQ
        mLChSTddo64GYoqQvoay1p7A57Y5+MdNDM/Dn1jXIYPqMCRxTcbK1r49lEfAZdgoU7IgPDkgMVY
        O142F0JcX7pdb2fNYV01FljV7A+LqagGLMu+uahI=
X-Received: by 2002:a17:902:d508:b0:196:7127:2240 with SMTP id b8-20020a170902d50800b0019671272240mr4201349plg.11.1675665990366;
        Sun, 05 Feb 2023 22:46:30 -0800 (PST)
X-Google-Smtp-Source: AK7set9DT/MCO0iby8rnWPn7BMhAYYHIX11ju/vj+gpiZJ6ANI2D41yyA3pSi0haWUW9eIvzfqUqF9EVCFEvrleMN3Q=
X-Received: by 2002:a17:902:d508:b0:196:7127:2240 with SMTP id
 b8-20020a170902d50800b0019671272240mr4201346plg.11.1675665990093; Sun, 05 Feb
 2023 22:46:30 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs-ZvyXKU9iAVKSkh2NfN5238rh-OaU8_uDBHVFtJb2ASQ@mail.gmail.com>
 <20230206062037.GA9567@lst.de>
In-Reply-To: <20230206062037.GA9567@lst.de>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 6 Feb 2023 14:46:17 +0800
Message-ID: <CAHj4cs_HT+iqoPkRcAFr8A4o5C3TzDE6h2fA-ZUbhiek7-MwnA@mail.gmail.com>
Subject: Re: [bug report] RIP: 0010:blkg_free+0xa/0xe0 observed on latest linux-block/for-next
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 6, 2023 at 2:20 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Feb 06, 2023 at 01:22:23PM +0800, Yi Zhang wrote:
> > Hello
> > CKI reported one new issue with the latest linux-block/for-next, pls
> > help check it, thanks.
> >
> > linux-block.git@for-next
> > commit: 99bd489eac97
> >
> > [ 4407.784047] Running test [R:13334567 T:10 - Storage - block -
>
> What actual test is this?
The test was doing fio on each numa node on the server.
I'm trying to reproduce it, but it's not 100% reproduced.
https://gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/blob/main/storage/block/fio_numa/runtest.sh

> > storage fio numa - Kernel: 6.2.0-rc6]
> > [ 4509.133240] BUG: kernel NULL pointer dereference, address: 0000000000000000
> > [ 4509.133654] #PF: supervisor read access in kernel mode
> > [ 4509.133930] #PF: error_code(0x0000) - not-present page
> > [ 4509.134206] PGD 0 P4D 0
> > [ 4509.134373] Oops: 0000 [#1] PREEMPT SMP PTI
> > [ 4509.134579] CPU: 2 PID: 965 Comm: auditd Tainted: G          I
> >   6.2.0-rc6 #1
> > [ 4509.135384] Hardware name: HP ProLiant DL360p Gen8, BIOS P71 05/24/2019
> > [ 4509.135758] RIP: 0010:blkg_free+0xa/0xe0
>
> Can you resolve this to a line using
>
> gdb vmlinux
> l *(blkg_free+0xa/0xe0)
>
Here is the info:
(gdb) l *(blkg_free+0xa/0xe0)
0xffffffff8171add0 is in blkg_free (block/blk-cgroup.c:118).
113 in block/blk-cgroup.c
(gdb) l *(blkg_free+0xa)
0xffffffff8171adda is in blkg_free (block/blk-cgroup.c:128).
123 in block/blk-cgroup.c


-- 
Best Regards,
  Yi Zhang

