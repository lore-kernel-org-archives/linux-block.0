Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13137C4740A
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 08:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A6A21655
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 08:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cyberfiber.eu header.i=@cyberfiber.eu header.b="QQ2vc3sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfJGIbx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:31:53 -0400
Received: from filter01-out3.totaalholding.nl ([31.186.169.213]:47417 "EHLO
        filter01-out3.totaalholding.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727252AbfJGIbw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Oct 2019 04:31:52 -0400
X-Greylist: delayed 1354 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Oct 2019 04:31:51 EDT
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter01.totaalholding.nl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iHO7p-0000uU-Od
        for linux-block@vger.kernel.org; Mon, 07 Oct 2019 10:12:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b2Q6geVg3PGB8iBc5GhtSrrvTtH2ztIP8x9zR5aOquw=; b=QQ2vc3sa9uqfIwcPFQyOxM+/8M
        6iFsDO39JwFVONUlYuIThVQm3HPn2e7dUwPrepOhJm52gsF6twwC62rmrURJtbJZPTQpk+7/I+kGz
        5zSJxhKTSjgNWNZuHWX2jswSwvxDEwrNjbYBuhP4wu6enHZFkqQzTPCqbC1qLJH2g29b7MNyh+O6w
        kCr/hMMWOZUScyXYc5+ZAwJqQqTAqW1sWfDwDY48iryo8dOo0yo+4Q7TzZ1AFSo7o2kJNKrH9Mwrd
        tH1aXQYlfq8EZG7GYsX8jO29CiGHVXKJtp4Xj2fWeSADXasqzLfsdqRN+u5pziVYXbwyBOIrkH5oT
        gHHGticw==;
Received: from 134-134-146-85.ftth.glasoperator.nl ([85.146.134.134]:60126 helo=DT0E.cyberfiber.eu)
        by www98.totaalholding.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iHO7p-0001xD-W2; Mon, 07 Oct 2019 10:12:14 +0200
Message-ID: <47605481ea8c32e5f63a106ec50d27d7915bc316.camel@cyberfiber.eu>
Subject: Re: packet writing support
From:   Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>
To:     Laurence Oberman <loberman@redhat.com>, linux-block@vger.kernel.org
Date:   Mon, 07 Oct 2019 10:10:41 +0200
In-Reply-To: <a5c5b4da389e43ac4fb6960135f634a6e2b8ee13.camel@redhat.com>
References: <db5c89c3fe26e4b7ec96443ec97a05df97162889.camel@cyberfiber.eu>
         <6e381f83-9a12-30d7-8f99-caaa6a608c4f@kernel.dk>
         <63a7e40795da8efc782c1985ceeb54e0d3e708b6.camel@cyberfiber.eu>
         <a5c5b4da389e43ac4fb6960135f634a6e2b8ee13.camel@redhat.com>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.28)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ezqdolHG91LK5q2HN6uCHCpSDasLI4SayDByyq9LIhVTykWBs1PHleD
 BroF0h12dUTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDrBQRDMCPoVIktGfXqz+K77w8
 BFityCCkxNlTi+jLDh0BcORxfCojcTOpEjtvWHp2PKN1o4539v1tZJZ+rYBzOzg9YkzbMy6DOYhG
 3MUcvhr5WSIV/ADayw0YwNNo7qOm8DjomP3d2Aqxr0VfVhf3qadxWf7PBaiEJ7Ubv24eC2q1gqil
 FjLFGSoqbEUSByQZc902m46X3jN9PS6tQyC01uj4c2f7whGZQeSjyr0GZKfGsic78ymdeM3VZEm7
 AV0/pE0L1o9YbzgtZN/a2BQSBQgqdb/JjbdVZfbc9c+Jxpt+54iyUCc8aaknZho9naJYg0bolM7B
 /rBFul0ycjYHG0NfDxtcqznH5VBUud8O4LV0JmbqROuof5+bHLNCgb4217NirEYyqwqMBGrw8ELi
 qO86tByCP69i0Qh5ndH5heRCJ7rPXZbjpKeI7vxRvveCIK/1NH5THMtlYvyHAYGOGgjdb5hy4d8/
 k+RlvkD7ATmoZ2kfng5rdXwjvpU4S+XAhVR1id1GLKHJBvyjlI1w1E/J5phsv+xvB6Q7084Dep9A
 VraDvUrsdRtIt1Ya41+bpDIcgO6LOWkBlZlNHPCyxwX3MPaPCeumOhbpVZ03tIU95AZWtzQOODZY
 aBS/QaPai/btrmlhC85OkmJRZ+my2YLTiFllyX974CpAmwOWQt/Apnqpdot95Z1s2bBwfdm/8X6o
 RcYO63BwpS5C898CHRA4HXJVGLuuocAGZOGSWJtOL4nawG8z87Sn7OLOV4LikazAQsNf7vua6ysA
 xFAilnb3SCYVYDSdH4IKBn5oTTl9HKvj+Li+B0slZd4aadi2b667E/1TXseb92FolcPTrPL5sKTz
 3tp9wpvGYs38JV+Sgf0DiLPRXTSWmFEPKyP0gxb6VQ9Dyf1mdym/fWDvnb+h1IgCQbaPY30Vfjqb
 xdTi1AYkryYheSAf/c7kR8HWm3EQIN2pUUDcOX/AZBHcfw==
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2019-10-06 at 16:48 -0400, Laurence Oberman wrote:
> On Sun, 2019-10-06 at 10:31 +0200, Mischa Baars wrote:
> > On Sat, 2019-10-05 at 09:50 -0600, Jens Axboe wrote:
> > 
> > > It's not really a case of quid pro quo, if someone gets removed,
> > > something else can stay. I'd argue that the floppy driver is
> > > probably
> > > used by orders of magnitude more people than the packet writing
> > > code,
> > > and as such that makes it much more important to maintain.
> > 
> > I'm not into time-reversal, if that is what you mean?! I love
> > unilinear time and causal computers!
> > 
> > Regards,
> > Mischa.
> > 
> 
> Hello Mischa
> Something is not making sense here.
> If this will not be an open source project and not released then why
> not simply snapshot the kernel as is now and go ahead.
> Maintain it yourself, issue solved. No need to harp on the packet
> writing code support anymore.
> 

You are mistaking my project for a kernel module. I do not intend to do a spinoff. Perhaps, if it were a kernel module, but it isn't.

> Many companies have taken a snap of the kernel to use for storage
> arrays and then made changes and did not release the entire solution as
> open source.
> 
> You said
> 
> "Yes, I've written the the code myself, thank you. It's prototype
> hardware and it's not intended as an open source software project. It
> is therefore not going to
> be released to the general public. When it's finished, and it isn't at
> the moment, it's hopefully going to be part of your future processors.
> "
> 
> Regards
> Laurence Oberman
> 

