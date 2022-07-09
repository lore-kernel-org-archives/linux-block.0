Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D9DC43334
	for <linux-block@archiver.kernel.org>; Sat,  9 Jul 2022 03:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiGIDUB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jul 2022 23:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIDUA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jul 2022 23:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2AFB6390E
        for <linux-block@vger.kernel.org>; Fri,  8 Jul 2022 20:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657336795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6tEa4h3AuCWiVLODFkT+rRGEj5LGAYoGPlr3UlbCOYw=;
        b=FpT5AFxqL+I9faMuejwxFrwIt+2h8HOCgnr7E9FgwtDAd/SuJE3KoHqEKWyJ9itxdgmV60
        zUngDHHZk7u6SAw7+fpA80GZqHFcsOSIAaW4QogQ/vD1v6fxHzRr4dIAXeNzdSL5mXxF4b
        y9/2SR2HJ6TSCqXB5gJW1GdK+0STpNA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-9f9kaj-zPkOqSXh52ads8Q-1; Fri, 08 Jul 2022 23:19:53 -0400
X-MC-Unique: 9f9kaj-zPkOqSXh52ads8Q-1
Received: by mail-pj1-f70.google.com with SMTP id mm6-20020a17090b358600b001ef7bd409b0so326792pjb.8
        for <linux-block@vger.kernel.org>; Fri, 08 Jul 2022 20:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tEa4h3AuCWiVLODFkT+rRGEj5LGAYoGPlr3UlbCOYw=;
        b=0xbtVUiYGB9f2kiXRs4MxA/p1QY8rv9UwjemAluWIeCLB71iflqAvfwnme7KClvQYc
         2KvxcSBQ+XDAt7XTSHALaQ9i5SOjt5juqhkIAW0y45ID13SLUCmXfmR4XSkbqr6b5hsN
         LrYY0ipaZXEC0fpoFtZcnX8Llp+78twf98ao1T3LOXlfUFFmGMGjhcwmxF+jK0nvPGNs
         0rVo2/q7b1hsw7lQStN01EjGdPsUYPst1crEnZ1WwNoSYZvKUFQfASLoYG1EdvRsgVwA
         aSUPGLdVktVLU31RTT883ZJEJwDVTRqTWHDUX0e9jtcYY0SzUVRupNF8lg3U39N+DpBs
         Y9hw==
X-Gm-Message-State: AJIora/s/cXeCDisXO9AQsTGnEhiB/RQDsfpUnlXeRdJb9Q/owtSTl80
        tAs73o4k602mUvD7CLoSe18AM/4ciIEDJ5Lk5EeSCBOt5+uNcbEajLeiVpBFcxKev8XGt6lUcmN
        2Bk461ix/JXnnH+aKNFUhXpsAxEMsBLtEB5vLpqc=
X-Received: by 2002:a17:902:7fc2:b0:16b:dc53:5060 with SMTP id t2-20020a1709027fc200b0016bdc535060mr6963798plb.95.1657336792550;
        Fri, 08 Jul 2022 20:19:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tJVTqZUrgGkJr+6RIms7c9nogEy1BpM0bt5qUl2JUpn+ksyqbgeDB7DA6BEla8M+7/b+q+bsw5N5dBmlbfJVI=
X-Received: by 2002:a17:902:7fc2:b0:16b:dc53:5060 with SMTP id
 t2-20020a1709027fc200b0016bdc535060mr6963773plb.95.1657336792237; Fri, 08 Jul
 2022 20:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9Jhg4DZRnck_rdGWtpv9nLTAF__CVtPQu9vViVUZ-Odg@mail.gmail.com>
 <def01493-bd2d-bed4-ab1a-9b4304687692@acm.org>
In-Reply-To: <def01493-bd2d-bed4-ab1a-9b4304687692@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sat, 9 Jul 2022 11:19:41 +0800
Message-ID: <CAHj4cs-xUroRHbvY4kBPCBFgch7d24yXDFLo4P_ym8KEkHCvug@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/005 trigered debugfs: Directory
 'hctx0' with parent '/' already present!
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jul 9, 2022 at 2:59 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 7/8/22 09:32, Yi Zhang wrote:
> > I found below error log when I ran blktests nvme/ tests on aarch64
> > with the latest linux-block/for-next,
> > Please help check it, and feel free to let me know if you need any
> > info/test for it, thanks.
>
> Is this 100% reproducible? I tried to reproduce this yesterday but
> without success. See also
Yes, it always can be reproduced at the second run of "nvme_trtype=tcp
./check nvme/005"
I reproduced it on aarch64, not sure if it's arch related.

> https://bugzilla.kernel.org/show_bug.cgi?id=216191.
I tried block/001, and cannot reproduce it.

>
> Thanks,
>
> Bart.

>


--
Best Regards,
  Yi Zhang

