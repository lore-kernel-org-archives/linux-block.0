Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511B1C76190
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 00:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204E5218BE
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 00:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRTJ23aR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfGWAGo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 20:06:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44731 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387583AbfGWAGo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 20:06:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so18125664pfe.11;
        Mon, 22 Jul 2019 17:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CAM7uWXTgqvExmfTj46KhucWcASslfvV8JC6Lo6xtzY=;
        b=qRTJ23aR/SCA1VPrJ0TzI/rY+RdB98A3ntKMIuu7/0vUaU9Vy6TBSPa2YllZdIrqRd
         eFHlbrfk5CeTr3al7rtyUSUf3yaic8kWCffinkg6aTvwNHbXeiN+QnH5T4lP01PSeO99
         a8pXx0MsGqHf0z/DQmcRigFhSxYrbXdXPxsHzKefe/KPsK0zoyR/toLJdpEvoIsI73Ac
         To6rGI5Se9yGOnGQcBDk7Z1lfOJ3JI6W1qYxyfOhSg5TCoYU9G1bar8wMdS1UELPOhHz
         2Ud1e3j3AI5R1c9qiXPOBlcuJwmpTtwO5ROILeh1+mTqjlMwKaLWLQbeeFijSZ5oV8OP
         4+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CAM7uWXTgqvExmfTj46KhucWcASslfvV8JC6Lo6xtzY=;
        b=jsMqukzZokICa+LdeaiR2OJVw7BeeCo2eqHGX+Dm+yz728Ow6E1tWGCFmxY1s5VkP1
         m5eEZACo2H7F7mQOb4Ku4pHOKJvQLQH9G0iEPLO2BGzslYcCepCjEg5YS45A3d+Bw+Kc
         gHZhE57ZY9SnsC1jsQ7zOK/gBeVjVxexofN+ytuCBKKZcy+Y0C9l2NJe/Oik4hsHoXYi
         88wrKgIgLbLVXUE0Qsws5FOeiYlvAjXUNpoqedooLHzG1p1o8wTiZki6SIdN6pPH9gPW
         80n6tYVf93KxwLJVsBOfUj/bY6MACd6UOK1b5ex7ylDLPRcM6Y0r/lIXJKnOvQvD4BkB
         4JRA==
X-Gm-Message-State: APjAAAWhYDk6h1MCieR/0m7File+XCHbJSLVwOSbwsqzBqrJj9pQ1tVK
        i/ioebzuMOscL1rh5ZL3lsI=
X-Google-Smtp-Source: APXvYqxiITXwceT1jPw0jMHyKhtqCaI/eqzLVmR51BxWupz0Mb32hYpeHKhiFU+ITjIdRBbymtxyAA==
X-Received: by 2002:a63:505a:: with SMTP id q26mr71883076pgl.18.1563840403653;
        Mon, 22 Jul 2019 17:06:43 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 131sm50254501pfx.57.2019.07.22.17.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 17:06:42 -0700 (PDT)
Date:   Mon, 22 Jul 2019 17:06:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bob Liu <bob.liu@oracle.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] bfq: Check if bfqq is NULL in bfq_insert_request
Message-ID: <20190723000641.GA31309@roeck-us.net>
References: <1563816648-12057-1-git-send-email-linux@roeck-us.net>
 <20190722202920.GA18431@roeck-us.net>
 <f3f2764a-90b4-e294-d364-a25156933a71@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3f2764a-90b4-e294-d364-a25156933a71@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 23, 2019 at 07:36:16AM +0800, Bob Liu wrote:
> On 7/23/19 4:29 AM, Guenter Roeck wrote:
> > On Mon, Jul 22, 2019 at 10:30:48AM -0700, Guenter Roeck wrote:
> >> In bfq_insert_request(), bfqq is initialized with:
> >> 	bfqq = bfq_init_rq(rq);
> >> In bfq_init_rq(), we find:
> >> 	if (unlikely(!rq->elv.icq))
> >> 		return NULL;
> >> Indeed, rq->elv.icq can be NULL if the memory allocation in
> >> create_task_io_context() failed.
> >>
> > 
> > The above function should have been ioc_create_icq(), sorry.
> > 
> > Guenter
> > 
> >> A comment in bfq_insert_request() suggests that bfqq is supposed to be
> >> non-NULL if 'at_head || blk_rq_is_passthrough(rq)' is false. Yet, as
> >> debugging and practical experience shows, this is not the case in the
> >> above situation.
> >>
> >> This results in the following crash.
> >>
> >> Unable to handle kernel NULL pointer dereference
> >> 	at virtual address 00000000000001b0
> >> ...
> >> Call trace:
> >>  bfq_setup_cooperator+0x44/0x134
> >>  bfq_insert_requests+0x10c/0x630
> >>  blk_mq_sched_insert_requests+0x60/0xb4
> >>  blk_mq_flush_plug_list+0x290/0x2d4
> >>  blk_flush_plug_list+0xe0/0x230
> >>  blk_finish_plug+0x30/0x40
> >>  generic_writepages+0x60/0x94
> >>  blkdev_writepages+0x24/0x30
> >>  do_writepages+0x74/0xac
> >>  __filemap_fdatawrite_range+0x94/0xc8
> >>  file_write_and_wait_range+0x44/0xa0
> >>  blkdev_fsync+0x38/0x68
> >>  vfs_fsync_range+0x68/0x80
> >>  do_fsync+0x44/0x80
> >>
> >> The problem is relatively easy to reproduce by running an image with
> >> failslab enabled, such as with:
> >>
> >> cd /sys/kernel/debug/failslab
> >> echo 10 > probability
> >> echo 300 > times
> >>
> >> Avoid the problem by checking if bfqq is NULL before using it. With the
> >> NULL check in place, requests with missing io context are queued
> >> immediately, and the crash is no longer seen.
> >>
> 
> 
> What about other place use blk_init_rq()?
> E.g in bfq_request_merged():
> 1897                 struct bfq_queue *bfqq = bfq_init_rq(req);
> 1898                 struct bfq_data *bfqd = bfqq->bfqd;
> 
> Which may have same Null-pointer bug?
> 
Good question. Doug asked it as well. My understanding is that the code
won't hit those places since bfq is essentially bypassed. Of course,
I may be completely wrong, so we should wait for Paolo to confirm
if I my understanding is correct (or wrong).

Thanks,
Guenter

> -Bob
> 
> >> Fixes: 18e5a57d79878 ("block, bfq: postpone rq preparation to insert or merge")
> >> Reported-by: Hsin-Yi Wang  <hsinyi@google.com>
> >> Cc: Hsin-Yi Wang <hsinyi@google.com>
> >> Cc: Nicolas Boichat <drinkcat@chromium.org>
> >> Cc: Doug Anderson <dianders@chromium.org>
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> ---
> >>  block/bfq-iosched.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> >> index 72860325245a..56f3f4227010 100644
> >> --- a/block/bfq-iosched.c
> >> +++ b/block/bfq-iosched.c
> >> @@ -5417,7 +5417,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
> >>  
> >>  	spin_lock_irq(&bfqd->lock);
> >>  	bfqq = bfq_init_rq(rq);
> >> -	if (at_head || blk_rq_is_passthrough(rq)) {
> >> +	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
> >>  		if (at_head)
> >>  			list_add(&rq->queuelist, &bfqd->dispatch);
> >>  		else
> >> -- 
> >> 2.7.4
> >>
> 
