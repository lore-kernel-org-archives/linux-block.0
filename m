Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D372C636D6
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 21:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjBVVfW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Feb 2023 16:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBVVfU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2023 16:35:20 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE08C457DF
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 13:35:18 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b12so36016621edd.4
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 13:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5qgfR8l8zHD6J2nRh6VzEgVP678bdHEIYPro2wGNo60=;
        b=WNnvETrhgQymVUcBHBVjP2CMrfbRITcSyEh2VMn/FgNdiYW+9FxilDkVCMdGIulQ7G
         eC5U8UASsb6+EY/bV8L56YWp4D68J/vBV5TmfP12dGmEUk2x4Ha2mzCtg4xKkym/+1cO
         XMLt90v0Lii45igw1IMTohj3WVcRGJLidYirI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qgfR8l8zHD6J2nRh6VzEgVP678bdHEIYPro2wGNo60=;
        b=rn/VRxbWXWqS6Fk3xFlKNKPitPhbr3oZ+xSGWOIyk128yPTMTYojrmB2Hf1LGT2kYL
         jQN2HZTSGCu3+rRomJaT6It1PnNkzo3IBkI5XWp/wy5elMcCw6+E2GhxJAaFFi9+rRU/
         lCcuDmMMUdIImeoY7Za9yjxlLYUUmk7H0Xcn39qtQ8oD0hFDTkYZPktUcOtnrQ2op4BJ
         SN1w2vYZmSkZ5mYWrjscl4WVG5gOQpt4h43ihkQU3FaCDbt89vEoqcG4kWY+khxzq+Vi
         zShCWD/P8yMVDMpkO/ayb+vkFtXw3h0kXbM+YpGfjXNHNqsAjZhXdmnxL3cyVZoomnGm
         jN0g==
X-Gm-Message-State: AO0yUKWB6MNH/uXXfhCSkMHkjeh0hg+RI1Ag2n+pSZXn7sPLEs7850Zn
        akHW6UuMcoi2+NS9eEi+plO9MtlYUtEHDNPQDKQ=
X-Google-Smtp-Source: AK7set//Gnkb6Ja2QOpE4KNV9wAdRLJ+iR6FfeVqk1E7BQFmNBfBvs7s1TiOg7ddAt2ta3KnTWWwlw==
X-Received: by 2002:a17:906:9f29:b0:8b1:3821:1406 with SMTP id fy41-20020a1709069f2900b008b138211406mr24051492ejc.45.1677101717079;
        Wed, 22 Feb 2023 13:35:17 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id ck20-20020a170906c45400b008c95f0ce32esm5355540ejb.3.2023.02.22.13.35.16
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 13:35:16 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id ee7so20958780edb.2
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 13:35:16 -0800 (PST)
X-Received: by 2002:a17:906:4f0a:b0:878:561c:6665 with SMTP id
 t10-20020a1709064f0a00b00878561c6665mr8126704eju.0.1677101715678; Wed, 22 Feb
 2023 13:35:15 -0800 (PST)
MIME-Version: 1.0
References: <Y/OueIbrfUBZRw5J@redhat.com>
In-Reply-To: <Y/OueIbrfUBZRw5J@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Feb 2023 13:34:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfzPOao+Rbq4aSitQ2gPaZ9PPGbR290X4BikD_W8ZcUg@mail.gmail.com>
Message-ID: <CAHk-=wgfzPOao+Rbq4aSitQ2gPaZ9PPGbR290X4BikD_W8ZcUg@mail.gmail.com>
Subject: Re: [git pull] device mapper changes for 6.3
To:     Mike Snitzer <snitzer@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Hou Tao <houtao1@huawei.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Joe Thornber <ejt@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Pingfan Liu <piliu@redhat.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        XU pengfei <xupengfei@nfschina.com>,
        Yu Zhe <yuzhe@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 20, 2023 at 9:31 AM Mike Snitzer <snitzer@kernel.org> wrote:
>
> - Fix all of DM's checkpatch errors and warnings (famous last words).

Actually, I think some of these are potentially actively detrimental.

I do *not* believe that we should run checkpatch on existing code,
since many of those things are heuristics.

For example, the

   Single statement macros should not use a do {} while (0) loop

check is dubious at best, and actively wrong at worst.

It's probably fine for new patches, but to use for existing code? Very
very questionable.

There are very real reason to use "do { xyz } while (0)" even for
single statements. In particular, it changes an expression statement
into a non-expression one, which means that you cannot mis-use it with
comma-expressions and some other situations.

Does that usually matter? No. But I *can* matter, and may well be done
intentionally.

Similarly, when you have multiple macros next to each other, it may
well make sense to just have them all have a common pattern, even if a
couple of them are just single statements.

Now, maybe all of this is ok for the dm code, but I really want to
emphasize that running checkpatch on pre-existing code and making
"trivial changes" based on it, and trying to get the warnings down to
zero is THE WRONG THING TO DO.

Checkpatch should not be seen as a "the warnings should not exist". It
should be seen as at most a _guide_. So never a "remove all warnings"
thing, but a "hey, new patch gets this note, think about it".

Some checkpatch warnings are also more black-and-white than others.
And that "don't use do { } while (0)" is definitely *NOT* some kind of
absolute dictum.

         Linus
