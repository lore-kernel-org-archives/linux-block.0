Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF471C433EF
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 00:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B731961B73
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 00:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241768AbhKRAIr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 19:08:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240507AbhKRAIp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 19:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637193945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rE06j6Gm812CNNg+JzoY4Kvbmh0B4iBlDwTGhqLXqbs=;
        b=Sarim0KVKVE65ZKBjns49FlPPFLAH/gN4P0XeZK8pwWSqreD7bPCxqR6XlhSl/rmkM4fUk
        ne7S7i/eiM6C3VUAR6qdGB/oDCXDn6d4Hb/wP1fedrnzSOuX1jcSP7oqgAw3jLVEbGCLhG
        F2IrP/m0SoKOlcsZvSqRg6rGTxNIxVo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-F3xE65QkOQW-ua6yXavqLQ-1; Wed, 17 Nov 2021 19:05:44 -0500
X-MC-Unique: F3xE65QkOQW-ua6yXavqLQ-1
Received: by mail-yb1-f199.google.com with SMTP id v133-20020a25c58b000000b005c20153475dso6782196ybe.17
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 16:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rE06j6Gm812CNNg+JzoY4Kvbmh0B4iBlDwTGhqLXqbs=;
        b=ajfB+InFfIKGoGX4giNCuwjXaCNtqFq0hVJDnK6hTtrdXGNdRXujRVxOgif+rC3CXW
         ARwIbtktugyK3nqsMva4YwpIadNpkBBmqhGxdAKeeiw/QKj3RpHtCevaTMdjcWdhrMAn
         +n3YDZAzm6rydCwSt8RdcT0oyJrHvBnnzF6ZHYeEaj09Z/7Pxo+lSu4nJ3CbYSQBT/yl
         5ZOE8c/0OmFEW6zL1AmT7HX+BlKrqTwBw8LUyGgw29LMbIgsHEw6sOq80sbvtdM4CS3v
         lqeVaOhq5vFRq3L4flY9OnrPaQTIHtaSX180ANWOxYVIhmceLRPUByP+FNqyehCZJrJ6
         SXbw==
X-Gm-Message-State: AOAM530MUwavHY2gtsVDccpp2qHue+iu+70NX0Oz5stL/EawucieCpAC
        hrzSFEUONpPrxXNcdXWn90ge38E4mK1yW9TZ/+6Erd6OeOQfn02gFPMF0B9YSMLVXR/KcCbKxMO
        gn8z8VIC9F+UuqocdhUcxZOUFuDlVRw/3xx3tHrg=
X-Received: by 2002:a25:aaef:: with SMTP id t102mr22873447ybi.512.1637193944175;
        Wed, 17 Nov 2021 16:05:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLFlzBIb+EHRbG8grWk1hulciwp0L6hmvfkW4FKX0XHzdkvvxveQ2l6o6CLYqfMO9OY+bgGD/hNPhWtpTRVCY=
X-Received: by 2002:a25:aaef:: with SMTP id t102mr22873418ybi.512.1637193943977;
 Wed, 17 Nov 2021 16:05:43 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs97spcWGFjz4JPzaRuzHnRGZkKP6HWMSPkbKLS9EmWMJA@mail.gmail.com>
 <9095c05e-659f-dd4c-95f9-617026216550@kernel.dk>
In-Reply-To: <9095c05e-659f-dd4c-95f9-617026216550@kernel.dk>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 18 Nov 2021 08:05:33 +0800
Message-ID: <CAHj4cs9uT6discm7iGei+__KnA2SzA49e77nvW_B-RcKPFFGjA@mail.gmail.com>
Subject: Re: [regression] nvme pci sysfs remove operation hang during fio test
 observed on 5.16.0-rc1
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 17, 2021 at 11:58 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/17/21 8:57 AM, Yi Zhang wrote:
> > Hello
> >
> > I found this regression issue on 5.16.0-rc1, pls check it and let me
> > know if you need any test/debug info for it, thanks.
>
> Pull in block-5.16 and it should be fixed.

Yeah, it was fixed, thanks.

>
> --
> Jens Axboe
>


-- 
Best Regards,
  Yi Zhang

