Return-Path: <SRS0=SSPg=VX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E396C7618F
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 18:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF052077C
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 18:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564166702;
	bh=MBXFDunWrID+sCagJzMalvVR0JLA/39Lc++kjM8IhP8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wsVtMKMB7dmCD4VZ+ODST+Gg8EYdBpYGwuqlPQoGV5Jrh0zR2Sz/fRDIJSiwQoPAU
	 r9yCm0q2JYyJ/QqAHLbQxgfjdlhmXGKIOlHt19IhomQjRSjZZ9vURFpE0zLpEztooX
	 EA6TuwM7KZoLvDh5MHyNzgOZPJGbA2ulva9+4VcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388142AbfGZSpB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:45:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39759 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbfGZSpB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jul 2019 14:45:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id v85so37709783lfa.6
        for <linux-block@vger.kernel.org>; Fri, 26 Jul 2019 11:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8R7UzlDQd8+Y/mz8YB8xShb8O/ZhlwR2zzOtyJHasnY=;
        b=iIgSC1jpTkh4eD9nr5L2x7bAn8szancSPCmdKvG/2hG4euU0zc8hq//XVrp+VxMnca
         puE6pY2gTlvGk60XqIWto8/oYz5SQQnr/+Kw30rcCR9n6REC7UeeOaBOWOtQ1dEStD7R
         iBOUJxDsNeoTgKjjlrMNyluq9Sp16kc5ofK7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8R7UzlDQd8+Y/mz8YB8xShb8O/ZhlwR2zzOtyJHasnY=;
        b=hVvcR7h8iRIVfe0TPyE0hUAfZHtyrCIh2TdM2WGqk81SSZBtXPPULSsW1KWixEJJJU
         XddzwFon6gkk/rskkWbb966hqt1H+KFxuqnBepOEL7ANWVDVADbK653yLLlIOcvAPmYd
         L39T8m7ZKvvAKQDDqUftcIUUwlgeutyVeDzKquguZolVHP6DfHWf/Zv8GeMqx0zbOA1Z
         PahHk4cy9jJWPCroI6CfPsPm4039EVHdCSUd2cmDAnrNgqSvzasDvqDCXgpx87wHCQDU
         6ImDzJtU0rcpmUgIdq0wETERR4ZoXUDn/sPiIXwQ4jVu1TMs9s7Gc4DHiAVpbvqCoeB6
         QjJg==
X-Gm-Message-State: APjAAAU4fuQG9v7MLQgpl2N3MmOzVJOSmQFRfHmHSEp8YxF8n+92Gnu4
        PFMFdFrX8PnrNL+U+FMgOjiKFV1EehU=
X-Google-Smtp-Source: APXvYqyaPOpinKDWHSb5CQIKb8HsL8D4+FjiavAsV/WoLPcDCEiTNF7c6lDKiqi6XxroAksBiJqToQ==
X-Received: by 2002:ac2:4891:: with SMTP id x17mr46510163lfc.60.1564166699336;
        Fri, 26 Jul 2019 11:44:59 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id k23sm5825938ljg.90.2019.07.26.11.44.58
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 11:44:58 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id d24so52402495ljg.8
        for <linux-block@vger.kernel.org>; Fri, 26 Jul 2019 11:44:58 -0700 (PDT)
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr51819152ljj.156.1564166698231;
 Fri, 26 Jul 2019 11:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <2b22063e-660c-a238-f109-fcf3f1b888b5@kernel.dk>
 <CAHk-=wjV1cykm1UYSVR1KzwV4ZF0QtU9rOTsThVJj8qSX6hKgQ@mail.gmail.com> <34bce605-51c0-b1b7-1d1d-f64f0e24b6c6@kernel.dk>
In-Reply-To: <34bce605-51c0-b1b7-1d1d-f64f0e24b6c6@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Jul 2019 11:44:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZzBkwOmYT3XC7u1tvrSk9AhCOxV+1S3ocAdLh4fA5cA@mail.gmail.com>
Message-ID: <CAHk-=wiZzBkwOmYT3XC7u1tvrSk9AhCOxV+1S3ocAdLh4fA5cA@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 5.3-rc2
To:     Jens Axboe <axboe@kernel.dk>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 26, 2019 at 11:39 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> The fix is sitting in the SCSI tree:

You clearly didn't follow the links.

That's *one* of the fixes.

Not the one that possibly should be fixed in block/blk-settings.c and
that I expected to come through your tree.

             Linus
