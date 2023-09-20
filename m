Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE3DCE79AD
	for <linux-block@archiver.kernel.org>; Wed, 20 Sep 2023 08:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjITI5P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Sep 2023 04:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjITI5O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Sep 2023 04:57:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10698CF
        for <linux-block@vger.kernel.org>; Wed, 20 Sep 2023 01:57:09 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c469ab6935so109775ad.1
        for <linux-block@vger.kernel.org>; Wed, 20 Sep 2023 01:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695200228; x=1695805028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCaB4LVQz5Zw5EnS/afR9/bgS309JzKYOV6hPcD95GQ=;
        b=XNx4NC4GYkaqbHmCT5sap16QyjixxSxYHvkAWz6dTf2l1SPcW0OG4w1jONY4dpuUuR
         4E3CtmbJ0XPU+DXO8tL6HhsyfdJLL7H9mkwz4bnIEB7NO9tjbTxENLzK8FM7u42E6pSO
         i8Qp/oz+56DdF/JfOYwuxQeMEYmpUU4SV/a45da48005fcqb3zdLzID5Nxxc+h7K07T7
         OFF/oKoMoTlav2XL9/FWuyz+5AmhyUKfpwjHAT8b+6EHE8S/qzgnfI/PrvTBMOw8+4NY
         5XcpfOybZSCGQSbkkYNAFLOj3R0W59ALXFxYU37rrvsxaGnfuFJXr+DzSsXsqlaSCxYg
         bg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695200228; x=1695805028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCaB4LVQz5Zw5EnS/afR9/bgS309JzKYOV6hPcD95GQ=;
        b=AT+5GzFUREl5q41xgDj5ll4C9hFNGgmmdLFnYOFoZrRRRRogsSavES2bYJabgyk7Rp
         4SmpqIbLVPImUkIpy+6+K74G7SeDL7yMlrvT2+OiTspJQN6mcbXD0cUUfPy4t0VpDTuo
         k88sdI8Pl8Nkds84h+paTSttO3BDhZvGG796UR+qOfEuP1QRAkM+fFRxxmxK22YWGc9d
         zgz9xV2W08Ny+tA5gl41JXRTr9FIMm/sZOZnR5Iuo4MKlZ/Te86ruYQRRs5XPZHZhJMI
         8/Ng6DMz7xayzuleAIoGFDhmd72AX15qqK3wLtR13yMG80NbYNPFvHHprQzTJgC82tsD
         uQjg==
X-Gm-Message-State: AOJu0YzjUoFrsPFax9XeP/IQistl0+AazkZz1jhnsokfu+WcZrMwhAAH
        4i4RyrztJKkEd4MHoKjl68o6z1nl2slsA3+6HR2i9A==
X-Google-Smtp-Source: AGHT+IG27sQVZz+H2ksdbYnMakCV8uuy/VU9E7xq+vEtRwplNSlDOY8vW8f2mbDcLnt16LsfQVyk9wbzoyZDZ9sWfHk=
X-Received: by 2002:a17:903:1c7:b0:1c1:d934:26bc with SMTP id
 e7-20020a17090301c700b001c1d93426bcmr169727plh.26.1695200228296; Wed, 20 Sep
 2023 01:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e534bb0604959011@google.com> <ZPeaH+K75a0nIyBk@dread.disaster.area>
 <CANp29Y4AK9dzmpMj4E9iz3gqTwhG=-_7DfA8knrWYaHy4QxrEg@mail.gmail.com> <20230908082846.GB9560@lst.de>
In-Reply-To: <20230908082846.GB9560@lst.de>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 20 Sep 2023 10:56:56 +0200
Message-ID: <CANp29Y5yx=F1w2s-jHbz1GVWCbOR_Z-gS488L6ERbWQTAX5dRQ@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] INFO: task hung in clean_bdev_aliases
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        syzbot <syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

#syz set subsystems: iomap

On Fri, Sep 8, 2023 at 10:28=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Sep 06, 2023 at 07:20:15PM +0200, Aleksandr Nogikh wrote:
> >
> > The reason why syzbot marked this report as xfs is that, per
> > MAINTAINERS, fs/iomap/ points to linux-xfs@vger.kernel.org. I can
> > adjust the rules syzbot uses so that these are routed to "block".
> >
> > But should MAINTAINERS actually also not relate IOMAP FILESYSTEM
> > LIBRARY with xfs in this case?
>
> I'd tag it with iomap, as it's a different subsystem just sharing
> the mailing list.  We also have iommu@lists.linux.dev for both the
> iommu and dma-mapping subsystems as a similar example.
>
> But what's also important for issues like this is that often the
> called library code (in this case iomap) if often not, or only
> partially at fault.  So capturing the calling context (in this
> case block) might also be useful.
>
> And to get out of these meta discussions:  I'll look into the actual
> issues in a bit, I'll try to find time despite travelling.
>
