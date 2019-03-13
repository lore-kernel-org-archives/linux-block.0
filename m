Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6BFC43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 18:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18FA21019
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 18:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="cKsT6Usn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfCMS0v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:26:51 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:13382 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMS0v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 14:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552501606;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=CsO3IVsBV4ObPCD8pXlkFLTUcwLT59U2Xe+Oa9Achqo=;
        b=cKsT6UsnwJpQJ9g04PvvXa5vV7bjdWiMYAkxvYKVzIKHCL9sOSn10MmyZnjCc++H20
        y9VnH4t/WeDgNEaYz6ekQ+6SvFuq8cMWuyDkVBLtKrx426QgBF1lwUtukpjoPq5ZYYue
        vtSdtCvPHcNkQ7JCI1xGUWFdW3qLvf4MR4v87iJrGbDbS30M/5NODEVDf4TdDdn+dAAW
        FgHZ/EK3lNLDr3QGJXujUo16CmGqtDIVYtQGyMcf6LsJyfp83jNoDNWsPAKWr5QnJ2BY
        kP918qROJlAIzEo6rkJ61l2zgrsZo4NiceucU/masZl8FSo37RLNJDVTB15lVvNt1uyL
        redg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1onXMaVuOBdyp/nutbxfg"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.119]
        by smtp.strato.de (RZmta 44.15 AUTH)
        with ESMTPSA id 307bb7v2DIMx2JG
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 13 Mar 2019 19:22:59 +0100 (CET)
Subject: Re: WARNING in hsr_forward_skb
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com>,
        arvid.brodin@alten.se, Jens Axboe <axboe@fb.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Miller <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000004cfa120583e1dfc3@google.com>
 <7dd5ffca-803d-9d5e-7fa4-f9eed2249d26@hartkopp.net>
 <CACT4Y+ZoDc=_a_W=wVMYj+VLW8WFBDbQJGB17dZTSvYinWhebA@mail.gmail.com>
 <CACT4Y+ayyFe6oek8MdnUd1LsB_+1kpJatBLnmF_jCttQPyCK0g@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <cc1224f9-8fdc-ed08-3004-ae528dbeadb8@hartkopp.net>
Date:   Wed, 13 Mar 2019 19:22:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ayyFe6oek8MdnUd1LsB_+1kpJatBLnmF_jCttQPyCK0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Dimitry,

On 3/12/19 5:21 PM, Dmitry Vyukov wrote:

>> You can see how bisection progressed and got to 4.12.0-rc2+ in the
>> bisection log.
>>
>> The commit that it come up with looks unrelated.
>> I've started collecting such cases at:
>> https://github.com/google/syzkaller/issues/1051
>> and added for this case:
>>
>> =====
>> Bisected to wrong commit.
>> Root cause: broken kernel boots, bugs that happen on all tests.
>> Boot is broken for several releases with "WARNING in hsr_forward_skb",
>> this switches to a bug that happens during every test "INFO: trying to
>> register non-static key in can_notifier", which then leads to a
>> completely random commit.
>> =====
> 
> Broken boots did not happen here. "WARNING in hsr_forward_skb" is the
> crash that we pursued, so it started correctly. But then diverged to
> an unrelated "INFO: trying to register non-static key in
> can_notifier".

Thanks for the clarification! I really appreciate your effort with syzbot!

Best,
Oliver

