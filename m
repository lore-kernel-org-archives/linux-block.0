Return-Path: <SRS0=s1xr=SI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A27AC10F06
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 16:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CE720863
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554568270;
	bh=jb6yy7bgxI0A4RvAzOVxk5WGblIUqABaej9Gn5NJcCs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=J2IVcvsDy18mlGCTAGoOKKOSnadwK5Gz4PBclKUFs5uNZyEm5/IeQ0Jiy04xXh4bF
	 ARY49Pi67NqP1qM4a73uisD2+rpodjjPukup05MrAUVUacfPCYXFEeUJmrUOUBEIjF
	 spH26dNGeXPP1Yy951COA9VSSv4S4gUt4qBquhPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDFQbJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Apr 2019 12:31:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37395 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfDFQbJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Apr 2019 12:31:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id o19so6517600lfl.4
        for <linux-block@vger.kernel.org>; Sat, 06 Apr 2019 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/qr5EbXZ6xio3j28Nfm8z9iejPNL/OkZ4onwLqY4AM=;
        b=f19wt0qjwtpCBho2I0CFFiOoNE/JyR5VkqTqpqYghNCndbnpMdf5+9OWsdPtjehljH
         XlwCutXV58SdsQig/9EzXFF4SXJTFyB3hHqKhZdvkKByRgoICZ5AK77/Sv2b2PU9IqrY
         TvRzSO7DRsggHmaH4VWEoaxuBrszeD9vUhMIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/qr5EbXZ6xio3j28Nfm8z9iejPNL/OkZ4onwLqY4AM=;
        b=F1uW6eXRwU6Itrn/3pfoU4qsr/KrzRuGt+KkWZqztM71wFDoZqBlV/WG5oEa4pw5u4
         f29Gj9bwC5136Z72HeiNnwmP9oz5tijYT2bwT+ScRcxDQeoqp4UvnZRUdEyY45wWAENK
         hfO+bZ8i4KaodCjugdQUsheS1KtFkXzeRjbR0j9ZSKnfi04TsAXdLUImgfv2z0yA0rVQ
         p/YLlWCynFM4jZsCUJ1uIvQfoRRnh/juJWifLTZiJpjMufeO+zrR7O0R4cn9q7XbcSCn
         pbyE8YX65jjf4UiRVr5FyfZxN4SY2YmdAnkOim2Yo70J+T8lTxyD1n6JjLqwtt19JBCk
         FG9A==
X-Gm-Message-State: APjAAAWT1Q77nOQjV3xqbM/Gi14Ls2AQjpw4NbUY8UVfItX0n3ZpKga5
        XcfZebXpGGUcSLh8tk9FSTOtZbABXsA=
X-Google-Smtp-Source: APXvYqzzpxXvdxkvZgZroTgn5H+t77uwN4lmMTCTMikQWIhfDYJKlPwSvzYbE7SzuZ4SKAzgJgGgVw==
X-Received: by 2002:ac2:5381:: with SMTP id g1mr10607856lfh.130.1554568266650;
        Sat, 06 Apr 2019 09:31:06 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id b7sm5551967ljb.6.2019.04.06.09.31.05
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 09:31:05 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id q66so7746165ljq.7
        for <linux-block@vger.kernel.org>; Sat, 06 Apr 2019 09:31:05 -0700 (PDT)
X-Received: by 2002:a2e:9597:: with SMTP id w23mr4727540ljh.111.1554568265019;
 Sat, 06 Apr 2019 09:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190405160859.5288-1-hch@lst.de>
In-Reply-To: <20190405160859.5288-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Apr 2019 06:30:48 -1000
X-Gmail-Original-Message-ID: <CAHk-=whUmB7ine4==Z1L4csYCYaQM8-catk8ytNsnyPTs5uwZw@mail.gmail.com>
Message-ID: <CAHk-=whUmB7ine4==Z1L4csYCYaQM8-catk8ytNsnyPTs5uwZw@mail.gmail.com>
Subject: Re: [PATCH] block: remove CONFIG_LBDAF
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 5, 2019 at 6:09 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Dropping this option removes a somewhat weird non-default config that
> has cause various bugs or compiler warnings when actually used.

I'm ok with this, but let's queue it for 5.2, ok? Jens?

              Linus
