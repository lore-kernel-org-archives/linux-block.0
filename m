Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931EBC433EF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 21:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244337AbiAKV7u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiAKV7u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 16:59:50 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BC2C06173F
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 13:59:49 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso7868901pjm.4
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 13:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4d36RkzytXf0AgHZAiUJdXMpTmlRY0RoMET8pPsPvK0=;
        b=LGd1jH+zfdPsEcPidDrJ0DVRR4MjhIWo1GWAUUtBAd8WFzU0bN8xR3cY8Q1y5rCn0G
         Tel+J2RbldSK6/GMpRPS9ML+zYKLZRPTzH8mpKFRyIGiFqNeFVRTtTcar5GEpLsTja+/
         3plP//t/Zlpq3FpZcan8Vq6n5gUvpDA9QXrFHGu2cLUWIwfVtT5pJP+hlOXwmyVxSDfS
         LXkYUTm20TeDHTd83XcU1urJ5U3WnMJmXMlC5B3Hma+aJicIBsqtz+NSsz9OwKgNgNJf
         8/UbFu4of/WHopTxp+n6wH1uOV5oAwdKrSiF5agsVRZ55cRjmfYBFeQBZIdD32P8Przw
         8qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=4d36RkzytXf0AgHZAiUJdXMpTmlRY0RoMET8pPsPvK0=;
        b=zdbtKiFJXpr48+MrpmMwIMrqggGuaOtr/xalCkihaEIFwJWRy3rv62v7+iKOiRB9mg
         +UqJNjfLOromSNw57xJvq68S6JmSo42kbbjofmqIdBHCXeiU7LqgN8Nn0BSOsfw3knKP
         QsFgqDj/wxxo2A90aVt0U2wiNiG8y0U7c7riFkrRbKQ1mvVP3ja7h4rKJIrXGTtCeX4N
         gxs1sT2C/C2mGB6knhMy7iiKyIJCwda2AYlqyRo6aludyTLdS+7FuOvdpx02NixZgvFb
         uehZJpAsoyHjFWw7/npouXj67XkVAaZsvNFjvj7FJd7feUQbfdwB8bvmRKspZiXMRAis
         /Nvw==
X-Gm-Message-State: AOAM532whmRzQzzr5W/Agc//N0Fzoai0HD/8uXpDm6efHCVr6K1bQPTQ
        WX92lJrLppQ8t8jstIMdtUg=
X-Google-Smtp-Source: ABdhPJyeC53hc0Mjhmw1IVlh6Gi1bTzao6f/P9GnEVnDagcJ383FsXEMOfHhKiCIPRTYPatWVsXgHg==
X-Received: by 2002:a17:902:d485:b0:14a:4ba5:6e64 with SMTP id c5-20020a170902d48500b0014a4ba56e64mr6535979plg.152.1641938389214;
        Tue, 11 Jan 2022 13:59:49 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4f0e:ffc8:3f7b:ac89])
        by smtp.gmail.com with ESMTPSA id l12sm11764682pfc.181.2022.01.11.13.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:59:48 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 11 Jan 2022 13:59:47 -0800
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
Message-ID: <Yd39019io71DHbVq@google.com>
References: <20220105233440.63361-1-mfo@canonical.com>
 <Yd0oLWtVAyAexyQc@google.com>
 <Yd3SUXVy7MbyBzFw@google.com>
 <e75c8f37-782f-f4d4-b197-8fda18090b42@nvidia.com>
 <Yd3mfROPwP72QPt3@google.com>
 <Yd3m55+d2edO2I4p@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yd3m55+d2edO2I4p@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 11, 2022 at 12:21:59PM -0800, Minchan Kim wrote:
> On Tue, Jan 11, 2022 at 12:20:13PM -0800, Minchan Kim wrote:
> < snip >
> > > > slow path with __gup_longterm_unlocked and set_dirty_pages
> > > > for them).
> > > > 
> > > > This approach would solve other cases where map userspace
> > > > pages into kernel space and then write. Since the write
> > > > didn't go through with the process's page table, we will
> > > > lose the dirty bit in the page table of the process and
> > > > it turns out same problem. That's why I'd like to approach
> > > > this.
> > > > 
> > > > If it doesn't work, the other option to fix this specific
> > > > case is can't we make pages dirty in advance in DIO read-case?
> > > > 
> > > > When I look at DIO code, it's already doing in async case.
> > > > Could't we do the same thing for the other cases?
> > > > I guess the worst case we will see would be more page
> > > > writeback since the page becomes dirty unnecessary.
> > > 
> > > Marking pages dirty after pinning them is a pre-existing area of
> > > problems. See the long-running LWN articles about get_user_pages() [1].
> > 
> > Oh, Do you mean marking page dirty in DIO path is already problems?
> 
>                   ^ marking page dirty too late in DIO path
> 
> Typo fix.

I looked though the articles but couldn't find dots to connetct
issues with this MADV_FREE issue. However, man page shows a clue
why it's fine.

```
       O_DIRECT  I/Os should never be run concurrently with the fork(2) system call, if the memory buffer is a private map‐
       ping (i.e., any mapping created with the mmap(2) MAP_PRIVATE flag; this includes memory allocated on  the  heap  and
       statically  allocated  buffers).  Any such I/Os, whether submitted via an asynchronous I/O interface or from another
       thread in the process, should be completed before fork(2) is called.  Failure to do so can result in data corruption
       and  undefined  behavior  in parent and child processes.

```

I think it would make the copy_present_pte's page_dup_rmap safe.
