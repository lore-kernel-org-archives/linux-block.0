Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00449C433EF
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 14:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E325F61373
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 14:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbhJDOhK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Oct 2021 10:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbhJDOhJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Oct 2021 10:37:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D83C061745
        for <linux-block@vger.kernel.org>; Mon,  4 Oct 2021 07:35:20 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id p13so37584102edw.0
        for <linux-block@vger.kernel.org>; Mon, 04 Oct 2021 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DGtFGDUfMevqWirZ/ziCiuJVGFIHXAXrgxKQ7OAmNJA=;
        b=gr2t1ZwAMDg23O/kbMJjckG7d6oZGGMr/690Lw+TK3EFwN0N3Hf9a9HJexGD0dmmts
         IGAT4EAHFqHGCTF1IXyuaWjtnX/7e0mUTghTdVF10dCMIhAkbYc22MRt1NKx23mNQjy9
         ekJ3dog9szhYoO7WRHwqjH4gnilnk1iuAwY0Ba3LtuYkvXg2E12dXTIlognKsxZQFgce
         pqLO0ZP9EP02HRIEamCKhRX9Jk2i6I4djF16e98MvRvjSD9Lxfen17JrApSfpFK34RHW
         aulhq3li0iD0HJS42bp64+3ZmYFExG4VpUEH1bRvJVLy9xDeXlYTid0wn3wovlLIT5E6
         T1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGtFGDUfMevqWirZ/ziCiuJVGFIHXAXrgxKQ7OAmNJA=;
        b=LzyBlruVtkagx7pDp+28cYYGy2JSR7D54q2lhlozlhJyuHuuNpVII1u18giF4dz1y7
         1YQ14zvqZHVkt/IuUXqfYhGMos4phxe18RsCrBZdTjYfAm0eb6B1epCqLZFVhO8sw9mp
         kWaPZsUmfYyr64QL7MEEkgfnQpdbceTj1zp3rQRWfJQfbF3MOjv3O6l+KQ3f/1qaSlLc
         7HLRUZ/oYEMcTyJwI1zpQP0vUzGg7NA3GtKVPbcMkOXQ/Wnc1mbBRCIaZsAG3YylDRya
         yRyjbVrBcxE6llxe/hyj0IqYnEQndtNKjgnif9DNS2NS8O3A0VwsXunyC6yrIl3jQivJ
         iENA==
X-Gm-Message-State: AOAM533VQoL6OmPkWS+7CHefrkgrto71qcenautYoGF2WiefYzIPKTXL
        zih3W2tCo4rKYgs6QEjt4+oBuNXg1IRH/6KvMG6eoA==
X-Google-Smtp-Source: ABdhPJwaWcqHUCHx20tHs9XuzZxMBOqv86kmZT12gZmuTNPTRvALwQ332GXGLjMEOjhTgz/k9oIcYW5n5jITJz+h54g=
X-Received: by 2002:aa7:c911:: with SMTP id b17mr9274547edt.5.1633358017613;
 Mon, 04 Oct 2021 07:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211001181627.394921-1-bgeffon@google.com> <20211001162204.f8d20e62e8b528f5e2e5fa3e@linux-foundation.org>
In-Reply-To: <20211001162204.f8d20e62e8b528f5e2e5fa3e@linux-foundation.org>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 4 Oct 2021 10:33:01 -0400
Message-ID: <CADyq12yGoOHbYNF_9DOTS5jW0nDmT_UgY2ZGwmd5AidvVaG9RQ@mail.gmail.com>
Subject: Re: [PATCH] zram: Allow backing device to be assigned after init
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 1, 2021 at 7:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri,  1 Oct 2021 11:16:27 -0700 Brian Geffon <bgeffon@google.com> wrote:
>
> > There does not appear to be a technical reason to not
> > allow the zram backing device to be assigned after the
> > zram device is initialized.
> >
> > This change will allow for the backing device to be assigned
> > as long as no backing device is already assigned. In that
> > event backing_dev would return -EEXIST.
>
> Why is this useful?

Hi Andrew,
In the case of ChromeOS we're backing zram with a loop device. For us,
having the ability to size the backing file after the system has fully
booted proves to be very useful. Also, doing so later allows us to
place users in different experimental groups while we evaluate the
performance of swapping to disk in the wild. Both of these things
would be much harder if we did it early on when swap is first brought
up or would require us to delay starting swap altogether.

Brian
