Return-Path: <SRS0=PKU6=PK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC64C43387
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 18:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2364218D3
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 18:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fTNNXjfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfABSIF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:08:05 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39802 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfABSIE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jan 2019 13:08:04 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so21532214lfh.6
        for <linux-block@vger.kernel.org>; Wed, 02 Jan 2019 10:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2rkWzYmHqIRZvpCQHP6mHU3okpvhSh7FsEKo3ekFGr8=;
        b=fTNNXjfGuQ1+MKjvWsBPE5N9jmauMN4O0mUmKgbC5Rvm/yQhAt+URg+GKsNkF2lFku
         mJph/ey8kkLtihBt0wG+jQIH8qhz/S9Hx1GstzMHKEk4OsyLYxzpVThOT7tysqjQ7xJE
         cfpzFAGTm8+fVGfq5aNX/B/n+YVtVwFze8UEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2rkWzYmHqIRZvpCQHP6mHU3okpvhSh7FsEKo3ekFGr8=;
        b=s3CsqSQUBErmrAVsytGqHpbzp6L/9C8X6FTbz12YQQGNDKmAR0cmTX2HVGlAf+JKJf
         GdY9Dkx/FErZMZAcVFdZqpQ6cWLOkIa7NWfCYxpZ9LzbXcHPAiOKS3V/l2g+JbovMQ3+
         Lcx6MQaMIM0vrLs8oWIJFR3qEP/eNQCnuhnJ4x6jTbbiaCP/tI9hKyJpTXR6c6cH4gfa
         JMMiXDDsJMnbZ38IyOZAsCBygGxnhVgYTVf1d7sGD89nA+KMmOABiHPrX4Y2h0NnGAVV
         Y+VLd1XUb4t4Ua3dyuTTlvjOwyI4KvxmG03sEfBX5NZ1g8XvwtHp0qRX9VermVsD9cR+
         qX6A==
X-Gm-Message-State: AA+aEWZ8xC4Ncs3ECttuoTaerznv2EX1fJsgpMJ6q5FnOcIfnvtpxlEq
        cSM7fXsbH87FPLFFV0J/ULLk5nU6O3w=
X-Google-Smtp-Source: AFSGD/Vj60BOPbU0tHYvIPSqhgl3/tKUzjgGEiuJhldu8K+lObIcdrR5wL4xQSBIeL2xEfcm0ICT0w==
X-Received: by 2002:a19:f89:: with SMTP id 9mr21431898lfp.10.1546452482216;
        Wed, 02 Jan 2019 10:08:02 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id l21-v6sm11436541ljj.48.2019.01.02.10.08.01
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 10:08:01 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id c16so21536461lfj.8
        for <linux-block@vger.kernel.org>; Wed, 02 Jan 2019 10:08:01 -0800 (PST)
X-Received: by 2002:a19:982:: with SMTP id 124mr21166558lfj.138.1546452480835;
 Wed, 02 Jan 2019 10:08:00 -0800 (PST)
MIME-Version: 1.0
References: <181e0aa7-34a5-5445-70b2-45770a81659d@kernel.dk>
In-Reply-To: <181e0aa7-34a5-5445-70b2-45770a81659d@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Jan 2019 10:07:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wicNcMhY_YCkT5Nsdcxake8x+sfYUByvbhTzp2v-LWjeA@mail.gmail.com>
Message-ID: <CAHk-=wicNcMhY_YCkT5Nsdcxake8x+sfYUByvbhTzp2v-LWjeA@mail.gmail.com>
Subject: Re: block: only use __set_current_state() for polled IO
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 2, 2019 at 9:55 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> A previous commit deemed it safe to use __set_current_state() for IRQ
> driven O_DIRECT, but that's isn't necessarily the case. Be safer and
> only apply that optimization to polled IO, where we know the the task is
> going to find the completions itself.

No.

We're just reverting 849a370016a5.

There is absolutely no point in trying to avoid a memory barrier that
is maybe 15 CPU cycles.

Stop this craziness. The optimization is garbage. If you want to save
15 cycles, get rid of code, don't add new code in an area where the
block maintainers have already shown that they can't get it right.

               Linus
