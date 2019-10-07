Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F17C4740A
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 08:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9079B2166E
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 08:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cyberfiber.eu header.i=@cyberfiber.eu header.b="ptz9AYD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfJGI6Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:58:16 -0400
Received: from filter01-out3.totaalholding.nl ([31.186.169.213]:42571 "EHLO
        filter01-out3.totaalholding.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726969AbfJGI6P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Oct 2019 04:58:15 -0400
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter01.totaalholding.nl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iHO4s-0006t1-6O
        for linux-block@vger.kernel.org; Mon, 07 Oct 2019 10:09:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D+PxyQH7cwD3wYQ0OLGyfmKavODj6xAEO+Ajnn59P8A=; b=ptz9AYD/GOIU9OXlgsttzUbVaa
        8mGvHoGfodCx7a7/oTtd/QxraRDlpgB1ieYh6kwL1SuDzPLrHP5ZdEPPsauqM/kQjMjVpJhINkM84
        TZmQvRsl8gBRfBVj9Xa60HXsPUeXGtqQZQGB7nYmoPDdteSGVnZDmHmA3ps25tS2TLP1ItMbAHlvm
        a4G1jTFgYBN6rmtrN3qCp2BYwFq9lGN0zdzSPeh9LdeKjIlenbOq8oZjWNyFnEzYx+A+Wc/JLSikB
        bsMrZ1z7zDCFbQnWpniFY/xc7Sp0sBuJNuTxdn4x44wdizgaRnq4YO2by0SwJVaTo4ynK+81L4wFu
        kJfKTV6w==;
Received: from 134-134-146-85.ftth.glasoperator.nl ([85.146.134.134]:60124 helo=DT0E.cyberfiber.eu)
        by www98.totaalholding.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iHO4s-0000m4-DC; Mon, 07 Oct 2019 10:09:10 +0200
Message-ID: <977cedab873dfe0705701b3b43c621a7a516e396.camel@cyberfiber.eu>
Subject: Re: packet writing support
From:   Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Date:   Mon, 07 Oct 2019 10:07:37 +0200
In-Reply-To: <71a450ed-3f52-fb3a-b0fa-3a08bdc4b3f6@suse.de>
References: <db5c89c3fe26e4b7ec96443ec97a05df97162889.camel@cyberfiber.eu>
         <6e381f83-9a12-30d7-8f99-caaa6a608c4f@kernel.dk>
         <a4b89c40caf62166ab7078296d73b6ae0f35adaf.camel@cyberfiber.eu>
         <fc70b63f-3780-5654-6bc5-0f2d6115bff0@kernel.dk>
         <6c51a5fe93cfad0f76fdbfe47caaa5f5d3f1ca88.camel@cyberfiber.eu>
         <71a450ed-3f52-fb3a-b0fa-3a08bdc4b3f6@suse.de>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.13)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ezqdolHG91LK5q2HN6uCHCpSDasLI4SayDByyq9LIhVJdEpaz+Henx5
 2cgUYhqj70TNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDrBQRDMCPoVIktGfXqz+K77w8
 BFityCCkxNlTi+jLDh0BcORxfCojcTOpEjtvWHp2XV7T+8DPdYCQzeqd3NLFGDg9YkzbMy6DOYhG
 3MUcvhr5WSIV/ADayw0YwNNo7qOm8DjomP3d2Aqxr0VfVhf3qadxWf7PBaiEJ7Ubv24eC2q1gqil
 FjLFGSoqbEUSByQZc902m46X3jN9PS6tQyC01uj4c2f7whGZQeSjyr0GZKfGsic78ymdeM3VZEm7
 AV0/pE0L1o9YbzgtZN/a2BQSBQgqdb/JjbdVZfbc9c+Jxpt+54iyUCc8aaknZho9naJYg0bolM7B
 /rBFul0ycjYHG0NfDxtcqznH5VBUud8O4LV0JmbqROuof5+bHLNCgb4217NirEYyqwqMBGrw8ELi
 qO86tByCP69i0Qh5ndH5heRCJ7rPXZbjpKeI7vxRvveCIK/1NH5THMtlYvyHAYGOGgjdb5hy4d8/
 k+RlvkD7ATmoZ2kfng5rdXwjvpU4S+XAhVR1id1GLKHJBvyjlI1w1E/J5phsv+xvB6Q7084Dep+t
 GiAymJKyPElPEMb0GdQ1VGRZ30Td82nYQ5FIgqTQcgX3MPaPCeumOhbpVZ03tIU95AZWtzQOODZY
 aBS/QaPai/btrmlhC85OkmJRZ+my2YLTiFllyX974CpAmwOWQt/Apnqpdot95Z1s2bBwfdm/8X6o
 RcYO63BwpS5C898CHW5uzy6lzOBEaaUKFzOKBEVOL4nawG8z87Sn7OLOV4LikazAQsNf7vua6ysA
 xFAilnb3SCYVYDSdH4IKBn5oTTl9HKvj+Li+B0slZd4aadi2b667E/1TXseb92FolcPTrPL5sKTz
 3tp9wpvGYs38JV+Sgf0DiLPRXTSWmFEPKyP0gxb6VQ9Dyf1mdym/fWDvnb+h1IgCQbaPY30Vfjqb
 xdTi1AYkryYheSAf/c7kR8HWm3EQIN2pUUDcOX/AZBHcfw==
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-10-07 at 09:23 +0200, Hannes Reinecke wrote:
> On 10/7/19 9:02 AM, Mischa Baars wrote:
> > On Sun, 2019-10-06 at 09:10 -0600, Jens Axboe wrote:
> [ .. ]
> > > I'm saying that you are comparing apples to oranges. The floppy driver
> > > might be older tech, but it's much more used than pktcdvd. It's not the
> > > case that we must pick one over the other, in terms of what stays and
> > > what goes.
> > > 
> > 
> > Yes we are, sort of. You can even have my pear. That's exactly the problem with your story :)
> > 
> > A DVD is 4Gb and Blueray goes all the way up to 100Gb, while a floppy disc is 1.44Mb.
> > Who would want to write his backup files to 1.44Mb floppy disc these days?
> > 
> Why do you keep on bringing up floppy?
> I was under the impression that you wanted to use pktdvd, not floppy...
> And as Jens made it clear, any potential removal of the floppy driver
> will have _zero_ influence on the future of pktdvd.

I do not keep bringing up the floppy drives. I'm merely trying to point out that removing the floppy driver is the more logical course of action.

Also, you must be mistaken. It's not about the potential removal of the floppy driver, it's about the removal of the packet writing driver. There will be no
pktcdvd kernel module in the future. To be precise, both reading and writing dvd's is already unsupported in the latest linux-next kernel.

> And in either case, the main question here was:
> Will you rebase your project to latest mainline once it's ready?
> Or will you settle on a kernel version to do your development on, and
> continue using that for your project?

No, the code is intended for companies like AMD, Intel or ARM. It is not indended for the opensource community. Does that mean that I cannot develop on an
opensource platform? Is that you are trying to tell me?

> Incidentally: I _do_ know of one company who happily will provide you
> with a stable OS to base your development on ... three, actually ...

You would like me to work with Microsoft products, don't you?

> Cheers,
> 
> Hannes

