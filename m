Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D381BC433F5
	for <linux-block@archiver.kernel.org>; Wed,  8 Dec 2021 18:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239388AbhLHSyC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Dec 2021 13:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239391AbhLHSyB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Dec 2021 13:54:01 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947A0C061746
        for <linux-block@vger.kernel.org>; Wed,  8 Dec 2021 10:50:29 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g14so11279039edb.8
        for <linux-block@vger.kernel.org>; Wed, 08 Dec 2021 10:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVu+O4vH5omtpZHli6o4+BSn/vNd8K1dVv76VMkPfw0=;
        b=hxpEnYwFcKlq8sBmKIy6fV/wFHJP+w//gnub12IeP/XY+A4StkFrp8oYTzStdwgW+e
         o5K6lPylJLMKsMrMhwkRVwQUt4NRetfVjq5mpMK9ZdxxBjsDPZMBtpGFmuTRsWxdQO4g
         ltDPV4sSnrogfkVl24vXLNkHxLbxQ1Henxlkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVu+O4vH5omtpZHli6o4+BSn/vNd8K1dVv76VMkPfw0=;
        b=mem0doR+6x8FKxlTIsu+jHbR1PXruhTkK+8nrXwNQ0jgg7EUBjKzBlEImVTQJV43OX
         +Xv7hI0aCzIAfsqq4S6M/mNr1iVnL6ZjEpvp01F8djDUlO+Nqd7/7aJfRqgQTF1cH95I
         gUBZrs/xm+oP33IhR5LG0shXjxS211SXTcv6W3SJw2C4HUEZm/d4/seeld9//jdD+ee3
         7/0TKCxzzPhBfBjb9udsmEC2466Y8wrS7Y+DLrB4ZZ14nob6VBPqNiJSFGTURZXbw731
         8PoT9nemvPmFPQ7d9TGhVnQmQgz4ssqkcj3DEBHvYg0c4p/ki90Ezkbx5DZjApHbBpSa
         kfew==
X-Gm-Message-State: AOAM5337+l742QAxktU8ivz6RjDTogYICiucFrYn5aONHtSz6SSogMvJ
        BIcP5sU+jIwEp2FRj0gY1ot/fT6mBBM1f1yyeYQ=
X-Google-Smtp-Source: ABdhPJyM53Z3ikCRorfCVNHJLQMVTLw0CjKz0aH0X7z1r757EtbwidaTDI4NEZVqTH5yLrgidakPog==
X-Received: by 2002:aa7:ce1a:: with SMTP id d26mr21379426edv.189.1638989427973;
        Wed, 08 Dec 2021 10:50:27 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id h10sm2428085edj.1.2021.12.08.10.50.26
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 10:50:26 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id o13so5645727wrs.12
        for <linux-block@vger.kernel.org>; Wed, 08 Dec 2021 10:50:26 -0800 (PST)
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr580297wrn.318.1638989426416;
 Wed, 08 Dec 2021 10:50:26 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net> <20211207202831.GA18361@worktop.programming.kicks-ass.net>
 <CAHk-=wg=yTX5DQ7xxD7xNhhaaEQw1POT2HQ9U0afYB+6aBTs6A@mail.gmail.com>
 <YbDmWFM5Kh1J2YqS@hirez.programming.kicks-ass.net> <CAHk-=wiFLbv2M9gRkh6_Zkwiza17QP0gJLAL7AgDqDArGBGpSQ@mail.gmail.com>
 <20211208184416.GY16608@worktop.programming.kicks-ass.net>
In-Reply-To: <20211208184416.GY16608@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Dec 2021 10:50:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg6reEPRY6ZDNA=3=cGRyK1csKhw0p3Ug57Z9by_Ev9Hw@mail.gmail.com>
Message-ID: <CAHk-=wg6reEPRY6ZDNA=3=cGRyK1csKhw0p3Ug57Z9by_Ev9Hw@mail.gmail.com>
Subject: Re: [PATCH] block: switch to atomic_t for request references
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 8, 2021 at 10:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> From testing xadd had different flags from add; I've not yet looked at
> the SDM to see what it said on the matter.

That should not be the case. Just checked, and it just says

  "The CF, PF, AF, SF, ZF, and OF flags are set according to the
result of the addition, which is stored in the destination operand"

which shows that I was confused about 'xadd' - I thought it returned
the old value in the register ("fetch_add"). It doesn't. It returns
the new one ("add_fetch"). And then 'fetch_add' ends up undoing it by
doing a sub or whatever.

So the actual returned value and the flags should match on x86.

Other architectures have the "return old value" model, which does mean
that my "different architectures can have different preferences for
which one to test" argument was right, even if I got xadd wrong.

               Linus
