Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEACC4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 19:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJRTUW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 15:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiJRTUH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 15:20:07 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10173DBE5
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 12:20:01 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id mx8so9941657qvb.8
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 12:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mFa9H1YcgEQ0QJQ6P/vrEWGWEagwD/S4HsG+zs6wkwI=;
        b=EePDupGOXDMX0Amsdt3KkO3ysbX9zyt5oakNbc4i76GaQMl6FVv5E56PrKs0D1zhwV
         nZcG4sxIbVO20KnnXZN+AH5oabUbzeSKlgEdC67IL9ad0Wr6BGBHa5PkOXc3Ojrc6ZR6
         tKbf5WjmJ20ykhY4PufKQqH642kc3Ux9uI17I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFa9H1YcgEQ0QJQ6P/vrEWGWEagwD/S4HsG+zs6wkwI=;
        b=fj9D1ScGRwSD/rytb1WdMixak+pPNjigi+r0VCBvogiUSLshZ4gdpkhCfoz9mi01xo
         Spn0iTkfRPGssySW/lN5hcnG+AKXyLDihWQmXWoqw1vlwSHHaFzIuXQ6F0WJBk5Y1vh0
         4ghjUpTFdeO5XCq/PDD0mC9Y29VkB7oe50R80CcOletox3jLFNC5D4FLDzRKqE6MDHHu
         x7j45ZvdaeNBf7j9lL55Uv2a8M9bc8MJP6nCbugVg2XFAOUxrQ86axa67vSlvAQ0Ns6N
         LtN0sq6nLi7WcMP8oochVnuANG4trmtYNz/a03ymDjKwJcG100YSSxds/riwX1/4yr20
         2Jag==
X-Gm-Message-State: ACrzQf3jKuHbWp3GNRvpmzNM9jDVlLwfADHscTQixiWJxpEla0ljii8n
        RcAibs9iBXOymLODgm44mrigGi1o76T1EA==
X-Google-Smtp-Source: AMsMyM7qMMU0qlo/1UAcCXEK5k64tYeDSTm/Dh/iGTeaLv5ZwLiQLwHtaTkf2xFIYat85gyWsMgEHA==
X-Received: by 2002:a05:6214:f27:b0:4b1:c73a:a990 with SMTP id iw7-20020a0562140f2700b004b1c73aa990mr3775132qvb.24.1666120797927;
        Tue, 18 Oct 2022 12:19:57 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id r10-20020ac85e8a000000b00397101ac0f2sm2469960qtx.3.2022.10.18.12.19.56
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 12:19:56 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-354c7abf786so147341687b3.0
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 12:19:56 -0700 (PDT)
X-Received: by 2002:a0d:fe07:0:b0:360:c3e9:fc8a with SMTP id
 o7-20020a0dfe07000000b00360c3e9fc8amr3888903ywf.441.1666120796403; Tue, 18
 Oct 2022 12:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <Y07SYs98z5VNxdZq@redhat.com> <Y07twbDIVgEnPsFn@infradead.org> <CAHk-=wg3cpPyoO8u+8Fu1uk86bgTUYanfKhmxMsZzvY_mV=Cxw@mail.gmail.com>
In-Reply-To: <CAHk-=wg3cpPyoO8u+8Fu1uk86bgTUYanfKhmxMsZzvY_mV=Cxw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Oct 2022 12:19:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiE_p66JtpfsM2GMk0ctuLcP+HBuNOEnpZRY0Ees8oFXw@mail.gmail.com>
Message-ID: <CAHk-=wiE_p66JtpfsM2GMk0ctuLcP+HBuNOEnpZRY0Ees8oFXw@mail.gmail.com>
Subject: Re: [git pull] device mapper changes for 6.1
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 18, 2022 at 11:54 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But no, we absolutely do *not* want to emulate that particular horror
> anywhere else.

Side note: if DM people go "Hmm, a lot of our management really does
have the exact same issues as 'mount()' and friends, and doing the
same things as mount does with the whole string interface and logging
sounds like a good idea", I want to nip that in the bud.

It's most definitely *not* a good idea. The mount thing is nasty, it's
just that we've always had the odd string interface, and it's just
grown from "const void *data" to be a whole complicated set of context
handling.

So don't even think about duplicating that thing.

Now, if some "inspired" person then thinks that instead of duplicating
it, you really would want to do device mapper *as* a filesystem and
actually using the fsconfig() model directly and natively, that is at
least conceptually not necessarily wrong. At what point does a
"translate disk blocks and munge contents" turn from "map devices into
other devices" to a "map devices into a filesystem"? We've had loop
devices forever, and they already show how filesystems and block
devices can be a mixed concept.

And no, I'm not seriously suggesting that as a "do this instead".

I'm just saying that from an interface standpoint, we _do_ have an
interface that is kind of doing this, and that is already an area
where a lot of people think there is a lot of commonalities (ie a
number of filesystems end up doing their own device mapping
internally, and people used to say "layering violation - please use dm
for that" before they got used/resigned to it because the filesystem
people really wanted to control the mapping).

In the absence of that kind of unification, just use 'errno'.

               Linus
