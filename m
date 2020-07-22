Return-Path: <SRS0=4wZT=BB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25645C433E0
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 11:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED236206E3
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 11:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dvsLOZv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGVLZ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jul 2020 07:25:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:33573 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgGVLZ6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jul 2020 07:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595417157;
        bh=uSm1Qdn/TXOtysgtWd0mwh5AQ3Dr/VSfNlY17FDMS0E=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=dvsLOZv44gqF2CG38nCmgqNWnZpOedmmPaxh0tsrw/RFsZ/6II8b6HjLCmOWRf9bs
         wJlJBVwf9PD/LblrBzFus34dqbjiYUDbN9A6Anv+2qTQIHa2eTS01jfBK2gb+CMT6P
         F83QUGV0G+QmjwkZ7HEVOZeXwNvqJgBA3VGRAei4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [188.192.120.146] ([188.192.120.146]) by web-mail.gmx.net
 (3c-app-gmx-bap24.server.lan [172.19.172.94]) (via HTTP); Wed, 22 Jul 2020
 13:25:57 +0200
MIME-Version: 1.0
Message-ID: <trinity-59ce6e71-01d6-4024-ac7f-8f24141f7dff-1595417157674@3c-app-gmx-bap24>
From:   truart@gmx.de
To:     linux-block@vger.kernel.org
Subject: What happened to led block trigger patch?
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 22 Jul 2020 13:25:57 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:6B0GsgoPJsOEp2k9Kd24GEmdkwNAOKxV9gE04uukb0zKnDKdPSc2gUSVlKVV5Z+iaOx/f
 9Nu0EMI1JQ01KT9/JUJxeZO8/+gm3+qUMls3rkwqjclR/UoAnJb4wSY5pzpqiRVJba0/goR/YHkI
 3OsziqsBVH+bItcd9Ci7vgIy3Nw1JUKApUIFhbYicmHMjHmw09WgJfRGhNgls6K47oZ7X3HuZAeR
 XaZR4CjZACc2fw9yHnyGao1qr69GjXqlW18lcy8xuYqmQMh6X6wN2kBg5BMC9OtJNQWNqoOBuxN0
 us=
X-UI-Out-Filterresults: notjunk:1;V03:K0:JU5Qu3Bc3mg=:y7e3KUPn8fU7+C3xrPjUlD
 /IoxgpR+bU55+bVhNKZWM35X4l7CABuvjjmYxvvKSx80TdZY2tvnbRVVzCHno4jo4fYGGUQ98
 4H0xpXNI1kgjsE5v4yPKNMl3qFyDmER+Id87DUGIGD2jskgfrCMZfvghilogNH+c7QQlHVkei
 P2u24xNgBiFYwRaMXFwJlXey7v6yUvFxU5lajqoKmvPO6buxOFVqw1znnGEv0RY3Z8NFMU7jB
 NXeMQriJYdprmLwTmy39+R8Vy1VdCFK5YiYMxPdq+XUktWAoSNbqAGhFRC7C5Y7VyXSxi+ZQg
 HeONpgDcp5UDd9OoS5EdujzrnkzZyzaHTd8l5CZGOhMR7rQE7s7jVLziyl0qmjlLvm/44YWNu
 tod36Dq9SApQ6k/m1LYbk42KoNUWo9Dwtldtoj3ZWk+FP5qqbbrYUI7Lcs62sspIxThEN1r6u
 OD97m7j/b4M/DZxDbexcjk31OWP7mOY3eT6Pxdt7Ff8BMEpKt39Aun5yj0Q0HKakP3j2KIxUv
 Bb1ECnG4Tz+BF2/vxU8rR0flpkO2Q/OIzZPbBdB1BpMM6MbOUwewu1ftJcjRuHJgg0xYtEcY2
 OlRbDOVKaiUlkEx8EHKKMsSgXDwXKCl5JAzA/B8VwvOv4xbIHtivSpY3o2pe4DS08mZxy5aRh
 Xl9j65Y0Ha93TgmAdmj7jF+1HEgyC2A+ShxKWoh0fTfF4Ew==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hej hej,

all our new thinkpads are missing a hard disk led, and when trying to use some keyboard led it turned out that this is not really working. The LED is either just blinking or showing nothing. When googling we found https://www.spinics.net/lists/linux-scsi/msg132286.html
All the laptops have nvme disks, so this is exactly what we need. But it seems to be missing in the latest kernel.

So may I ask what happened to this patch? Is it scheduled for being added? It's definitely needed as every new notebook I'm aware of doesn't have hard disk leds while nvme disks are default for most new notebooks now. So linux should be able to show disk traffic not only for ide and sata but also for up-to-date disk technologies. Any chance we get that patch? Is there a place to vote for a patch?

Thanks!
Michael
