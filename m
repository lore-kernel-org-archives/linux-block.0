Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07FDC433EF
	for <linux-block@archiver.kernel.org>; Tue,  1 Feb 2022 02:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiBACYG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jan 2022 21:24:06 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:43652
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbiBACYG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jan 2022 21:24:06 -0500
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DF0B33F1A3
        for <linux-block@vger.kernel.org>; Tue,  1 Feb 2022 02:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643682244;
        bh=HNbqgIyTl4U/xKe4xsBZV50k1Yf+Ba7ETVwZMbT4bZs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Grz7+EIkDYowm3GbDM09KUFHdqInhvOGV5yeddvIwhgoA3+HtZnTj9bJNEsjkB2aq
         0dMLRZEKiL4/vTaT+9UjWFIB2rm5Wqnd4Q8TwkvyUCJd6NYoSM+C4VGYq80qmwDI7B
         cvlyaAWhP/95SUDshWOXuFJhUsuWzwZ13/XcNe/ujvcjTcb1Nj/0Fqt6E3iYzp0heh
         zGvGwM1EV0jse/fakd4+lkxCrwndiZUYcfQbEBoJnqAOPcM71mRkiCHJ6f1PMFAReK
         SM5pn85ZlUJ8eYoIB6U+0MgZFMikeJPhjO6j0nIv7fkYCIMR4BqAmLFmR+RwcgrmJa
         m/u/Rs4793gzQ==
Received: by mail-pj1-f69.google.com with SMTP id mn21-20020a17090b189500b001b4fa60efcbso797767pjb.2
        for <linux-block@vger.kernel.org>; Mon, 31 Jan 2022 18:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNbqgIyTl4U/xKe4xsBZV50k1Yf+Ba7ETVwZMbT4bZs=;
        b=ya2BEdODNvwaqFxlWRPHekDJKtis8xT0oM6MW2huaeiBvx/jJjS9Bd64aOdfhFP6LW
         hUHQlkjTRseEqj3kiY+ICt1tHg7rrg5hNJ1vS4GiLE5gKRuqkJH2lfS2TjoJmsl1f51J
         sJyZVofsEFXUxsDVmAaRVhzWHF4FgqsLrb1BatDogNap4JcvbP0A2sj0L14nkn3AMVbT
         k4ayqm0WqlN0BdTcbS6yB0tk1NzA+xD7N+bW2F9Xc+b7Bq3CbGAVJiK0qLOJSSNJ5P32
         jv24NiBpOifcp742/iTMeAXVzkDc96ECOKzgxFJAvwla6lpwMpmbt4rlNqhogzikwHGq
         jHCA==
X-Gm-Message-State: AOAM532uJJq914PTbiwx2sWoJri1i2OUpV8liiJ35AA6aMQjP5OhJuVI
        aced/pRtWjuf2cbDrCYgW+pI+u46ixDzAbg2MMQ3NjMQ1HsJMQ4dgnKyBxb7HWwDZ7ftfvhxZ89
        KC24cr0qnDH6beAxEOF44JzoO8MWQpHDuBq+wlVqU61+lW0EEu/v2erH7
X-Received: by 2002:a17:902:c412:: with SMTP id k18mr23673511plk.142.1643682243186;
        Mon, 31 Jan 2022 18:24:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUpLi1Kj9iW2239Gl4OCQo7sqjVsLCdg+wb37W63kLcV8MTz5K+4G0SF2M2xMZ1pGQgsrwVqJZb6NZCuH2H+M=
X-Received: by 2002:a17:902:c412:: with SMTP id k18mr23673491plk.142.1643682242961;
 Mon, 31 Jan 2022 18:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20220131230255.789059-1-mfo@canonical.com> <20220131154340.e65ebe932d8933bc68c4ddf4@linux-foundation.org>
In-Reply-To: <20220131154340.e65ebe932d8933bc68c4ddf4@linux-foundation.org>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Mon, 31 Jan 2022 23:23:50 -0300
Message-ID: <CAO9xwp16-q-Ow29VVmTY-wRUtK4wZ+o_pfm+MmNhX4tP1-1=eg@mail.gmail.com>
Subject: Re: [PATCH v3] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 31, 2022 at 8:43 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 31 Jan 2022 20:02:55 -0300 Mauricio Faria de Oliveira <mfo@canonical.com> wrote:
>
> > Problem:
> > =======
> >
> > Userspace might read the zero-page instead of actual data from a
> > direct IO read on a block device if the buffers have been called
> > madvise(MADV_FREE) on earlier (this is discussed below) due to a
> > race between page reclaim on MADV_FREE and blkdev direct IO read.
> >
> > ...
> >
> > Fixes: 802a3a92ad7a ("mm: reclaim MADV_FREE pages")
>
> Five years ago.  As it doesn't seem urgent I targeted 5.18-rc1 for
> this, and added a cc:stable so it will trickle back into earlier trees.
>
> How does this plan sound?

That sounds good; it's not urgent, indeed. Thanks!

-- 
Mauricio Faria de Oliveira
