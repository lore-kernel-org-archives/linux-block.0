Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77225C388F9
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 18:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3688422206
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 18:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dH00Lj87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgKUSXe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Nov 2020 13:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgKUSXe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Nov 2020 13:23:34 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3301C061A4A
        for <linux-block@vger.kernel.org>; Sat, 21 Nov 2020 10:23:33 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u18so18103957lfd.9
        for <linux-block@vger.kernel.org>; Sat, 21 Nov 2020 10:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7cZfFDWETupzrz1W/PA0N75+saduUeI+gk15nXI7Q0=;
        b=dH00Lj87XUWDjVhZTS31u5fK+b2ZiXmaVewWBK/V48aWDdpvmlY8lYEZ3TsPZy+JuP
         Piggiet9UE2qE2SNHmspoYRK7bxHTomINqVwsLJcANApC/MOgACoEjU5ZxHckGmnDp1N
         lQ0V7X3C4QU5N8npwm/3beAXsfs54Clu8S4xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7cZfFDWETupzrz1W/PA0N75+saduUeI+gk15nXI7Q0=;
        b=S2WSFVyY5CfTi0kEJJMm8G9Yiuncf6+dO0yYSjQixrVk3m4U2iVQJDV9af5IQzRlat
         +q2NC2Pl8ejXy/GAJC4/ThfwtgxMeRb4WFCq8SUlB/bTsiC0lRbiVVZsbwWYHDhZJl2Q
         dCK1hIwjSFdnCVw/gLwgR9Gxky5nVno4mdS8AHKUU/uJ/Tl0t6lzDUkZsd1p7S4/2tcR
         O1GsCTY5a8NU8j+qmALCGjkYvdUhboCzerXcM1RttZ9Cgt1fX0aAFP3b+YgIL8LUR96P
         F8gvm9pfIL/zyUfn8mUm6IV7Wdcag0U59qSFobPbz2uReHIRecsrCPi+1jKdbjoHozSo
         r69A==
X-Gm-Message-State: AOAM53102eKVSyM9PwG8MVV2qKWh2CNqeL+uq1JRp3YTSwN/ePE8Krmk
        wUW4U1DXPVFaCWDLbPD0oMKP73sp2mcw8A==
X-Google-Smtp-Source: ABdhPJwqOAtwsouRn9aafr82f0vKlAj+Yh8O8qmrWv+l47+gU3aaxpIbRaLzcmDw8GdoZJtPJhRWjQ==
X-Received: by 2002:a19:5d55:: with SMTP id p21mr815424lfj.115.1605983011678;
        Sat, 21 Nov 2020 10:23:31 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id r7sm782506lfc.206.2020.11.21.10.23.29
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 10:23:30 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id z21so18082812lfe.12
        for <linux-block@vger.kernel.org>; Sat, 21 Nov 2020 10:23:29 -0800 (PST)
X-Received: by 2002:a19:ae06:: with SMTP id f6mr11146486lfc.133.1605983009454;
 Sat, 21 Nov 2020 10:23:29 -0800 (PST)
MIME-Version: 1.0
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Nov 2020 10:23:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj3p3eScaULtpCtWwS9NGFxT7dVTTC3mg1VyAyO2L5j7w@mail.gmail.com>
Message-ID: <CAHk-=wj3p3eScaULtpCtWwS9NGFxT7dVTTC3mg1VyAyO2L5j7w@mail.gmail.com>
Subject: Re: [PATCH 00/29] RFC: iov_iter: Switch to using an ops table
To:     David Howells <dhowells@redhat.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 21, 2020 at 6:13 AM David Howells <dhowells@redhat.com> wrote:
>
> Can someone recommend a good way to benchmark this properly?  The problem
> is that the difference this makes relative to the amount of time taken to
> actually do I/O is tiny.

Maybe try /dev/zero -> /dev/null to try a load where the IO itself is
cheap. Or vmsplice to /dev/null?

         Linus
