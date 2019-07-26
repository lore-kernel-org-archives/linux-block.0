Return-Path: <SRS0=SSPg=VX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEA4C7618F
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 17:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A42218B8
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564163821;
	bh=RNMEIiOnFyjV6sNYOt95vbi9kIoEI1nXNx4ROd0+Pbk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vet/7C+Zz5a5fbJCgqTutuu3wsKSUCHIJzt6VTyMFALUYoMMV1lxERyabrLdkOoco
	 9nc1DgM8kbf+x4KWYilG+RIHEuWMxVdY4D/Kw20WWc+QFPaN4T4LFMNP4TCTiPgWsj
	 lBWzE2V1h9VknRJIXLGfGPOyLiEsxw/XJbwRCAns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfGZR5A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jul 2019 13:57:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35364 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfGZR5A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jul 2019 13:57:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id p197so37617156lfa.2
        for <linux-block@vger.kernel.org>; Fri, 26 Jul 2019 10:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfmsfBmT17PJJ74ANUzoszKWmZYNwTxSI7eHLYgnatM=;
        b=dgaJ0WL2L14193aZi6FUX47ldYOF2Rp/E7f64/OFB3tYBGyxOp8iTQCHfM6/L8Xxe4
         anbouLngD9B9DF422OFWmp9gQdzWfI9K3GFOYLsUe68uQOCU9sbWGvC+TzILXPnaXcx7
         aGfPUVs+0oi1puJhMtFgtRAb6cnStUOqZQDow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfmsfBmT17PJJ74ANUzoszKWmZYNwTxSI7eHLYgnatM=;
        b=uP1HWH9oNOINux5iE9/I61IlzXJIIYx8Yve1VcffVIYGKL8ZxiSbLGxMeoe/kCvHJ3
         coF+8bZC0JCAf1XfPvGX6fqO/mfKXrw4FP3HM5PbnbxGt68xFxlzsg0kWz9vcyXpKTmk
         mSXuh6PQaZTUQo80D3kA8thMtmIVbW6EFU0D545r0HeIv/jNvtFMPgfSWebE1xXvuRK0
         7wwH0AwNaOUgsGYYWDBZhqdGvUfeIXwAQEe53kx0wGWeZcA2fzQEYgqhln6Mg1ZeQicY
         FoMPIelam7abM37TDXfLqn0b15YR5+r4QLLJVcMHn6tAoH5HsinNQHCDtu+YEoQ33kS+
         P8WQ==
X-Gm-Message-State: APjAAAX7JYiOcz4aHnUWpG2IfmIgv/sz+ILZdw3SxsK/3vdYqM2/8fS2
        XhXJRHYmTDD73HI7KOHx1JeeZN5jlbg=
X-Google-Smtp-Source: APXvYqxBBndqtDAYJNqBaGiArSAXXcogkuT6sV/j/s6XgwZw4HLg0/9EU51DdANPOCNOFp8bSygdiQ==
X-Received: by 2002:a19:c514:: with SMTP id w20mr45448600lfe.182.1564163818206;
        Fri, 26 Jul 2019 10:56:58 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 189sm9588525lfa.0.2019.07.26.10.56.56
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 10:56:57 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id r15so20657855lfm.11
        for <linux-block@vger.kernel.org>; Fri, 26 Jul 2019 10:56:56 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr45204978lfm.170.1564163816531;
 Fri, 26 Jul 2019 10:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <2b22063e-660c-a238-f109-fcf3f1b888b5@kernel.dk>
In-Reply-To: <2b22063e-660c-a238-f109-fcf3f1b888b5@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Jul 2019 10:56:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjV1cykm1UYSVR1KzwV4ZF0QtU9rOTsThVJj8qSX6hKgQ@mail.gmail.com>
Message-ID: <CAHk-=wjV1cykm1UYSVR1KzwV4ZF0QtU9rOTsThVJj8qSX6hKgQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 5.3-rc2
To:     Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Guys, what happened to the wrong sector boundary and max sector mess?

There are at least two different issues (with one of them having two
proposed fixes);

  https://lore.kernel.org/linux-block/1563896932.3609.15.camel@HansenPartnership.com/
  https://lore.kernel.org/lkml/1563895995.3609.10.camel@HansenPartnership.com/
  https://lore.kernel.org/lkml/1563839144.2504.5.camel@HansenPartnership.com/

but I don't actually seem to have a pull request for any of this.

The

   dma_max_mapping_size(dev) << SECTOR_SHIFT

this in scsi_lib.c is clearly completely wrong, and is still there in my tree.

The virt_boundary_mask thing can apparently be fixed other ways too
(ie questionable whether it should be fixed in block/blk-settings.c or
in drivers/scsi/scsi_lib.c, but I don't see either one. I was
expecting the block/blk-settings.c one to be in this pull request.

Maybe I'm missing some alternate fix? I don't think so, particularly
since I still see the wrong-way shift, at least.

Is this due to some confusion about who is supposed to fix it?
Christoph was involved in both, issues, and the problems came throigh
different trees (ie block tree for the virt_boundary_mask, scsi with
the

                  Linus

On Fri, Jul 26, 2019 at 8:12 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> A set of fixes that should make it into this release. This pull request
> contains:
