Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1596C433EF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 21:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiFAVno (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 17:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiFAVnl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 17:43:41 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABCA2C133
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 14:43:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n28so3905132edb.9
        for <linux-block@vger.kernel.org>; Wed, 01 Jun 2022 14:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rROPJDXC0BSDIKkq62Y3eAfugF0fDNsfhrQHzbt7NtU=;
        b=XKSko4kOJRH2iwn+HXhyRF2svcP+8l8SfsNelRJReLTOwZ7qnLYbsMr+QjAieLw2Pa
         +3osXaE4YAQKEViXnvbKDndD/U3DIdouDaZz8ANy/yaIDy2iwE3tLkdMVML/ZbesLUFi
         1diYZRV7ROKmXYdETmNvVpEak/Kot8Mg6OrZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rROPJDXC0BSDIKkq62Y3eAfugF0fDNsfhrQHzbt7NtU=;
        b=pHThJjMiIVshvRrEs1W4t4cmqkz7n82qBZEDsMGkCHqXHxZe5vZkntqPe4VFMyUvHg
         eZBMEkgi5DbowtKg/9+ODSABm9N50TawD4gY4YEQP9t9k4H5J4HEfmgL0Uiy9HWgWe3w
         neKTW556/CHpYR3dg2yoOa+ryDfaUuv5oSashOa6EkUEVWWolcXkD5oUdSkEAowINwoG
         13GnZBtI8hvKOi0fS6QAKUJmJawX7RVYFUAyHKqaCRiWyqIdbxIpOfXpZetF0s18D5cX
         46MTO1DA/hLRbmWfvUsz4JEL8B9iWzVp+lJelAapbGABuZL4n23nndwVmj4c+QspvB7h
         OF/w==
X-Gm-Message-State: AOAM532hclTibc38q6q7eLuBiUvotMlZmDXCVVzveOXY0ha3og2qSEpv
        VxbszqZ/rD+XF7k3dcOlK4KzLKgsX2w+rTIt
X-Google-Smtp-Source: ABdhPJw7QYAiwqpQ7yMYHJnYMgkQqKwRGl+nindbUoEUPv9PRKdVv8+/lvuVZvodOvfEoyXNHYr/Xg==
X-Received: by 2002:a05:6402:40d4:b0:42b:3203:aafe with SMTP id z20-20020a05640240d400b0042b3203aafemr1955279edb.376.1654119818219;
        Wed, 01 Jun 2022 14:43:38 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id a2-20020a1709062b0200b0070569ed5429sm1090992ejg.55.2022.06.01.14.43.36
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 14:43:36 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id p10so4023398wrg.12
        for <linux-block@vger.kernel.org>; Wed, 01 Jun 2022 14:43:36 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr1083904wrz.281.1654119816176; Wed, 01
 Jun 2022 14:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <YpfTQgw6RsEYxSFD@redhat.com>
In-Reply-To: <YpfTQgw6RsEYxSFD@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jun 2022 14:43:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTOB7yuygFwz64xFHYthwdTOYoC=L2kM4k1GW2a80uNQ@mail.gmail.com>
Message-ID: <CAHk-=wjTOB7yuygFwz64xFHYthwdTOYoC=L2kM4k1GW2a80uNQ@mail.gmail.com>
Subject: Re: [git pull] device mapper fixes for 5.19-rc1
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     device-mapper development <dm-devel@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Alasdair G Kergon <agk@redhat.com>,
        Sarthak Kukreti <sarthakkukreti@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 1, 2022 at 1:59 PM Mike Snitzer <snitzer@kernel.org> wrote:
>
> ----------------------------------------------------------------
> - Fix DM core's dm_table_supports_poll to return false if no data
>   devices.

So looking at that one (mainly because of the incomprehensible
explanation), I do note:

 (a) the caller does

        for (i = 0; i < t->num_targets; i++) {
                ti = t->targets + i;

    while the callee does

        unsigned i = 0;

        while (i < dm_table_get_num_targets(t)) {
                ti = dm_table_get_target(t, i++);

Now, those things are entirely equivalent, but that latter form is
likely to generate horribly bad code because those helper functions
aren't some kind of trivial inline, they are actually normal functions
that are defined later in that same source file.

Maybe a compiler will do optimizations within that source file even
for functions that haven't been defined yet. Traditionally not.

Whatever. Probably not a case where anybody cares about performance,
but it does strike me that the "use abstractions" version probably not
only generates worse code, it seems less legible too.

Very odd pattern.

 (b) The commit message (which is why I started looking at this) says
that it used to return true even if there are no data devices.

     But dm_table_supports_poll() actually _still_ returns true for at
least one case of no data devices: if the dm_table has no targets at
all.

So I don't know. Maybe that is a "can't happen". But since I looked at
this, I thought I'd just point out the two oddities I found while
doing so.

                    Linus
