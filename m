Return-Path: <SRS0=Yov/=X6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810A7C3E8AB
	for <linux-block@archiver.kernel.org>; Sat,  5 Oct 2019 10:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1163D222C5
	for <linux-block@archiver.kernel.org>; Sat,  5 Oct 2019 10:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cyberfiber.eu header.i=@cyberfiber.eu header.b="VVo/yaGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfJEKe2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Oct 2019 06:34:28 -0400
Received: from filter02-out9.totaalholding.nl ([185.56.145.241]:48551 "EHLO
        filter02-out9.totaalholding.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727653AbfJEKe1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Oct 2019 06:34:27 -0400
X-Greylist: delayed 1202 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Oct 2019 06:34:26 EDT
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter02.totaalholding.nl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iGh4w-0001hU-4c
        for linux-block@vger.kernel.org; Sat, 05 Oct 2019 12:14:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z57rBx7JXhH9fuTT9gae+DqquiC0Gs5Z6kALYw9DWj8=; b=VVo/yaGtS3top4fi7r+lw36iKm
        u/pXojwlB7acy3t2gTe4/qS8Cun1HIpgysF4ZOLHRgHC3TU/Y7xf1eYuo0G/nUkc0A4jECj2d4Axg
        XGNHBmcODvzJz1m93zV3Z5MvlX+JTzrDzK4Lx983CHEoer5/N2gv2BRepJQFLPSP2KadlNduPy1ce
        c+EQheovrQg7KTfOFNrHm63PQv+lZxopaHv1XRbByfybq34AjwsycNWA8Hmqz6LCm7Ww/kM3uVlui
        nR+8wMUXIfjVWsgIttC1ZRc6fT1SfDP/AftTLhIO/QgnBINMM+3QOCDkiiO162kL1iHh8N7z2/RxQ
        6Tbw8zJg==;
Received: from 134-134-146-85.ftth.glasoperator.nl ([85.146.134.134]:33856 helo=DT0E.cyberfiber.eu)
        by www98.totaalholding.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iGh4v-0002aw-KW
        for linux-block@vger.kernel.org; Sat, 05 Oct 2019 12:14:21 +0200
Message-ID: <db5c89c3fe26e4b7ec96443ec97a05df97162889.camel@cyberfiber.eu>
Subject: packet writing support
From:   Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>
To:     linux-block@vger.kernel.org
Date:   Sat, 05 Oct 2019 12:12:53 +0200
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
X-SpamExperts-Outgoing-Evidence: Combined (0.35)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ezqdolHG91LK5q2HN6uCHCpSDasLI4SayDByyq9LIhVc+BsoG/GUGEQ
 jCOlW/h+/ETNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDrBQRDMCPoVIktGfXqz+K77w8
 BFityCCkxNlTi+jLDh0BcORxfCojcTOpEjtvWHp2EPqipJhAyt44yQscDkX3xzg9YkzbMy6DOYhG
 3MUcvhr5WSIV/ADayw0YwNNo7qOm8DjomP3d2Aqxr0VfVhf3qadxWf7PBaiEJ7Ubv24eC2q1gqil
 FjLFGSoqbEUSByQZF+KbsVJyJvk1v2cRMLfeu+j4c2f7whGZQeSjyr0GZKei3GSvwir0OshyEkOw
 fCYvJRLqCXwZ1lLOS3w3BIDj/vtduhq2eYJp1M6uQht/3vmQeETIza2ISn5dEgBRzdTORAwX31WV
 Y5lWjWxuGSRuxWXf5NNoWqxwzT7YQb2bq3uDyiKr2bObCttBtO6VKDuO5YE5enyccp7RH4WQio3u
 GdiBOWdyCfmuoHBoHDwUzk5JaKOFs8saAYDXeULHXubmmAaukvjjB3H15eqNCNu9Sik4xAm9D8KT
 eKJT7gNACPd+5CDNPcr0lQdM2IbB/ACbUWibaRDYiV5DUOzBDXPBF0x21M1BcAkcfhoJPUHCGUEz
 hUvEuzST3Ntq6RdKQNjg3Fqaphbql6XpICdUd9RPCrbeBZYFZNAmraKhaFOqJnBVkXMUiM+O9bkD
 u7p24goh0Atx8uxJ0NCPHdglD3COmRDJZnz9Sdz+LdCLXuI1HDKNms8bhxfe2nIpwkiiQMh/nEw+
 d60sEkyHnU2JFGgcgMcx91fm33g+9q6aH9nUmBOaIrvHjZWN3MKFkx7o78OJlHlGswvv8qi+FB9l
 7UZiHNDCk+RCzYrX/RwmwFdA76zjmFowZIJCJV4+/tSzU23RWdd9Kd/KcS2LVqa4cfDcDplUFfgo
 YePXKinFtKQYFZhF2jAMM1dKeoL9l/FUUwpAwVIeVYJozYvRNqNh/jw9v3CouBsQyQgpDFiro4OD
 up39Y8Gy+1Sm2Uf/sympAQhGsLrgFBHsyeQJJ8GSKhUR3Q==
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Advised by the linux-next mailing list to repost this message on the linux-block mailing list:

Hi,

If I'm correct, packet writing support is going to be removed from the
Linux kernel. Is there any particular reason for
this, as far as you people know? Both DVD-writers and Blueray-writers are
still being sold to date.

I'm currently working on quite a large project. I would be dependent
solely on USB to store my backup files, when the packet writing support
is removed. Actually I'm quite uncomfortable with that idea, because
USB is rewritable. Any serious attempt to do damage to my project will
result a permanent loss of code. Personally I would do anything to keep
packet writing support in the kernel.

I'd hoped you could remove normal floppy disc support instead. That
seems the more logical course of action. Floppy disc drives aren't
being sold anymore for quite some years now.

Anybody there?

Have a pleasant day,
Mischa Baars.

