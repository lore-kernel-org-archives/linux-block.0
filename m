Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151BDC77B7C
	for <linux-block@archiver.kernel.org>; Thu, 11 May 2023 16:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbjEKQxZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 May 2023 12:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbjEKQxY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2023 12:53:24 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AEC59DC;
        Thu, 11 May 2023 09:53:22 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-77e80c37af1so2479561241.0;
        Thu, 11 May 2023 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683824001; x=1686416001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7CyuNeO1bKn8cJ+nOjq+BFfHo7Ts+ohomPRgom/d1k=;
        b=nHXKHuXToMZIHYv6zpwAqjgg+hlwgncxBpc2kvB0Tr3VCMpfOqH3tri9226u988h+8
         NeMpTHcryTDzBrxA6SE7OB2GbvwKt057XjBUcbVFrcPHHJCZDWCUseBd96ELRwRALuUZ
         DVBPCyJusx5/PWrDIEd1Pq3D+h0y+/z2kNghXtqdQT5oxlJvGymkELEP27R1mhKJ3CB3
         KqNbOdH6YK4wkJinlV+x9AJ7m08Oj7AIT4GY8Erm1XJR3dkLxqZfJ1Gfe0cErlfwOOOh
         45bhNiynGXqEzhgHHJXm3K9V0ppqOiRFGc/crJZSzAaULz1tKDmgY2ORhftvOA6FzqKD
         uc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683824001; x=1686416001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7CyuNeO1bKn8cJ+nOjq+BFfHo7Ts+ohomPRgom/d1k=;
        b=BucIJmEFmCSRhRuSp1W8hJD7NDFYU8b6eIDomKHS46ncgCg+RgvgdF5NQ7hgluRid1
         2+MXnXpxs60jGH2BtVzCq6dFh7kUU8KaS8ixnqiL3hhYV2Ma1XBPlMywvR572SbEj4Ow
         n57uZLHdYek9bZfqeOXiLt0LxDM4GIily0nzNbKN1KM/7/pg16sZrmlwt9ujToMFl5qQ
         xPlnr0z9acfbQo/JM/853KUFKQGSh7WS3RfF7sbC0bXc07wGp0mkXKIrUKjE+PJwwOwi
         ZTfiLgdtpJQw7fiSQv0SqQfTpEYTmhR/Mytsiq+FnYCmbAKH/JB+NYyHvR5ArJKa6NOg
         orSA==
X-Gm-Message-State: AC+VfDy82IifM5t2pRAbfag2W8qW3qHaCq8NpoSP3/Rmeker0w8LWaXD
        5/eDLULUIhfdcI8BYup6/nCPVtpQSwPMa8QdkYw=
X-Google-Smtp-Source: ACHHUZ4aUqksIqw7q6XK5aUmktWWI15AwBlyuT3gm+Nn55vbT17csRXZOgyZLke+iIdzRgKnsrxWb86Ob0pUeZMwOAs=
X-Received: by 2002:a67:e242:0:b0:436:bef:1eac with SMTP id
 w2-20020a67e242000000b004360bef1eacmr5228663vse.29.1683824001262; Thu, 11 May
 2023 09:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230511142535.732324-1-cgzones@googlemail.com>
 <20230511142535.732324-4-cgzones@googlemail.com> <ZF0LXRWZb+xL+pTS@infradead.org>
In-Reply-To: <ZF0LXRWZb+xL+pTS@infradead.org>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 11 May 2023 18:53:10 +0200
Message-ID: <CAJ2a_DdwSZciKNtbbK14sOt5BqbATpmvqMVpR3tJvhMZitHxDw@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] block: use new capable_any functionality
To:     Christoph Hellwig <hch@infradead.org>
Cc:     selinux@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alistair Delva <adelva@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Serge Hallyn <serge@hallyn.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 11 May 2023 at 17:35, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, May 11, 2023 at 04:25:27PM +0200, Christian G=C3=B6ttsche wrote:
> > Use the new added capable_any function in appropriate cases, where a
> > task is required to have any of two capabilities.
>
> What is this new function and why should we using it?

Quoting the description from
https://lore.kernel.org/all/20230511142535.732324-10-cgzones@googlemail.com=
/
:

Add the interfaces `capable_any()` and `ns_capable_any()` as an
alternative to multiple `capable()`/`ns_capable()` calls, like
`capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN)` instead of
`capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.

`capable_any()`/`ns_capable_any()` will in particular generate exactly
one audit message, either for the left most capability in effect or, if
the task has none, the first one.

This is especially helpful with regard to SELinux, where each audit
message about a not allowed capability request will create a denial
message.  Using this new wrapper with the least invasive capability as
left most argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables
policy writers to only grant the least invasive one for the particular
subject instead of both.

> Your also forgot to Cc the block list on the entire series, making this
> page completely unreviewable.
