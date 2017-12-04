Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753707AbdLDK5d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Dec 2017 05:57:33 -0500
Date: Mon, 4 Dec 2017 18:57:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alban Browaeys <alban.browaeys@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Subject: Re: blk-mq + bfq:  udevd hang on usb2 storages
Message-ID: <20171204105720.GA6884@ming.t460p>
References: <1512147869.8698.21.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512147869.8698.21.camel@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Dec 01, 2017 at 06:04:29PM +0100, Alban Browaeys wrote:
> I initially reported as https://bugzilla.kernel.org/show_bug.cgi?id=198
> 023 .
> 
> I have now bisected this issue to commit a6a252e6491443c1c1 "blk-mq-
> sched: decide how to handle flush rq via RQF_FLUSH_SEQ".
> 
> This is with an USB stick Sandisk Cruzer (USB Version:  2.10) I
> regressed with.
> systemctl restart systemd-udevd restores sanity.
> 
> PS: With an USB3 Lexar (USB Version:  3.00) I get more severe an issue
> (not bisected) where I find no way out of reboot. My report to bugzilla
> has logs when I was swapping between the these keys. The logs attached
> there mixes what looks like two different behaviors.

Hi Paolo,

>From both Alban's trace and my trace, looks this issue is in BFQ,
since request can't be retrieved via e->type->ops.mq.dispatch_request()
in blk_mq_do_dispatch_sched() after it is inserted into BFQ's queue.

        https://bugzilla.kernel.org/show_bug.cgi?id=198023#c4
        https://marc.info/?l=linux-block&m=151214241518562&w=2

BTW, I have tried to reproduce the issue with scsi_debug, but not succeed,
and it can't be reproduced with other schedulers(mq-deadline, none) too.

So could you take a look?

Thanks,
Ming
