Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411FDC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 21:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15AF2218FD
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 21:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbeLTVbN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:31:13 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:41041 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbeLTVbN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 16:31:13 -0500
Received: by mail-pl1-f179.google.com with SMTP id u6so1451919plm.8
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 13:31:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ss0NPqgOe7r4x6jQE4nkk9DOPn+wpSYLhsVziui5s1Y=;
        b=dqGaAYzRlW1Cqsc1+72qeCwPEnJ4RCFnXqR9xN+gL9TP1hA/YVxkfRF9sgvQyzHULY
         nIC97x5q/V66T1VxxK2e9+TKK33Nj47OWq7/Cqo5W0Bn/2cClscOwu9FzFiyDVZqKIfa
         mILvv+NNswxCHfmwlr1HRXULc+sQFjURxhDSzFWdtZtMJTHhGfXG3afkRbzOxvXlt5Bd
         9IWGrTJKTcbaAFEs9lvnLxHW5b/z+1PwTmCXiz1xXY74JRNUyhkYhOeEr3UKxnoztHQ8
         BpO91dXF4+3EeYq/D0UEhtQFK3WfZZDphwgmy+ppLcbGesv/t0acZPxH3EhoR3VQGkxg
         h8Qg==
X-Gm-Message-State: AA+aEWY7OuF0530a2QspcAbCcxuTVIUARTSt0zLOjDrgzK1LfpUqTtAe
        S70InwqQreiRGR3G6/n2DzQ=
X-Google-Smtp-Source: AFSGD/WqoOoMql+52wCJX1Be0SKIEKYNNM0AJLypeBVgQdWeU0H/B+cNYOl4pGQ5q5waeuDJ5cu37g==
X-Received: by 2002:a17:902:b90b:: with SMTP id bf11mr25244096plb.284.1545341472210;
        Thu, 20 Dec 2018 13:31:12 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 24sm42930511pfl.32.2018.12.20.13.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 13:31:11 -0800 (PST)
Message-ID: <1545341470.185366.519.camel@acm.org>
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Thu, 20 Dec 2018 13:31:10 -0800
In-Reply-To: <120bb59a-af93-7d8c-9afc-7087973632bf@kernel.dk>
References: <1545261885.185366.488.camel@acm.org>
         <74c0280c-e557-ad03-cd75-98dd6d868da3@kernel.dk>
         <1545265001.185366.496.camel@acm.org>
         <1ca5cd37-87ce-8cff-6cb4-1fdb29bd4da2@kernel.dk>
         <0560802f-efc0-e9ec-99f7-4bdbdbc234f8@oracle.com>
         <c078750c-ff6b-4939-281b-7556d31dc74d@kernel.dk>
         <fe9dfe60-3cfc-9cfa-56c3-1365cbe8ec53@oracle.com>
         <a45c9931-ce8b-0ac8-f304-412c6042eff9@kernel.dk>
         <372d2960-ff0c-1135-28f9-23eea8670463@oracle.com>
         <ccf50ee5-ff34-39a0-d7eb-3853fee55a4c@kernel.dk>
         <6ae35005-7ba9-91e1-f315-d128f410c12c@kernel.dk>
         <1545328865.185366.508.camel@acm.org>
         <bd78b521-d0d4-22ec-ff7f-2d70709ca742@kernel.dk>
         <b9c3bd7c-9e82-7300-d525-0bd72ed66f66@kernel.dk>
         <1545339362.185366.511.camel@acm.org>
         <e7d6d857-b20a-245c-c6c7-fb9b110215e9@kernel.dk>
         <1545340987.185366.515.camel@acm.org>
         <120bb59a-af93-7d8c-9afc-7087973632bf@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-20 at 14:26 -0700, Jens Axboe wrote:
+AD4 On 12/20/18 2:23 PM, Bart Van Assche wrote:
+AD4 +AD4 On Thu, 2018-12-20 at 14:00 -0700, Jens Axboe wrote:
+AD4 +AD4 +AD4 On 12/20/18 1:56 PM, Bart Van Assche wrote:
+AD4 +AD4 +AD4 +AD4 +AEAAQA -96,6 +-97,9 +AEAAQA static void blk+AF8-mq+AF8-check+AF8-inflight(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
+AD4 +AD4 +AD4 +AD4  +AHs
+AD4 +AD4 +AD4 +AD4  	struct mq+AF8-inflight +ACo-mi +AD0 priv+ADs
+AD4 +AD4 +AD4 +AD4  
+AD4 +AD4 +AD4 +AD4 +-	if (rq-+AD4-q +ACEAPQ mi-+AD4-q)
+AD4 +AD4 +AD4 +AD4 +-		return+ADs
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Aren't you back to square one with this one, if the tags are shared? You
+AD4 +AD4 +AD4 can't dereference it before you know it matches.
+AD4 +AD4 
+AD4 +AD4 My patch can only work if the new rq-+AD4-q +AD0 NULL assignment in +AF8AXw-blk+AF8-mq+AF8-free+AF8-request()
+AD4 +AD4 is executed before the request tag is freed and if freeing a tag does not happen
+AD4 +AD4 concurrently with any bt+AF8-iter() call. Would you accept that I add a seqlock to avoid
+AD4 +AD4 this scenario?
+AD4 
+AD4 Ugh no, let's not go that far. Why not just use my approach that avoids
+AD4 any need to dereference rq, unless we know it belongs to the queue in
+AD4 question? I think that's cheaper than resetting -+AD4-queue as well when the
+AD4 rq completes, I'm always wary of adding new stores in the completion
+AD4 path.

I think there is a race condition in bt+AF8-iter() in your approach: tags-+AD4-rqs+AFs-bitnr+AF0.queue
can change after it has been read and that can cause a request that is not associated
with hctx-+AD4-queue to be passed to iter+AF8-data-+AD4-fn(). Since 'fn' will access '+ACo-rq' I think
that with your patch a use-after-free can occur similar to the one reported at the
start of this e-mail thread. Your patch may make it harder to trigger that issue though.

Bart.

