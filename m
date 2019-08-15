Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336CDC3A589
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 14:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F204E2067D
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 14:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="SFv3m91M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbfHOOuL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:50:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36473 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbfHOOuL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 10:50:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id u15so2482596ljl.3
        for <linux-block@vger.kernel.org>; Thu, 15 Aug 2019 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYT2OSHdO2DhGI1fwQFHGoFCd1oy7Hq2Yne9sDtdOm8=;
        b=SFv3m91M3bw6JeMwDStZK9fHM0zPXfPmHV+zj7XOFgng2BkLQhXyTBN+CDlDyE3tE+
         pJYRl0W5IoisMmUL3u7KLavEtBV8WbsayMKI2Ndj7PpuPn1m/sYhPMWdV3hvRDwf7U2d
         W2r62kWw8X9sgxRVC+sHMOJrk2mP8bbSHWARbLYevcM4vkV/a9IZuCwt9svHaU72eNYg
         f37aWSotRPlDW6ZHMaPfJWofSRQCKFiPXOs3wTJ2ZGvu35ErDBW5VN69RYP5Ke8IbTHb
         ihrcejBWCucjoAABUL2XgxJ8VCzXm6zX+46m1qzRBmD10PQ0H9C/UYl+cRKw15fVUYIX
         RXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYT2OSHdO2DhGI1fwQFHGoFCd1oy7Hq2Yne9sDtdOm8=;
        b=sVZilKKL/hiqv4DShlQ9CoM+jKTuEYRrppkH6s1ZONxWPuqHENkm1zm/2a7C2SLfe8
         h8uSLu7sdHnx1WgF/2BLD6rlKlt2Hm07AL1GMtpEmZu7YiGLPSl7LQUIDb9a4fxKOPse
         A0iOhsRooWmt1+opZf9/+/172HbrsOj6ToOxlaeemdLd2/j0juMZtPJfoBou9+CJOOfc
         lp3gZVVnlG40YJNu7HI1x8JvbaPSkPatBn5tV6+gv1Fysx+pDTMxcgrsdIKFr0EtvGDU
         EKmIE9aH0ufU1wR4sAxklpf9fiJAUup90ukufYbuPvwaZjqYRXIfIjmt5TrtP2BhBU5D
         B9XQ==
X-Gm-Message-State: APjAAAXpRNm1BTutQGaYT5YNKpLnv/1UYgNIZRheCrt5dIBhjHQl8xXM
        wZsCeRvjptEkY97Bj3rsXEEBvSFu8jQKJr3FxAQtqQ==
X-Google-Smtp-Source: APXvYqyfs8OtHgp4GrtWZwMaMMg8hiNezGefnRigGy1I7CavN0aKhlm20eEzQ6pzBIanR2L4TTIMz54bjUdmC6/qSH0=
X-Received: by 2002:a2e:96d3:: with SMTP id d19mr613083ljj.185.1565880609143;
 Thu, 15 Aug 2019 07:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190814103244.92518-1-maco@android.com> <29990045-b05e-1411-a5c2-32e735265a04@acm.org>
In-Reply-To: <29990045-b05e-1411-a5c2-32e735265a04@acm.org>
From:   Martijn Coenen <maco@android.com>
Date:   Thu, 15 Aug 2019 15:49:58 +0100
Message-ID: <CAB0TPYGczqoDz=ReM75cYc4hbS58V-a4m_qJ8GoAoWtepXTWNA@mail.gmail.com>
Subject: Re: [PATCH] RFC: loop: Avoid calling blk_mq_freeze_queue() when possible.
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, kernel-team@android.com,
        Narayan Kamath <narayan@google.com>,
        Dario Freni <dariofreni@google.com>,
        Nikita Ioffe <ioffe@google.com>,
        Jiyong Park <jiyong@google.com>,
        Martijn Coenen <maco@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 14, 2019 at 4:29 PM Bart Van Assche <bvanassche@acm.org> wrote:
> Hi Martijn,
>
> Is the loop driver used in Android Q to make a file on a filesystem
> visible as a block device or rather to make a subset of a block device
> visible as a block device? In the latter case, have you considered to
> use the dm-linear driver instead? I expect that the overhead per I/O of
> dm-linear will be lower than that of the loop driver.

Hi Bart,

In this case we're using the loop driver to make a file on the
filesystem visible as a block device (in the file is a filesystem we
want to mount), so unfortunately dm-linear is not an option.

Best,
Martijn

>
> Bart.
