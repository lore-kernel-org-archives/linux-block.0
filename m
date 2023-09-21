Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0726CD4938
	for <linux-block@archiver.kernel.org>; Thu, 21 Sep 2023 00:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjIUAi1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Sep 2023 20:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIUAi1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Sep 2023 20:38:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E73B7
        for <linux-block@vger.kernel.org>; Wed, 20 Sep 2023 17:38:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c59c40b840so3317325ad.3
        for <linux-block@vger.kernel.org>; Wed, 20 Sep 2023 17:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1695256700; x=1695861500; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jMd1KRyDEvQHJgfGmaNgihRzYBqmhVKvC+CzE4oWItk=;
        b=cDd6GDoaZ6J84c/CzUz/r9V9a07bKe5F2PPSzuoJVZIvXyoJdSCOY6ybGiC2TNAMb+
         yXVQQZrra9nCbK6FOrkeXMJCAXk1Ols5CToRV9NYH3vT/gUTz4HYBhkMRTz83cGs2Io6
         iQI31+dCkVowjSdfZys6m2GKvGBf0lmbJ/VZq8NNnYirat0frKl9c9RdNbmNB83cbwcx
         FxZFDBUQqfWrfVg7VcZkCSYpo9MrxuwotVngXcd4sV1h2UBF12BwuluchYxxunWOSp9B
         o3L0rDtseYrvoK5c9Fiff+OScHplum/l9CZP7/1R5QRFDrAdIPPQ4IhnCuG8KOEawQRC
         IOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695256700; x=1695861500;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMd1KRyDEvQHJgfGmaNgihRzYBqmhVKvC+CzE4oWItk=;
        b=DviOkDuYgVW0YZshBj9+E0NkSTEHLjOZWET10igiGEv8gThEy0lZJmPs/BOEoIO19y
         ZkqI6qFhkIgmnDRF1Wv45G2ZxrFSrwwEHt7MBgQn8pZ0Ejh0gUJZK9a8yke5MPET2BZ4
         t9FLeKZnZBO5yAgaQw0Kvh9dhL2tAwr/taz/JMeFVAkUjfcDtNe/RXAXmBX6gC9Ec20D
         3bYczcXuvDw8s2BhA9IfQFleLyllcT+9DP9QeO+ERhL98YwWQtfgUNL8KJmWFK4jB+iH
         /JGd4ONC3DlY5x+VacHzNJuYWne8guQ/x6UiHNuJs52vy8bRYHM6PVAV62QhXyH8DOyw
         OFlQ==
X-Gm-Message-State: AOJu0YzFnRFuG9ozBM0leGN2gYd+YQnv1vJ2PQq5AQ1dnm4VrhRampca
        bDFVlPxbAlqd0Ud7uj/xHmuVd0QhhNRjzuoFn5U=
X-Google-Smtp-Source: AGHT+IEzLBFMk3kEDzcaTGMq6sgJhldRQhr+5QWyOipuNTfWB8uF3/9WdBQ08yQlD0BAeEqi8ebKKg==
X-Received: by 2002:a17:903:228b:b0:1bb:e71f:793c with SMTP id b11-20020a170903228b00b001bbe71f793cmr4666954plh.44.1695256700664;
        Wed, 20 Sep 2023 17:38:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id ij27-20020a170902ab5b00b001bd41b70b65sm111056plb.49.2023.09.20.17.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 17:38:19 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qj7hx-003RjF-0J;
        Thu, 21 Sep 2023 10:38:17 +1000
Date:   Thu, 21 Sep 2023 10:38:17 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-block@vger.kernel.org
Subject: Re: [syzbot] [xfs?] INFO: task hung in clean_bdev_aliases
Message-ID: <ZQuQeWm3UIn31ciq@dread.disaster.area>
References: <000000000000e534bb0604959011@google.com>
 <ZPeaH+K75a0nIyBk@dread.disaster.area>
 <CANp29Y4AK9dzmpMj4E9iz3gqTwhG=-_7DfA8knrWYaHy4QxrEg@mail.gmail.com>
 <20230908082846.GB9560@lst.de>
 <CANp29Y5yx=F1w2s-jHbz1GVWCbOR_Z-gS488L6ERbWQTAX5dRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y5yx=F1w2s-jHbz1GVWCbOR_Z-gS488L6ERbWQTAX5dRQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 20, 2023 at 10:56:56AM +0200, Aleksandr Nogikh wrote:
> # set subsystems: iomap

No. As I said when I originally reassigned this from XFS to the
block subsystem, this is a regression caused by changes to the block
device code. Just because that overall change was to use iomap for
block devices, that doesn't make it an iomap regression or the
responsibility of XFS or iomap maintainers to triage and fix this
block device regression.

> On Fri, Sep 8, 2023 at 10:28 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Sep 06, 2023 at 07:20:15PM +0200, Aleksandr Nogikh wrote:
> > >
> > > The reason why syzbot marked this report as xfs is that, per
> > > MAINTAINERS, fs/iomap/ points to linux-xfs@vger.kernel.org. I can
> > > adjust the rules syzbot uses so that these are routed to "block".
> > >
> > > But should MAINTAINERS actually also not relate IOMAP FILESYSTEM
> > > LIBRARY with xfs in this case?
> >
> > I'd tag it with iomap, as it's a different subsystem just sharing
> > the mailing list.  We also have iommu@lists.linux.dev for both the
> > iommu and dma-mapping subsystems as a similar example.
> >
> > But what's also important for issues like this is that often the
> > called library code (in this case iomap) if often not, or only
> > partially at fault.  So capturing the calling context (in this
> > case block) might also be useful.

Which is exactly what Christoph also said.

Please don't conflate a discussion about the incorrect assignment
by syzbot (i.e. associating iomap with XFS because of a shared
mailing list) with the actual problem that was initially reported.

So, set this back to the block subsystem where it actually belongs.

#syz set subsystems: block

-Dave
-- 
Dave Chinner
david@fromorbit.com
