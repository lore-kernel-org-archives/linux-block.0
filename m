Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F0CC433B4
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 08:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A7E461451
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 08:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhEGIbT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 May 2021 04:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234688AbhEGIbT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 May 2021 04:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620376219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+izLZibXyh+gT45+rH9M32lbhj5zaOlz/STXzGzx34=;
        b=dkZIZsAtc88d18lLVRTbjXVVFkrZhKv0cVpTkWI6gatrI/Zlp3VXr/qBWINw4APq/21Z5h
        kUEnaoQVbv6ehS/OwyaaLXnwnVL1SRs1JA964MXxDSS7Xet8QfP9wcUcmj/qpJk88CkvnX
        dLuBJ6AHJ5zfbzqV91c/Gs1NIveH6QI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-ymg9e5C8OpWrK6DVjEWNqQ-1; Fri, 07 May 2021 04:30:15 -0400
X-MC-Unique: ymg9e5C8OpWrK6DVjEWNqQ-1
Received: by mail-yb1-f199.google.com with SMTP id d89-20020a25a3620000b02904dc8d0450c6so9179794ybi.2
        for <linux-block@vger.kernel.org>; Fri, 07 May 2021 01:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4+izLZibXyh+gT45+rH9M32lbhj5zaOlz/STXzGzx34=;
        b=lVGxKbuw/4YsXtfDeFD1EwE+OqaA6eYrQ+N+6j0XmmifqaAu4j2g05qAwUDyMFmMBf
         V6/NmUdZJsvZyEOFRPQvaLdw9kwkxVpFmHkUvEMwAGiDKKP10NqP5ATtrHaWy9Sey2Gn
         ytZjNY/4fm5vPs9OPRRfBVLNipJFgcO6PJ+eTdysnjWmh+kR9OGqzHkQAfE4VMmTiv8q
         wkViQtr5A+qLHoObLLjy6X+azlJ5/nKNU5EXPTFLmHNfMDTxIxa2C95dF+CJFhxnNCa/
         AGji+CahWvn9+KSatzhZ2+HlgOGiVzp2JFfCLkB9V8f7jT7RAtKSb+z3tUCuaKz8uDgR
         ukrg==
X-Gm-Message-State: AOAM531LzqZXmGwOsS9Rx+w8bV6bDUhCVDhT19qJ+kyrDw0BZlrvDW3d
        uwYtafF8fUnrunbJeDbxUnb8O8Pwjk+14yN+sDWXF72VYccU6C7rsSE7R7FPjhkr4dg8e9UsJ7Y
        buXAVpSWFBAn6QqLB4wM2EMZuY1N5nQk4DHx2DqQ=
X-Received: by 2002:a25:cc8d:: with SMTP id l135mr10979198ybf.89.1620376214564;
        Fri, 07 May 2021 01:30:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxE8YNq4xz19ukTpC18X74T5PVq9HBx7dUIJs5aicZppzNFPDVxQfGPughCAYRsUpW37yCKbORdt7nlxHVGzDU=
X-Received: by 2002:a25:cc8d:: with SMTP id l135mr10979180ybf.89.1620376214338;
 Fri, 07 May 2021 01:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <1366443410.1203736.1617240454513.JavaMail.zimbra@redhat.com>
 <4F41414B-05F8-4E7D-A312-8A47B8468C78@linaro.org> <c7d23258-0890-f79f-cc6a-9cb24bbaa437@redhat.com>
 <CAHj4cs9+q-vH9qar+MTP-aECb2whT7O8J5OmR240yss1y=kWKw@mail.gmail.com>
 <B657F0B6-E999-467B-98CB-56C29B04B8F3@linaro.org> <F22E9AB1-06EE-4A66-833A-16C3AD1FFF18@linaro.org>
In-Reply-To: <F22E9AB1-06EE-4A66-833A-16C3AD1FFF18@linaro.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 7 May 2021 16:30:03 +0800
Message-ID: <CAHj4cs_4jPzoZWcuio+jQig4GARVfMac9h=0TyYCiQYqXmXUyQ@mail.gmail.com>
Subject: Re: [bisected] bfq regression on latest linux-block/for-next
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Xiong Zhou <xzhou@redhat.com>, Li Wang <liwan@redhat.com>,
        Ming Lei <minlei@redhat.com>,
        Bruno Goncalves <bgoncalv@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 3, 2021 at 5:35 PM Paolo Valente <paolo.valente@linaro.org> wro=
te:
>
>
>
> > Il giorno 20 apr 2021, alle ore 09:33, Paolo Valente <paolo.valente@lin=
aro.org> ha scritto:
> >
> >
> >
> >> Il giorno 20 apr 2021, alle ore 04:00, Yi Zhang <yi.zhang@redhat.com> =
ha scritto:
> >>
> >>
> >> On Wed, Apr 7, 2021 at 11:15 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> >>
> >>
> >> On 4/2/21 9:39 PM, Paolo Valente wrote:
> >>>
> >>>> Il giorno 1 apr 2021, alle ore 03:27, Yi Zhang <yi.zhang@redhat.com>=
 ha scritto:
> >>>>
> >>>> Hi
> >>> Hi
> >>>
> >>>> We reproduced this bfq regression[3] on ppc64le with blktests[2] on =
the latest linux-block/for-next branch, seems it was introduced with [1] fr=
om my bisecting, pls help check it. Let me know if you need any testing for=
 it, thanks.
> >>>>
> >>> Thanks for reporting this bug and finding the candidate offending com=
mit. Could you try this test with my dev kernel, which might provide more i=
nformation? The kernel is here:
> >>> https://github.com/Algodev-github/bfq-mq
> >>>
> >>> Alternatively, I could try to provide you with patches to instrument =
your kernel.
> >> HI Paolo
> >> I tried your dev kernel, but with no luck to reproduce it, could you
> >> provide the debug patch based on latest linux-block/for-next?
> >>
> >> Hi Paolo
> >> This issue has been consistently reproduced with LTP/fstests/blktests =
on recent linux-block/for-next, do you have a chance to check it?
> >
> > Hi Yi, all,
> > I've been working hard to port my code-instrumentation layer to the ker=
nel in for-next. I seem I finished the porting yesterday. I tested it but t=
he system crashed. I'm going to analyze the oops. Maybe this freeze is caus=
ed by mistakes in this layer, maybe the instrumentation is already detectin=
g a bug. In the first case, I'll fix the mistakes and try the tests suggest=
ed in this thread.
> >
>
> Hi Yi, all,
> I seem to have made it.  I've attached a patch series, which applies
> on top of for-next, as it was when you reported this failure (i.e., on
> top of 816e1d1c2f7d Merge branch 'for-5.13/io_uring' into for-next).
> If patches are to be applied on top of a different HEAD, and they
> don't apply cleanly, I'll take care of rebasing them.
>
> Of course I've tried your test myself, but with no failure at all.
>
> Looking forward to your feedback,
> Paolo
>
Hi Paolo

With the patch series, blktests nvme-tcp nvme/011 passed on
linux-block/for-next, thanks.

Thanks
Yi

