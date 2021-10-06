Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F867C433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 15:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F27610C7
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 15:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhJFQAn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhJFQAm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 12:00:42 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC98C061746
        for <linux-block@vger.kernel.org>; Wed,  6 Oct 2021 08:58:50 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id p18so3350375vsu.7
        for <linux-block@vger.kernel.org>; Wed, 06 Oct 2021 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8f0JVd+gTPaH9TpaiXB3RSVMg8JjTNf39SFpo8XmoJM=;
        b=IZFP+pqJ8mPBqSpzgjYgFunJO7ogWb4uCMdEFWzDX6cwL3jJZgaQUWgGtOhwNEXaI2
         ftZDL/jZb81JwekvprJrX2uUsobN/1LykudNc7ARjJs8GDOfCrSG01eHFqEOSG/Qcvs7
         ErysdKELjnLc0JWWKFLyidlAOwtMP6LLsEvuh210vz0qAJZfAgs4Te9bp9tYoAxqvlsf
         fC7aNQ7rHqsFeUpPf4Wy3xSTJINgJHYm7YpxymNM7LhvbQnDOPMumABo5fY8eGfCNv+4
         /tM6hffevQZHuBVv9k7sD7gq+XswKOAihKmmWN+jk/XTzjv82H2pITgh08GQlfEcp2U+
         Vc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8f0JVd+gTPaH9TpaiXB3RSVMg8JjTNf39SFpo8XmoJM=;
        b=JZdZdl/I/NOELvbFh0N2ee5X8psilR69QHUj0x/hZ6ZSO9hInEmr4Q/igwfntBcOCq
         Qxb7wZ8clRaGHH+orHCF5WLRrk5Rkh19wpB4ozrl/q1Q0lWKZgMtPB47kUVd48O5tK+W
         slcoQKEFmiFtp8H5vTY/078bQiBn3i837sGfZZ2kGldQSpgzvBnMalvDT2DSLLz1tHwh
         01V+x9ZoROjR1bCR1qlqMTlYvpdEHcL4pI5htk67Yt6M3u/xS3EK5PHtHsKrqYbUvwM+
         fZAQkvGfaTzCa4plAdCJyFd49sXa5CzylK3jAACIICAqZW0UH5LPp9B7Kx2coRdkvXty
         UCfA==
X-Gm-Message-State: AOAM531X6o5wOg+pT6eFqDq77aHfS2xedwz2d9Ot0V+L2ivR1DgYCOyC
        S1DrSm69RG0sU+E0L2Yf3E2HtHzgHu7vEMHXLXVo/g==
X-Google-Smtp-Source: ABdhPJxm6beT16fsT8mDfI3FtrLzaLeQGcMms/9pNJPVpN0ScU9qe6ITvrn4MU+1+mVeFPdgu3rCjiGbIrh2vbb/JBg=
X-Received: by 2002:a67:e94a:: with SMTP id p10mr25025921vso.56.1633535929203;
 Wed, 06 Oct 2021 08:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210505193655.2414268-1-egranata@google.com> <CAPR809ukYeThsPy4eg8A-G8b4Hwt7Prxh9P75=Vp9jnCKb6WqQ@mail.gmail.com>
 <YO6ro345FI0XE8vv@stefanha-x1.localdomain> <87pmvlck3p.fsf@redhat.com>
 <YO7zwKbH6OEW2z1o@stefanha-x1.localdomain> <CAPR809uuo=5kmzUs3RFp6z_4===R0hxdFiScLPouUS+qxdaVWg@mail.gmail.com>
 <87h7duz7vq.fsf@redhat.com>
In-Reply-To: <87h7duz7vq.fsf@redhat.com>
From:   Enrico Granata <egranata@google.com>
Date:   Wed, 6 Oct 2021 09:58:38 -0600
Message-ID: <CAPR809vsz_z4ooL6dPJMDtTWtf02-jbz4FVipRjsLGczCV_XCQ@mail.gmail.com>
Subject: Re: [virtio-dev] Fwd: [PATCH v2] Provide detailed specification of
 virtio-blk lifetime metrics
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        virtio-dev@lists.oasis-open.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I would very much favor that - thanks for bringing this thread back to attention

Thanks,
- Enrico

Thanks,
- Enrico


On Wed, Oct 6, 2021 at 5:54 AM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Fri, Aug 06 2021, Enrico Granata <egranata@google.com> wrote:
>
> > Hi folks,
> > I am back from my leave of absence, so thank you everyone for your patience
> >
> > This proposal has been outstanding for a while and didn't seem to
> > receive pushback, especially compared to the initial proposal
> >
> > Would it be the right time to put this modification up for a vote?
>
> I guess no news is good news? (Or it fell through the cracks for everybody...)
>
> I can update #106 and start voting.
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
