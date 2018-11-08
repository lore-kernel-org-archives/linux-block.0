Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44303 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeKIDLy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Nov 2018 22:11:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id w3-v6so9135924pgs.11
        for <linux-block@vger.kernel.org>; Thu, 08 Nov 2018 09:35:22 -0800 (PST)
Message-ID: <1541698519.196084.225.camel@acm.org>
Subject: Re: [PATCH 1/2] blk-mq-tag: change busy_iter_fn to return whether
 to continue or not
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Date: Thu, 08 Nov 2018 09:35:19 -0800
In-Reply-To: <8a340d9c-da15-90c9-760e-fb80fb2871b6@kernel.dk>
References: <20181108160609.27568-1-axboe@kernel.dk>
         <20181108160609.27568-3-axboe@kernel.dk>
         <1541694515.196084.218.camel@acm.org>
         <8a340d9c-da15-90c9-760e-fb80fb2871b6@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2018-11-08 at 09:31 -0700, Jens Axboe wrote:
+AD4 On 11/8/18 9:28 AM, Bart Van Assche wrote:
+AD4 +AD4 On Thu, 2018-11-08 at 09:06 -0700, Jens Axboe wrote:
+AD4 +AD4 +AD4 --- a/block/blk-mq-debugfs.c
+AD4 +AD4 +AD4 +-+-+- b/block/blk-mq-debugfs.c
+AD4 +AD4 +AD4 +AEAAQA -424,13 +-424,15 +AEAAQA struct show+AF8-busy+AF8-params +AHs
+AD4 +AD4 +AD4   +ACo Note: the state of a request may change while this function is in progress,
+AD4 +AD4 +AD4   +ACo e.g. due to a concurrent blk+AF8-mq+AF8-finish+AF8-request() call.
+AD4 +AD4 +AD4   +ACo-/
+AD4 +AD4 +AD4 -static void hctx+AF8-show+AF8-busy+AF8-rq(struct request +ACo-rq, void +ACo-data, bool reserved)
+AD4 +AD4 +AD4 +-static bool hctx+AF8-show+AF8-busy+AF8-rq(struct request +ACo-rq, void +ACo-data, bool reserved)
+AD4 +AD4 +AD4  +AHs
+AD4 +AD4 
+AD4 +AD4 Please update the kdoc header above hctx+AF8-show+AF8-busy+AF8-rq() such that it reflects
+AD4 +AD4 the new behavior. I'm referring to the +ACI-will be called for each request+ACI part.
+AD4 +AD4 Otherwise this patch looks fine to me.
+AD4 
+AD4 Took a look at the comment, and what do you want changed? There's no change
+AD4 in behavior for hctx+AF8-show+AF8-busy+AF8-rq(), it loops all requests just like before.
+AD4 We just return true to ensure we continue iterating.

Oops, I added my reply below the wrong function. I wanted to refer to the
following comment above blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter():

 +ACo +AEA-fn:		Pointer to the function that will be called for each request

Additionally, how about similar comments above bt+AF8-for+AF8-each(), bt+AF8-tags+AF8-for+AF8-each()
blk+AF8-mq+AF8-all+AF8-tag+AF8-busy+AF8-iter() and blk+AF8-mq+AF8-tagset+AF8-busy+AF8-iter()? I think this patch
affects all these functions.

Thanks,

Bart.
