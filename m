Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0C3C10F11
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 14:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0B020685
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 14:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrCZPw13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfDVOgI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:36:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43290 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfDVOgI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 10:36:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so16015041wrx.10
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=62uCNZQS4zr/oMrXJTdPwrYX7H4DT5oqjx33inDCXys=;
        b=HrCZPw13pgUeMtO7jygN1AuxCySCSb+Ivmoh0vhxEBO9NMt9GPw2dI5uHHuxjh/qkN
         7q82nq4ZdWwk+eGBJlwGfOAV9ZgGg00zu2Wolm9KJ8ipXwRvyHW6LdI4HXIPRS7Tqn6+
         sec0KAx6L47K5nUf+yngA1KJjARNhBg/xz9WWhZEFllFK8vV+tSsdrN2NBxjEvwVwdpd
         6zqQpH35z63UVSu+PsQWO7Y4H5M+KSHDkErFTQWdrRvNAwkBpSxXZWl5PSSSjvo11Des
         LxXSqEebrOKoiM/DaIdU6ZdBwpRsbzEZDmlBOtUSYPWmqdjRxuRzZJd8LuNG5Ka99lG/
         B6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=62uCNZQS4zr/oMrXJTdPwrYX7H4DT5oqjx33inDCXys=;
        b=MdwT4sxrL1kAbjdMR3JaZWSYVSH8+vUGXcm98eYvq0SdozPDp7SYcqrujDoP9b5fyH
         hb0I1uYYox3OK5ldVnklOUpoMDo7IXMeNvjXuMFUtnYSrfFvf7BVaZp4QsWi2tFKJVIS
         UeKbM90LHNpdUTLAg3Oq++mIhAK36IY3E9YK0jOnL1gjATZAKyCmaiAT+5uK6+RHHog+
         NHXdSKJrHBPT16RLXCKLh17t/HK3T2igP2pOt32bIZh0YfOEho9rFGV1vefUo+ZW+kp4
         pfKHDlTI0upcSxqkIGLP6EYHRDt4YAcMlWu2i9jMmcd/qnHVewdPMIJwXISCMvajcsEl
         CqDg==
X-Gm-Message-State: APjAAAVRYrKc2vRv9GZcrdC9Ifdskm2W2j2htKyY6UmIx3WGT7XcY+Jz
        P5LxYKWZ6Tr54Sh+scQJFk76c/EeySrJd8WINmY=
X-Google-Smtp-Source: APXvYqz+0JVIEsU24bFnQau8S2BrdGiGnZxRBMosJgbBUb1NmoIJj/vsmwJn15692JJkcLSHa5dudKqXB8mA9JM6wOE=
X-Received: by 2002:adf:b646:: with SMTP id i6mr48942wre.12.1555943766413;
 Mon, 22 Apr 2019 07:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190402131424.GA12935@192.168.3.9> <1554310465.118779.227.camel@acm.org>
In-Reply-To: <1554310465.118779.227.camel@acm.org>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Mon, 22 Apr 2019 22:35:55 +0800
Message-ID: <CAA70yB5BaGk0LLxvkNcYbbf+dyOy0sm+5hAXTM4arhcvCA4Fng@mail.gmail.com>
Subject: Re: [PATCH v2] block: don't show io_timeout if driver has no timeout handler
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Weiping Zhang <zhangweiping@didiglobal.com>,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Ping

Bart Van Assche <bvanassche@acm.org> =E4=BA=8E2019=E5=B9=B44=E6=9C=884=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:54=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 2019-04-02 at 21:14 +0800, Weiping Zhang wrote:
> > If the low level driver has no timeout handler, the
> > /sys/block/<disk>/queue/io_timeout will not be displayed.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>
>
