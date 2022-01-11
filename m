Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDD5C43219
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 20:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiAKUWD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 15:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiAKUWC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 15:22:02 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAA6C06173F
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 12:22:02 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id hv15so851799pjb.5
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 12:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FwRE6lWGEei45bkbMJKeSP3Ud1XwG78sUDvZWgOWgpo=;
        b=cjzdDhMq5PVoq65mBc5qeuyiZFFdVdMaVzlF66W+jYzN7SAeFYI+z7X68c8D05b+eb
         AUIKlWMpCDZEhOa0wUgKUzDKs971LKDdwfYnyq87X2rHdCzB7Djk+CRpNwvFbHEBQS0r
         mhta2JxLCwm99SAb+n5p9+LUROFrash/1mz2zJKWdE9kbFp7LHaiu5mpR5aUjueNX+OE
         xhsYe0stuWCucbA0XyMwNphRb3qpVxW+235kdg6kvUGHnp/E0VfXD45nWnbBFdSjsDso
         I8iXL4zF8cdcg5uWt5of0FuMgCDkidGdWM+566+9Up6yMrLIiyu8T1sSja+jNUwNwElz
         kZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FwRE6lWGEei45bkbMJKeSP3Ud1XwG78sUDvZWgOWgpo=;
        b=zmYaXmugFdtvcX419eE40WxLJjn4/uYI0wf4IqUb9S5h4aBlbbXP1BKswDwfNm6Ycr
         dyt2tSKc3ivwrZmtDVt3946wWz4YBK8pFqk9uG38vu+OxcSHJW01vQgIlHnJFg+yoV8r
         9TMT6n4TCr1Sjwq9B45FZ21BEDdU57dEOzxv18VhmNiT50lgM7ylJ3frWHyBDXk7QbTU
         ZF9wsFTftGcWNEJRJZSf0iSVDfDtAtS5UyKkhFkNvNeF0rnDjYy04YKKfsciOq3GzM0+
         wviUKhpAhD4q6GK3f6kgDx36AEUsw8ZqNRQcPInBG2lRIsKsJHX7WSLVl1uMZEPHuya9
         67Vg==
X-Gm-Message-State: AOAM533PTQMJQbov6WHuf8WwEJxFe4vvMsEnHXiRPfijX6ZtsXDParE0
        cjcxaT+6TLJ7ASRt1Wp7Rhk=
X-Google-Smtp-Source: ABdhPJxtm4p16eLqvWbpcaznKxK781NoOA7XdbozbbQmSuwmCZr+fWSSn7Kc4rLWEPu32xzYvTmCZw==
X-Received: by 2002:aa7:9094:0:b0:4bd:8f39:236e with SMTP id i20-20020aa79094000000b004bd8f39236emr6092357pfa.35.1641932522088;
        Tue, 11 Jan 2022 12:22:02 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4f0e:ffc8:3f7b:ac89])
        by smtp.gmail.com with ESMTPSA id q13sm11581369pfj.65.2022.01.11.12.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:22:01 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 11 Jan 2022 12:21:59 -0800
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
Message-ID: <Yd3m55+d2edO2I4p@google.com>
References: <20220105233440.63361-1-mfo@canonical.com>
 <Yd0oLWtVAyAexyQc@google.com>
 <Yd3SUXVy7MbyBzFw@google.com>
 <e75c8f37-782f-f4d4-b197-8fda18090b42@nvidia.com>
 <Yd3mfROPwP72QPt3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd3mfROPwP72QPt3@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 11, 2022 at 12:20:13PM -0800, Minchan Kim wrote:
< snip >
> > > slow path with __gup_longterm_unlocked and set_dirty_pages
> > > for them).
> > > 
> > > This approach would solve other cases where map userspace
> > > pages into kernel space and then write. Since the write
> > > didn't go through with the process's page table, we will
> > > lose the dirty bit in the page table of the process and
> > > it turns out same problem. That's why I'd like to approach
> > > this.
> > > 
> > > If it doesn't work, the other option to fix this specific
> > > case is can't we make pages dirty in advance in DIO read-case?
> > > 
> > > When I look at DIO code, it's already doing in async case.
> > > Could't we do the same thing for the other cases?
> > > I guess the worst case we will see would be more page
> > > writeback since the page becomes dirty unnecessary.
> > 
> > Marking pages dirty after pinning them is a pre-existing area of
> > problems. See the long-running LWN articles about get_user_pages() [1].
> 
> Oh, Do you mean marking page dirty in DIO path is already problems?

                  ^ marking page dirty too late in DIO path

Typo fix.
