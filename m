Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082D4C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 22:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E6E218AF
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 22:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfBAWwo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:52:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44137 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfBAWwo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 17:52:44 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so3593023pgr.11;
        Fri, 01 Feb 2019 14:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alD8oqLoxVBwNZ5wp3BoDMTenYcuEA2UbtNdEFZhtrQ=;
        b=OBQPnqNg6Ln6KmmWFIlkw1Kx8l3Cff4JfC6P4ea3uFFPrVLU9ta2neQioV7h6BDcmA
         gcF46Xw1XmWlmAT5aCXmZ54KHjFB9EOX7zBOifZluYNbzbLuNrM0kz7Sarh1AMGjkVY9
         bmwAeHZt0Wbjsm87oaY05OgQvln2o4/JJM/Mb9K7IAxjw412/huSHFsWCygo1pcjUeYC
         nnXlAJ7+KuYObhgBMwH/ssZYor0CG5H6xwkfwjRGgDQSliJIs/r6+c7jXsCsJlRkuLtD
         IlvOCuMRgiZ8/D9sM81gW9S51jejfmCSYy5JPon0rQgJl4S23nvPD3txamZT6U7kvjpz
         +SOw==
X-Gm-Message-State: AHQUAuYeK36450JYfIWcNteoouofGyKvuXrlSMMXfgNNjdLFxogZn8Xe
        xIY5Vz7l1mudHM7GlZew0UzJ6H3R
X-Google-Smtp-Source: AHgI3IbsWZ1+4N3r2w5vRAepv7b9L8/dEuGlUwMIRV/GhxGxTe6BPc6SqnPsIrl+rXVTVD0uwBPOpw==
X-Received: by 2002:a65:6242:: with SMTP id q2mr4171187pgv.245.1549061563278;
        Fri, 01 Feb 2019 14:52:43 -0800 (PST)
Received: from ?IPv6:2620:0:1008:1:f2c3:4898:1184:cd77? ([2620:0:1008:1:f2c3:4898:1184:cd77])
        by smtp.gmail.com with ESMTPSA id g70sm17008237pfg.98.2019.02.01.14.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 14:52:42 -0800 (PST)
Message-ID: <1549061551.164323.17.camel@acm.org>
Subject: Re: [PATCHSET v11] io_uring IO interface
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com
Date:   Fri, 01 Feb 2019 14:52:31 -0800
In-Reply-To: <20190201152414.23296-1-axboe@kernel.dk>
References: <20190201152414.23296-1-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-02-01 at 08:23 -0700, Jens Axboe wrote:
+AD4 Here's v11 of the io+AF8-uring project. Main fixes in this release is a
+AD4 rework of how we grab the ctx-+AD4-uring+AF8-lock, never using trylock for it in
+AD4 a user visible way. Outside of that, fixes around locking for the polled
+AD4 list when we hit -EAGAIN conditions on IO submit. This fixes list
+AD4 corruption issues with polling that some users have reported.
+AD4 
+AD4 As far as I'm concerned, this project is ready to get staged for 5.1.
+AD4 Please do review carefully so we can fix any minor nits that might still
+AD4 exist.
+AD4 
+AD4 The liburing git repo has a full set of man pages for this, though they
+AD4 could probably still use a bit of polish. I'd also like to see a
+AD4 io+AF8-uring(7) man page to describe the overall design of the project,
+AD4 expect that in the not-so-distant future. You can clone that here:
+AD4 
+AD4 git://git.kernel.dk/liburing
+AD4 
+AD4 Patches are against 5.0-rc4, and can also be found in my io+AF8-uring branch
+AD4 here:
+AD4 
+AD4 git://git.kernel.dk/linux-block io+AF8-uring
+AD4 
+AD4 Changes since v10:
+AD4 - Rework uring+AF8-lock locking
+AD4 - Ensure that async contexts lock when fiddling with polled lists
+AD4 - Minor tweak to io+AF8-iopoll+AF8-check() continue looping condition
+AD4 - Fold +AF8AXw-io+AF8-uring+AF8-enter() into io+AF8-uring+AF8-enter()

Hi Jens,

Which goal(s) do you want to realize with this new API? Is the goal perhaps
to reduce the overhead of submitting I/O and receiving I/O completions?
If so, where can I find a comparison of the performance of this API with
libaio and synchronous I/O?

Thanks,

Bart.
