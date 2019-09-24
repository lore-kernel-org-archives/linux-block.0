Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2C4C432C2
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 08:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08EA2146E
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 08:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="hEEPKBhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438877AbfIXIIS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 04:08:18 -0400
Received: from mout.web.de ([212.227.15.4]:49247 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436523AbfIXIIS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 04:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569312482;
        bh=5UUB7nBISPCMR8MLkZQo563E2CTK7plA3+JuTrsQPlU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hEEPKBhivbXBokJZPSixHFQyrwbGDoTQfOUMwaSxHAT+mm73WXm1wk+J0XjHaBXAR
         fqrJifb6ER1xWqCtVT/c3fxnMrRIIiXiGSno3JlXkqT+FBBRJYFxvjtTrVBz1jpaTx
         m7kYHgHNuH+TBbxdB1g+/DN4wjPrT5OCjPPvB9DQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.71.162]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6Dve-1hxcnA2BeE-00yDJX; Tue, 24
 Sep 2019 10:08:02 +0200
Subject: Re: sched: make struct task_struct::state 32-bit
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Julia Lawall <julia.lawall@lip6.fr>
References: <a43fe392-bd6a-71f5-8611-c6b764ba56c3@arm.com>
 <7e3e784c-e8e6-f9ba-490f-ec3bf956d96b@web.de>
 <0c4dcb91-4830-0013-b8c6-64b9e1ce47d4@arm.com>
 <32d65b15-1855-e7eb-e9c4-81560fab62ea@arm.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <af969579-116c-fba7-fd32-15a876ac0445@web.de>
Date:   Tue, 24 Sep 2019 10:07:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <32d65b15-1855-e7eb-e9c4-81560fab62ea@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gdWTto7J1BLMzpuLsjXkxMpm9JPQANR6lT0+Gi8LVIYwwvcnmCB
 wbRC8Aq7YkXsjPF2BrDnR9s/c6qPEEeWSZK/1z0lz52lbZhqTmxMIlxXHOnRhiYfG5sQtoQ
 FwqPHD58FJBBWWLkgBF6+0ELov+JPZgWu/8tcNRcWkjWo+IVraNRuisxGf/B+KkFlahpWIz
 8h+zWSyzIgQs9I7ijaaeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:axxi6oXRmys=:x4mHB2rn9HIwxjm/+2t7zx
 F1NrtiZgELzy2ru7iCxdt4NWKcGpGGjPsVpGg8+16qutpm0DWxghSB/AXMPHdJBFv332Hh1Vb
 PT7SQ7NNJ+cIwPLJ5/SCW9E9keRAkmt1EyMCNy2gN91IKJFEswwEJ0MmC7+/cfjfCFsIEp6pJ
 FLKEG3th06O4BcFH8mqUF9Mk4vWFLAyKc4IAj9KPFUt52E88JzUorbGFyke7DxbVSNwlWGRmd
 335yNlorr+YGfDVj0M7VGzOXfmdyK/rJYLlXc52IO7MSuwslC2MYJTko88PnGyQ+/+QfCyApC
 EntibQqhHBCyVM5ev/ZHr9rVu8zwj57bXWJ699bXDBgazEIswXQyyihh4mbJ4ecIVkoFl6zS/
 cmxBNk4APQ06Nkwb0sN06cnrenzVEypb4td+1BnXd/fC93T0aJEqvSdc+khMwrsfS46p3iBh1
 Dj/iHl0ASgnP7MZxzb3RukBHlJBf6p2O2kKB004Qj2B+0e1dGistXv+swgJ12UOJETuqvAm5l
 qPmCXhUb8nv7iEJcl2Q1sYYlegwEqaVo2Zp9r1fDY1TFN2OurCMZhS9mF/ifkxvL+2XjT4pkq
 jmIC43UcGojXxpC8CMkTJB5B35KhuI0zPlAI8WwIUHGGIou7SrQYfzRxpZJr5Q2rYWNd6LlS1
 wtkwa2yF+Zab/WaSEEdbyG49wgbEzyfLNSPWscRO3DxAVNSSI5NUfgsV8+gf7FvTGFV7Sa70F
 Gb9yZFcwP8MbIsaC7DRzl5OCJ1vqXTurImDFjGp95IRRCW7Qp7Vnegr0rpBQU+FJSxm8ci/U1
 AuG8PMOB6Gf6MZXYSAFURWupW33l69XI9GojX2CvRivO6UaD+tFtqRrQuVzFwFQ0Ok/zs1nuY
 ogEE5QDEKFNi+dWpAnx9GbB1/ThpKJnD7hOGMZCSTnrSYMxUkOnb98c78kYM+RuZWSt0+GgAo
 OpqtSr0JhRztyLJDymLPBkgF6xliV49tYmmc5M+Gv+favKnyfoTs4tEQlR79y/G6fSRHfMHFU
 KB1tngPzCRERXJi5gE/qlFIVq6PQdxebZZXRI+GHpuIECb8p3VI4kFiblW4qezbxEVS77nryq
 IzBd3+9e1OyF3NzrLITHCQ8g3zZCgCqD7XCvxGbTmEfHFB+aFVOnETsmB9L3rRk7kJS2spFvm
 nA1BDxjDD0G0bT53sK5dPzMc/2dAyNrR9YFqfCAKWIzVYKPGNcudBkVPMA2oBfj2TejziW80d
 hoed+CDCFa7ucCxSpJghlOwp/KfxX/t8n/+xfb924K9fDBc4oTMisWxIOUzs=
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> // FIXME: current not recognized as task_struct*, fixhack with regexp
> identifier current =3D~ "^current$";

Would you really like to use a regular expression for finding a single wor=
d?


> identifier state_var;
> position pos;
> @@
>
> (
>   p->state & state_var@pos
> |
>   current->state & state_var@pos
> |

I see further opportunities to make such a SmPL disjunction more succinct.

*
( ( \( p \| current \) ) -> state & state_var@pos
|
=E2=80=A6

* How do you think about to work with a SmPL constraint
  for a metavariable with the type =E2=80=9Cbinary operator=E2=80=9D?


>   set_current_state(state_var@pos)
> |
>   set_special_state(state_var@pos)

| \( set_current_state \| set_special_state \) (state_var@pos)


> |
>   signal_pending_state(state_var@pos, p)
> |
>   signal_pending_state(state_var@pos, current)

| signal_pending_state(state_var@pos, \( p \| current \) )


Regards,
Markus
