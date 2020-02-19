Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714DEC34047
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 17:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4654F2465D
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 17:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j15SO/r/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBSRNf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:13:35 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42746 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgBSRNf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 12:13:35 -0500
Received: by mail-io1-f65.google.com with SMTP id z1so1367040iom.9
        for <linux-block@vger.kernel.org>; Wed, 19 Feb 2020 09:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7P/YRJ7NRLXP5j7uZoB4Xy1U6Bu5a/mvMz2cDAjg/s=;
        b=j15SO/r/JRx+y9gS/MYmBwyYNE02UEUPGvgqKisdut0Z5LMtKHljtTRoEKSCnNNhs/
         L1SC/le2wQWl52Ci6RBH+gEGzJoVifdYlBVkqc+3yuF7NK02paJQfRY5/H1EzvLB6p0L
         bQLx507O1Ud2ZgYNWg+X5NAEDossEcaEqh+NaWSmUawSl59jsogIc3Xhlr3VDA839OHZ
         sfJZOmVJwlX8zvc6kWWgsOSEgYhwu3deHr6gBrh5xDFhC7kv+glGkaiZJqz86hoCEFH/
         9npEm+sMMAghtzvnmWuNjoV08gYQ7XmwDWlmSVk7y8HAb0nGM1yFqF5WK2cmd7l8nR0q
         Zt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7P/YRJ7NRLXP5j7uZoB4Xy1U6Bu5a/mvMz2cDAjg/s=;
        b=ZQcUKcS40b14s9jbChQ9DdMHHFADTKx7d3p+Lw2X419WacbrItNpveZT+3oYgAgbY3
         T/5/IAnsAiPu3Q5XbNh2beBej2ktCbgGkIyed7TogYggCla2bIDDssKSFEI01vj4tU3H
         MxmHD2o7rq3j+3diIjxZ3XJaywjbMuuZOtpR+ioVeKhhk2cLdemjeGzFCb7d+tbeuPl1
         ExWaPdZOxFW6IxKcpFLEly/Y3AKhHJsbHSwaYw47nVeBlP31xucGP59F6aCe1SD/kdcI
         PV1Q5M4PKNhL2rVMOqAAu7ZvBFHf3cUKMizm05G1vav2P9tPpD4NTYSv6EvncKNhs52+
         qSAQ==
X-Gm-Message-State: APjAAAW4JVzi3hE0Wq+o9IZKHwwBlh9ct9Uc+ifNSfbVxkN3bKpWRWJ2
        xlYwnNZQOgm0I/lhQphRAkePGKK6EWFf9tzIJ9U=
X-Google-Smtp-Source: APXvYqwfMw8yFSEy+AeXQUZmYsGwreunmLRqAMOcb1imkeAMdbsUn4ILVzQkXKXA8Pl0ufKn0377cdeY8pfWrvpr2nw=
X-Received: by 2002:a02:2a06:: with SMTP id w6mr22457936jaw.63.1582132414993;
 Wed, 19 Feb 2020 09:13:34 -0800 (PST)
MIME-Version: 1.0
References: <b7ad1223-4224-da46-4c48-50427360f31c@wwwdotorg.org>
 <20200219163258.GB18377@infradead.org> <dfff89c0-d3cf-96a0-7f44-4d2256a3aba3@wwwdotorg.org>
In-Reply-To: <dfff89c0-d3cf-96a0-7f44-4d2256a3aba3@wwwdotorg.org>
From:   Alberto Faria <albertofaria2@gmail.com>
Date:   Wed, 19 Feb 2020 17:13:24 +0000
Message-ID: <CAHB4L8htX_dsr01qegp4nOKk-_krVLSjLWJCv8LiobcmQZ+qgA@mail.gmail.com>
Subject: Re: dd, close(), sync, and the Linux disk cache
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

> Can you explain further why it's necessary given that the kernel
> explicitly blocks execution of close() to flush buffers to disk,
> assuming the process is the last one with the device open? Am I
> misinterpreting the code path I mentioned later in my email? In
> practice, I can see this happening when I use dd.

From what I could gather empirically, close() does write dirty pages
from the block device's page cache to disk but does not submit a
"flush" request to the device driver. Depending on the driver and
device, this may be necessary to ensure that data is persistently
stored (e.g., if the device features an internal write-back cache).
Performing a sync command with the block device as an argument, or
reopening the device and invoking fsync() or fdatasync(), submits
and awaits that request.

The existence or non-existence of a device-internal write-back
cache, and differences in the timing and policies of such a cache,
may explain why in some cases the sync appears necessary and in
others it doesn't.

Alberto Faria
