Return-Path: <SRS0=Upb7=PP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EF2C43387
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 21:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7162E2087F
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 21:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfAGVaD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:30:03 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:46645 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfAGVaD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jan 2019 16:30:03 -0500
Received: by mail-pl1-f170.google.com with SMTP id t13so738475ply.13
        for <linux-block@vger.kernel.org>; Mon, 07 Jan 2019 13:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=77lHhy7ipdnkHsNmNO8xUU7xxAiUxG3JEbN1nWi3Cvo=;
        b=CgVQyvPOCYF+siBrpS05kN8XXheHy9NF4Bnka8NfTYZFN7GIQqV8FyL+uRD2H5IbD7
         LQYI3M7ZwQafD4VQv1VS10eNvkgyRg/MdOlSoERe/cDA17hIfgXuOy80w/yzCgTt6YIr
         3lfZGj1im5YHgVIXdpDzd/vMHJiUd1aJ+AOirUs/km6GDnsXjioD4xPLhFEyAqNykCna
         vv6kU/9bswunG9zuXngOk1ilClW75WNHxd1cGRmrioZPi4q4szks279UWfmngHPe5Itu
         D1ebkM9dL2NuLCc350IFG/vonTJIq4A9BerkR0STzDw8AmJbp5M32Ih9Kb6Y978ANjdf
         9tPA==
X-Gm-Message-State: AJcUukdNxtOStkh2phcnCNniv38yy9SXHdHvXQy5gClFb3pc9fiwcOWU
        AcwkNZ4vzEqlEqPTgbGxBpo=
X-Google-Smtp-Source: ALg8bN5rSEaCD8sYCqUJbq1U/c5lSFfEYHuxcM+Bm85N9iykFg9/tvHOxu6eV5E6rpfrfugBrErI9Q==
X-Received: by 2002:a17:902:6683:: with SMTP id e3mr56048186plk.93.1546896602766;
        Mon, 07 Jan 2019 13:30:02 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id u8sm99394696pfl.16.2019.01.07.13.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 13:30:02 -0800 (PST)
Message-ID: <1546896601.83374.26.camel@acm.org>
Subject: Re: Kernel v5.0-rc1 and blk-mq
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon, 07 Jan 2019 13:30:01 -0800
In-Reply-To: <1546896114.83374.22.camel@acm.org>
References: <1546896114.83374.22.camel@acm.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-01-07 at 13:21 -0800, Bart Van Assche wrote:
+AD4 When I tried to run the SRP tests from the blktests repository against the
+AD4 v5.0 kernel several issues were reported. The same tests pass against kernel
+AD4 v4.20.

A correction: this was triggered by a new test (+ACI-Run sg+AF8-reset while I/O is ongoing+ACI).
Anyway, I don't think that such a test should trigger the following statement in
blk+AF8-mq+AF8-start+AF8-request():

	WARN+AF8-ON+AF8-ONCE(blk+AF8-mq+AF8-rq+AF8-state(rq) +ACEAPQ MQ+AF8-RQ+AF8-IDLE)+ADs

A few kernel versions back I ran sg+AF8-reset manually while I/O was ongoing and that
test passed. So this test result may indicate an issue in the blk-mq request state
rework.

Bart.
