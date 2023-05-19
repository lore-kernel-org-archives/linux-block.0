Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBE7C77B7A
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 16:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjESQcO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 12:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjESQcE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 12:32:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5891CE52
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 09:31:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-965b5f3b9ffso213417966b.0
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684513895; x=1687105895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afFaOwVkDQVoLtMd5ERUW5Y+E5Lld4ra+zl50KIIzto=;
        b=YzrWcDld4RTJchGelZsjKIflSPDXxiN983phPQf+kkueJ++VbeVCYYGAIi9K+eB62u
         pvnn8G2ZHozyAGv0C9JWxXUEJFs028oh1ByD36OWtKKdm/xJ3b1kImHNWzYbpdVNtFHS
         IVwUNWaLdUfhR5yMO2njMd1b8YV9G1S0wfjeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684513895; x=1687105895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afFaOwVkDQVoLtMd5ERUW5Y+E5Lld4ra+zl50KIIzto=;
        b=CKN0QpU/OGTAyYDn1YgVt0/OC9RymBVQm6RfXEZ945w7VuOgpvx71u7jX6nZBWSLpX
         ZNcQyR0TNdmnWM9yPLDT6jckmMnMc8YEtIVcQAnxaG25Zvj/Fp81OfIN3/zr68xLzfTz
         k22U3f1XvT0E5MDmeNjgt2TIdFOQ3iEAL8GTmc/oJxjcje7NlkDYiV73V/rR6Cc6vyfw
         ZFKYKvG0RWX7knrYabFr98yOSF5BCYtD3djRT2Ls83BrYaFF3rYOzqgLF809vkr0vVGp
         XcWFTQlkC04ZXbEEW6+JXsZr6Uy9eFC5H+LPS4+/eyWAp/zQ5fW+w41FhxMo4+Syp/Zv
         12RA==
X-Gm-Message-State: AC+VfDypOUQ/IuEeVGJQTywDF4hiwK1p/VXugzrwuZYUgm/fJT438Ko4
        v99rhQ+dfoXcbuTCvGFYH5kkRQmDu6bekkc26wCev0sU
X-Google-Smtp-Source: ACHHUZ7Z1FUMpYnere81VViihlOpYBbA36hhH4N3c6+8/8dCGrW2mZzJ5TID4sw5iVGhgbKVMcXgig==
X-Received: by 2002:a17:907:7da7:b0:96a:316f:8aaa with SMTP id oz39-20020a1709077da700b0096a316f8aaamr2324080ejc.37.1684513895743;
        Fri, 19 May 2023 09:31:35 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id j13-20020a1709062a0d00b009659fed3612sm2452354eje.24.2023.05.19.09.31.34
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 09:31:35 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-510d9218506so2103451a12.1
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 09:31:34 -0700 (PDT)
X-Received: by 2002:aa7:d7cd:0:b0:512:698d:34ac with SMTP id
 e13-20020aa7d7cd000000b00512698d34acmr65349eds.12.1684513894474; Fri, 19 May
 2023 09:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-4-dhowells@redhat.com>
In-Reply-To: <20230519074047.1739879-4-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 09:31:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whX+mAESz01NJZssoLMsgEpFjx7LDLO1_uW1qaDY2Jidw@mail.gmail.com>
Message-ID: <CAHk-=whX+mAESz01NJZssoLMsgEpFjx7LDLO1_uW1qaDY2Jidw@mail.gmail.com>
Subject: Re: [PATCH v20 03/32] splice: Make direct_read_splice() limit to eof
 where appropriate
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 19, 2023 at 12:41=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> +
> +       if (S_ISREG(file_inode(in)->i_mode) ||
> +           S_ISBLK(file_inode(in)->i_mode)) {

This really feels fundamentally wrong to me.

If block and regular files have this limit, they should have their own
splice_read() function that implements that limit.

Not make everybody else check it.

IOW, this should be a separate function ("block_splice_read()" or
whatever), not inside a generic function that other users use.

The zero size checking looks fine, although I wondered about that too.
Some special files do traditionally have special meanings for
zero-sized reads (as in "packet boundary"). But I suspect that isn't
an issue for splice, and perhaps more importantly, I think the same
rule should be in place: special files that want special rules
shouldn't be using this generic function directly then.

                 Linus
