Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42417 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752167AbdATO3A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2017 09:29:00 -0500
Date: Fri, 20 Jan 2017 07:28:57 -0700
From: Jens Axboe <axboe@fb.com>
To: Paolo Valente <paolo.valente@linaro.org>
CC: <linux-block@vger.kernel.org>,
        Linux-Kernal <linux-kernel@vger.kernel.org>, <osandov@fb.com>
Subject: Re: [PATCH 7/8] mq-deadline: add blk-mq adaptation of the deadline
 IO scheduler
Message-ID: <20170120142857.GC18162@kernel.dk>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <1481933536-12844-8-git-send-email-axboe@fb.com>
 <2E4B3957-783C-41D4-A1BD-C329F6BDA65D@linaro.org>
 <89FD5566-F9DE-492C-8AC1-CC2542D7CE7E@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <89FD5566-F9DE-492C-8AC1-CC2542D7CE7E@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 20 2017, Paolo Valente wrote:
> 
> > Il giorno 20 gen 2017, alle ore 14:14, Paolo Valente <paolo.valente@linaro.org> ha scritto:
> > 
> >> 
> >> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> ha scritto:
> >> 
> >> This is basically identical to deadline-iosched, except it registers
> >> as a MQ capable scheduler. This is still a single queue design.
> >> 
> > 
> > Jens,
> > no spin_lock_irq* in the code.  So, also request dispatches are
> > guaranteed to never be executed in IRQ context?
> 
> Or maybe the opposite? That is, all scheduler functions invoked in IRQ context?

Nope

-- 
Jens Axboe

