Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A17C4CECE
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 00:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87DF21855
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 00:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568765916;
	bh=EdfxfBL+kZBfgWkSsjy/yFLC2Wi6c8NaPQpXsOIKt9w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=M0lf0x7yju8pmPSweVsf5OtAnKeQHeZZNk3LmHYBWUtcOI3ctzJlJo9zkJqTCKwu7
	 fVRT9ER6wx59rACnptX8h7Uf9aPECzB5nyPlyaSrI0qhUlt6oDR9PAKUp+gAUd8wqh
	 S5QttqF/UGR3qBPRhYYsEmTwSY4frD+lO1b+Ynas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfIRASg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 20:18:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41781 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbfIRASf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 20:18:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id r2so4250188lfn.8
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 17:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A+42Yi1Km6Nb0ZjJ9T/rLLTYPx+bJkhXj7oFjQEE+1E=;
        b=SgC71Qm9BxM9eJ7jRTJcd8L1MZT6/qgew/3PmOS8QjLRrulKb8SWD7zUa+qidHqHul
         CTHGG79RzCn74XHhmv3IlGXZTdKjE8S6dNnDFofF0gtEk0MzQqcvO5VSoT2H0ngpGvzW
         hsMDT6dZS7AKIeUtGzXRya8sOduG4gldnLqbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+42Yi1Km6Nb0ZjJ9T/rLLTYPx+bJkhXj7oFjQEE+1E=;
        b=PDW7VZZgB51O6sHfIteFxcYlFICNcv2VEgpHVrvup6Qya0pKCP7GQOmuaZmel+PsHd
         ZK5rf5MENeKi2kLMdSA9TCjR3JD6TaoJIbNrX/1jd/n3biB6Su2s9Joii0tZt7tP46JX
         1m2A0lstuyCw8GF8n3naxDGlTuyBb/xsIoadM92Re/oHBE75KDRMC63AtXh88XuyHXXP
         nViIVxuncEyMyaRi2osMkMyLj6JirCCXIYqOgoCy/BnMB7hku3vZx9MgI6yRHhVMqikm
         pQNt5uD/7IWIvwRcJcP6P7iM/WInsJPLwOS/8mdKwXv9SSOPyOkBKm4rYhNNAp1YyPfM
         qTjg==
X-Gm-Message-State: APjAAAUveM3BXULs560rlvGBrh9M5eSNPxnifP1RlxB0gV4e+z5zs+0U
        aqX7zRadpIcOoYVBvkPJO3v9v1rp1FU=
X-Google-Smtp-Source: APXvYqwKqWmRAJpA/vNdBTSMJhpc8aWGZO/eFqjKTetCdyvZmgo8sv3jrG3vMrvcRfvP85sR1R4twA==
X-Received: by 2002:a19:810:: with SMTP id 16mr482510lfi.110.1568765913292;
        Tue, 17 Sep 2019 17:18:33 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id z30sm811776lfj.63.2019.09.17.17.18.32
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 17:18:32 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id d17so4265223lfa.7
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 17:18:32 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr487659lfn.52.1568765911962;
 Tue, 17 Sep 2019 17:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <61b11672-f41b-9708-2486-f284a99483a8@kernel.dk>
In-Reply-To: <61b11672-f41b-9708-2486-f284a99483a8@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Sep 2019 17:18:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhKxxJ8yM1StiPcb8866PzxLBB77_d+MEA3SKY4hhjjg@mail.gmail.com>
Message-ID: <CAHk-=whhKxxJ8yM1StiPcb8866PzxLBB77_d+MEA3SKY4hhjjg@mail.gmail.com>
Subject: Re: [GIT PULL] Block changes for 5.4
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 16, 2019 at 7:52 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> - blk-cgroup writeback fixes (Tejun)

Well, that's a very short description of a pretty subtle series.

Honestly, I would much rather have seen this as three completely
separate pull requests:

 - the writeback and cgroup stuff

 - the core queuing changes

 - the nvme driver updates

 - the other driver updates

because right now this pull request is just a mess of completely
unrelated stuff that just shares a very weak common thread of "yeah,
it's related to block devices".

I've pulled this, but can you please just split driver stuff out from
core queue handling code that is largely independent of any particular
driver, and very much out from core VM writeback?

They really have almost nothing to do with each other, and I don't see
why you are randomly mixing these things up.

It makes it much harder to review the end result, and I think one
example of the weakness of this is the almost useless merge message
that didn't really talk much about these "fixes" (which is already not
really a proper description - those patches are really more like a
completely new way of doing certain cases of writeback, and much more
fundamental than just "some random fix that gets a single liner in
between other stuff").

                Linus
