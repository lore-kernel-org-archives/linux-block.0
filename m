Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8145C433EF
	for <linux-block@archiver.kernel.org>; Tue,  4 Jan 2022 11:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiADL5r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:57:47 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58904
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230292AbiADL5q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Jan 2022 06:57:46 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8769F3F1B0
        for <linux-block@vger.kernel.org>; Tue,  4 Jan 2022 11:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641297465;
        bh=TTSxXc2RKt32xiQ39M9Zcwu4JZ3xGkPo+vBRnWQ78JM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=TXOscMIK4MkE3gcyF8NDbIbGq2yLLSyQjWgHjGxrorNVZ3ZpgUY8XmiktHxXrQQCv
         QXSPupy1iOiG3vt148THHXaSMbSZpShZ+rdTSdPzNh1tHQM/knxXi8LXgfOzD2peFM
         vQ3KTa2iMRWYYx/CScj2kpJ+ru0b0pN3V8A1poXGFGYtlNBs9GZTZWIiv26tHQzVCY
         ProLMFqOFXXR02BuDMvn+JBWyxJXMZotnDIB1f7Iov1lp5TNqZW0ZLrUoKtrFO8yWS
         AeXNLFMfA7nkXH7Syy/oCybOGMRs+rF7U6na+Su15Hahag6rSTkbvfrqSfTQhceAGR
         oUtlpA0/9iffQ==
Received: by mail-pj1-f72.google.com with SMTP id r32-20020a17090a43a300b001b2a1644b8dso14327352pjg.4
        for <linux-block@vger.kernel.org>; Tue, 04 Jan 2022 03:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTSxXc2RKt32xiQ39M9Zcwu4JZ3xGkPo+vBRnWQ78JM=;
        b=HvEJyzgmpHQpYzsJald5Aj9mO5A2KFFbhlt2BraP91GL7o2yfjFeUGOiOWwpXjpJ6i
         AukdrHT+sElleyfKCo+072i/i7E8AfoQQivZuS4nokjxxuKcgqusyeY11IqU34sYDJMZ
         uuIWkIErwH8ET4NZJiSKrOcTtLcUd+/R6v3KtS46G7R+9KW2s0ddo7MAuD3Y16kMIDu+
         tRFG8PE0HhqJS3yKqCKXgxQwnUZUtWEqW9HQEbaVuzbqA476QrWvXJ6lqFqLKNV4Juu+
         MH+VKx0/Wsb4H8nQhHdYRmL6+/nvR7yHdeHkembc6U8i+a+Rb/7u1X+4Pn9yDE7bxWrF
         Umxw==
X-Gm-Message-State: AOAM531aelYHWLg6POlpqFggCcJFYSgKTFPVduqs1Q0di6ni9InQ2PlR
        HX55rr1hwdQhNAAu09UMnE9NZbrnNrf9a7JKlwm2E15FjeCIB5832T28hsSinuNReiwXzxN2ueG
        8jiPevCEbvRi08r3O8zKeqAAjd86ZQro7eMXY1Y0dCey60oYwFB7nWcF1
X-Received: by 2002:a17:902:dac7:b0:148:ea85:af4d with SMTP id q7-20020a170902dac700b00148ea85af4dmr48765133plx.131.1641297464071;
        Tue, 04 Jan 2022 03:57:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxU6C6dvrScVurb08yFmZeWpWrS8mICcJPRA1UJmcOFi10MVXzk4xNR4n9ktbQbCqN0fdbA9dFX1k1SJQXPjB0=
X-Received: by 2002:a17:902:dac7:b0:148:ea85:af4d with SMTP id
 q7-20020a170902dac700b00148ea85af4dmr48765113plx.131.1641297463823; Tue, 04
 Jan 2022 03:57:43 -0800 (PST)
MIME-Version: 1.0
References: <20211211022115.1547617-1-mfo@canonical.com> <CAHbLzkoZXHQ2WuuQGafuo0YV_KOML91g2ZkDjyzw_J7E40yVsA@mail.gmail.com>
In-Reply-To: <CAHbLzkoZXHQ2WuuQGafuo0YV_KOML91g2ZkDjyzw_J7E40yVsA@mail.gmail.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Tue, 4 Jan 2022 08:57:32 -0300
Message-ID: <CAO9xwp1zkGRdn1BKoE=Np6BvOQ-G5bzr5URnp2t9_a2PyynYSQ@mail.gmail.com>
Subject: Re: [PATCH] mm: fix race between MADV_FREE reclaim and blkdev direct
 IO read
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Linux MM <linux-mm@kvack.org>, linux-block@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 17, 2021 at 3:51 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Fri, Dec 10, 2021 at 6:22 PM Mauricio Faria de Oliveira
> <mfo@canonical.com> wrote:
...
> > MADV_FREE'd buffers:
> > ===================
> >
> > So, back to the "if MADV_FREE pages are used as buffers" note.
> > The case is arguable, and subject to multiple interpretations.
> >
> > The madvise(2) manual page on the MADV_FREE advice value says:
> > - 'After a successful MADV_FREE ... data will be lost when
> >    the kernel frees the pages.'
> > - 'the free operation will be canceled if the caller writes
> >    into the page' / 'subsequent writes ... will succeed and
> >    then [the] kernel cannot free those dirtied pages'
> > - 'If there is no subsequent write, the kernel can free the
> >    pages at any time.'
> >
> > Thoughts, questions, considerations...
> > - Since the kernel didn't actually free the page (page_ref_freeze()
> >   failed), should the data not have been lost? (on userspace read.)
> > - Should writes performed by the direct IO read be able to cancel
> >   the free operation?
> >   - Should the direct IO read be considered as 'the caller' too,
> >     as it's been requested by 'the caller'?
> >   - Should the bio technique to dirty pages on return to userspace
> >     (bio_check_pages_dirty() is called/used by __blkdev_direct_IO())
> >     be considered in another/special way here?
> > - Should an upcoming write from a previously requested direct IO
> >   read be considered as a subsequent write, so the kernel should
> >   not free the pages? (as it's known at the time of page reclaim.)
> >
> > Technically, the last point would seem a reasonable consideration
> > and balance, as the madvise(2) manual page apparently (and fairly)
> > seem to assume that 'writes' are memory access from the userspace
> > process (not explicitly considering writes from the kernel or its
> > corner cases; again, fairly).. plus the kernel fix implementation
> > for the corner case of the largely 'non-atomic write' encompassed
> > by a direct IO read operation, is relatively simple; and it helps.
...
> IIUC, you are expecting to get the old data after MADV_FREE? TBH, you
> should not expect so at all after MADV_FREE since those pages may get
> freed at any time.

Hey, thanks for checking this.

Correct; the discussion behind this is covered in the text above. It's indeed
arguable, but the fix makes the behavior more consistent for the case of a
direct IO read (rather than potentially returning zero-pages a bit randomly.)

cheers,

-- 
Mauricio Faria de Oliveira
