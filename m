Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C8FC742A1
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 19:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063D720872
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 19:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="S/ROkNGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfGKTVQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 15:21:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45823 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfGKTVQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 15:21:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so3185488pfq.12
        for <linux-block@vger.kernel.org>; Thu, 11 Jul 2019 12:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jjJDt4c8s8Wx2l2CMYbWjw8ETw/oZJkwEnPdvyXBhBA=;
        b=S/ROkNGcw6RU0xVpHVxjlkaYtcvxu00mYXYtPHmU5X1TzLXi2jJTYFTJD+hBWS26PV
         miVcA2MUmCswJ7IEeRdlIEXelK5Rzrzw3T9p7LqgdZCu+H4K+YN9EoPPvfsFS2pOcCth
         g6Jns1oN/ZJNBcT+xwu8IlEjzrBOIuTzoNQsJcma/iF1NGSBoWSjRv3jqzz/FaRHjOdf
         EXS2lFP3WwYgEWk24zPV1JSnlHMUb6lh5z5e+LhPm7Fra0gGfYxBdN6UOxg/+RIDl+aT
         lK113qS90eTgWw8C2C3TSdSa+NLmsPrlVJwsLlVUvUgPSuQTKrFg+WXB8kKqjV/iSFo9
         LZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jjJDt4c8s8Wx2l2CMYbWjw8ETw/oZJkwEnPdvyXBhBA=;
        b=lK/Jr6ssoEDodEvdjxlxK8oqtcGq++NhSslLTzujIBCcDk1wlVGfoQgLzpL7OvV1hn
         DbbqV64DuaX/R0d7IMwFPmTFSnDF8wFLknGdBhlu5QKR0ow+cKDA83xAwvNI4uj7zoDx
         Q/8z7WETWdmhrJ/ZL5fRgi9rSqzt7NXjXOGyt83/iUlvev710T05jG5p6l637wAVUdJR
         0YhE/UjjsMvVN3QEXNexqndwaczjugwDmin3Lw8NqNvOyXKARDp8nj3U80zzgOD+q4qh
         Kvh2P0Yv1pKCdpyj76cyz26figJspL0S7HoiHhBMC2GD9D1rjs/zglbuiG+No8SwW0Tp
         tozA==
X-Gm-Message-State: APjAAAUXwO1F9zVH1yAMt5owTICqiRyda0hRJ1iTz3mRwGmNLvZDwYQ4
        xLNg6oFZhm1ma+Sx9+c+24I=
X-Google-Smtp-Source: APXvYqyFJcGrr5lL27uWfzNAbH2ndZyTElHLrWTm7X8eMfFGSy2oiq1PRf6djx5Obu9RvUjfQnZxIw==
X-Received: by 2002:a63:778a:: with SMTP id s132mr3684120pgc.242.1562872875179;
        Thu, 11 Jul 2019 12:21:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::c242])
        by smtp.gmail.com with ESMTPSA id g2sm11208840pfq.88.2019.07.11.12.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 12:21:14 -0700 (PDT)
Date:   Thu, 11 Jul 2019 15:21:12 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jens Axboe <axboe@fb.com>, Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/2] wait: add wq_has_multiple_sleepers helper
Message-ID: <20190711192110.aqpin7pr6jwmydsr@macbook-pro-91.dhcp.thefacebook.com>
References: <20190710195227.92322-1-josef@toxicpanda.com>
 <bbe73e4e-9270-46ac-16d7-39a40485fe53@kernel.dk>
 <20190710203516.GL3419@hirez.programming.kicks-ass.net>
 <752dbdc9-945d-e70c-e6f3-0c48932c7f60@fb.com>
 <20190711114543.GA14901@redhat.com>
 <20190711134006.GA19160@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711134006.GA19160@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 11, 2019 at 03:40:06PM +0200, Oleg Nesterov wrote:
> On 07/11, Oleg Nesterov wrote:
> >
> > Jens,
> >
> > I managed to convince myself I understand why 2/2 needs this change...
> > But rq_qos_wait() still looks suspicious to me. Why can't the main loop
> > "break" right after io_schedule()? rq_qos_wake_function() either sets
> > data->got_token = true or it doesn't wakeup the waiter sleeping in
> > io_schedule()
> >
> > This means that data.got_token = F at the 2nd iteration is only possible
> > after a spurious wakeup, right? But in this case we need to set state =
> > TASK_UNINTERRUPTIBLE again to avoid busy-wait looping ?
> 
> Oh. I can be easily wrong, I never read this code before, but it seems to
> me there is another unrelated race.
> 
> rq_qos_wait() can't rely on finish_wait() because it doesn't necessarily
> take wq_head->lock.
> 
> rq_qos_wait() inside the main loop does
> 
> 		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
> 			finish_wait(&rqw->wait, &data.wq);
> 
> 			/*
> 			 * We raced with wbt_wake_function() getting a token,
> 			 * which means we now have two. Put our local token
> 			 * and wake anyone else potentially waiting for one.
> 			 */
> 			if (data.got_token)
> 				cleanup_cb(rqw, private_data);
> 			break;
> 		}
> 
> finish_wait() + "if (data.got_token)" can race with rq_qos_wake_function()
> which does
> 
> 	data->got_token = true;
> 	list_del_init(&curr->entry);
> 

Argh finish_wait() does __set_current_state, well that's shitty.  I guess we
need to do

data->got_token = true;
smp_wmb()
list_del_init(&curr->entry);

and then do

smp_rmb();
if (data.got_token)
	cleanup_cb(rqw, private_data);

to be safe?

> rq_qos_wait() can see these changes out-of-order: finish_wait() can see
> list_empty_careful() == T and avoid wq_head->lock, and in this case the
> code above can see data->got_token = false.
> 
> No?
> 
> and I don't really understand
> 
> 	has_sleeper = false;
> 
> at the end of the main loop. I think it should do "has_sleeper = true",
> we need to execute the code above only once, right after prepare_to_wait().
> But this is harmless.

We want has_sleeper = false because the second time around we just want to grab
the inflight counter.  Yes we should have been worken up by our special thing
and so should already have data.got_token, but that sort of thinking ends in
hung boxes and me having to try to mitigate thousands of boxes suddenly hitting
a case we didn't think was possible.  Thanks,

Josef
