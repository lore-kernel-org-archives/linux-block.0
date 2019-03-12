Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF87C43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 12:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F15206BA
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 12:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="oUZXCL95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCLMC2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:02:28 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:25789 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfCLMC2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 08:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552392143;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=P5/PVrxkOtneOBmRAzRCH23Ow+mn9LtOrfvfD94JTQI=;
        b=oUZXCL958GhknvxpCYsX0KtwOAWpMzTar8o1xA/gTZAXGNeggsapWuiSDf0f5Oz41x
        yuo8i4fYBuBuKTW1shvUGna+mrwfnPh4LrbNRDf84Sz/0Z1+90wq2PXmfTbJqjjqATh4
        ICnWaxmiRORJ/Nwnu2jf+c2WjAKjZd8Yfu688F0k8s8v3XVjuN0RNMDbW/6sd/UmSfGa
        jMHc6fyP1wJJtKn/W01k5TK6jxo+NijYUjzqlFB8NsqBzSby518OvgNL2xMDU1z8P4cL
        s7VurMDXbHoqCy+UsJEqqxeY5Qo9nhnJT6+isp09lsn0s8ifCRZwv+kApr/aSDWUS940
        ouOg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1onXMaVuOBdyp/nutbxfg"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.119]
        by smtp.strato.de (RZmta 44.13 AUTH)
        with ESMTPSA id e06351v2CC1xuWH
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 12 Mar 2019 13:01:59 +0100 (CET)
Subject: Re: WARNING in hsr_forward_skb
To:     syzbot <syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com>,
        arvid.brodin@alten.se, axboe@fb.com, axboe@kernel.dk,
        davem@davemloft.net, hch@lst.de, linux-block@vger.kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mkl@pengutronix.de, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000004cfa120583e1dfc3@google.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <7dd5ffca-803d-9d5e-7fa4-f9eed2249d26@hartkopp.net>
Date:   Tue, 12 Mar 2019 13:01:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <0000000000004cfa120583e1dfc3@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

I'm not sure why a Kernel 4.12.0-rc2+ is used here, but I do not get any 
problems on the my latest 5.0.0-06622-g1fc1cd8399ab tree and I strongly 
assume this patch showing up in 4.12-rc6

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit?id=74b7b490886852582d986a33443c2ffa50970169

fixes the problem.

Best regards,
Oliver

On 3/12/19 9:57 AM, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit ab42f35d9cb5ac49b5a2a11f940e74f58f207280
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Fri May 26 11:53:19 2017 +0000
> 
>      blk-mq: merge bio into sw queue before plugging
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e68713200000
> start commit:   ab42f35d blk-mq: merge bio into sw queue before plugging
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=15e68713200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11e68713200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=fdce8f2a8903f3ba0e6b
> userspace arch: amd64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f6d1fd400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17290fdd400000
> 
> Reported-by: syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com
> Fixes: ab42f35d ("blk-mq: merge bio into sw queue before plugging")
