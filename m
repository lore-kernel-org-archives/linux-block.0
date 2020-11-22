Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B95C63697
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 16:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ECD72080A
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 16:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="JOJBa8yN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgKVQQr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Nov 2020 11:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbgKVQQr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Nov 2020 11:16:47 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B8FC0613CF
        for <linux-block@vger.kernel.org>; Sun, 22 Nov 2020 08:16:46 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id s27so437803lfp.5
        for <linux-block@vger.kernel.org>; Sun, 22 Nov 2020 08:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9qAYYU7qLTqNGo8meREqfnSUbV871EDhNHo/cPoPy0=;
        b=JOJBa8yNjePop47L7cV+OC01ssZuHPnNFJld0CgcBFPCtRLRKQCAAIqxiZd3X3Mq3x
         ZJxhVnqFNeBAOK92EV2XPKknvp46I1QFjWWd16nru3bOmtX+gDl8zwUzEWFW0s+M/6Ff
         vfCfjTe0Kq8a5+Nn9iuYScYXwuiA0aLJ8YBk3Q3ALy7ehtC7mGfYb0ZZriH/5CxF7NKD
         UZJgEXfTssgs6mAubTzC4pCYj+Yt+tBhsWUD6MVGh9hIJJshM6UbvYwGJMY9QG6Fk1rz
         fMBcj6V3piRj3WE3Rw/LWZX2QnbyJIW/L9CL2LMY+xDRE6EXma83OEVE9gDX6LctXa7A
         NF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9qAYYU7qLTqNGo8meREqfnSUbV871EDhNHo/cPoPy0=;
        b=KSqHHt1GSvzN/SgxAc1kmVHtNr/U5dVxLmHguNvx89EPsU6vnnh+m0QpSKZtU+Y4Lg
         IiLWpT0lALE9rIeWMwGd495Weyjub1h3yPKqKthH82cF7TCTDsoBAQDbOW1dGnRRaqVJ
         M2+vX1ImrDo18SB2T3dTbzTquoKjk2wn9fwgEKz4Qc4mkXuvIB98DfmWrSFroSRzZ1j6
         u+80ALB8N8hA9v6G9m+Kj7oiG3wQeOq1dsldgvXVdokjOuPSHaCDpDb1MrPVdQTpxwDI
         24OBg6g79uUaRJ7V/5WvrTrGuBIzm86x1cn41rDTDgIRK0viKZv+OE/FlaTjPU0N485+
         OoZw==
X-Gm-Message-State: AOAM531h7DJrMJDu8zLDRrGn/VTYWCpVm19dVkQ39ayMpsCNtevJ6vmo
        vuYKtM5/YSUjykDnYNLVUHSNQH60ayoVNzJASRPB
X-Google-Smtp-Source: ABdhPJx0pPbNmP1x9mLEZheeiCp0mfGIwihnljTToQL9L3KLjTYS0c1anSmYXet3/3dncIFTArKJAjMplhgmP9VN6sM=
X-Received: by 2002:a19:f207:: with SMTP id q7mr11121546lfh.588.1606061805283;
 Sun, 22 Nov 2020 08:16:45 -0800 (PST)
MIME-Version: 1.0
References: <CAHg0Huzvhg7ZizbCGQyyVNdnAWmQCsypRWvdBzm0GWwPzXD0dw@mail.gmail.com>
 <3b2f6267-e7a0-4266-867d-b0109d5a7cb4@acm.org> <CAHg0HuyGr8BfgBvXUG7N5WYyXKEzyh3i7eA=2XZxbW3zyXLTsA@mail.gmail.com>
 <cc14aa58-254e-5c33-89ab-6f3900143164@acm.org>
In-Reply-To: <cc14aa58-254e-5c33-89ab-6f3900143164@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Sun, 22 Nov 2020 17:16:34 +0100
Message-ID: <CAHg0Huw35m_WiwFqcTEHpCz94=JhaKZdEuV-F=aetQ_SEQgauA@mail.gmail.com>
Subject: Re: [RFC] Reliable Multicast on top of RTRS
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 4, 2020 at 5:33 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-09-04 04:35, Danil Kipnis wrote:
> > On Thu, Sep 3, 2020 at 1:07 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >> How will it be guaranteed that the resulting software does
> >> not suffer from the problems that have been solved by the introduction
> >> of the DRBD activity log
> >> (https://www.linbit.com/drbd-user-guide/users-guide-drbd-8-4/#s-activity-log)?
> >
> > The above would require some kind of activity log also, I'm afraid.
>
> How about collaborating with the DRBD team? My concern is that otherwise
> we will end up with two drivers in the kernel that implement block device
> replication between servers connected over a network.

Will take a closer look at drbd,

Thank you,
Danil.

>
> Thanks,
>
> Bart.
