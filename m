Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AB7CD4851
	for <linux-block@archiver.kernel.org>; Fri, 22 Sep 2023 18:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjIVSvy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Sep 2023 14:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjIVSvx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2023 14:51:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EB7AF
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 11:51:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c136ee106so321657866b.1
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695408706; x=1696013506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ah1VmvWzOnKnkyFlWIeYuTucJzJ+3NRjWIwcRi6c2zI=;
        b=FaPDT8B5cyjl0XRxvrxoCfBKIU6Tjk8TycxNF/KS17PgcgdnUGUoF2m94Bw3BDqsSh
         vqkSlbpkjXp/m68rymiB5C2I4FpZvJvZpXMuV8+qGtCsYzhAFeAkU7jVNVjFOaG8jMRS
         tCyamDSFoilJgPyjciOUL0pZX1lcFBF6IMcpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408706; x=1696013506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ah1VmvWzOnKnkyFlWIeYuTucJzJ+3NRjWIwcRi6c2zI=;
        b=kDcNdU/NOGTroRoq3ZtbWhlUlDBPUwV6jrGp9pGkzNjK5+CWIv+8cOp4B0gjJWtVao
         ug58f/qgF9cqgHPmSrQOmSChr6ppABeOovkC7U8BY0pHGIsUVZuZkRQNq78DpzU3QiVQ
         lnPHi5PUmjs7VafaZ9uASdiaA58L/fF+FUvyoTFQbjI66xefRMmTz40FqQtYGCT13YQN
         OijyfZOnFv7K5+/Ae23073rCNgTrDS72X5k12A+1G+zzIr97GqKH/w2UIXpCbZ8+YdoM
         lsEkDcEulTOPf9aeE9fJk9zVgxiH+2sguBWHxjVWrR2u5VrubCRXU0N7mn7YLriU+RI/
         SijA==
X-Gm-Message-State: AOJu0Yye/URMEJQF3U5xBBkughQo2H8X4q+sb5xJqJ4qVcV1uC1ZLT+a
        e9eTO6snnM0O8F2c8MNA5/Q5SkKDoa6J3DqfiOB87CG8
X-Google-Smtp-Source: AGHT+IHvxSsS1vvcOQCHSg1LjnnQnBktqCoLClW1gFL5cDMYi1SZpDvUYVgHOe/xeYXvsOcEPOZsyA==
X-Received: by 2002:a17:907:2e01:b0:9ae:406c:3425 with SMTP id ig1-20020a1709072e0100b009ae406c3425mr234689ejc.0.1695408701323;
        Fri, 22 Sep 2023 11:51:41 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id qq23-20020a17090720d700b00993664a9987sm3040460ejb.103.2023.09.22.11.51.40
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 11:51:41 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-532c81b9adbso3053776a12.1
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 11:51:40 -0700 (PDT)
X-Received: by 2002:aa7:c98b:0:b0:533:310b:a8aa with SMTP id
 c11-20020aa7c98b000000b00533310ba8aamr309019edt.13.1695408696292; Fri, 22 Sep
 2023 11:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230922120227.1173720-1-dhowells@redhat.com> <20230922120227.1173720-10-dhowells@redhat.com>
In-Reply-To: <20230922120227.1173720-10-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Sep 2023 11:51:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyv0cs056T8TvY1f0nOf+Gsb6oRWetxt+LiFZUD4KQCw@mail.gmail.com>
Message-ID: <CAHk-=whyv0cs056T8TvY1f0nOf+Gsb6oRWetxt+LiFZUD4KQCw@mail.gmail.com>
Subject: Re: [PATCH v6 09/13] iov_iter: Add a kernel-type iterator-only
 iteration function
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

On Fri, 22 Sept 2023 at 05:03, David Howells <dhowells@redhat.com> wrote:
>
> Add an iteration function that can only iterate over kernel internal-type
> iterators (ie. BVEC, KVEC, XARRAY) and not user-backed iterators (ie. UBUF
> and IOVEC).  This allows for smaller iterators to be built when it is known
> the caller won't have a user-backed iterator.

This one is pretty ugly, and has no actual users.

Without even explaining why we'd care about this abomination, NAK.

If we actyually have some static knowledge of "this will only use
iterators X/Y/Z", then we should probably pass that in as a constant
bitmask to the thing, instead of this kind of "kernel only" special
case.

But even then, we'd want to have actual explicit use-cases, not a
hypothetical "if you have this situation here's this function".

                 Linus
