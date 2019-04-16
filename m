Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFF5C10F13
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 21:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFB92075B
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 21:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="h+FK1dML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfDPVa4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:30:56 -0400
Received: from mout.web.de ([217.72.192.78]:35427 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfDPVaz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 17:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1555450252;
        bh=czUW8TU9BfEC93l5PDH4u0516PkET3OYl375+ABECn0=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=h+FK1dMLArCZaZXgrO7xllMetwGauE2zgcw5yikrfoOUZTkZEeAk3Z00MKHaaPiQ6
         wCldo8Io4qYEiEGuqbsRJ0QgWE5tD004dfnAKqf+u+aP+u4lyySsoLGURNqLnm3oym
         nbAHAuxWnOuQ1B28aRp3QXGRLIow3K+Lp/HuzsnA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from laptop.manuel.cli.intranet ([109.192.218.194]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MMmx9-1hCwtg42Pf-008eRy for <linux-block@vger.kernel.org>; Tue, 16 Apr 2019
 23:30:52 +0200
To:     linux-block@vger.kernel.org
From:   Manuel Bentele <manuel-bentele@web.de>
Subject: Adding QCOW2 reading/writing support
Openpgp: id=5260D26DAE5C7FDF3113C572EC7CB9F864CA371E
Autocrypt: addr=manuel-bentele@web.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <60bbe5e0-317d-8ead-0eb8-d1dc79927bc8@web.de>
Date:   Tue, 16 Apr 2019 23:30:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:dWxNGanJqt38yRPjouHSINLSxd6mjUPFOTxYZpewEmWBixxn/lI
 r4fYOG437KsDG0NxJ6BaWFkXvcmmrEKRnJOoh8ZTtSQF9xMIeQm4Sbb7UuZ+w7KPDG+2RKd
 Lu13/v7sdLaqo3r+eTqXmtqmg/IG6ZteGiv01W7ou1U8e9mNG95N7VgdzxZVYEBUhoxCf9U
 a5938L9eJmRb2Ji4Wfe3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4BC4lKF/pSQ=:8kwGuWw/GWA2YLMfLrPfzK
 OYJ6dyixY+37ULFsSmeRHVUKj/t+BoYuKzeX0DUuTi/QIlIgkH14RKEBw7BDwerbotK0vuk9d
 HkKWuePX2UmsOmdW2NRT39uTl8gtybsQDk1dwzd7fyj2a9Oo8Ecxt6dVryWMkT11c+s1ARGRO
 xB77oJJ0v8Lzt4UDnSUSBtOnYNuzeWwRQvoil53n4w8H65kK2a4llhvILbFbd0Q9X7HJegadt
 +fgiSONVF7nprsTzala7GsgSToMkigaPmnGuBzR+tn4rYcLiOiy54M6Zt+R6pfeVOblsdjRTM
 VKjCwcA+VaWITB8IKOTcVi7Q8k1DE9t1v62EmDW9jmUjVFr5iKwC4JDG7vnrKDetnlm0Gi/8r
 uMa14fGd+0P730JNnGb3Vz3sZW+SJuW4X2eBzU2iEFcwf2g0AJMHUrSuahU8Ytno5cqboJt0D
 9p6PmUDdGcc076kVGgkBvNVEKofLefCxZ+iPryy5XSC/y0Yo4tq8K4lCrRmxsZRMvhTkV0u2j
 B1N00pxWTeyf6qJYA3wPPnASPBxl6QBnqpe7Cn9Yk0sV98ZeP0ZYVyAjYVDQsfbfwdUHh0SDt
 f4d7Mc+QfDNgd/YqjMaiOaeHz+URref1EHvquiUF5VoVQm5/IBvFGbejDDvJEAHpQaNlDm3Wp
 RFcEyv7jmOI0xkNJuE3wdTFOyDM748XJUjjWUp+9mC8fUQl/UZNPc4+ap/scqdof+VWhZpbkH
 bAyXyI2ydc0nb56NsBeLnl83Qf6K5eUUftwGF+ASMDdFor5SwwAFX0CjkCjIEv+7Y2LW8zZFg
 QX22ray8Xl8plmhDjyiKCiFtNqTiiv7qA8DpmKvFam7AWvspde9rN1eljWuCIohaY7njrlkFz
 cQVIRc3w9xPIAz97+XJ4uOdgdoUWHIUC5c0mnoG/ma+mo4i3NM0opmckBLEvRUj05jv3ycOtQ
 OapwhykuLUw==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi everyone

I'm going to implement an in-kernel reading of QCOW2 images.
In the project, I only need the reading of QCOW2 images, but it's
essential to make thoughts for the implementation of the writing, too.
One of the difficulties seems to be the support of making an image
sparse (resizing the disk image).

Now, I want to ask you for advice: What is the best approach to achieve
this?

=C2=A0 * Implement the reading/writing in the device mapper?
=C2=A0 * Extend the loop device?
=C2=A0 * Create a new subsystem for the processing of sparse devices or im=
ages?

Or do you have any other idea?

Regards,
Manuel Bentele
