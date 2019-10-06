Return-Path: <SRS0=GTOX=X7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD13C4360C
	for <linux-block@archiver.kernel.org>; Sun,  6 Oct 2019 08:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8282133F
	for <linux-block@archiver.kernel.org>; Sun,  6 Oct 2019 08:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cyberfiber.eu header.i=@cyberfiber.eu header.b="uwGAJCod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfJFICT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Oct 2019 04:02:19 -0400
Received: from filter01-out9.totaalholding.nl ([85.17.242.87]:38523 "EHLO
        filter01-out9.totaalholding.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726207AbfJFICT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 6 Oct 2019 04:02:19 -0400
X-Greylist: delayed 1779 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Oct 2019 04:02:17 EDT
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter01.totaalholding.nl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iH11w-0001Gc-6m
        for linux-block@vger.kernel.org; Sun, 06 Oct 2019 09:32:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tUJmv8KBuuRXGS8KGPECYmoiSmgCRz2L0wr1uO+Dpfw=; b=uwGAJCodVs9+5qcohYeFpjLOQt
        T2r9AP/i9RYBOujSJtyNAjJweiErN67WFm2/OsVEuRZ298mIKtZyF3/5rx3YDf38uKf2kRc+nYXAz
        gkHf5OAmOZzRHHLfTKoiy+XLgLVDUvoSuPe1HbSpntV6NE8vLoMar1rb4jS2X7Ve51LkGIjtV+k1R
        oEaOJvA2Ga1WRyf439J0v1Misw0BEr2h7m5FaQYSeeyTdcfhhwWDh4ZgqFZXyIHUod3+6di26Ngqw
        sC1gbuOTP0Ve5SeN26XOTPs57ANe3u6XgRQFpe9OWH252byhxSpUBMYRhfHZLXXD44ecz1P2qGCDS
        tQvQfK2A==;
Received: from 134-134-146-85.ftth.glasoperator.nl ([85.146.134.134]:34796 helo=DT0E.cyberfiber.eu)
        by www98.totaalholding.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iH11v-0007km-P7; Sun, 06 Oct 2019 09:32:35 +0200
Message-ID: <a4b89c40caf62166ab7078296d73b6ae0f35adaf.camel@cyberfiber.eu>
Subject: Re: packet writing support
From:   Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Date:   Sun, 06 Oct 2019 09:31:06 +0200
In-Reply-To: <6e381f83-9a12-30d7-8f99-caaa6a608c4f@kernel.dk>
References: <db5c89c3fe26e4b7ec96443ec97a05df97162889.camel@cyberfiber.eu>
         <6e381f83-9a12-30d7-8f99-caaa6a608c4f@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - www98.totaalholding.nl
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cyberfiber.eu
X-Get-Message-Sender-Via: www98.totaalholding.nl: authenticated_id: mjbaars1977.linux-block@cyberfiber.eu
X-Authenticated-Sender: www98.totaalholding.nl: mjbaars1977.linux-block@cyberfiber.eu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Originating-IP: 185.94.230.81
X-SpamExperts-Domain: out.totaalholding.nl
X-SpamExperts-Username: 185.94.230.81
Authentication-Results: totaalholding.nl; auth=pass smtp.auth=185.94.230.81@out.totaalholding.nl
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.32)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ezqdolHG91LK5q2HN6uCHCpSDasLI4SayDByyq9LIhVemTvXwSoHVrM
 Zy0vRb/SgETNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDrBQRDMCPoVIktGfXqz+K77w8
 BFityCCkxNlTi+jLDh0BcORxfCojcTOpEjtvWHp2vUsC5D3HdNxIQSQrqpVmijg9YkzbMy6DOYhG
 3MUcvhr5WSIV/ADayw0YwNNo7qOm8DjomP3d2Aqxr0VfVhf3qadxWf7PBaiEJ7Ubv24eC2q1gqil
 FjLFGSoqbEUSByQZc902m46X3jN9PS6tQyC01uj4c2f7whGZQeSjyr0GZKei3GSvwir0OshyEkOw
 fCYvJRLqCXwZ1lLOS3w3BIDj/vtduhq2eYJp1M6uQht/3vmQeETIza2ISn5dEgBRzdTORAwX31WV
 Y5lWjWxuGSRuxWXf5NNoWqxwzT7YQb2bq3uDyiKr2bObCttBtO6VKDuO5YE5enyccp7RH4WQio3u
 GdiBOWdyCfmuoHBoHDwUzk5JaKOFs8saAYDXeULHXubmmAaukvjjB3H15eqNCNu9Sik4xAm9D8KT
 eKJT7gNACPd+5CDNPcr0lQdM2IbB/ACba2hPlcWz+/ka0Jz8k5SXCkoq/NrO1ynXbs8iot7lhmWv
 Ugie2Mg51i4RxB4Shf1soxt5ZPZW/MPCafNVDdgaGMkwftihmYbZeHoaTU0hoD+qre98Cwa2gTLo
 VdoPF0VK1x66Qw3T0UFAji0c5knCvOVEuCim6e30IO5icHqQdUOIuwMKV9tojzhFmK6DBPxB1Dzh
 Abz0k3oy+k13MupbujEEAftWubkgOTRcKPBjduEccBIk1Sag4dKiqCrF8eZZFzniHPxtHdK1NLmO
 gcMupCl+RmG1mdc9Jig47dwRByefHnIJ+kdneJuZ34MFaGRAQ2K5UjhgJmfm3gS/XH6VTwQCojDi
 NLBubQBrRmHyHyUelVs1LOVCK8p6qw0xNxh35NpS3rE/TCb4GSlUZGHqBPwdYV2wDufUP/TgvnLT
 shxfUfin6s8/+LT9ZdCyQwcPTHoJXz4t2QVQW74e+jwXGg==
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On Sat, 2019-10-05 at 09:50 -0600, Jens Axboe wrote:
> On 10/5/19 4:12 AM, Mischa Baars wrote:
> > Advised by the linux-next mailing list to repost this message on the linux-block mailing list:
> > 
> > Hi,
> > 
> > If I'm correct, packet writing support is going to be removed from the
> > Linux kernel. Is there any particular reason for
> > this, as far as you people know? Both DVD-writers and Blueray-writers are
> > still being sold to date.
> 
> The reasons are mostly that it's ancient technology and my doubt was
> that nobody used it, and it's completely unmaintained code as well.
> 

How can it be ancient technology when CD-, DVD- and Blueray-writers are being sold by the thousands at this very moment? Floppy disk drives on the other hand
were invented in 1967. This is the ancient technology you're looking for.

> > I'm currently working on quite a large project. I would be dependent
> > solely on USB to store my backup files, when the packet writing support
> > is removed. Actually I'm quite uncomfortable with that idea, because
> > USB is rewritable. Any serious attempt to do damage to my project will
> > result a permanent loss of code. Personally I would do anything to keep
> > packet writing support in the kernel.
> 
> If there are folks using the code (successfully), it's not going away.
> But I can't quite tell from your email if you're just planning to use
> it, or if you are using it already and it's working great for you?
> 

Yes, I've written the the code myself, thank you. It's prototype hardware and it's not intended as an open source software project. It is therefore not going to
be released to the general public. When it's finished, and it isn't at the moment, it's hopefully going to be part of your future processors.

I did however find a enormous lot of bugs (in the kernel, the compiler, and in latex) since the project start, that deserve the attention of the opensource
community. The bugs will come available to you in time. We can work on a better kernel and compiler together.

> > I'd hoped you could remove normal floppy disc support instead. That
> > seems the more logical course of action. Floppy disc drives aren't
> > being sold anymore for quite some years now.
> 
> It's not really a case of quid pro quo, if someone gets removed,
> something else can stay. I'd argue that the floppy driver is probably
> used by orders of magnitude more people than the packet writing code,
> and as such that makes it much more important to maintain.
> 

Who are you talking about? Are you asking to be removed? I'm afraid I don't quite understand.

Regards,
Mischa.

