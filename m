Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC59C433F5
	for <linux-block@archiver.kernel.org>; Sat, 27 Nov 2021 02:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbhK0CYu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Nov 2021 21:24:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21848 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231511AbhK0CWu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Nov 2021 21:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637979576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zaIv11LfWbkrJcok1nuicSB6CCct1DxBM+c/FnWrGy4=;
        b=MONJrkOwjr/BQoV4fZpqj31W0d3KOrRsydrxJrHR3s2WkNnMik+MNaXqWdbcJRltmhCW2K
        sZP+3KuBXMg6gibf9hdyGPlSvQRiidfFkUabF3Nf1Q+5qnkfupnGHlDmVfA9peVmeu6tMp
        gB+f0iKNU/4U5kIICHJLSWucTDnbh9Q=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-zIzvLsmDNzm3iKBRg6SUaA-1; Fri, 26 Nov 2021 21:19:34 -0500
X-MC-Unique: zIzvLsmDNzm3iKBRg6SUaA-1
Received: by mail-yb1-f199.google.com with SMTP id q198-20020a25d9cf000000b005f7a6a84f9fso13000189ybg.6
        for <linux-block@vger.kernel.org>; Fri, 26 Nov 2021 18:19:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zaIv11LfWbkrJcok1nuicSB6CCct1DxBM+c/FnWrGy4=;
        b=mtVcPxkkG+rO6f1vRY4NOrSN6+BCq2rHOPqHTXUsHYMjMWZchDb88L2IlYHtx4jdT1
         UDrRMgjWxpPPRHcAPYdHnEEfPGAY1fT+VgnjhSFtGvmtQvu4tsmsx8h4PMvwpIR3WmE0
         WhqQ6I7Rbb2gfXMU5CdTH4Xlfu9dsFbJIp+cGDVUpEnZ2JRytOG1Nwt5hRhpwi9MdtUX
         1Bg9Kf43ZCMoMLJp5lcXXE4tyqNfCEPFsyA/rhmg3/MDfiOE0u8/sF4WISPyC8p55El5
         kH4P6U0miLeQXMv/0aGErDQuK3XBFbFzJl05ZUa+QENBXycEnXTLaFjvpUMjhiSgNzpD
         w0Ag==
X-Gm-Message-State: AOAM530TKaIHOfhRqSi95evK5HcUpG9x0iPiMsbGaaikJ5oJwE+KArc+
        EFUUISUz2TT4QttmYiVrx+1qG1HiWAyP7m3MH15P/BgP440jrkNjNs/thzL1LGkUdZgWGrDRjjF
        ZgBUpYhE07JW/XfVdL2kzl+P+H/QRdAI5cYhCkR0=
X-Received: by 2002:a25:77d7:: with SMTP id s206mr20024594ybc.512.1637979573471;
        Fri, 26 Nov 2021 18:19:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwV+YmlIYD4PnNXfCDVlBFGHxaTfU1Q/dUewB8jO6xeHoH1NlRkY4ZBA72ZzNW7aLnJM2/q7LEtL0GIiVYVfq4=
X-Received: by 2002:a25:77d7:: with SMTP id s206mr20024576ybc.512.1637979573292;
 Fri, 26 Nov 2021 18:19:33 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8=xDxBZF62-OekAGtHDtP6ynALKXm7fK2D2ChpNXnGAw@mail.gmail.com>
 <YaBGI7bR/9ot514F@T590> <YaEKWPlAmDJYV6Si@T590> <d909e3a1-942a-efe8-0f8a-f1206676a40f@kernel.dk>
In-Reply-To: <d909e3a1-942a-efe8-0f8a-f1206676a40f@kernel.dk>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sat, 27 Nov 2021 10:19:22 +0800
Message-ID: <CAHj4cs_NcY-51LjP_dku3GGn7Oy_K=KF3HhjnnJQoUfUcN5d=Q@mail.gmail.com>
Subject: Re: [bug report] WARNING at block/mq-deadline.c:600
 dd_exit_sched+0x1c6/0x260 triggered with blktests block/031
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 27, 2021 at 12:38 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/26/21 9:24 AM, Ming Lei wrote:
> > On Fri, Nov 26, 2021 at 10:27:47AM +0800, Ming Lei wrote:
> >> Hi Yi,
> >>
> >> On Thu, Nov 25, 2021 at 07:02:43PM +0800, Yi Zhang wrote:
> >>> Hello
> >>>
> >>> blktests block/031 triggered below WARNING with latest
> >>> linux-block/for-next[1], pls check it.
> >>>
> >>> [1]
> >>> f0afafc21027 (HEAD, origin/for-next) Merge branch 'for-5.17/io_uring'
> >>> into for-next
> >>
> >> After running block/031 for several times in today's linus tree, not
> >> reproduce the issue:
> >
> > Yi, it should be one for-5.17/block only issue, please test the
> > following patch:

Thanks Ming, the issue was fixed:

Tested-by: Yi Zhang <yi.zhang@redhat.com>

>
> Good catch, again - can't believe this keeps biting us, guess we just
> have to get used to this pattern. Though not expecting many changes
> there in the future, so maybe not a huge issue.
>
> --
> Jens Axboe
>


-- 
Best Regards,
  Yi Zhang

