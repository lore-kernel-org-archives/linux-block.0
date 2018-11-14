Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FC1C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E261322360
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E261322360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732993AbeKOBGH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:06:07 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42835 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbeKOBGG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 20:06:06 -0500
Received: by mail-pl1-f193.google.com with SMTP id x21-v6so5190490pln.9;
        Wed, 14 Nov 2018 07:02:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKNxG3ln7TPHbefRdNQiMFq2WTOdLRwnXO1PGMX3qYQ=;
        b=S3Dq2zpHZKvX9dzFRtS/L4tNZ7ruScGs85fuxHErJ+amxGQZRQq0d80hUTD8rBVLaZ
         aa6JFRAdDbRBRHVkQXpWzMOL3/puncYDTHIRV2KA9Mwz9am7oKmzm0Z2bHkdKbSy7KeW
         0lxm5hiFbmG5RU0XEh53v28V4AK8fNb/ryWafZ04rankEMl6PHkOhq6ohkb6z4Lgzhqq
         GbfAlRLeIZ/aQbuCvspC3fW10+DONs5m1XLXJyLr1p5mH4kSGZ9Sk0p3BtBtrusV0hI/
         JTRAJSC6O4zl/6nfZivU/8HQ32spoEJNGpQfnQy6jwB6Hcvf8eWP+7QTXLwqSiNtiZyq
         qHxA==
X-Gm-Message-State: AGRZ1gLsyP1NiYuipUe/DCWIGTKPmJ0lZa9cW3mmwYPDCU0ckJk1E0D+
        /9TppXHqKndQPepf2bK7ZvI=
X-Google-Smtp-Source: AJdET5c2jjfCp8nMJQjZK9otlm03sgrQJV5yog11BUQ5AGzELCDB1gUtrqMADTqZeMetNyHVBI1qXw==
X-Received: by 2002:a17:902:5582:: with SMTP id g2-v6mr2261082pli.56.1542207750902;
        Wed, 14 Nov 2018 07:02:30 -0800 (PST)
Received: from [192.168.40.151] ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id u6sm24573977pgr.79.2018.11.14.07.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 07:02:29 -0800 (PST)
Message-ID: <1542207748.192870.14.camel@acm.org>
Subject: Re: [PATCH V2] SCSI: fix queue cleanup race before queue
 initialization is done
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        "jianchao . wang" <jianchao.w.wang@oracle.com>
Date:   Wed, 14 Nov 2018 07:02:28 -0800
In-Reply-To: <20181114082551.12141-1-ming.lei@redhat.com>
References: <20181114082551.12141-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2018-11-14 at 16:25 +-0800, Ming Lei wrote:
+AD4 --- a/drivers/scsi/scsi+AF8-lib.c
+AD4 +-+-+- b/drivers/scsi/scsi+AF8-lib.c
+AD4 +AEAAQA -697,6 +-697,12 +AEAAQA static bool scsi+AF8-end+AF8-request(struct request +ACo-req,
+AD4 blk+AF8-status+AF8-t error,
+AD4  		 +ACo-/
+AD4  		scsi+AF8-mq+AF8-uninit+AF8-cmd(cmd)+ADs
+AD4  
+AD4 +-		/+ACo
+AD4 +-		 +ACo queue is still alive, so grab the ref for preventing it
+AD4 +-		 +ACo from being cleaned up during running queue.
+AD4 +-		 +ACo-/
+AD4 +-		percpu+AF8-ref+AF8-get(+ACY-q-+AD4-q+AF8-usage+AF8-counter)+ADs
+AD4 +-

I think the above comment is misleading. In the block layer a queue is called
alive if the +ACI-dying+ACI flag has not been set. When the above call to
percpu+AF8-ref+AF8-get() occurs it is not guaranteed that that flag has not yet been
set. But it is guaranteed that q-+AD4-q+AF8-usage+AF8-counter is not zero. I would prefer
if the comment would be modified.

What's not clear to me is why this patch only protects the blk-mq path but
not the legacy path. Does the legacy path need similar protection? It also
triggers a queue run after having finished a request.

Otherwise this patch looks fine to me.

Bart.
