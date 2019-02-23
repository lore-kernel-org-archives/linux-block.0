Return-Path: <SRS0=C1jc=Q6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED7DC43381
	for <linux-block@archiver.kernel.org>; Sat, 23 Feb 2019 03:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F26A20675
	for <linux-block@archiver.kernel.org>; Sat, 23 Feb 2019 03:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfBWDKw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Feb 2019 22:10:52 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:33784 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfBWDKw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Feb 2019 22:10:52 -0500
Received: by mail-qt1-f177.google.com with SMTP id z39so4899241qtz.0
        for <linux-block@vger.kernel.org>; Fri, 22 Feb 2019 19:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVo2yvPkQcOfnCvpRVWOLfbTevOVnB/+yEXQwluhnxg=;
        b=fUbUleKapOIR8T3TFdu/bsi1zPRplssimpUwvel3Xi2j/CAp5u9Xt31bUdTFEjq68s
         lVN96ekZIsaXsuAdV+0kNoxRyQ5OxpxwE3p5BeiqBCjGTAXw+zVrnTB4rxndnKH6KcQr
         s9fboFH97wTx7PNMLV8bJDOtLWH7vIfOSZxtNgZszgbbhw2+lWDiGUzglVp460PNPvXU
         iNbo1paEOjIo4tr3Djd9pKcBoWE8vBVTYJuWAUmuZyfsV62btnlOzF0xSvTANmPxN/eo
         AnzlcO1N/9bx/iIKEil/nH0qElpEUlo6Nt6P/uR+tOdcj/8FMf6wXzHr9ympn0tLq/oy
         h5Tg==
X-Gm-Message-State: AHQUAuaaBstWrBBlAsVYaRmDK3LSY7H4ZDNXZvaftLtMwITlI/D24YG8
        W6ToSHWeumfobGPbrRpQrC/3uuBIXCzGe7m7bmzy4A==
X-Google-Smtp-Source: AHgI3Ia151HevhdKkieKfFIh0xt3StuTG7l/w5zA9LNpkBZ4YAfvv6MudmiETtuMEoiILVcbUgqQkxYXUtvEB1KfIbI=
X-Received: by 2002:a0c:93ab:: with SMTP id f40mr5721776qvf.59.1550891451403;
 Fri, 22 Feb 2019 19:10:51 -0800 (PST)
MIME-Version: 1.0
References: <70cda2a3-f246-d45b-f600-1f9d15ba22ff@gmail.com>
 <87eflmpqkb.fsf@notabene.neil.brown.name> <20190222211006.GA10987@redhat.com>
 <7f0aeb7b-fdaa-0625-f785-05c342047550@kernel.dk> <20190222235459.GA11726@redhat.com>
 <CAMeeMh-2ANOr_Sb66EyA_HULkVRudD7fyOZsDbpRpDrshwnR2w@mail.gmail.com> <20190223024402.GA12407@redhat.com>
In-Reply-To: <20190223024402.GA12407@redhat.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Fri, 22 Feb 2019 22:10:39 -0500
Message-ID: <CAMeeMh9qLkTByWJewPR4o844wPkA-g5Hnm7aGjszuPopPAe8vA@mail.gmail.com>
Subject: Re: block: be more careful about status in __bio_chain_endio
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, NeilBrown <neilb@suse.com>,
        linux-block@vger.kernel.org,
        device-mapper development <dm-devel@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'm also worried about the other two versions, though:

memory-barriers.txt#1724:

1724 (*) The compiler is within its rights to invent stores to a variable,

i.e. the compiler is free to decide __bio_chain_endio looks like this:

static struct bio *__bio_chain_endio(struct bio *bio)
{
  struct bio *parent = bio->bi_private;
  blk_status_t tmp = parent->bi_status;
  parent->bi_status = bio->bi_status;
  if (!bio->bi_status)
    parent->bi_status = tmp;
  bio_put(bio);
  return parent;
}

In which case, the read and later store on the two different threads
may overlap in such a way that bio_endio sometimes sees success, even
if one child had an error.

As a result, I believe the setting of parent->bi_status needs to be a
WRITE_ONCE() and the later reading needs to be a READ_ONCE()
[although, since the later reading happens in many different
functions, perhaps some other barrier to make sure all readers get the
correct value is in order.]
