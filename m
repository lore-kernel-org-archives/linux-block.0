Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E50C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 15:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E722920863
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 15:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbfCRPE7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:04:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36730 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfCRPE7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 11:04:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id r124so11598018pgr.3
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 08:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTGVzdB/0aE1dt1UucJUscaeEjwEIR5e5bpu3ZKlhx0=;
        b=apm4EIKatq+5j+g63obUFZwwO2Pu2Ac5oQh0YfRxYJ3cDU6hepYFT2wGqRroMgZF0H
         tykaHO6yUGPSwpceNmI//dPO3N23ZIbspkgguCA2QP6eMBEPp6QyqXAbdQd0OlRGpzZH
         h66F82ZJ8krw3OpEU0n8uz45SuxwPpd5NqlpgkHBhL07TuYLEdWhpOb6QEhyN+/djCZr
         NHnIQjgJaC5Wa5mE0CGc2mH0aoNHpDV5fE1JoEqMpYmvF6BIToj2JtHR2cpLQ4NQPEpG
         eLZe3SNWPAyJR07sTSqZJRp91wg60ytXvAsGtjlef08OhQvx1mxSmAHTM5sZDXwziRSQ
         R82A==
X-Gm-Message-State: APjAAAXnVIQ4Fd71eFhxDxTe4iyF09iRDg4q3lGy3dsj8d4oX1ngZCpH
        JS+Q8B3VkiT+3S8uKANZ+Gc=
X-Google-Smtp-Source: APXvYqzJVDJWRnHixeXC3Kc+0kIcB8yrR70+jwQNumcwzZ9NYA7R04ceXp8fneVwtmpxL2boXnWWbQ==
X-Received: by 2002:aa7:8157:: with SMTP id d23mr19556745pfn.67.1552921498271;
        Mon, 18 Mar 2019 08:04:58 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id e8sm14180798pfn.103.2019.03.18.08.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 08:04:57 -0700 (PDT)
Message-ID: <1552921495.152266.8.camel@acm.org>
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Date:   Mon, 18 Mar 2019 08:04:55 -0700
In-Reply-To: <20190318073826.GA29746@ming.t460p>
References: <20190318032950.17770-1-ming.lei@redhat.com>
         <20190318032950.17770-2-ming.lei@redhat.com>
         <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
         <20190318073826.GA29746@ming.t460p>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-03-18 at 15:38 +-0800, Ming Lei wrote:
+AD4 On Sun, Mar 17, 2019 at 09:09:09PM -0700, Bart Van Assche wrote:
+AD4 +AD4 On 3/17/19 8:29 PM, Ming Lei wrote:
+AD4 +AD4 +AD4 In NVMe's error handler, follows the typical steps for tearing down
+AD4 +AD4 +AD4 hardware:
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 1) stop blk+AF8-mq hw queues
+AD4 +AD4 +AD4 2) stop the real hw queues
+AD4 +AD4 +AD4 3) cancel in-flight requests via
+AD4 +AD4 +AD4 	blk+AF8-mq+AF8-tagset+AF8-busy+AF8-iter(tags, cancel+AF8-request, ...)
+AD4 +AD4 +AD4 cancel+AF8-request():
+AD4 +AD4 +AD4 	mark the request as abort
+AD4 +AD4 +AD4 	blk+AF8-mq+AF8-complete+AF8-request(req)+ADs
+AD4 +AD4 +AD4 4) destroy real hw queues
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 However, there may be race between +ACM-3 and +ACM-4, because blk+AF8-mq+AF8-complete+AF8-request()
+AD4 +AD4 +AD4 actually completes the request asynchronously.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 This patch introduces blk+AF8-mq+AF8-complete+AF8-request+AF8-sync() for fixing the
+AD4 +AD4 +AD4 above race.
+AD4 +AD4 
+AD4 +AD4 Other block drivers wait until outstanding requests have completed by
+AD4 +AD4 calling blk+AF8-cleanup+AF8-queue() before hardware queues are destroyed. Why can't
+AD4 +AD4 the NVMe driver follow that approach?
+AD4 
+AD4 The tearing down of controller can be done in error handler, in which
+AD4 the request queues may not be cleaned up, almost all kinds of NVMe
+AD4 controller's error handling follows the above steps, such as:
+AD4 
+AD4 nvme+AF8-rdma+AF8-error+AF8-recovery+AF8-work()
+AD4 	-+AD4-nvme+AF8-rdma+AF8-teardown+AF8-io+AF8-queues()
+AD4 
+AD4 nvme+AF8-timeout()
+AD4 	-+AD4-nvme+AF8-dev+AF8-disable

Hi Ming,

This makes me wonder whether the current design of the NVMe core is the best
design we can come up with? The structure of e.g. the SRP initiator and target
drivers is similar to the NVMeOF drivers. However, there is no need in the SRP
initiator driver to terminate requests synchronously. Is this due to
differences in the error handling approaches in the SCSI and NVMe core drivers?

Thanks,

Bart.
