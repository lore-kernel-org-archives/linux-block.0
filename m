Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734FDC433EF
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 00:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343628AbiALABL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 19:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiALABL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 19:01:11 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B76C06173F
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 16:01:11 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id t18so1324140plg.9
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 16:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=72DjrFB46ccE7PgvOtFUW6osXTrjWGV/9wfVer6QRWI=;
        b=SrGKT6YIfMXA8iCawqnOatf3gyv8mY+IHiM8oZ2c7xSKn6LIeGUWHchOaynAob/fqm
         s/P4ZLB+LOyHpPzZ5g6OWTaISa/MwfwB6S/+fg8EADLKlwSxYiBVsrkRVGMGxdVtAJgT
         Adxn9lsZvDdteWn4trFUhxneA36WWS7BoHMc4tqJnFF8/VECZ3IZmjNz7mPCblGzgDDc
         FdEF0jdhKGoiUcnPNI9xEB45kfK02y7+HajE3sNCtKgd/f4EOJ18ILaypMQWlcAmBS8Q
         UxNfg31t5StzcRvTjLxkmR7/VF2BEGSa44eQi7DAS7nhSm4/hwK0WF8v+R4lgWqeP+Us
         ozxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=72DjrFB46ccE7PgvOtFUW6osXTrjWGV/9wfVer6QRWI=;
        b=KGC4FxbVmU7Au7mOYuP5TZ6aDOi2gr2CL5KsV3FRyqRzaKtcdvnp99uzTyXSKo880M
         8V58Hg3cKA5h2KzughbJ5tO+1Lc5WsiOPJ7lCQvcurFM1b+Mxa0Aor/VFvHN6jEQ7DsG
         q8llXdJBALuDO44p+GXbKLr0lfGROwFI8YxU/sxyqlksxPwNgQGnsquDJ+snbV9wY5Mv
         dOqDWNJoH+Y2gIEh/ntUObefde6rXmHqKlIUO0kW7WwztwCM3Sn6Lw+atpnuSpkv9y56
         wM0UTXP6t4N/aVryK+LphqDD0SgAIBzFkgonZAuu6Ds9DEg+9WMJCETJyX62ambXt5z6
         NrVQ==
X-Gm-Message-State: AOAM532Dw6kOCLImdEw4o17PwzGDEuflNMWgN9gWVvsi5Ll8q1J25fQv
        DnQtLPs7lR/HKiTreFurczM=
X-Google-Smtp-Source: ABdhPJyHEaxX5rDvVsr8if/O0BHZoabBbIqlbgJGVmpHhgUmZOB0RB8mbyfeDjG1+peavMGMG/8vkA==
X-Received: by 2002:a63:b909:: with SMTP id z9mr6282962pge.26.1641945670424;
        Tue, 11 Jan 2022 16:01:10 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4f0e:ffc8:3f7b:ac89])
        by smtp.gmail.com with ESMTPSA id h5sm11805982pfi.46.2022.01.11.16.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 16:01:08 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 11 Jan 2022 16:01:06 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
Message-ID: <Yd4aQjqo4E75qYWQ@google.com>
References: <20220105233440.63361-1-mfo@canonical.com>
 <Yd0oLWtVAyAexyQc@google.com>
 <Yd3SUXVy7MbyBzFw@google.com>
 <e75c8f37-782f-f4d4-b197-8fda18090b42@nvidia.com>
 <Yd3mfROPwP72QPt3@google.com>
 <Yd3m55+d2edO2I4p@google.com>
 <Yd39019io71DHbVq@google.com>
 <7094dbd6-de0c-9909-e657-e358e14dc6c3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7094dbd6-de0c-9909-e657-e358e14dc6c3@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 11, 2022 at 03:38:24PM -0800, John Hubbard wrote:
> On 1/11/22 13:59, Minchan Kim wrote:
> ...
> > > > > Marking pages dirty after pinning them is a pre-existing area of
> > > > > problems. See the long-running LWN articles about get_user_pages() [1].
> > > > 
> > > > Oh, Do you mean marking page dirty in DIO path is already problems?
> > > 
> > >                    ^ marking page dirty too late in DIO path
> > > 
> > > Typo fix.
> > 
> > I looked though the articles but couldn't find dots to connetct
> > issues with this MADV_FREE issue. However, man page shows a clue
> 
> The area covered in those articles is about the fact that file system
> and block are not safely interacting with pinned memory. Even today.
> So I'm trying to make sure you're aware of that before you go too far
> in that direction.
> 
> > why it's fine.
> > 
> > ```
> >         O_DIRECT  I/Os should never be run concurrently with the fork(2) system call, if the memory buffer is a private map‐
> >         ping (i.e., any mapping created with the mmap(2) MAP_PRIVATE flag; this includes memory allocated on  the  heap  and
> >         statically  allocated  buffers).  Any such I/Os, whether submitted via an asynchronous I/O interface or from another
> >         thread in the process, should be completed before fork(2) is called.  Failure to do so can result in data corruption
> >         and  undefined  behavior  in parent and child processes.
> > 
> > ```
> > 
> > I think it would make the copy_present_pte's page_dup_rmap safe.
> 
> I'd have to see this in patch form, because I'm not quite able to visualize it yet.

It would be great if you read though the original patch
description. Since v2 had a little change to consider
mutiple maps among parent and child, it would introduce a little
mistmatch with the description but it's still quite good to explain
current problem.

https://lore.kernel.org/all/20220105233440.63361-1-mfo@canonical.com/T/#u

Problem is MADV_FREEed anonymous memory is supposed to work based on
dirtiness came from the user process's page table bit or PageDirty.
Since VM can't see the dirty, it just discards the anonymous memory
instead of swappoing out. Thus, the dirtiness is key to work correctly.

However, DIO didn't make the page Dirty yet until IO is completed
and at the same time, the store operation didn't go though via
user process's page table regardless of DMA or other way.
It makes VM could decide just drop the page since it didn't see
any dirtiness from the page. So it turns out enduser would be
surprised because the read syscall with DIO was completed but
the data was zero rather than latest uptodate data.

To prevent the problem, the patch suggested to compare page_mapcount
with page_count since it expects any additional reference of the page
means someone is doing accessing the memory so in this case, not
discarding the page. However, Yu pointed out page_count and
page_mapcount could be reordered in copy_page_range, for example.
So I am looking for the solution(one would be adding memory barrier
right before page_dup_rmap but I'd like to avoid it if we have
other idea). And then man page says forking under going DIO would
be already prohibited so the concern raised would be void, IIUC.

Hope this helps your understanding.
Thanks!

work 
