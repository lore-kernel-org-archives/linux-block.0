Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D32C4740A
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 07:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE0F22474
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 07:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cyberfiber.eu header.i=@cyberfiber.eu header.b="FHDsTOMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfJGHEI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 03:04:08 -0400
Received: from filter02-out8.totaalholding.nl ([185.56.145.240]:37157 "EHLO
        filter02-out8.totaalholding.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726202AbfJGHEI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Oct 2019 03:04:08 -0400
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter02.totaalholding.nl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iHN3l-0004f3-Vu
        for linux-block@vger.kernel.org; Mon, 07 Oct 2019 09:04:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VcuFljo9M9yQbq4PEe3jpUUcDjctI2XyByIGTG0GVHE=; b=FHDsTOMnkdPLtEPAAw+F6WFx/R
        H8jTI3ddxXGMLQKm49819Nire//JOYbJ/ftQ1Bw/8Nid7A4/ysylj1xEuTecRUm2kK/vSWkPwliMd
        GeqcFB9EFcnSHkC5U12YRX7zrObXrNOdqnDcy6WRxbhOZ9PnGX1OV82Hk/BlUEKman6XpJwFcTSlb
        dQTkvvY1incm0BNYoWcCDL3xVlSdBA32BkjWVTUu5zAH/vyVbpWZJdtYfoB1yf6MLmcbRmyNfYWj1
        H83SuDvXUEXTcBQ6okNS0BVcVuCRNUu6ls6qj4IC9wBTIJo7+NmRT08jv85fP5Eom5ox134eU8gHl
        UeISc+CQ==;
Received: from 134-134-146-85.ftth.glasoperator.nl ([85.146.134.134]:59922 helo=DT0E.cyberfiber.eu)
        by www98.totaalholding.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iHN3m-00061P-20; Mon, 07 Oct 2019 09:03:58 +0200
Message-ID: <6c51a5fe93cfad0f76fdbfe47caaa5f5d3f1ca88.camel@cyberfiber.eu>
Subject: Re: packet writing support
From:   Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Date:   Mon, 07 Oct 2019 09:02:25 +0200
In-Reply-To: <fc70b63f-3780-5654-6bc5-0f2d6115bff0@kernel.dk>
References: <db5c89c3fe26e4b7ec96443ec97a05df97162889.camel@cyberfiber.eu>
         <6e381f83-9a12-30d7-8f99-caaa6a608c4f@kernel.dk>
         <a4b89c40caf62166ab7078296d73b6ae0f35adaf.camel@cyberfiber.eu>
         <fc70b63f-3780-5654-6bc5-0f2d6115bff0@kernel.dk>
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
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.27)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ezqdolHG91LK5q2HN6uCHCpSDasLI4SayDByyq9LIhVlou36wB0H8tu
 /aHNNYerv0TNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDrBQRDMCPoVIktGfXqz+K77w8
 BFityCCkxNlTi+jLDh0BcORxfCojcTOpEjtvWHp2lffyJjHzmSegA20b0GS7zTg9YkzbMy6DOYhG
 3MUcvhr5WSIV/ADayw0YwNNo7qOm8DjomP3d2Aqxr0VfVhf3qadxWf7PBaiEJ7Ubv24eC2q1gqil
 FjLFGSoqbEUSByQZF+KbsVJyJvk1v2cRMLfeu+j4c2f7whGZQeSjyr0GZKfGsic78ymdeM3VZEm7
 AV0/pE0L1o9YbzgtZN/a2BQSBQgqdb/JjbdVZfbc9c+Jxpt+54iyUCc8aaknZho9naJYg0bolM7B
 /rBFul0ycjYHG0NfDxtcqznH5VBUud8O4LV0JmbqROuof5+bHLNCgb4217NirEYyqwqMBGrw8ELi
 qO86tByCP69i0Qh5ndH5heRCJ7rPXZbjpKeI7vxRvveCIK/1NH5THMtlYvyHAYGOGgjdb5hy4d8/
 k+RlvkD7ATmoZ2kfng5rdXwjvpU4S+XA+ln3SmdyWNNJvR4I+Hp8ZWNeKErwtwuMGNtXyijhL/he
 +Yies+K5FQn8vYvEg4R1ssQttTq2W/PyuXc9rk1LZdVnAwYmYPhCtjQveFc/ttqzpjogZOIQLFqr
 QNK2b8/y4JRq3UYHEt22IvIMKBSTlfO+aaj6wnK9h39sR8Y3Dzu1X2iVNki8izWZuQRxhjw0T1+z
 /gVqUXbO3Yb0X5mHnKlPPR+MZWSVI6ySzYXPQ00ewK91rfjpSnVyLT4JKsE1F7I6vAoqMu7bH6bh
 5Tn1+ApfpnfqaBDETpAVW0am1AftxOzzT/YWdmD8gywgB151uK+wsnvd2XRh79oPsqvurHLa/P4e
 zC06EoqeDuStmICc1mvxWkfhDNLhFrRgdcJncNLOj0gyfC+E+JhwuM2loN6g5fMPPHW04q0LBG3v
 ooS/KWL2TW1pyb+uOnvvAx7DvnjL6OI0XUlLzsHhA6/79TEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2019-10-06 at 09:10 -0600, Jens Axboe wrote:
> On 10/6/19 1:31 AM, Mischa Baars wrote:
> > Hi Jens,
> > 
> > On Sat, 2019-10-05 at 09:50 -0600, Jens Axboe wrote:
> > > On 10/5/19 4:12 AM, Mischa Baars wrote:
> > > > Advised by the linux-next mailing list to repost this message on the linux-block mailing list:
> > > > 
> > > > Hi,
> > > > 
> > > > If I'm correct, packet writing support is going to be removed from the
> > > > Linux kernel. Is there any particular reason for
> > > > this, as far as you people know? Both DVD-writers and Blueray-writers are
> > > > still being sold to date.
> > > 
> > > The reasons are mostly that it's ancient technology and my doubt was
> > > that nobody used it, and it's completely unmaintained code as well.
> > > 
> > 
> > How can it be ancient technology when CD-, DVD- and Blueray-writers
> > are being sold by the thousands at this very moment? Floppy disk
> > drives on the other hand were invented in 1967. This is the ancient
> > technology you're looking for.
> 
> It's a suboptimal solution to the fact that devices were put to market
> that required > page sized writes at the time. Hence pktcdvd sits in
> between and ensures that we write out blocks that are big enough. If the
> kernel supported > page size block sizes on file systems, pktdvd would
> be superflous.
> 
> And please stops bringing up floppy, it's totally irrelevant to this
> conversation.
> 
> > > > I'm currently working on quite a large project. I would be dependent
> > > > solely on USB to store my backup files, when the packet writing support
> > > > is removed. Actually I'm quite uncomfortable with that idea, because
> > > > USB is rewritable. Any serious attempt to do damage to my project will
> > > > result a permanent loss of code. Personally I would do anything to keep
> > > > packet writing support in the kernel.
> > > 
> > > If there are folks using the code (successfully), it's not going away.
> > > But I can't quite tell from your email if you're just planning to use
> > > it, or if you are using it already and it's working great for you?
> > > 
> > 
> > Yes, I've written the the code myself, thank you. It's prototype
> > hardware and it's not intended as an open source software project. It
> > is therefore not going to be released to the general public. When it's
> > finished, and it isn't at the moment, it's hopefully going to be part
> > of your future processors.
> 
> Let's keep this very simple:
> 
> 1) Have you used the pktcdvd code at all? How much?

Where are talking about the kernel/drivers/block/pktcdvd.ko.xz module. I have not used it directly, as it is a kernel module. Instead I have been working with
K3b, the KDE cdwriting software package.

Quite a lot actually, let's say I have written about 11 * 25 cd's / dvd's in total. Without any problems. They are all still readable too, even after all this
time (about ten years). 

> 2) If yes to the first question, has it been stable?

Very stable if you ask me. Flawless even.

> > I did however find a enormous lot of bugs (in the kernel, the
> > compiler, and in latex) since the project start, that deserve the
> > attention of the opensource community. The bugs will come available to
> > you in time. We can work on a better kernel and compiler together.
> 
> So bugs in pktcdvd? Or others parts?

No, no bugs in pktcdvd. No fixing to do whatsoever.

> > > > I'd hoped you could remove normal floppy disc support instead. That
> > > > seems the more logical course of action. Floppy disc drives aren't
> > > > being sold anymore for quite some years now.
> > > 
> > > It's not really a case of quid pro quo, if someone gets removed,
> > > something else can stay. I'd argue that the floppy driver is probably
> > > used by orders of magnitude more people than the packet writing code,
> > > and as such that makes it much more important to maintain.
> > > 
> > 
> > Who are you talking about? Are you asking to be removed? I'm afraid I
> > don't quite understand.
> 
> I'm saying that you are comparing apples to oranges. The floppy driver
> might be older tech, but it's much more used than pktcdvd. It's not the
> case that we must pick one over the other, in terms of what stays and
> what goes.
> 

Yes we are, sort of. You can even have my pear. That's exactly the problem with your story :)

A DVD is 4Gb and Blueray goes all the way up to 100Gb, while a floppy disc is 1.44Mb. Who would want to write his backup files to 1.44Mb floppy disc these days?

Regards,
Mischa.

