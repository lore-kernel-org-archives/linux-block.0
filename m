Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44609 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbeHQUg2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Aug 2018 16:36:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id g6-v6so6416637lfb.11
        for <linux-block@vger.kernel.org>; Fri, 17 Aug 2018 10:32:13 -0700 (PDT)
MIME-Version: 1.0
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Fri, 17 Aug 2018 19:31:56 +0200
Message-ID: <CAPybu_2k-0d=8NxL7kr757QcWOnXyU_TAyV7DMwiMrSDkiXfgA@mail.gmail.com>
Subject: blk-mq 5-8 times slower for bmap-tools
To: linux-block@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello

Coming from: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=906328

bmaptools is kind of a "smart dd" tool, that lets you write images
very fast and securely. Since the last Debian Kernel update it has
become 5-8 times slower.

After some debugging, we have figured out that the reason for that
slowness is the Multi-Queue Block IO Queueing Mechanism.

Debian maintainer has pointed out that in the near future the single
queue will be deprecated.

My question is if we can get a similar perfomance for bmaptools with
blk-mq and how?

Thanks!

-- 
Ricardo Ribalda
