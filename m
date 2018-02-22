Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34844 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeBVWmL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 17:42:11 -0500
Received: by mail-pf0-f193.google.com with SMTP id y186so2002275pfb.2
        for <linux-block@vger.kernel.org>; Thu, 22 Feb 2018 14:42:10 -0800 (PST)
Date: Thu, 22 Feb 2018 14:42:08 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: v4.16-rc2: I/O hang with dm-rq + Kyber
Message-ID: <20180222224208.GA20710@vader.DHCP.thefacebook.com>
References: <1519333819.2861.17.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519333819.2861.17.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 22, 2018 at 09:10:23PM +0000, Bart Van Assche wrote:
> Hello Omar,
> 
> I/O hangs if I run the following command on top of kernel v4.16-rc2 + the
> ib_srpt patch that adds RDMA/CM support:
> 
> srp-test/run_tests -c -d -r 10 -t 02-mq -e kyber
> 
> This does not happen with the deadline scheduler nor without a scheduler.
> This test passed a few months ago. I have attached the output of the following
> command to this e-mail:
> 
> (cd /sys/kernel/debug/block && grep -r .) | grep -v /poll_stat
> 
> Can you have a look?
> 
> Thanks,
> 
> Bart.

Hey, Bart, thanks for the report. Can you clarify what the device
topology is w.r.t. the dm devices?
