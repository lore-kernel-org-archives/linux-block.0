Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751492AbeBWQ0n (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Feb 2018 11:26:43 -0500
Date: Sat, 24 Feb 2018 00:26:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "osandov@osandov.com" <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: v4.16-rc2: I/O hang with dm-rq + Kyber
Message-ID: <20180223162626.GB17466@ming.t460p>
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

The following 2 patch fixes one IO hang on kyber in my test on USB, could
you test it and see if your case can be fixed?

	https://marc.info/?l=linux-block&m=151940022831994&w=2

BTW, from your attached log, looks it belongs to domain token leak
issue too, so it should have been addressed by above patches.

Thanks,
Ming
