Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD92C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 08:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F5B20840
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 08:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547628865;
	bh=TT6Wuhial05lhUPWMlvLkr+62xVH1euGBPzYe+N3bCw=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=eKjRKcEXi69NLKcMxQ8LQqI1tF1cnj0LtvgaeWZKvyof4cuncDUgDkI7bHPp/dyC2
	 cttDQGT7kEeKCcZyRrN4PJpD8RZml5LE3kLxIb2Gh5iLg76gRAiDjPDievMkIOTtNe
	 qoXtlnBBUZ9ISoU+JiY8XfiNlHDcAKRnrhh6lJpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388992AbfAPIyU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:54:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:38918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731682AbfAPIyT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 03:54:19 -0500
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8156020866;
        Wed, 16 Jan 2019 08:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547628858;
        bh=TT6Wuhial05lhUPWMlvLkr+62xVH1euGBPzYe+N3bCw=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=doFVyhOEIYZEq46cMmEGvlFX7ksGoATSrUWl7o3xjrod/OBM9zYPvfogFRRReFD/i
         DJUE6oHmdfSWOvU7CuoLCrMnc1l1ZJVp4oZ2vSM4z4+D02YeJXZHdW1yRYNNq4C8fn
         QyWqH17v9ZKLGNgLVX7X4/pIWMRb7mVHFeUjQPAs=
Received: by mail-lj1-f173.google.com with SMTP id n18-v6so4748139lji.7;
        Wed, 16 Jan 2019 00:54:18 -0800 (PST)
X-Gm-Message-State: AJcUukeCakYoiDv8XMaZoGkp/Sb7Bobl3yRkWH5uoy8VGQpAEWzZVDnz
        tEFZpVvJoB2LXJ+9gkSvtjibBMeb0d4qvBgrNYg=
X-Google-Smtp-Source: ALg8bN6zt7MPM1kJlXsi0rKVmvQRDLc7sqq1DsTGTnHa2dDNph68BPtukDavCtbrn3c3H1RWRFi49lye8Yc9j/losLI=
X-Received: by 2002:a2e:9cd2:: with SMTP id g18-v6mr6016495ljj.161.1547628856679;
 Wed, 16 Jan 2019 00:54:16 -0800 (PST)
MIME-Version: 1.0
References: <CAJKOXPdQaxKH3z3yMBggP3dAFJ3ecgCcHk=bGaVHZ-Q+V2Riug@mail.gmail.com>
In-Reply-To: <CAJKOXPdQaxKH3z3yMBggP3dAFJ3ecgCcHk=bGaVHZ-Q+V2Riug@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 16 Jan 2019 09:54:05 +0100
X-Gmail-Original-Message-ID: <CAJKOXPd2WiMC8uc1YuyR+_vEScSewMzQe1Y7UGHgxvkCD+tQ7A@mail.gmail.com>
Message-ID: <CAJKOXPd2WiMC8uc1YuyR+_vEScSewMzQe1Y7UGHgxvkCD+tQ7A@mail.gmail.com>
Subject: Re: [BUG bisect] kernel BUG at block/bio.c:1833 and fail to mount disk
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 16 Jan 2019 at 09:52, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Hi,
>
> On today's next-20190116 I see a bug during boot:
> [ 6.843308] kernel BUG at ../block/bio.c:1833!
> [ 6.847723] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> ...
> [ 7.543824] [<c044c144>] (bio_split) from [<00000000>] ( (null))
> [ 7.549881] Code: 13833b01 11c630bc e1a00006 e8bd8070 (e7f001f2)
>
> (not much in the calltrace)
> On all my boards. Also QEMU-arm fails.
>

I forgot the bisect commit:

258cfdfaf7bd729e759a0a91fd00ac9794796ad3 is the first bad commit
commit 258cfdfaf7bd729e759a0a91fd00ac9794796ad3
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Jan 11 19:01:15 2019 +0800

    block: use bio_for_each_bvec() to compute multi-page bvec count

:040000 040000 d79b2e71d308650df4764ff644f29d3a24dbab96
0a5d624843b805ee0c9fd9a7e2d5163f5b15b167 M block

BR,
Krzysztof
