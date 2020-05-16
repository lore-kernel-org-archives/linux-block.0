Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A78CC433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 07:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE14206F4
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 07:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgEPHkq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 03:40:46 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50341 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgEPHkp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 03:40:45 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N2Ujn-1j5IkW28WV-013zOi for <linux-block@vger.kernel.org>; Sat, 16 May
 2020 09:40:43 +0200
Received: by mail-qt1-f174.google.com with SMTP id v4so4050870qte.3
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 00:40:43 -0700 (PDT)
X-Gm-Message-State: AOAM5339O+QFLvC48ZNFH+McRFzpwxnB2ZWywz8U78/RbrbmfFa/tkuu
        6mFwBHtkDLYDiFJvEw4F6gR1o5SzXlhmvh+2AYs=
X-Google-Smtp-Source: ABdhPJxcEfJU96uHck57iuTGtaWAKQJ4BTxrNfthc1LMg0oXfgP7f3pwOD+atrD1szFtyWWYd5iHedeHHhTBMq0MRNc=
X-Received: by 2002:ac8:6914:: with SMTP id e20mr7226813qtr.7.1589614842445;
 Sat, 16 May 2020 00:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200516001914.17138-1-bvanassche@acm.org> <20200516001914.17138-2-bvanassche@acm.org>
In-Reply-To: <20200516001914.17138-2-bvanassche@acm.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 16 May 2020 09:40:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1FFgWp2P9tuaaBLtLy5KzxekuL1oVNsJuJQQY_Cism2A@mail.gmail.com>
Message-ID: <CAK8P3a1FFgWp2P9tuaaBLtLy5KzxekuL1oVNsJuJQQY_Cism2A@mail.gmail.com>
Subject: Re: [PATCH 1/5] block: Fix type of first compat_put_{,u}long() argument
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:TbfH9GInwxIfTncVPR0YiJhphAPI8SFM/M3+ncORho/Wu+fBaQb
 RXADQTPiRMQhd780rY52pQQSQgZ2rWmlm6Jf/g+lNowQOiYt4SbT1X/yvMHcdUwLkydDB/4
 Ui14r8iZlST41Gf2ASj6BDFPrJn76F9xbAP8z3Ah2WDlg4lAA52B/1OHDTLRb+zTJd6rAI5
 6J4aSm9JKA0EfO+4xnZXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QCnZWrxhXy4=:nLKgjzRpRseTrC2WcEQP3R
 J9DdSoXs8tCIWlaTkrr5ziXswBSAesEohnA4Ttl2+usQ3B51cw0XQHwjQjDDP0tEBIQSXGWUv
 AgLAV16ky/IB+tWg3JQAoG93dvoV8/12CYP1kMnTwzf386uNfgFBPP/JGlpLbEf6PGm6RB7xJ
 MG4QWDKZ100o3nq/8DOgaZw5io1BcKOveIjpa/LZmNebhTbdNiCAKCLCSdqJEa/xycqfg8fd/
 aG88CCfB54CLwJEFOvGe/dkrxPT0FMxDnR+eIxJ2yDWFwNTdfcK/eTZDbnioURKXcHZMu8ctP
 4iBhPGraK9K4ZLD7y1OGYdW3TJnPCpFDg3Ah9gtDo1OL3dsez1dIhhSckzKhwghAnbdocyB8Q
 AmIRZiKiabeuTdiFxv1xd1nrp3XoyXvCdWREInyl+zp5X1mjo9z5lLufa9fCq96jZFWpy6PWr
 TvhYYm3GT/oprlZ3lod6n/v2sgTJZvn/s6p0P27jcyUiyW9FeNwMoJ5HaAJhCXOji3KJqsqei
 mRmyelbZB4IELypzaJlJoEu2mTAbqIxItjQ4zFwoZiUldokd5IJkfA/TMVNpQhgbXPCBuxd/h
 QCzGdYJTtpba1PKCjLJMCpBvU/VCAnK2SMySEuop9IxRLQNxFCcnlqW6nrJgwvUtA22q2swR1
 F8TM+QyXGFippvnFBdEed98RMIAdvWWHvl5KcpT6MWVn2gHEx7VOB8/ADWwggODMTjcAwnHSn
 GaWz4ln0VJtKdC6RlmG99aey3wqY9VZj8OpjwY7ZS5S2Gt2/aRZ04bNbVegDClfF6GqkWxeeD
 tH0iCqHV7eQTuQjTFvKiMKu75kJrrOA5YBYsvfhMYonPjVmkPI=
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 16, 2020 at 2:19 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> This patch fixes the following sparse warnings:
>
> block/ioctl.c:209:16: warning: incorrect type in argument 1 (different address spaces)
> block/ioctl.c:209:16:    expected void const volatile [noderef] <asn:1> *
> block/ioctl.c:209:16:    got signed int [usertype] *argp
> block/ioctl.c:214:16: warning: incorrect type in argument 1 (different address spaces)
> block/ioctl.c:214:16:    expected void const volatile [noderef] <asn:1> *
> block/ioctl.c:214:16:    got unsigned int [usertype] *argp
> block/ioctl.c:666:40: warning: incorrect type in argument 1 (different address spaces)
> block/ioctl.c:666:40:    expected signed int [usertype] *argp
> block/ioctl.c:666:40:    got void [noderef] <asn:1> *argp
> block/ioctl.c:672:41: warning: incorrect type in argument 1 (different address spaces)
> block/ioctl.c:672:41:    expected unsigned int [usertype] *argp
> block/ioctl.c:672:41:    got void [noderef] <asn:1> *argp
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Fixes: 9b81648cb5e3 ("compat_ioctl: simplify up block/ioctl.c")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Thanks for the fix!

Acked-by: Arnd Bergmann <arnd@arndb.de>
