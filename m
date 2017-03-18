Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36643 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdCRBEz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2017 21:04:55 -0400
Received: by mail-pf0-f182.google.com with SMTP id o126so44152020pfb.3
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2017 18:03:15 -0700 (PDT)
Date: Fri, 17 Mar 2017 17:55:45 -0700
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: Re: [RFC PATCH 0/4] blk-mq: multiqueue I/O scheduler
Message-ID: <20170318005545.GA16466@mew>
References: <cover.1489787289.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1489787289.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Mar 17, 2017 at 03:03:29PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> With Kyber set to a target latency of 1 ms, the reader sees latencies of 8 ms
> on average. Kyber brings this down to just over 1 ms.

Of course, this is supposed to say, without Kyber, the reader sees
latencies of 8 ms. With Kyber set to a target latency of 1 ms, the
actual average latency is just over 1 ms.
