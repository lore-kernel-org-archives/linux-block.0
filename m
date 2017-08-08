Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34783 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751967AbdHHWAt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2017 18:00:49 -0400
Received: by mail-pg0-f53.google.com with SMTP id u185so19991983pgb.1
        for <linux-block@vger.kernel.org>; Tue, 08 Aug 2017 15:00:49 -0700 (PDT)
Date: Tue, 8 Aug 2017 15:00:47 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Anton Volkov <avolkov@ispras.ru>
Cc: tom.leiming@gmail.com, axboe@fb.com, osandov@fb.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ldv-project@linuxtesting.org, khoroshilov@ispras.ru
Subject: Re: [PATCH] loop: fix to a race condition due to the early
 registration of device
Message-ID: <20170808220047.GA4072@vader.DHCP.thefacebook.com>
References: <CACVXFVN-pKP5zePBvUtKkpEkOi=1fr+ePsudxbciN993BHGzNA@mail.gmail.com>
 <1502109470-2945-1-git-send-email-avolkov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502109470-2945-1-git-send-email-avolkov@ispras.ru>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 07, 2017 at 03:37:50PM +0300, Anton Volkov wrote:
> The early device registration made possible a race leading to allocations
> of disks with wrong minors.
> 
> This patch moves the device registration further down the loop_init
> function to make the race infeasible.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Volkov <avolkov@ispras.ru>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Hi, Anton,

Were you able to reproduce this issue or was it purely theoretical? If
the former, it'd be nice if you could add a test case to blktests [1].

1: https://github.com/osandov/blktests

Thanks!
Omar
