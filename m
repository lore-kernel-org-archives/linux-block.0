Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D060CC433DF
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 19:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B43207D4
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 19:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="ejWrZ/jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgETTJM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 15:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgETTJK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 15:09:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C21C08C5C0
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 12:09:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id f13so3741249edr.13
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tl5hNSaq9jwtAfQ3H4b6ZmG+ScLEKqnmbeQTtX38GBs=;
        b=ejWrZ/jfJqN1W3XBa5rEh8Lk4R2pGtjUsAfERal12GI7QfCZfWLDd9UtMrTSYE1/tI
         FovDCSwIGfbaaHj8cZJ1IKJDULyXaqYHAyGtIE65kUKbthWtIjz/KQGrx+y85v2kRRQb
         81QOjyfbBp6VHvsSe4y3k88jU+q/CRx/ohQyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tl5hNSaq9jwtAfQ3H4b6ZmG+ScLEKqnmbeQTtX38GBs=;
        b=kdT4RvOlbtX+Ux4qNOIQ53CIfNoxLoPJXbZezcBu3bhiuWDa9GVhKoXbHGcqyHWF7m
         wwITBK6oBL7TtTKX76eIaPERYOgIK0fFWlyLSgDVsdYvLXjSIkdjkx4fwtZVCJZj8Yfl
         oOe7A5DnvEo6/tIIaXD/lUhta5u9qdfsDfQLeyfUA6wc3VsyJO2bdMCUktzEZPvFPh9b
         RbrekK3Udxy5HUb/Y5OT2moRO39tCkn60F4sG0LMn1LDK3jxFa0K4zPdpbtpfd37aAAf
         CpxHWwP5qLyZNqsrYKJXJn5i9/dux6nUMMpx3ruPsuOYCrF4oIrHVgLTD0fF575T3b09
         mg3A==
X-Gm-Message-State: AOAM531Bh6H7jPGneinQR4a1FfDuqHkD/O8Uge5K+zc26zYJoCqgg+zi
        zVnQrSiutulwtKJLjrOz7LMENA==
X-Google-Smtp-Source: ABdhPJweTP3W62AzAZrqweXxsUYkSWvtaZ1Wr8JxuA7F/wzgya+W3/hBf6pFGJ7YDBt9fmp3P99NeQ==
X-Received: by 2002:a50:9312:: with SMTP id m18mr4674386eda.252.1590001748698;
        Wed, 20 May 2020 12:09:08 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:758d])
        by smtp.gmail.com with ESMTPSA id g21sm2514869edw.9.2020.05.20.12.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 12:09:08 -0700 (PDT)
Date:   Wed, 20 May 2020 20:09:06 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, cgroups@vger.kernel.org
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-ID: <20200520190906.GA558281@chrisdown.name>
References: <CA+G9fYu2ruH-8uxBHE0pdE6RgRTSx4QuQPAN=Nv3BCdRd2ouYA@mail.gmail.com>
 <20200501135806.4eebf0b92f84ab60bba3e1e7@linux-foundation.org>
 <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com>
 <20200519075213.GF32497@dhcp22.suse.cz>
 <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz>
 <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Naresh,

Naresh Kamboju writes:
>As a part of investigation on this issue LKFT teammate Anders Roxell
>git bisected the problem and found bad commit(s) which caused this problem.
>
>The following two patches have been reverted on next-20200519 and retested the
>reproducible steps and confirmed the test case mkfs -t ext4 got PASS.
>( invoked oom-killer is gone now)
>
>Revert "mm, memcg: avoid stale protection values when cgroup is above
>protection"
>    This reverts commit 23a53e1c02006120f89383270d46cbd040a70bc6.
>
>Revert "mm, memcg: decouple e{low,min} state mutations from protection
>checks"
>    This reverts commit 7b88906ab7399b58bb088c28befe50bcce076d82.

Thanks Anders and Naresh for tracking this down and reverting.

I'll take a look tomorrow. I don't see anything immediately obviously wrong in 
either of those commits from a (very) cursory glance, but they should only be 
taking effect if protections are set.

Since you have i386 hardware available, and I don't, could you please apply 
only "avoid stale protection" again and check if it only happens with that 
commit, or requires both? That would help narrow down the suspects.

Do you use any memcg protections in these tests?

Thank you!

Chris
