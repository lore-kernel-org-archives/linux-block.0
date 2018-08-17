Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbeHQR2D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Aug 2018 13:28:03 -0400
Date: Fri, 17 Aug 2018 10:24:28 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Omar Sandoval <osandov@fb.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH blktests 3/3] Add NVMeOF dm-mpath tests
Message-ID: <20180817142428.GA3413@redhat.com>
References: <20180815203728.19521-1-bart.vanassche@wdc.com>
 <20180815203728.19521-4-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180815203728.19521-4-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 15 2018 at  4:37pm -0400,
Bart Van Assche <bart.vanassche@wdc.com> wrote:

> Add a series of tests for the NVMeOF drivers on top of the dm-mpath
> driver. These tests are similar to the tests under tests/srp. Both
> tests use the dm-mpath driver for multipath and the loopback
> functionality of the rdma_rxe driver. The only difference is that the
> nvmeof-mp tests use the NVMeOF initiator and target drivers instead
> of the SRP initiator and target drivers.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

I like the prospect of keeping NVMe honest by testing it with DM
multipath.

But will you grow dependent on ANA in the future?  If so then you're out
of luck given the way the NVMe driver's ANA support was maliciously
added without care for making it work without the NVMe driver's native
multipath support.

Seems very few people care about making NVMe multipath _not_ so tightly
coupled to native NVMe multipath.  And sadly I don't have time to work
on untangling the "all-in" nature of NVMe ANA and native NVMe
multipath.

Put differently: until Jens stops taking hch's pull requests despite
concerns being raised against hch's approach (that hch completely
ignores because he rules with an iron fist from the top of a mountain in
the Alps) we're pretty much screwed.

Mike
