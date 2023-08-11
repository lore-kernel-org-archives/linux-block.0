Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2731EB64DD
	for <linux-block@archiver.kernel.org>; Fri, 11 Aug 2023 16:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjHKQjJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbjHKQjJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Aug 2023 12:39:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8F52696
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 09:39:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99cbfee358eso292520866b.3
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691771947; x=1692376747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIHlgRVD4zuIsPHrllchsXgEvRrrKBDJPCXSLRIlRrE=;
        b=HKHeGXsCsnFAgm5g19pTrZh7wlETPzz6bibBKIHF7dFVtlcbrZfdZx/5fo+bjGFGKR
         JlmyttburRrNMleVRL7az+QY06Z99EU/gQdrtZiZtFMDu9QYak1AQGY/CfVzd8BSx0FQ
         YYXV9UECSnsSqdxDAaAJ2Pm0riRPcsoqhgyK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771947; x=1692376747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIHlgRVD4zuIsPHrllchsXgEvRrrKBDJPCXSLRIlRrE=;
        b=I27KzZba1ShB7FGraGqD2o17PIfsYnu+2OMSWLdL1diVNty5tr8c9mbiTyLyuWV2JW
         AclzJ0PVYadRvD8tZhXQU4jKQvjtqqx66LpDSOYEXHvLE0jMVF1PqZXUfKhWhapDfpfU
         YJ+ESLfDHTAVU8rNfY1INt7J9Meag3l/WpuT/IU+8kLV4VrDLlM1sPHNqJmN39jiYwal
         pdp17JDMrmUCVg1P/K+/dxz67xBFwuTOXmqXTMo/Naa8/3Zh5J1r6z58YV0q+RNuf2ow
         xechDEIrpZsXe/i4R2lEWhykuSWCDl75pQ0UPCgYRITxLdWD17htADv5n5Mc/y1fAvYN
         HdqA==
X-Gm-Message-State: AOJu0YyTJo/uqtAEENkE+HHspdUeXYmIPNQccVA6syhw+1DCdn6hMBzc
        qRBCsoK7EtX2i4t7/r4OlZlIm68vwIotB96DmslgBaKU
X-Google-Smtp-Source: AGHT+IFOcC6uPRL7wbA7puKsFyUpJuG7YsDCaMGBMYfmAd0AE0bw/a8Gxeazqs5l9HK4GMf8L2UUWA==
X-Received: by 2002:a17:906:7698:b0:999:80cf:82fd with SMTP id o24-20020a170906769800b0099980cf82fdmr2291372ejm.18.1691771947031;
        Fri, 11 Aug 2023 09:39:07 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id ce11-20020a170906b24b00b0097073f1ed84sm2439883ejb.4.2023.08.11.09.39.04
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 09:39:04 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so2927995a12.0
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 09:39:04 -0700 (PDT)
X-Received: by 2002:a05:6402:184c:b0:522:ae79:3ee8 with SMTP id
 v12-20020a056402184c00b00522ae793ee8mr2037905edy.5.1691771944135; Fri, 11 Aug
 2023 09:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <3710261.1691764329@warthog.procyon.org.uk>
In-Reply-To: <3710261.1691764329@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Aug 2023 09:38:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1QZ+zdXkjnEY7u1GsVDaBv8yY+m4-9G3R34ihwg9pmQ@mail.gmail.com>
Message-ID: <CAHk-=wi1QZ+zdXkjnEY7u1GsVDaBv8yY+m4-9G3R34ihwg9pmQ@mail.gmail.com>
Subject: Re: [RFC PATCH] iov_iter: Convert iterate*() to inline funcs
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>, jlayton@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 11 Aug 2023 at 07:40, David Howells <dhowells@redhat.com> wrote:
>
> Convert the iov_iter iteration macros to inline functions to make the code
> easier to follow.

I like this generally, the code generation deprovement worries me a
bit, but from a quick look on a test-branch it didn't really look all
that bad (but the changes are too big to usefully show up as asm
diffs)

I do note that maybe you should just also mark
copy_to/from/page_user_iter as being always-inlines. clang actually
seems to do that without prompting, gcc apparently not.

Or at *least* do the memcpy_to/from_iter functions, which are only
wrappers around memcpy and are just completely noise. I'm surprised
gcc didn't already inline that. Strange.

            Linus
