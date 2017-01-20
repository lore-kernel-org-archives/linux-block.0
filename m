Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33674 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752124AbdATO2c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2017 09:28:32 -0500
Date: Fri, 20 Jan 2017 07:28:26 -0700
From: Jens Axboe <axboe@fb.com>
To: Paolo Valente <paolo.valente@linaro.org>
CC: <linux-block@vger.kernel.org>,
        Linux-Kernal <linux-kernel@vger.kernel.org>, <osandov@fb.com>
Subject: Re: [PATCH 7/8] mq-deadline: add blk-mq adaptation of the deadline
 IO scheduler
Message-ID: <20170120142826.GB18162@kernel.dk>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <1481933536-12844-8-git-send-email-axboe@fb.com>
 <2E4B3957-783C-41D4-A1BD-C329F6BDA65D@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <2E4B3957-783C-41D4-A1BD-C329F6BDA65D@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 20 2017, Paolo Valente wrote:
> 
> > Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> ha scritto:
> > 
> > This is basically identical to deadline-iosched, except it registers
> > as a MQ capable scheduler. This is still a single queue design.
> > 
> 
> Jens,
> no spin_lock_irq* in the code.  So, also request dispatches are
> guaranteed to never be executed in IRQ context?  I'm asking this
> question to understand whether I'm missing something that, even in
> BFQ, would somehow allow me to not disable irqs in critical sections,
> even if there is the slice_idle-expiration handler.  Be patient with
> my ignorance.

Yes, dispatches will never happen from IRQ context. blk-mq was designed
so we didn't have to use irq disabling locks.

That said, certain parts of the API can be called from IRQ context.
put_request and the completion parts, for instance. But blk-mq doesn't
need to grab any locks there, and neither does mq-deadline. This might
be different from bfq. lockdep can be a big help there.

-- 
Jens Axboe

