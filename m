Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B564C43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 10:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3602082C
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 10:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vcHrIGg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfDAKfQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:35:16 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:33839 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfDAKfP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 06:35:15 -0400
Received: by mail-wm1-f45.google.com with SMTP id r186so1247311wmf.1
        for <linux-block@vger.kernel.org>; Mon, 01 Apr 2019 03:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/7C0IohzWXZjJ0NwALGrigsjy1qcIqbbTdWC7cBS0ec=;
        b=vcHrIGg8pzTEVDL0AHs61OuehOaz89tFFQwMAt+tsUkaKM9HzbbOebKSDqaKjS36/I
         JOWCgNStPFE5LVE5vfwfS0DDbOllr4sIACDJ7xMOH3Bo3ht/55RK60gtnMrYxCf5piin
         qkeRgHNIcyKhYIeEj27NLUAKHl6hm/WZjGHpRBrU90PEi8o8k/br/BI789ITNOUE9Y7S
         M1HviizIeKfCYmcJ45SHa6Zs+PszIkFQIWW72IL/Mh10xlnbbLkgHxtieUfNcfbsh8by
         VMD2BTdrIX46/6rqz7dr9mZ/+Ua8d+FvkVpCqVry67q4QejG2hVJoJYwvMmE1QXBnO7t
         EQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/7C0IohzWXZjJ0NwALGrigsjy1qcIqbbTdWC7cBS0ec=;
        b=L628zeWFRguE1uEAdUN3cnm26GE7P1So+hTubPzEswr5leYBFEjUReQ4Y61RhuPozd
         rYZnq9Qrp9gvtIPeybkN3RIU+fnV15dbmUOfFFeOnDGmmANwyy7pPVAIA4iFOYYVqKqw
         PiQFhwr5iwBDY1IRKIMbuRIhTPpUl1YD768JDuXu4+CYfSO3eRdMQ4wYCjRDBrjG9PN3
         u0OeqxWaDlOeIaeiF8V/+h2RcraLnJUdmo8Tlammr1F4MyYbCvaCIkNVxOFRExbxJ0io
         eab5r6rHKsgoBCjxeomSAkDRUm72FPbyh0htFu+7UZwUP9ej8OL3YMUrGxLGBNmtpnxP
         ywqA==
X-Gm-Message-State: APjAAAU3fXGAhfsFM6S9A2BvpzAXOutC2x7+Vt7Qg4jpgZnAQ8Z8ra5F
        93DjYfi2JQ/TIaoykpl5jVs9AQ==
X-Google-Smtp-Source: APXvYqxe8cBXs9KW4FBO1JvlixbVQDo7hBigrf6i0aqh1naWo0jmLgb2GDVFmsfPEjAVonIM8wj2kA==
X-Received: by 2002:a1c:d084:: with SMTP id h126mr9551034wmg.110.1554114914005;
        Mon, 01 Apr 2019 03:35:14 -0700 (PDT)
Received: from [192.168.0.101] ([88.147.53.253])
        by smtp.gmail.com with ESMTPSA id f9sm10631222wmb.36.2019.04.01.03.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 03:35:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Bisected GFP in bfq_bfqq_expire on v5.1-rc1
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190401122233.3e861312@fire.localdomain>
Date:   Mon, 1 Apr 2019 12:35:11 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EBC090F1-72C0-4794-91CC-37F9A2A1DEFB@linaro.org>
References: <20190329160227.7d55c8dd@fire.localdomain>
 <0e203a26-b941-cef4-dff1-013999d4b041@kernel.dk>
 <626EAE58-63C1-4ABA-9040-9D9A61F74A0D@linaro.org>
 <20190401115509.76310e03@fire.localdomain>
 <84B0CA50-0ED8-4171-8007-19EA43951735@linaro.org>
 <20190401122233.3e861312@fire.localdomain>
To:     Dmitrii Tcvetkov <demfloro@demfloro.ru>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 1 apr 2019, alle ore 11:22, Dmitrii Tcvetkov =
<demfloro@demfloro.ru> ha scritto:
>=20
> On Mon, 1 Apr 2019 11:01:27 +0200
> Paolo Valente <paolo.valente@linaro.org> wrote:
>> Ok, thank you. Could you please do a
>>=20
>> list *(bfq_bfqq_expire+0x1f3)
>>=20
>> for me?
>>=20
>> Thanks,
>> Paolo
>>=20
>>>=20
>>> <gpf.txt><gpf-w-bfq-group-iosched.txt><config.txt>
>=20
> Reading symbols from vmlinux...done.
> (gdb) list *(bfq_bfqq_expire+0x1f3)
> 0xffffffff813d02c3 is in bfq_bfqq_expire (block/bfq-iosched.c:3390).
> 3385             * even in case bfqq and thus parent entities go on =
receiving=20
> 3386             * service with the same budget.
> 3387             */
> 3388            entity =3D entity->parent;
> 3389            for_each_entity(entity)
> 3390                    entity->service =3D 0;
> 3391    }
> 3392
> 3393    /*
> 3394     * Budget timeout is not implemented through a dedicated =
timer, but

Thank you very much.  Unfortunately this doesn't ring any bell.  I'm
trying to reproduce the failure.  It will probably take a little
time.  If I don't make it, I'll ask you to kindly retry after applying
some instrumentation patch.

Thanks,
Paolo=
