Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34527 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbdH0JsT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Aug 2017 05:48:19 -0400
Received: by mail-qk0-f178.google.com with SMTP id a77so15201380qkb.1
        for <linux-block@vger.kernel.org>; Sun, 27 Aug 2017 02:48:19 -0700 (PDT)
MIME-Version: 1.0
From: Suraj Choudhari <surajschoudhari@gmail.com>
Date: Sun, 27 Aug 2017 15:18:18 +0530
Message-ID: <CAGvB2rNGKR=+8bEeAr=o9SJ2x+K939yfCtDbaVuaw+8Tmq=2pg@mail.gmail.com>
Subject: Help - blk_get_request hangs in schedule even if no memory pressure
To: linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On my test system, blk_get_request() continuously hangs in schedule().

schedule+0x35/0x80
schedule_timeout+0x237/0x2d0
io_schedule_timeout+0xa6/0x110
get_request+0x258/0x760
blk_get_request+0x7f/0x100

I suspect the problem might be due to __get_request returning ENOMEM,
leading to sleep in schedule().

static struct request *__get_request(struct request_list *rl, unsigned
int op, struct bio *bio, gfp_t gfp_mask)   {
...
/*
* The queue is full and the allocating
* process is not a "batcher", and not
* exempted by the IO scheduler
*/
return ERR_PTR(-ENOMEM);
...

if (rl->count[is_sync] >= (3 * q->nr_requests / 2))
return ERR_PTR(-ENOMEM);
...

}

However, there is no significant memory pressure or IO load on my test
system, I wonder why the __get_request might be failing leading to
sleep.

Any possible cause?   Any suggestions are welcome!


Thanks & Regards,
Suraj
