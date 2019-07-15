Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEA0C7618A
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 03:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EBA20C01
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 03:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zvgVIvU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfGODvE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Jul 2019 23:51:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42826 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfGODvE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Jul 2019 23:51:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so7578786plb.9
        for <linux-block@vger.kernel.org>; Sun, 14 Jul 2019 20:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N9B2WuYqxWI3sQIiMvCR+6gSg99hE+CXMAzxbmGePS4=;
        b=zvgVIvU+NoZ/YHfINvizfxwTm1od1rTXT76A1EQphhRyCYTZbmM+vZKFxYZeKItIo2
         dgYZANAo/2IZKBYBDtAPzZJ8JMWoG+yv8yzmghq9Lf1KhhlgH5equdhQQQtStZ0nZmlC
         bZqQyF9CsGs7ZuqalXgH4DJdfITlPwfg9LCSngA0NEu42ZHm0EWlMLvYk08PB+Snhvli
         B1EU4zpyAJ7mo7ClPdvA+VIXCLw2AUM9i85qQxlRlMwxp0zQcV8f1IHl04fjyq7JKos9
         CM5aspUBCRUoOpRwcaFVLiUE9/I2mI2dQua9FcmsVSPljA6pHSDqE1mC/PsdCC3IQtAV
         EoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N9B2WuYqxWI3sQIiMvCR+6gSg99hE+CXMAzxbmGePS4=;
        b=aZ1ZLLsIfcPMJwRvfOQ/Tisc1gAeLL9s82MQtUUNQwDi2PIOcN3C8TEWxOf6Dd4SlN
         Qt+JJSGWdkQmFnJTGExEwokqViiyREQs8vYW088xVIbFn/6XBabLYGLueQTy4vrAzQ8E
         5AYSKjrnD0mLQ3gnYGqzehiJ0otuCUJx2C+CdymE4BBXFfhA1o9UM8nu2ckH8bfMKMDP
         pX8Gh/jF2NsgXlexs9DqEef1b29t0LmIjk43lpO1dKDKPOcrVAzNDrowvf6oKEIk+4Fs
         wqbh8evm6/gPvBLZ1WlJl8alnloyb4Be9vupFQ+KTlVqoUUmWMYC1Bi9lDyBgu8+r+YP
         sbPw==
X-Gm-Message-State: APjAAAU7D95jeduBJd8/SH+KarHjFTO7aV1r809Ag4+Ce3BXB3H3z0cN
        biCgss93N60bJ1Wg9Y8Oo5ZiK16JSkk=
X-Google-Smtp-Source: APXvYqxhvIY5ZD5NpmY2vqVdP/07G+hwenkarxAqwcIxWvxYGoaUIo2GTSqXRqIdPTaYutXcT3PPGA==
X-Received: by 2002:a17:902:8548:: with SMTP id d8mr26057307plo.100.1563162662835;
        Sun, 14 Jul 2019 20:51:02 -0700 (PDT)
Received: from [192.168.1.238] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id v184sm15624103pgd.34.2019.07.14.20.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 20:51:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/3] io_uring: use kmem_cache to alloc sqe
From:   Jens Axboe <axboe@kernel.dk>
X-Mailer: iPhone Mail (16G5069a)
In-Reply-To: <5d2bf52d.1c69fb81.af3a2.b57fSMTPIN_ADDED_BROKEN@mx.google.com>
Date:   Sun, 14 Jul 2019 21:51:00 -0600
Cc:     linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD843851-A62C-4368-A78B-F863A72E589C@kernel.dk>
References: <20190713045454.2929-1-liuzhengyuan@kylinos.cn> <1f56dacc-6f69-35ff-dfb9-0b3e91696e36@kernel.dk> <5d2bf52d.1c69fb81.af3a2.b57fSMTPIN_ADDED_BROKEN@mx.google.com>
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 14, 2019, at 9:38 PM, Zhengyuan Liu <liuzhengyuan@kylinos.cn> wrote:
>=20
>=20
>> On 7/14/19 5:44 AM, Jens Axboe wrote:
>>> On 7/12/19 10:54 PM, Zhengyuan Liu wrote:
>>> As we introduced three lists(async, defer, link), there could been
>>> many sqe allocation. A natural idea is using kmem_cache to satisfy
>>> the allocation just like io_kiocb does.
>> A change like this needs to come with some performance numbers
>> or utilization numbers showing the benefit. I have considered
>> doing this before, but just never got around to testing if it's
>> worth while or not.
>> Have you?
> I only did some simple testing with fio. The benefit was deeply depend on t=
he IO  scenarios. For random and direct IO , it appears to be nearly no seq c=
opying, but for buffered sequential rw, it appears to be more than 60% copyi=
ng compared to original submition.

Right, which is great as it=E2=80=99s then working as designed! But my quest=
ion was, for that sequential case, what kind of speed up (or reduction in ov=
erhead) do you see from allocating the unit out of slab vs kmalloc? There ha=
s to be a win there for the change to be worthwhile.

=E2=80=94=20
Jens Axboe

