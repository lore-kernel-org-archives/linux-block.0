Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF6BC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 15:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AFB20872
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 15:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfCRPt1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:49:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39052 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfCRPt0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 11:49:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id h8so11666484pgp.6
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 08:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YXuzdlCHhgWVAxBqw3+RNjlhyFNzOx4bP1/RMhizIyI=;
        b=HSzgK03s/bUzfWUD4He1l249CJz1Je0V/+vcFyoAuQjdSwYGmowFX+8TuQEimQ3CnU
         Q7Z7/1ZDOEqz/Do5norYNorb4MyF/hm9gYgi4hvVx7bpVLTmGQ1W8NYHH4y3baeNzq8r
         c7klAX7SlU50F3kfltBHhyZ9VJCtYPwReIQd41MFS/fcyJkfroYfsc3oFRWBcNPGy67h
         E2uk82XjQzzR2eDPrB01B4zTYrNqbpSqzS0BUSATNxhdvJRnzhXS6CM/SRgNiz8q4Vzs
         O+bJB7eVXKADg+AEb6i8d9OZn/s8HZwr1N0P3TKprnrzq5D4bxRiih/d/biPOOCQKdiA
         wm8A==
X-Gm-Message-State: APjAAAWxkMyJsNAtVQmqZ15M4X/BN9la6lZE7hKCkR1MwglggMEl9mZc
        z92qGO0y10mh4zuPxUKco7w=
X-Google-Smtp-Source: APXvYqxYv19NsL0kQAQCv2yPa+igYRNRcKzrHToZvARKxnqWy32bqamfmIRHaJsXTk5f9y1KmIIHzA==
X-Received: by 2002:aa7:8710:: with SMTP id b16mr19933847pfo.15.1552924166056;
        Mon, 18 Mar 2019 08:49:26 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h184sm24474746pfc.78.2019.03.18.08.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 08:49:25 -0700 (PDT)
Message-ID: <1552924164.152266.21.camel@acm.org>
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Date:   Mon, 18 Mar 2019 08:49:24 -0700
In-Reply-To: <20190318151618.GA20371@ming.t460p>
References: <20190318032950.17770-1-ming.lei@redhat.com>
         <20190318032950.17770-2-ming.lei@redhat.com>
         <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
         <20190318073826.GA29746@ming.t460p> <1552921495.152266.8.camel@acm.org>
         <20190318151618.GA20371@ming.t460p>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-03-18 at 23:16 +-0800, Ming Lei wrote:
+AD4 I am not familiar with SRP, could you explain what SRP initiator driver
+AD4 will do when the controller is in bad state? Especially about dealing with
+AD4 in-flight IO requests under this situation.

Hi Ming,

Just like the NVMeOF initiator driver, the SRP initiator driver uses an
RDMA RC connection for all of its communication over the network. If
communication between initiator and target fails the target driver will
close the connection or one of the work requests that was posted by the
initiator driver will complete with an error status (wc-+AD4-status +ACEAPQ
IB+AF8-WC+AF8-SUCCESS). In the latter case the function srp+AF8-handle+AF8-qp+AF8-err() will
try to reestablish the connection between initiator and target after a
certain delay:

	if (delay +AD4 0)
		queue+AF8-delayed+AF8-work(system+AF8-long+AF8-wq, +ACY-rport-+AD4-reconnect+AF8-work,
				   1UL +ACo delay +ACo HZ)+ADs

SCSI timeouts may kick the SCSI error handler. That results in calls of
the srp+AF8-reset+AF8-device() and/or srp+AF8-reset+AF8-host() functions. srp+AF8-reset+AF8-host()
terminates all outstanding requests after having disconnected the RDMA RC
connection. Disconnecting the RC connection first guarantees that there
are no concurrent request completion calls from the regular completion
path and from the error handler.

Bart.
