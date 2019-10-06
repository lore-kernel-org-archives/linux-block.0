Return-Path: <SRS0=GTOX=X7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2911FC4360C
	for <linux-block@archiver.kernel.org>; Sun,  6 Oct 2019 08:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C9E214AF
	for <linux-block@archiver.kernel.org>; Sun,  6 Oct 2019 08:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cyberfiber.eu header.i=@cyberfiber.eu header.b="a74XoGiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfJFIcz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Oct 2019 04:32:55 -0400
Received: from filter01-out9.totaalholding.nl ([85.17.242.87]:43009 "EHLO
        filter01-out9.totaalholding.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726207AbfJFIcz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 6 Oct 2019 04:32:55 -0400
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter01.totaalholding.nl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iH1yF-0006LB-JI
        for linux-block@vger.kernel.org; Sun, 06 Oct 2019 10:32:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CqXQqXrECT20isZsZ/sIriCxdUbQjf2eJsYO841aZDQ=; b=a74XoGiMs+DXVIg4Cd9eH36arR
        1dcmlwQsOaRgFt5m0fCSyXUk9kwaE2zZMUFBl0PxZrjlX0VBr5ra8A/qhZAry5HrLO72lIIpf71KN
        QW+dgO9I0c6D4dg4Wlhl46UAIK7QyYA5gGSZON5oQJ1xkeV5OgZs4XBzKlFJdi+B8Vfnd9EWnSR7X
        Plo9zedxgkzerfYt1BMf6fNhoyqL/voUJQhFmKKnusAIrMRt4mMnNsEZzwhy6tsus3kVYufXf6NdV
        53OO67AuU0Lx0F/wP9tvLWqWnOvSJpj3mRRTlGIheTC65YBOWY+4CEjsuXuYa6ZfdbPfsJh/DCOwi
        e84spP0g==;
Received: from 134-134-146-85.ftth.glasoperator.nl ([85.146.134.134]:34858 helo=DT0E.cyberfiber.eu)
        by www98.totaalholding.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iH1yF-00053l-9d; Sun, 06 Oct 2019 10:32:51 +0200
Message-ID: <63a7e40795da8efc782c1985ceeb54e0d3e708b6.camel@cyberfiber.eu>
Subject: Re: packet writing support
From:   Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Date:   Sun, 06 Oct 2019 10:31:22 +0200
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
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ezqdolHG91LK5q2HN6uCHCpSDasLI4SayDByyq9LIhVLFHtTzQ+WN2B
 CxYjlCSXvkTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDrBQRDMCPoVIktGfXqz+K77w8
 BFityCCkxNlTi+jLDh0BcORxfCojcTOpEjtvWHp2BjDQQ3Od+q9RPOWuZCvfpTg9YkzbMy6DOYhG
 3MUcvhr5WSIV/ADayw0YwNNo7qOm8DjomP3d2Aqxr0VfVhf3qadxWf7PBaiEJ7Ubv24eC2q1gqil
 FjLFGSoqbEUSByQZc902m46X3jN9PS6tQyC01uj4c2f7whGZQeSjyr0GZKei3GSvwir0OshyEkOw
 fCYvJRLqCXwZ1lLOS3w3BIDj/vtduhq2eYJp1M6uQht/3vmQeETIza2ISn5dEgBRzdTORAwX31WV
 Y5lWjWxuGSRuxWXf5NNoWqxwzT7YQb2bq3uDyiKr2bObCttBtO6VKDuO5YE5enyccp7RH4WQio3u
 GdiBOWdyCfmuoHBoHDwUzk5JaKOFs8saAYDXeULHXubmmAaukvjjB3H15eqNCNu9Sik4xAm9D8KT
 eKJT7gNACPd+5CDNPcr0lQdM2IbB/ACba2hPlcWz+/ka0Jz8k5SXCkoq/NrO1ynXbs8iot7lhmW7
 vs5scNsnbqaPgn3EoERAP5VR2wwx3je26eGjWD/UlMkwftihmYbZeHoaTU0hoD+qre98Cwa2gTLo
 VdoPF0VK1x66Qw3T0UFAji0c5knCvOVEuCim6e30IO5icHqQdUOIuwMKV9tojzhFmK6DBPxB1Dzh
 Abz0k3oy+k13MupbuoArxjlbEwVa7vprMDzy04QccBIk1Sag4dKiqCrF8eZZFzniHPxtHdK1NLmO
 gcMupCl+RmG1mdc9Jig47dwRByefHnIJ+kdneJuZ34MFaGRAQ2K5UjhgJmfm3gS/XH6VTwQCojDi
 NLBubQBrRmHyHyUelVs1LOVCK8p6qw0xNxh35NpS3rE/TCb4GSlUZGHqBPwdYV2wDufUP/TgvnLT
 shxfUfin6s8/+LT9ZdCyQwcPTHoJXz4t2QVQW74e+jwXGg==
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 2019-10-05 at 09:50 -0600, Jens Axboe wrote:

> It's not really a case of quid pro quo, if someone gets removed,
> something else can stay. I'd argue that the floppy driver is probably
> used by orders of magnitude more people than the packet writing code,
> and as such that makes it much more important to maintain.

I'm not into time-reversal, if that is what you mean?! I love unilinear time and causal computers!

Regards,
Mischa.

