Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F7DC10F05
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 09:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412E82084B
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 09:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBlHcfam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfDAJBd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:01:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34109 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfDAJBc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 05:01:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so10917755wrq.1
        for <linux-block@vger.kernel.org>; Mon, 01 Apr 2019 02:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sXk/RNe/QfIZJt2m4bkPTnI917e020gPuS2AXpdWHYA=;
        b=mBlHcfambs1nqnYLFIU3kZmBlRvkbALXztXs2utLtWZKPiczYNbpPuBFwomLpiqbAD
         aURjdY0B+L7a1AdoJgUQqT1pBO0pUq1S91W6YucYE8638ULy5QzRGTNdl/kKDgHXWULc
         1uiOREBZdqST7T61yBtCR8bZHdQqLwpZfkuyCWrwAcgdm8m+9JyLk1BNrsKLNXSLg+YO
         UN/nPldmK0bSEpddErfFUS9dJcfO5UeC7Zt8EhPD6WtoSsLvajthDr52O/XZwkE3T04T
         re1fBmUxIqR4hRzrmayY/ISn9zN7EJ0hCthmrMLOe2x/phUK3yCr47KVooFjmEL7DcEF
         tLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sXk/RNe/QfIZJt2m4bkPTnI917e020gPuS2AXpdWHYA=;
        b=hcaJvCgPQ3SyEuJ2wtK2x9j5U7yOKoTVc3tUxYSAACajlo+MvmYBzbADLPHpMWcWRx
         BEd59R0EroxiQ+T2OEQjmq45TXzKLZZLRPoFS5wCGnGRN9OIE/GM0PVWRyOKnc+3lNt+
         3Au5wbOMcvn25QkrsZFYmsgT4E7PVjGlA0ocqGxWkFvGbqgoXlM9LLkRt95Q2uli0fwx
         ofYO9PSE2upD81vcLfgOATMNETMYzzGD5w4C9VItNTo5mS+DC249maQOVNiXsMYCcfRh
         en3ns7EFVtf43bYdTJOajw4R9ZK3N90SQSbfkNCNNkSk3GnvFeTD4dZ9QyaSyfOEcs+r
         ISxg==
X-Gm-Message-State: APjAAAXlHNICX1YlHjt5FeUVodiw4PKHXBlIB0tjPNjNKlHVRdi3LS3Z
        lC/4JVWKMTe+SnB8FcmFrBT1ng==
X-Google-Smtp-Source: APXvYqxeAyEFBlAuZQoHb8VHHtsmRwWrxfY7XYvNTiAEh9EidxkoUXqDezY7o8LJF9ENN2G6K5Ilvg==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr41844552wrr.190.1554109290099;
        Mon, 01 Apr 2019 02:01:30 -0700 (PDT)
Received: from [192.168.0.101] ([88.147.53.253])
        by smtp.gmail.com with ESMTPSA id 13sm10146380wmf.23.2019.04.01.02.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 02:01:29 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Bisected GFP in bfq_bfqq_expire on v5.1-rc1
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190401115509.76310e03@fire.localdomain>
Date:   Mon, 1 Apr 2019 11:01:27 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <84B0CA50-0ED8-4171-8007-19EA43951735@linaro.org>
References: <20190329160227.7d55c8dd@fire.localdomain>
 <0e203a26-b941-cef4-dff1-013999d4b041@kernel.dk>
 <626EAE58-63C1-4ABA-9040-9D9A61F74A0D@linaro.org>
 <20190401115509.76310e03@fire.localdomain>
To:     Dmitrii Tcvetkov <demfloro@demfloro.ru>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 1 apr 2019, alle ore 10:55, Dmitrii Tcvetkov =
<demfloro@demfloro.ru> ha scritto:
>=20
> On Mon, 1 Apr 2019 09:29:16 +0200
> Paolo Valente <paolo.valente@linaro.org> wrote:
>>=20
>>=20
>>> Il giorno 29 mar 2019, alle ore 15:10, Jens Axboe <axboe@kernel.dk>
>>> ha scritto:
>>>=20
>>> On 3/29/19 7:02 AM, Dmitrii Tcvetkov wrote:
>>>> Hi,
>>>>=20
>>>> I got kernel panic since v5.1-rc1 when working with files on block
>>>> device with BFQ scheduler assigned. I didn't find trivial way to
>>>> reproduce the panic but "git checkout origin/linux-5.0.y"
>>>> on linux-stable-rc[1] git repo on btrfs filesystem reproduces the
>>>> problem 100% of the time on my bare-metal machine and in a VM.
>>>>=20
>>>> Bisect led me to commit 9dee8b3b057e1 (block, bfq: fix queue
>>>> removal from weights tree). After reverting this commit on top of
>>>> current mainline master(9936328b41ce) I can't reproduce the
>>>> problem.
>>>>=20
>>>> dmesg with the panic and bisect log attached.
>>>>=20
>>>> [1]
>>>> =
https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
>>>=20
>>> Paolo, can you please take a look at this?
>>>=20
>>>=20
>>=20
>> Yep.
>>=20
>> That you very much Dmitrii for also bisecting.  I feel like this
>> failure may be caused by the typo fixed by this patch:
>> https://patchwork.kernel.org/patch/10877113/
>>=20
>> Could you please give this fix a try?
>=20
> Still reproduces with the patch on top of current mainline
> master(v5.1-rc3).
>=20
> Crashes with and without CONFIG_BFQ_GROUP_IOSCHED look same to me.
> Original dmesg was also from kernel with CONFIG_BFQ_GROUP_IOSCHED=3Dn.
>=20
> gpf.txt contains crash with the patch and CONFIG_BFQ_GROUP_IOSCHED=3Dn
> gpf-w-bfq-group-iosched.txt - with the patch and =
CONFIG_BFQ_GROUP_IOSCHED=3Dy
> config.txt - kernel config for the VM with CONFIG_BFQ_GROUP_IOSCHED=3Dn
>=20
>=20

Ok, thank you. Could you please do a

list *(bfq_bfqq_expire+0x1f3)

for me?

Thanks,
Paolo

>=20
> <gpf.txt><gpf-w-bfq-group-iosched.txt><config.txt>

