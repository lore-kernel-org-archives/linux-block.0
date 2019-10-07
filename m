Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234E7ECE58C
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 14:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BC22070B
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 14:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cyberfiber.eu header.i=@cyberfiber.eu header.b="kv18l923"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfJGOVU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:21:20 -0400
Received: from filter02-out9.totaalholding.nl ([185.56.145.241]:48655 "EHLO
        filter02-out9.totaalholding.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728010AbfJGOVU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Oct 2019 10:21:20 -0400
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter02.totaalholding.nl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iHTst-0003eQ-2R
        for linux-block@vger.kernel.org; Mon, 07 Oct 2019 16:21:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7+ExyQANKa9TXef2Qr62qDh+YpR0cY+94JMjRQoMu3o=; b=kv18l923bo3AjYC62haK/s2OAb
        OUt6QZhQ4c2nD7B1Z80rzjiCA2GPmS3THrr9uzFEGO2NHLFotKl8kJWROpgME8wQqc7HSht9c+rPn
        kOVbNgUENwaPtVM0zyxfoUhelu0GmUY4PSl57k5+OwrLThYxDOjC0WGHv8AtEAu1UF4YsE7HzhSxz
        ezs3yKwrR3XPhHhQOc/qdPb0Ag1oZQeb9pvj4bP2dQT/KyMINO3BCoTf823gBzDmKBEPTLGB6NEMb
        MXBzHsFnBYmxYf4+BFat8FIvrte8fpGy6jmXIZHMJBXFXFb1KyQoPstKZchndK8Nr6QoW89rtT1km
        +kqyXyvA==;
Received: from 134-134-146-85.ftth.glasoperator.nl ([85.146.134.134]:60508 helo=DT0E.cyberfiber.eu)
        by www98.totaalholding.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iHTst-0007yB-AD; Mon, 07 Oct 2019 16:21:11 +0200
Message-ID: <c7a184d86cc64b649cbdcfc1542a30cf74f78624.camel@cyberfiber.eu>
Subject: Re: packet writing support
From:   Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Date:   Mon, 07 Oct 2019 16:19:38 +0200
In-Reply-To: <99b7b647-8788-8a20-e052-db3306837e2f@kernel.dk>
References: <db5c89c3fe26e4b7ec96443ec97a05df97162889.camel@cyberfiber.eu>
         <6e381f83-9a12-30d7-8f99-caaa6a608c4f@kernel.dk>
         <a4b89c40caf62166ab7078296d73b6ae0f35adaf.camel@cyberfiber.eu>
         <fc70b63f-3780-5654-6bc5-0f2d6115bff0@kernel.dk>
         <6c51a5fe93cfad0f76fdbfe47caaa5f5d3f1ca88.camel@cyberfiber.eu>
         <99b7b647-8788-8a20-e052-db3306837e2f@kernel.dk>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.37)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ezqdolHG91LK5q2HN6uCHCpSDasLI4SayDByyq9LIhVqWO/X8TZDlvT
 l/BBLAftkkTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDrBQRDMCPoVIktGfXqz+K77w8
 BFityCCkxNlTi+jLDh0BcORxfCojcTOpEjtvWHp2t8RAoHM1ETs1MNGW7p2ipDg9YkzbMy6DOYhG
 3MUcvhr5WSIV/ADayw0YwNNo7qOm8DjomP3d2Aqxr0VfVhf3qadxWf7PBaiEJ7Ubv24eC2q1gqil
 FjLFGSoqbEUSByQZF+KbsVJyJvk1v2cRMLfeu+j4c2f7whGZQeSjyr0GZKei3GSvwir0OshyEkOw
 fCYvJRLqCXwZ1lLOS3w3BIDj/vtduhq2eYJp1M6uQht/3vmQeETIza2ISn5dEgBRzdTORAwX31WV
 Y5lWjWxuGSRuxWXf5NNoWqxwzT7YQb2bq3uDyiKr2bObCttBtO6VKDuO5YE5enyccp7RH4WQio3u
 GdiBOWdyCfmuoHBoHDwUzk5JaKOFs8saAYDXeULHXubmmAaukvjjB3H15eqNCNu9Sik4xAm9D8KT
 eKJT7gNACPd+5CDNPcr0lQdM2IbB/ACbUWibaRDYiV5DUOzBDXPBF0x21M1BcAkcfhoJPUHCGUHV
 1fYiM3luo4AOITgzCWwlDLgAzaJhQKHOpGbofNa4j7beBZYFZNAmraKhaFOqJnBVkXMUiM+O9bkD
 u7p24goh0Atx8uxJ0NCPHdglD3COmRDJZnz9Sdz+LdCLXuI1HDKNms8bhxfe2nIpwkiiQMh/nEw+
 d60sEkyHnU2JFGgcgKp/Yt8cuMxAkM0S/WZgLWiaIrvHjZWN3MKFkx7o78OJlHlGswvv8qi+FB9l
 7UZiHNDCk+RCzYrX/RwmwFdA76zjmFowZIJCJV4+/tSzU23RWdd9Kd/KcS2LVqa4cfDcDplUFfgo
 YePXKinFtKQYFZhF2jAMM1dKeoL9l/FUUwpAwVIeVYJozYvRNqNh/jw9v3CouBsQyQgpDFiro4OD
 up39Y8Gy+1Sm2Uf/sympAQhGsLrgFBHsyeQJJ8GSKhUR3Q==
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-10-07 at 08:10 -0600, Jens Axboe wrote:
> On 10/7/19 1:02 AM, Mischa Baars wrote:
> > > Let's keep this very simple:
> > > 
> > > 1) Have you used the pktcdvd code at all? How much?
> > 
> > Where are talking about the kernel/drivers/block/pktcdvd.ko.xz module.
> > I have not used it directly, as it is a kernel module. Instead I have
> > been working with K3b, the KDE cdwriting software package.
> 
> Let's keep it even simpler - why do you think you are using the pktcdvd
> code at all? If you're using k3b to burn CDs or DVDs, then you are not
> using that code at all. You'd have to actively setup a devie using
> pktsetup, and you'd then mount it with UDF to write files. Doesn't sound
> like what you are doing at all, which renders this whole discussion
> pointless.
> 

I would not dare call it pointless. I have here a k3b application that has proven to work in the past, yet now it does not show any willingness to cooperate.
Until recently, I was still able to read CD's / DVD's from the filemanager, but since I installed the linux-next kernel, the driver doesn't even show up using
'fdisk -l' (with SCSI cdrom support compiled in).

