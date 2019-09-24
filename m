Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1C4C432C2
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 08:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F93214D9
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 08:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="hEr+GJ4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394977AbfIXI2v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 04:28:51 -0400
Received: from mout.web.de ([212.227.15.3]:56113 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394923AbfIXI2v (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 04:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569313715;
        bh=81JZBQpINSCG3/xfWngKEmRt/JYECAlDxcVtcKbD0XQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hEr+GJ4RlK/hsMoY0C/r5GnM/nsLXtR9L9fV42Ha784ZP0Sc4t/aqOBD/fg1HZiBy
         i1uVvlHrGPxx/zcQtXq78+Y/KD9WNz/3HPFRjacY9XR1hA/dW7mWt+92f0ke2ko63S
         4YsFsEvHo/8F4aS94Z36l7FnvuBbDE6nCRyCijAg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.71.162]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfYXz-1iWfm420E7-00P72Z; Tue, 24
 Sep 2019 10:28:35 +0200
Subject: Re: sched: make struct task_struct::state 32-bit
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>
References: <a43fe392-bd6a-71f5-8611-c6b764ba56c3@arm.com>
 <7e3e784c-e8e6-f9ba-490f-ec3bf956d96b@web.de>
 <0c4dcb91-4830-0013-b8c6-64b9e1ce47d4@arm.com>
 <32d65b15-1855-e7eb-e9c4-81560fab62ea@arm.com>
 <alpine.DEB.2.21.1909231228200.2272@hadrien>
 <d529c390-546e-a8a4-f475-c3ee41f97645@arm.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a1491516-a701-8804-8277-75fb5247191a@web.de>
Date:   Tue, 24 Sep 2019 10:28:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <d529c390-546e-a8a4-f475-c3ee41f97645@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+LGehVKc09r1KuvfQbU6UtXN4wMbiGphRgKwWf6E5/pcoBay+CX
 hxQtIG/AXQEA72ofNH+z/E/IQpI5dOlGwrkTiXGvRXac9WkyaBILSc1Nm7Y6OAR1aZzZvWg
 nHknsoTJNX0ExTzcE5uNE85trDQdcAC0c4Zi+3Wh4WnEWRN1kWL+oGgg1Dsbvi+YoiGCEiN
 8Xi5iXU/pgbViJyNEWwpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ndp5C+YO2XY=:bEjXmQLpbsDAKujsReYlP8
 /XjsIU2C+Ky2XLlpzdHutvatEFcllHuXSxRUC/kxW5mVs4L56PKsiWb3Vu/awYqYOSUjCiFtK
 Tn9ch+XE0/oigNL9MCWTwiVeKf/bl4s1ntlH+QK8zpEvIghww7JM9k0mLUP/MKrAgBcIJGXk6
 fFTmhQenEdXjTJjJtRE4qykb3cgp25icMONDt+BUgdfLscQDk79gZxs04A0VtoCP21oxIxYNs
 M9/mqOV9UawZUTzbd0k0GAHBRPp64+TqC8YIhXu9TXcLeBW+PFPqXCCU6kT718VIb3HthvWLr
 pcnu7HKUmXXdsvpfY0qiNtG3iOxFkdFA2FKJecfLN+VZlHVVbu1yaJ+bJlLebOfFKdwR1q3/r
 GlEDkuCt+L0BHFMgUge/73z14ZDk7KGwdJm6CykFn741DOBovrJDgDC6RiBotpTVbHtqPWj6V
 6NoW29Efn3woO+w1Nrodwj3W7HoDLZej+GyZy6Da8Cl6/cTNegUSGny8MyAoxbCW5gaiEsTb1
 C55rPTkg/WF4UxWSzF7x3OIUL3wHCVp5oDlCA+m201nBGwmnnLZchCXqmgWJLg9I8zXafKddS
 RIiiLMh2Va39nInIuOUxk80sTu6FVl9qBr3qCqAy8V5L3QuPhkktVyioTrCVqYVSTRX+I0/mM
 LGspeNnawObv8ixw0+lwHzH3N//oWVGlZgskvghpDq8vRH0tO/+YYVjrg+prIcLfoZxeWajJi
 0EsVGGgtOLIVAPAdh+ge5KNHqK3nxJ8lQG1VvelpOAX1YFrn/BVzG1UI1OzVqVKM4jaEN9b+b
 qXzH/7M3UTlAYS0GiP26fbg+yd/Fqf0wTsf8YcSc5pOHjyORTLwkRqcVd0r3xa/5VhFf6Yh8N
 TBayi9AAhDN1fyYMMVDhawHQzU8jy2448GMq4o8ze5kDpw6ZwkfnAHzboUSLwf64eurYTvWQG
 IkmrpazD352W9fmVxHlN+84kAdiRohhnJS9Rxp0rs21rPduut3yWyVsyA3hV3ttpfbu8V9NJf
 zF9ou78u4fguhc8JeEJOaj94oMGvFZ4hYceM/9vhku023HywU45SYPKwN1gIpgRkiYdSfZW9s
 xFIA9iaQArvMJ6HKnkb9sQ8p6CnMAsusNE+Aj4m54WGP/xTrHYIma4f60oFCs2XyX5D7oTDtX
 MA7L5LzS8o0IhUz/EW1A9YN59hv1REZcUDAt97uYZ8+H/6xx6wYnPxKfVfGQQ35r4f7GWyfDh
 vWqXuncgK1OxgPp40RuPQf91P3AKVzgbkTbNhqFhA99XjSI7T/vcRzwinywY=
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>>> identifier task_state =3D~ "^TASK_";
>>
>> Are there a lot of options?  You can also enumerate them in {}, ie
>>
>> identifier task_state =3D {TASK_BLAH, TASK_BLAHBLAH};
>
> Around a dozen, can be enumerated easily and is indeed probably better t=
han
> a regexp.

Can the application of a regular expression be more convenient
for such an use case?


>> You want to look at the definitions of called functions?
>> Coccinelle doesn't really support that,

I got an other impression.


>> but there are hackish ways to add that.

How do you think about to discuss corresponding software development chall=
enges?

Regards,
Markus
