Return-Path: <SRS0=DC0a=XA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D35C43140
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 15:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717B5206B8
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 15:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="DssZJuMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389020AbfIEPwL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:52:11 -0400
Received: from mout.web.de ([212.227.17.11]:48929 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730518AbfIEPwK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Sep 2019 11:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567698707;
        bh=YjuLJQHXe/uLAFFIxg5br08ZQG/pMiCw9MBbSYeF1LI=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=DssZJuMT3vVoRg9i0dPDI8G/z/slGUOwalkshjOEhUvku5fhpCytr2KlV4uPRwqFS
         J+3LvJp7E9PawdODXyyNhBgtUL9AMFcMV+d3R9hgUAV1hXFcCoR7doKNVNCGHCW5Ze
         b9X3fP5fDZlIaynhiWya+cwxcQBu8sOU85daSZq0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.131.221]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mfq6i-1hl5PC39YC-00NAFl; Thu, 05
 Sep 2019 17:51:46 +0200
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>
References: <a43fe392-bd6a-71f5-8611-c6b764ba56c3@arm.com>
Subject: Re: sched: make struct task_struct::state 32-bit
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7e3e784c-e8e6-f9ba-490f-ec3bf956d96b@web.de>
Date:   Thu, 5 Sep 2019 17:51:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <a43fe392-bd6a-71f5-8611-c6b764ba56c3@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g1fZROSW3lXKaILymBFMmRcQTT5baPT1MsjWb0TQESOyAvUUvsY
 o38v6NffEH63/AkL9owRXjp34pYQGnnpvDwgL9b0MCZN99KgYldNw69i54QfgCIu4GuRrUw
 n1pWdcsF7NcuXYtY1PYHI0uPhqFwoEI6dbjXNI4CZ4Usct8FnXCPwjrdYFbPVW9IlO1K7Aw
 gmB8z7Br/InXsN3BWKttA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U98YLqIcjsQ=:3OqYxrpcGir0q/CR4CPk6j
 fLYNbOZZ2jko5KCNdZEvYdqIjpQC+xrzdXA64WbEFdX6cBoUlnHW4Jf8AXPKryMMX4csJUZdu
 x63lrvL+nJtr9mUR4e84zQ/H+tNotYhCX1iIar3wL+gOM9OXcq3Iz2+ekAmq06L1bi5xHWHlC
 ++H3wfJWXdK/y25XmqsfV+2ojGQE7gsDA9IlPZnCUOK+z5ueDpnT1TSWML/T1/6m266c7f9dg
 79pCgQRmOeUW/k0j+SUN9cBik60shRLUXPyfvQE7z6JTuEjs7QPWeokjIQtSFQ0w65uj1+dlQ
 XpKKglRAh4Kz5C+pYvIjXt4GvD4FOCtI0T5j2fZkg6LZe8vddgoyJdb3NKhm2yI7mN10izYOe
 JOdF49+O+1fw/KFbU0qYUweUDLqNYsCkxYKqfND8KLZVNHI2syKdNmFrl84tLICEmT753T7h+
 lxwCzZsnYutAo62l/LsNcSq46hDXosV5o+nsjEO5eeC8vuVo8Ypdc6zSxRcKQCv6N1stgxpyE
 9+43N/YgLwm7am/KUqPQrJnQrFp7C3VJbYGamHg7pVIeH1+giNZLWUKiu/f3Fy3CD9Zwi3jWZ
 wmBDF+lCOVOiofwYu+lHSLeHkJ1C4wGoxUhjRHWeLXbbMAAMyXUcfz9buHx5MhiULUeGKRy7F
 8TPSTdoBfmQhvD0v8nTwAKkkmzDEb9n5JXzQiJq32HHruIpCDAtpPwnm30kUPa12li9/Lrr20
 lqJRByVmGv5/OSHYBgF7s1K5VCz+MxBWHADFmYZRkvyNb/1FtSh3EbqwPOQny7LXYeNxVFPMU
 ZgxRuJCKGSi+k7VgdW1uQ3sh7QUVCPVmSnVA7UP/xLabtMNCKrgvLh5tPNfQan3QaBfdequYi
 c+EO6lLRcGDoQYzkBQsCupoGudt7Rv6ovqmj9jsfy/B9+Vj42TjbEqgi7HYSNiIXGY4NKoKpz
 747P70qC9pmY8w6Vo53RUAHaPqxt7WKZTouqxZa/5bf160XCuLNB2xLGUfVieq79uS/bp9j9X
 XOE1sHKDJGSnRrYOQmQn92XKVMuokioIKhOCbL9FKLOwW5xOJYKz3+QrdQFSO7iHK3CCeO5h1
 KF8fp+zTR70aaWCw6CFrKyLEDAg4E/AoRUpJPfL4YustHBxNUUlNs0EPNaIvRrMCe3fgiwPqP
 2BEHq6i5l1inDrnIz9ZhoSv76QhTEpjdLamxtETQGL8hpEPx4kYXXWRIEGg2n8jreIT06Kz/t
 gpfgFPtzHMDzREYn8
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> @funcmatch@
> identifier func;
> identifier p;
> identifier state_var;
> @@
>
>   func(..., struct task_struct *p, ...
> -      , long state_var
> +      , int state_var
>        ,...)
> {
> 	...
> }
=E2=80=A6
> Which seems to be doing roughly what I want.

Can a transformation approach like the following work also
for your software?

@replacement@

identifier func, p, state_var;

@@

 func(...,
      struct task_struct *p,
      ...
,
-     long
+     int
      state_var
,
      ...)

 {

 ...

 }



Regards,
Markus
