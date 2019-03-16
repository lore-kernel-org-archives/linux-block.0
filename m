Return-Path: <SRS0=01oL=RT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901A5C43381
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 01:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577A921871
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 01:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552700308;
	bh=UfFW7mLzJCigZNffhJkds2/ebDEpdTrZ4sYz0cQb2x4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nbv1W0u7YFei00vRx+qgiE6HQAR97qA3qRvoZ4Us8X0OBhe8evGnPVHGX92ZqWDsv
	 4E9deEBUArSI+ZDVMHlcZCapdmXOkHeWR6na2/nIHEdIKFtduB1XeViD+A5G9iNmdV
	 zH7epWjkcIbzg43jiqLgk5VL6cR3OOxarJccRHy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfCPBez (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 21:34:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45937 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCPBez (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 21:34:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so1225873ljd.12
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 18:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M13FtalC3wZiHNHMJnwtA/ImIg3BtGJsLIdUZ4w922s=;
        b=JvKFCw8qtw+zh3eSsBizhTIYBj7b56eSYlVoyKQwEQy4YhrvSWjlCB9eVruuhcv7c3
         z2S+DmI4J9kzpLD9PrdSGVIhq8L1n4PMD/uWeddTfJKN1OroAXybx0L0ar2p0muzh5+C
         tyZVrheLABSoPJARbL9vPHlZuhzYoutN8vA2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M13FtalC3wZiHNHMJnwtA/ImIg3BtGJsLIdUZ4w922s=;
        b=S83Tw9McAkRYuLhhwYNWeSWEt0EFIrsR05HfPZCZ7rlAQfPTd4P7cNJ+wHaJ47YUiF
         LVpNqs6eMO6XHb1MvpbAl4q8Q9yAFVPhuXY28OCaqP6AbgTuK3v02IphaE/BW/d3Al5C
         BRyuyyhedEF2cUj+Gqzbc/wHryCzeNteE67b1ALwcuaVxz1WEzRwrf1amhdbLSYIT9Ik
         mWFYGZWW7OEj3v/lLWgMnhWEATwRFFzRL0/uCBZ0GXPWa7VYbZngfqOQfFnH3x5nmcfg
         a+amhLoLnkTjRfFtGWaBOGmLGIjhmBt5n7d65zamz9yi74tZwhv+z5KsvK57llUCvkxk
         LNFA==
X-Gm-Message-State: APjAAAU6hRNCsfkxYgTMauHvVN9gLcXsvhFImN71t9WNDIeKvLDgImIH
        +rabVw7Dw7WtYo6GMgzh9IRM/7xKZ1g=
X-Google-Smtp-Source: APXvYqzSmaCzU5eUR0tOEROpjZ5+zkcq0/rHbqHAqfA7GFTRTWqfdC+u1ay+F61JZAhUeWAV3OGMmg==
X-Received: by 2002:a2e:30a:: with SMTP id 10mr2764535ljd.148.1552700093142;
        Fri, 15 Mar 2019 18:34:53 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id t14sm720270lfl.38.2019.03.15.18.34.51
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 18:34:51 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d18so8167726lfn.3
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 18:34:51 -0700 (PDT)
X-Received: by 2002:ac2:424c:: with SMTP id m12mr3927188lfl.62.1552700091266;
 Fri, 15 Mar 2019 18:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190315145938.21516-1-axboe@kernel.dk> <20190315145938.21516-4-axboe@kernel.dk>
 <aa0e7a3a-d7dc-2b6e-5a2c-adf99aab27a6@kernel.dk>
In-Reply-To: <aa0e7a3a-d7dc-2b6e-5a2c-adf99aab27a6@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Mar 2019 18:34:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3iyLvh4L2us0WZc18UPKwFtZYA2L5h3OnP01a+T+59w@mail.gmail.com>
Message-ID: <CAHk-=wg3iyLvh4L2us0WZc18UPKwFtZYA2L5h3OnP01a+T+59w@mail.gmail.com>
Subject: Re: [PATCH 3/3] io_uring: add io_uring_event cache hit information
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 15, 2019 at 9:27 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Linus, curious on your opinion on this one. I had this as part of the
> original series, but removed it from the pull request due to the
> mincore etc discussions.

I'd rather not have new ways to leak cache information, and in fact
already the IOCB_NOWAIT is a bit questionable for that. But afaik, the
non-O_DIRECT paths don't even support it to begin with for some
filesystems.

Wasn't the whole point of this io_ring that we'd move *away* from
direct block access and O_DIRECT?

I'm seeing a lot of stuff that looks like just "more of the same old
O_DIRECT garbage" that seems to be all about thinking that IO doesn't
cache.

Haven't we gotten over that already? It was one of the arguments you
used for io_ring to begin with.

                      Linus
