Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f44.google.com ([209.85.160.44]:42325 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeABQXS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jan 2018 11:23:18 -0500
Received: by mail-pl0-f44.google.com with SMTP id bd8so28908816plb.9
        for <linux-block@vger.kernel.org>; Tue, 02 Jan 2018 08:23:18 -0800 (PST)
Subject: Re: [for-416 PATCH 3/3] bcache: allow quick writeback when backing
 idle
To: tang.junhui@zte.com.cn
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1514883236-11844-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <0fdcfaaf-af7a-adb8-075d-b321b9df4ef7@lyle.org>
Date: Tue, 2 Jan 2018 08:23:14 -0800
MIME-Version: 1.0
In-Reply-To: <1514883236-11844-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/02/2018 12:53 AM, tang.junhui@zte.com.cn wrote:
> If no front-end I/O coming, would this cause write-back IOs one by one
> (one write-back IO issued must after the completion of the previous IO)?
> though with zero delay time, is the write-back performance still good?

Yes-- this speeds up writeback during idle from 4k/sec to about 10MB/sec
on my slow 5400RPM disk.  (It writes back at about 20MB/sec with deep
queues in the same scenario).  So in this case it's about 2500x faster
than current idle writeback, but half as fast as writeback with full
device utilization.

With only one I/O outstanding at a time, if front-end I/O starts latency
for the first request is still good.

> Thanks,
> Tang Junhui

Mike
