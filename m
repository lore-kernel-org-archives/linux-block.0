Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751143AbdLARaO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Dec 2017 12:30:14 -0500
Date: Sat, 2 Dec 2017 01:29:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alban Browaeys <alban.browaeys@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Subject: Re: blk-mq + bfq:  udevd hang on usb2 storages
Message-ID: <20171201172958.GA22528@ming.t460p>
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

>From my investigation, looks the issue is in BFQ:

	https://marc.info/?l=linux-block&m=151214241518562&w=2

Could you apply the attached debug patch, run your test and provide us the log?

Thanks,
Ming
