Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F764CD4844
	for <linux-block@archiver.kernel.org>; Fri, 22 Sep 2023 16:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjIVQfR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Sep 2023 12:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjIVQfQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2023 12:35:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBC4F7
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 09:35:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso874644766b.1
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 09:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695400508; x=1696005308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gOhjx56+C1/SUOCT4pJr+RaAn7PBsJsy8c2/c8L0wsg=;
        b=VXldlrG11szZBfan3YaFaOg1qRTFUXItPvz+d594Ed/RZo0X8fDhhFTcT+Tfee5VSP
         yLE9fyNVXNnPLkw0gSESTe8Z8WM+wGotLZjHCgzE0IfCnJJtL1u/7KVdSA3g4FbBQDNs
         0yJxayfVAnOtmdEA4zWcMbTKTM0gvJiAOw2es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695400508; x=1696005308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOhjx56+C1/SUOCT4pJr+RaAn7PBsJsy8c2/c8L0wsg=;
        b=IswnPpCOAOKb4Ud/jJTShkD7M9KK4uGOpIqIORJlgqrvqCssFGx/3quuL3/MNAUR8B
         JBdxnKleH4gyk7K+9oKpsu5bGUZ8nbMlLaNwMEFXMnrIwbN493eM8KIMBesAFtx4HaG+
         OXJX1t5SREJoWNYStY/xYTp/rF0XZmfii1X1+6iW+EKtxB59UXH76eSkLoXEy/6qH2RY
         Vsb/Ss6ewREMxWrWTeDHEdVeBCHRfaVUA4hgbUIqiXTMSvZNMztPausNNojv0NmM3OJ4
         2+WMdjkI3xHDtA9MLv+6ujTqzGlDXfB7DQsmxkicoll5kW1g30iJVjKvSejlxILUNu9v
         6I7g==
X-Gm-Message-State: AOJu0Yw++A+P8fqSGqqPbB3Mq7V03q7nCajyqEf0Q3rG2JN9UiXJSlnl
        IYvc3nXPPyip7Y8BlF6cYO4C+CqYfZlKTkBYo29Xk1jw
X-Google-Smtp-Source: AGHT+IG+xPZX1JvxC9pnWNlZRCouoQWhpsWwgiirkV2ofCDcXLz9J5Rwu+3IB/X8l2QxH4qZmkR3Ig==
X-Received: by 2002:a17:907:ea5:b0:9a1:e0b1:e919 with SMTP id ho37-20020a1709070ea500b009a1e0b1e919mr5057126ejc.4.1695400508196;
        Fri, 22 Sep 2023 09:35:08 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id q3-20020aa7d443000000b0052576969ef8sm2459750edr.14.2023.09.22.09.35.07
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 09:35:07 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so8629067a12.0
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 09:35:07 -0700 (PDT)
X-Received: by 2002:a05:6402:27ca:b0:52c:f73:3567 with SMTP id
 c10-20020a05640227ca00b0052c0f733567mr4854122ede.13.1695400507255; Fri, 22
 Sep 2023 09:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230922120227.1173720-1-dhowells@redhat.com> <20230922120227.1173720-9-dhowells@redhat.com>
In-Reply-To: <20230922120227.1173720-9-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Sep 2023 09:34:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgW5z-OBA8kbOOoM7dAriOsb1j7n6GaUNjGeg9fPY=JRw@mail.gmail.com>
Message-ID: <CAHk-=wgW5z-OBA8kbOOoM7dAriOsb1j7n6GaUNjGeg9fPY=JRw@mail.gmail.com>
Subject: Re: [PATCH v6 08/13] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@aculab.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 22 Sept 2023 at 05:02, David Howells <dhowells@redhat.com> wrote:
>
> iter->copy_mc is only used with a bvec iterator and only by
> dump_emit_page() in fs/coredump.c so rather than handle this in
> memcpy_from_iter_mc() where it is checked repeatedly by _copy_from_iter()
> and copy_page_from_iter_atomic(),

This looks fine now, but is missing your sign-off...

             Linus
