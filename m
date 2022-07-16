Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF05C433EF
	for <linux-block@archiver.kernel.org>; Sat, 16 Jul 2022 03:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiGPDdY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 23:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGPDdY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 23:33:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC9B32B82
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 20:33:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bk26so9150789wrb.11
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 20:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vYR3WbTFw4TG1sTb7Tx0DmmRBxroaabfz9k7MAvXkH8=;
        b=k7qQPhMi60UEu2t7Hy049XBotEoKQQS4zKTvIZbjutCVW3oOPDzfx/tdLWSNpBnAuk
         Qr/jpVC/tkzaqBgeT7DhsxNRpddneFPr3lGnPMdRZ/fGzqTxOFFowlSmNl0f0yiNCaQ7
         KZJdZiyJvNaLfDBguZfb3B7tsLe1EfdJeZfL4jgVhJEKCKAhUFGFj/sqH9QC8ChW0wyx
         7WALWpRiTCSmJ+8hllhUoERb9LdVasszLNciNqU1jLpTCCcbZ4lJkMXJRTIyFs9jgJPO
         od5s4hxPHJN/vuFDpKdYJFXkhyMsKp53LyJ41wKjw3fRXmiA/Q6pISDX8GV1EJSRthLX
         ETrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYR3WbTFw4TG1sTb7Tx0DmmRBxroaabfz9k7MAvXkH8=;
        b=MtQ23kd+okiLGlZlA3BWYEPdcNHlDUjIP7rUptcGpupqIQIHafc2rHw8C8LNE++QYw
         IxxjTAPC/5dZM0IzcPgGt9ec7S95w6n8qPEiwRhY7SbKrzZA6ymnFw2GHAQJZEwNDsPq
         FXVWowDsyGZdKLysxrgQndNRtroqFnbqbiq/JW6FKhyaSGDNSFEx0YPhthhm2YqQkXMG
         dusMjn0GSe8mdrT2USyZxOHJ4j4y/FoyLfuNbfUa3sUQAJa7iVeNiA9gatd1lu59mdhs
         rZQpnu5WIEiz1eKob64eBx8Z1j8/AjAs9BM8CPMx05wLBZmueoH+107U5izLxEo9Q1BX
         cJyQ==
X-Gm-Message-State: AJIora/4woycWoHLvVTtjuPQmZJwo1iuuBbme5pFX6zrdnGXOfLLAR++
        pWb2D0M8T+/cmPfPvfr0OIMBQ96MjDFa+ikvziC3
X-Google-Smtp-Source: AGRyM1tBYotr89sxZgUpj7Rz0paH0nzxUS6pduI0qUwqAk5vOCrzC6ovujPmRSHKTDcGuNMqQfswDSvUMwdMgE31v98=
X-Received: by 2002:adf:d22f:0:b0:21d:6b26:8c6f with SMTP id
 k15-20020adfd22f000000b0021d6b268c6fmr15647822wrh.70.1657942400130; Fri, 15
 Jul 2022 20:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220715191622.2310436-1-mcgrof@kernel.org> <a56d191e-a3a3-76b9-6ca3-782803d2600c@kernel.dk>
 <CAHC9VhRzm=1mh9bZKEdLSG0vet=amQDVpuZk+1shMuXYLV_qoQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRzm=1mh9bZKEdLSG0vet=amQDVpuZk+1shMuXYLV_qoQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 15 Jul 2022 23:33:08 -0400
Message-ID: <CAHC9VhQm3CBUkVz2OHBmuRi1VDNxvfWs-tFT2UO9LKMbO7YJMg@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,io_uring: add LSM hooks for the new uring_cmd file op
To:     Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>
Cc:     casey@schaufler-ca.com, joshi.k@samsung.com,
        linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        a.manzanares@samsung.com, javier@javigon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 15, 2022 at 3:52 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Jul 15, 2022 at 3:28 PM Jens Axboe <axboe@kernel.dk> wrote:
> > On 7/15/22 1:16 PM, Luis Chamberlain wrote:
> > > io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> > > add infrastructure for uring-cmd"), this extended the struct
> > > file_operations to allow a new command which each subsystem can use
> > > to enable command passthrough. Add an LSM specific for the command
> > > passthrough which enables LSMs to inspect the command details.
> > >
> > > This was discussed long ago without no clear pointer for something
> > > conclusive, so this enables LSMs to at least reject this new file
> > > operation.
> >
> > From an io_uring perspective, this looks fine to me. It may be easier if
> > I take this through my tree due to the moving of the files, or the
> > security side can do it but it'd have to then wait for merge window (and
> > post io_uring branch merge) to do so. Just let me know. If done outside
> > of my tree, feel free to add:

I forgot to add this earlier ... let's see how the timing goes, I
don't expect the LSM/Smack/SELinux bits to be ready and tested before
the merge window opens so I'm guessing this will not be an issue in
practice, but thanks for the heads-up.

-- 
paul-moore.com
