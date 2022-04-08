Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E89CC433EF
	for <linux-block@archiver.kernel.org>; Fri,  8 Apr 2022 05:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiDHFxa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Apr 2022 01:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiDHFx3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Apr 2022 01:53:29 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4201C2296D1
        for <linux-block@vger.kernel.org>; Thu,  7 Apr 2022 22:51:27 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h14so8129337lfl.2
        for <linux-block@vger.kernel.org>; Thu, 07 Apr 2022 22:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QMVVRJGSL83qZp/D399to2LDBBeobEw6FStjIYATZ/Y=;
        b=0YiRAWzvm1vgAPRBpqShBhJzPF6IeAHhJxoonPSnyl+HeapfBuqBKQCYebg6GIkrv9
         lSJj4vxwr5M89BFYzC4xZSqEELjc7WzOUexpm9x3uKYSnrmw6jy/tHU6PHtW0wvxtuqt
         z28rXPcsP5k7B8OTAFBB1Y+WGPN/m0XxgPx52dk+s5hZgUJ2YgkbHsH4kBchwzvJ+tfD
         1A4cCfA5RMoyhXM0Tqd6KRQYk1xfN8xQI2wRHYdkDgFV430cBSLTxglcmlO4yM8L0fse
         awJ3BB3sOXtwpKTDxYoach8joggACHPRPjA5gLy+lq90d0TBo8THUnJV6IH9s77ZzoEk
         rEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QMVVRJGSL83qZp/D399to2LDBBeobEw6FStjIYATZ/Y=;
        b=4/xekmnNL92n520rR85D215P+6Of0j/3PK+GitfeHzRk9BB5rxz3PE7xBXKpedFpeP
         QcdgCyaHFKNWsWGLTo95nDuXOo3PT2OWj0dSuxs+snzb+7GBY2J4D7RMjNbh+lpCa5+n
         dJKs2ejsnpQ1wGYx2sjoEhVTECJtIPNIqp0QzQs3G8i4JE4KzVXBILiArt32+5C2MKXy
         Y2inK/enStVWKGOyJtykaiBD6iIgceUoFdBttMdDFK1TIBpTdutpOSNeT14Bdx2iVCaT
         VrwvXY0i1FFdCoeTy3kX5qzsQZ7P8ngNsfvUvOJGlYy9wIocy8JJMOnSE466WI4tKw6j
         NyXw==
X-Gm-Message-State: AOAM531AjIuCmieVz7DCZQxxejHXKZDLBbkn+LKou0VkvdsfIw265YeA
        YE2Hl3p2MkwD2M/sgUT372LbRX5x1LFmGbW4QYVsrg==
X-Google-Smtp-Source: ABdhPJzjAOb88R3T8f0sBYpRPzkVucnZ8sw6tR7Q1e3wb3WhXl14J4PvwZOLRdJ9aVqEXjrcnlvXppRqb6ku2CgYizg=
X-Received: by 2002:a05:6512:1594:b0:44a:2d71:f14d with SMTP id
 bp20-20020a056512159400b0044a2d71f14dmr12204895lfb.446.1649397085177; Thu, 07
 Apr 2022 22:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQkDFs7bt5T=jHO0iZ0zUgvaPpYPf_n4s+URtQXqF2Mew@mail.gmail.com>
 <CAHj4cs8Mtv66ikMDTJYQ48spEvF8QYyoD0SrZPDKfgXarpp=dg@mail.gmail.com>
In-Reply-To: <CAHj4cs8Mtv66ikMDTJYQ48spEvF8QYyoD0SrZPDKfgXarpp=dg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 7 Apr 2022 23:51:09 -0600
Message-ID: <CAJCQCtS=1W23HZ71jw1AxJ=SXihDgjWfgxVC+vjjNpd9=87zrw@mail.gmail.com>
Subject: Re: 5.18-rc1 nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) DNR
To:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 7, 2022 at 10:42 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hi Chris
>
> This issue has been reported and you can find more info here.
> https://lore.kernel.org/linux-nvme/F2ACCD82-052F-473F-9882-1703147FA662@oracle.com/T/#t

Thank you, I didn't realize there is an nvme specific list. Noted.

I filed a rhbz referencing the nvme list thread in case anyone else
stumbles into this.
https://bugzilla.redhat.com/show_bug.cgi?id=2073270

-- 
Chris Murphy
