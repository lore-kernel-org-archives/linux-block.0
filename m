Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1534CC433FF
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 01:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34F62166E
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 01:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap3AA5Q7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404787AbfHIBMQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 21:12:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36568 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404550AbfHIBMQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 21:12:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id k21so93084685edq.3;
        Thu, 08 Aug 2019 18:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q1VDmvy5H5V/lcQDElMHgpagqDBHRV5q2PlN+0yp058=;
        b=ap3AA5Q7qTtE00hxn3S74U63HIxZRuOIEAkqJtskyVa1jNpnNvhKUvDrT3dAGsl5SF
         h2/RDfNHPRr5jvA8f6B8NXM6HB02DfY+BP/8ghY3TDNi1E4A+9px3gb2AWH8EVgw6UWR
         5dKfp34zFQ2H1rLuXMNlFRuIVPEVt1gWvaRQdkB+rmgNXZPrMxnMrkunvkhKFoqjPcCv
         Dwrzw1Kt5tlCv0D2XXpTb9ueZanzUxnqkS1xdp9MK3eHxRebHwIBUF6xH07LUxddrU32
         95wwhu60FOS1kgOLv3zM+npKW+J94/3fxc84boCfaA3Y2puUH5U6GxfSjl1rwe5Hrjq4
         iBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q1VDmvy5H5V/lcQDElMHgpagqDBHRV5q2PlN+0yp058=;
        b=ZXAZxqasuxJOQGf/QK5MMecDd4sGl44k0D1SnQkInTITjCcsETm6CaBsltFwyEVzi7
         dzEoQFpPl1wpYIAD2NalB5LeUPSzBqEJax8WqXWMwgiV77xaCbhlJw3Fa2T8D/iJg+g4
         zynFAWxRsh/BRrUdqjFbr0Gc/JevulMDLXwxGlewmSn9ECTFEI+yS457EfIw4NjlX1nM
         Q/gdKDemYTr+h7xZKs1AjoAuw1/VzHXNnUgV6wW5FtXvdONNtqi8PYdoyaWC14YkahnR
         o12urW0QQ2ZtKl1V0yc0vryhoU5C3YAL+ssK7s5aBTrj9rvmk2xM2uXedR36VCnvYNLp
         WC8g==
X-Gm-Message-State: APjAAAXubARfIRy+mr0x5ILMsIqYtGBVZJuIAXgJu/hXFMyJAjXYOLUa
        +kAIZQQnxcAw8OTVtgNurAIKG3lbmVl6AdvCFQE=
X-Google-Smtp-Source: APXvYqw72mDmwWU01nhdnAQXUm1rWO+j4MknD7wIqU6RymBJZboowbBNIAROGI7j1bBlzLXNIgbxAtgfJJR0skLrINI=
X-Received: by 2002:a17:906:7cd6:: with SMTP id h22mr16154601ejp.254.1565313134395;
 Thu, 08 Aug 2019 18:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190808131100.24751-1-hslester96@gmail.com> <20190808133510.tre6twn764pv3e7m@Air-de-Roger>
In-Reply-To: <20190808133510.tre6twn764pv3e7m@Air-de-Roger>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Fri, 9 Aug 2019 09:12:04 +0800
Message-ID: <CANhBUQ1rSUPsg+XddCQ4B=JiSA8VV+YkdC-pmgY25hFnvwdFcw@mail.gmail.com>
Subject: Re: [PATCH 3/3] xen/blkback: Use refcount_t for refcount
To:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 8, 2019 at 9:35 PM Roger Pau Monn=C3=A9 <roger.pau@citrix.com> =
wrote:
>
> On Thu, Aug 08, 2019 at 09:11:00PM +0800, Chuhong Yuan wrote:
> > Reference counters are preferred to use refcount_t instead of
> > atomic_t.
> > This is because the implementation of refcount_t can prevent
> > overflows and detect possible use-after-free.
> > So convert atomic_t ref counters to refcount_t.
>
> Thanks!
>
> I think there are more reference counters in blkback than
> the one you fixed. There's also an inflight field in xen_blkif_ring,
> and a pendcnt in pending_req which look like possible candidates to
> switch to use refcount_t, have you looked into switching those two
> also?
>

I will switch those two in next version.

> Roger.
