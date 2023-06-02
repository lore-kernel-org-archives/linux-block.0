Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC23C7EE23
	for <linux-block@archiver.kernel.org>; Fri,  2 Jun 2023 01:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjFBBCr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jun 2023 21:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjFBBCq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jun 2023 21:02:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEA6E4
        for <linux-block@vger.kernel.org>; Thu,  1 Jun 2023 18:02:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5162d2373cdso2009926a12.3
        for <linux-block@vger.kernel.org>; Thu, 01 Jun 2023 18:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685667763; x=1688259763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvpp6zCJzkAVruqEfeRw+jwirL2eHCSWtsESmTUPR/s=;
        b=BBY56f7jmoox511iIEW/fUwIxf2zGwY2AoUXWaS6uG2zKcGVDZ+SuOYpCAtU6zZyVw
         PC40gGUre+V8SVy8aSUqENVoLO2TWnmU6KvHWQfeIXYHbKBTootWbyGM3ITcIcB7B6B8
         kPRB08aQxabbnXAy/5iwMNAWRIahUwv3BdlAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685667763; x=1688259763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvpp6zCJzkAVruqEfeRw+jwirL2eHCSWtsESmTUPR/s=;
        b=UDKU6JFdVFJY1KR2c4VKiVDpLQ1UUnznRZJYjTvVLeXLp8y+LUGctViboSZZG+jkH/
         tevzzr9pg7p/ALaYiG8U/TeNyJeU4PPUOlPKL/lSJSj+9NEG6OWCjIkyas/RsEFqAU2T
         on/SP+8dtDZd8Ih0z7MeqFd8/Du6unxXd42y4IrC/Mh2AFdVaS6QeGUD2YdPyRAGLIc6
         YPgJ90cnfnkCLhEjHbNmbUqGK10J+xChFY/eKZH3MEk4vswpihIcudUQAqjzO29HCQSD
         /svrRZ+3ZVieePZp8wZTG4La1nLy5uHLy/VQlXtnxFLwT7Ijq22Ac3OpEoFIDjlerhmp
         +iEQ==
X-Gm-Message-State: AC+VfDxMsOGFNPghYPu+BRIOPVI/Sor5gcIp3ep617PhvtqRm1DoMDYI
        wIWhZnmq2iVkMfQTyymx7f+h6xsSBTHMgWFFmamrkeey
X-Google-Smtp-Source: ACHHUZ5jD7mIhvWMwxboyWIvzFkSNFtopYafMMIL8V8PaBwPyx0sMjyzVhqnZtRuB69G3C0l3lSWcQ==
X-Received: by 2002:a17:907:360d:b0:94e:8559:b5c5 with SMTP id bk13-20020a170907360d00b0094e8559b5c5mr9356155ejc.64.1685667763579;
        Thu, 01 Jun 2023 18:02:43 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id c4-20020a170906528400b009745d484519sm75137ejm.70.2023.06.01.18.02.42
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 18:02:42 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-96fbc74fbf1so226303266b.1
        for <linux-block@vger.kernel.org>; Thu, 01 Jun 2023 18:02:42 -0700 (PDT)
X-Received: by 2002:a17:907:940d:b0:974:6026:a312 with SMTP id
 dk13-20020a170907940d00b009746026a312mr300827ejc.51.1685667762103; Thu, 01
 Jun 2023 18:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072829.1258286-1-hch@lst.de> <20230601072829.1258286-4-hch@lst.de>
In-Reply-To: <20230601072829.1258286-4-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Jun 2023 21:02:25 -0400
X-Gmail-Original-Message-ID: <CAHk-=wj3TrM-NWUcFUivefNwzbfGdfcgDGfGP12m6WBfH9JpWg@mail.gmail.com>
Message-ID: <CAHk-=wj3TrM-NWUcFUivefNwzbfGdfcgDGfGP12m6WBfH9JpWg@mail.gmail.com>
Subject: Re: [PATCH 3/3] block: fail writes to read-only devices
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 1, 2023 at 3:28=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Note that the last attempt to do this got reverted by Linus in commit
> a32e236eb93e ("Partially revert "block: fail op_is_write() requests to
> read-only partitions") because device mapper relyied on not enforcing
> the read-only state when used together with older lvm-tools.

I'm certainly happy to try again, but I have my doubts whether this will wo=
rk.

Note that the problem case is for a device that *used* to be writable,
but became read-only later, and there's an existing writer that needs
that writability.

The lvm fix was not to stop writing, but to simply not mark it
read-only too early.

So I do think that the problem here is purely in the block layer.

The logic wrt "bdev_read_only()" is not necessarily a "right now it's
read-only", but more of a thing that should be checked purely when the
device is opened. Which is pretty much exactly what we do.

So honestly, that whole test for

+       if (op_is_write(bio_op(bio)) && bio_sectors(bio) &&
+           bdev_read_only(bdev)) {

may look "obviously correct", but it's also equally valid to view it
as "obviously garbage", simply because the test is being done at the
wrong point.

The same way you can write to a file that was opened for writing, but
has then become read-only afterwards, writing to a device with a bdev
that was writable when you *started* writing is not at all necessarily
wrong.

So please at least consider the possibility that that test - while it
looks obvious - is simply buggy.

                Linus
