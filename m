Return-Path: <SRS0=xgQW=U4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B04C4321A
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 16:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FF32086D
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 16:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="toYLAA3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfF2QMI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jun 2019 12:12:08 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:46222 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfF2QMI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 12:12:08 -0400
Received: by mail-io1-f49.google.com with SMTP id i10so5328173iol.13
        for <linux-block@vger.kernel.org>; Sat, 29 Jun 2019 09:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=59azEh7BXrcbkZlQa9IzXL9jo7RflCXRCdxV5RsH6eo=;
        b=toYLAA3uRCCr4OHmBH3iwLBQUtsCxxRQ4ujWl53T26TF4OjO7eKMHxTaHSW+/HqLpC
         4TyxVglVF913QWWttwJb00fCGk00TqL+Osz6dLHfgzBkMcj7FH8YnkW7/k214zbSwA2T
         3yntvBC9fp+zZDJXD3KOinxx0Yf4C/BCWGDfWYH5QLkPYo2Jttnd4mGcuu3xy319d92W
         UM2luQ1qUTrcX3fuU2ueNGBk98kmB3lxNR30+qcXbVrlGsZOgTbMgqewWBcxN4UjN5kD
         rEhdAt39xJika8pSZAsxxQndTiue9ipN/MC6lfw6yZ8hrv4XIBi0hhH57vzR4Bk6MhNU
         ZGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=59azEh7BXrcbkZlQa9IzXL9jo7RflCXRCdxV5RsH6eo=;
        b=IpEXKFJX9VnGyagWiCMALNGAmFScfb0pPPAiTL37W9q/r2pFYRxZlmeHge7Hz0wYdj
         9Sul1dpfK0zc7VgjTzdhTkspqJGp7clDZJmPFyDnegTtAlsul3IxJkX83nqKAnKdJb/Q
         QYWLWdjRPuGE7ZEx2M0aWuqxWPm8cFs5FQbrPz+pBggly4wbtNNKdA0NojCcwnQz6mZ5
         MP0KgZ8yY9RKb99J7KOSH6JUEr/qy+dc9vg/maOt+/xV1QNqT6JaYBDvr84GmiewUB6r
         OFHUG4Fn0l+etu7jBvfnaY9AP6EHX+Xn5H3bmCux3ZJK1snHuqwmSk4PP1wOZvKrPp24
         sA2Q==
X-Gm-Message-State: APjAAAU1Czi2IcUdvWwfS/ZmJUS6SmX6eLl+4YeZY1GhB4HNHvB2q4Mh
        iOf1Wh5NZQdI0jzLeDV98FcRyWzM+hnW5Q==
X-Google-Smtp-Source: APXvYqyTq9gsZw9yuZnztcHVO2rMiDbn1QfkVSrpjstVWs9PZRh2dzpCkHJGOA+hd3G1d/CI1DKSlg==
X-Received: by 2002:a6b:5103:: with SMTP id f3mr17328919iob.142.1561824727855;
        Sat, 29 Jun 2019 09:12:07 -0700 (PDT)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o5sm4743484iob.7.2019.06.29.09.12.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 09:12:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     davem@davemloft.net
Subject: [PATCHSET 0/2] io_uring: add sendmsg/recvmsg support
Date:   Sat, 29 Jun 2019 10:12:02 -0600
Message-Id: <20190629161204.27226-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds basic support for sendmsg(2) and recvmsg(2) through io_uring.
Similarly to how we handle file IO, we first attempt a non-blocking
call, and if that fails with -EAGAIN/-ENONBLOCK, we punt to an async
worker.

Pretty straightforward, and a test case can be found in the liburing
repository.

-- 
Jens Axboe


