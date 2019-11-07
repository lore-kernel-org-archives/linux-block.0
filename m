Return-Path: <SRS0=Ukdl=Y7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CD9C43331
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 16:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3422077C
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 16:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573145531;
	bh=Z1dqk+RRh5Tw9vIdgN632bDR4HOjWiROuyE5KZkrIOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ERBfK5ONRkMOcfDXpcPdNB+6YsoiUYKoTKEctFNqoqgG2BAQ08rL5xO5fqz2zv9tI
	 XPl3nb4zTxJHtWCGUvLIa6EPQ6CiIKnHZKsnkTxt+JCJFHGUxJU6lJEW9GUwegzcD1
	 p4BSzjzWgaNn9Uae9yHER6syZHfaIciAicZnY//w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfKGQwL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:52:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37721 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKGQwK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Nov 2019 11:52:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so2135563lfp.4
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2019 08:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QmbLva0bcejWfZ5vroXCCCNjtDh9+KzeuzRfAkUcNVw=;
        b=RC+2jxnet1c9HEhXNBxtTTpEfLinckdbFJn5Bmrik3m/W7Num2OjpLxTQS23AoRNRr
         Aj4dYDnclnksK9me7oG5iyDsfchGPA4TwVOyMbOGN2PJFpJroPg+VNW7luk63nWV0aoz
         X/nFl5ue/aQhw5K+6Ogz8TNi8yWG86H2/HKz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmbLva0bcejWfZ5vroXCCCNjtDh9+KzeuzRfAkUcNVw=;
        b=TzIO3VlGbcpmHUgRsRvIZIQmIujwUhBzYixMmgKuFxY6nhqpwsa3+9Tbm9P+vabeET
         uZ4+x2hfk1YA1jEfZbpphTTafsMizr9/FCe7dTxGB2Ekp8ZQjSZz75yWsBeSrkf/+NeI
         v0qxMWZq27n/zXfzrcZ8Ib36oH7GFcEBLFWGzhdC9TFE+/soCKaKhRD67HoJq+PYYhnO
         qrZqouJkAvSKzXFBiiKRokHQ8pTvlaGQMBhF4NNwIJsinaupvPedyhZ44z0ZJ9AqY7mq
         o5u6VuNPrZ9XABsgY1xX6AOrf9zCXuPBPq+AbvznMlfC797o5VCPG+ilEVFKGqM144FP
         Mm5Q==
X-Gm-Message-State: APjAAAUWMiXhHEJRQ/R/t6lb6z89iTLFnwNScomuKu2Tl7EeKQonRP04
        Z9Dt43wkJkGaP2iyPt/1s4jXl0+JNKI=
X-Google-Smtp-Source: APXvYqxFqyqvYhClw3KNBxy7jpM0c+SP8hCNg+PU54s3t0pTDmxI5uSzdEZ6PZudWyC+RD/nESPKeA==
X-Received: by 2002:a19:6917:: with SMTP id e23mr3102914lfc.4.1573145528502;
        Thu, 07 Nov 2019 08:52:08 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 4sm1238992lfa.95.2019.11.07.08.52.06
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 08:52:07 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id j5so2113517lfh.10
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2019 08:52:06 -0800 (PST)
X-Received: by 2002:ac2:5bca:: with SMTP id u10mr3159115lfn.134.1573145526683;
 Thu, 07 Nov 2019 08:52:06 -0800 (PST)
MIME-Version: 1.0
References: <157262967752.13142.696874122947836210.stgit@warthog.procyon.org.uk>
 <20191107090306.GV29418@shao2-debian>
In-Reply-To: <20191107090306.GV29418@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Nov 2019 08:51:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJ+jaT5Ev-wCg7iGNNO_JFUyMDcat0KDdA2b_+n_cZCQ@mail.gmail.com>
Message-ID: <CAHk-=wiJ+jaT5Ev-wCg7iGNNO_JFUyMDcat0KDdA2b_+n_cZCQ@mail.gmail.com>
Subject: Re: [pipe] d60337eff1: phoronix-test-suite.noise-level.0.activity_level
 144.0% improvement
To:     lkp report check <rong.a.chen@intel.com>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 7, 2019 at 1:03 AM lkp report check <rong.a.chen@intel.com> wrote:
>
> FYI, we noticed a 144.0% improvement of phoronix-test-suite.noise-level.0.activity_level due to commit:
>
> commit: d60337eff18a3c587832ab8053a567f1da9710d2 ("[RFC PATCH 04/11] pipe: Use head and tail pointers for the ring, not cursor and length [ver #3]")

That sounds nice, but is odd. That commit really shouldn't change
anything noticeable. David, any idea?

               Linus
