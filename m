Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225D7C25B06
	for <linux-block@archiver.kernel.org>; Sun, 14 Aug 2022 23:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiHNXog (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Aug 2022 19:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHNXof (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Aug 2022 19:44:35 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D3E7670
        for <linux-block@vger.kernel.org>; Sun, 14 Aug 2022 16:44:34 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id x23so5105118pll.7
        for <linux-block@vger.kernel.org>; Sun, 14 Aug 2022 16:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3T6voZjkr2Hj9zkDwC6o63AUbZ5i//uKacyYdalF4TE=;
        b=p60jlfUnJ/JVUQU4uBmDOcIvla3gFpLDxLaKmhMPGS98S5eE3GoX67xAAuVcjoREd6
         DBM5MloYFZdbEJNBrE0eCh0i9kdm7AbBVM5QyjPXWF5qnwL+0MNPTSNCYYSq0bP0HXFG
         c6goygQTEEDUZTFQ7pZPTgkNRl9yvQGGF8UufgMOljKZhy78aGnVvbeGnmhdz5zQWgXn
         NswYcY5YoKBwj7Oyh9ISu3Ir5DvQL6R8NHFCdd7OBVq/gw9HfWsDOht8BfaBSXHQTM5v
         Cve6OVfvpqYA8eAlSk1YXDf7PkN2osqucKkPmDEiGdO9yTzfZ9tZ3FzJn+U7g6dFfQg1
         bmMA==
X-Gm-Message-State: ACgBeo130NVTusMQLSWcht4VnQJ8OjiH/xHt0IIy2r9/O823HaqWKJxt
        WjZMImz452V+uX/9sYJFWfw=
X-Google-Smtp-Source: AA6agR5PXpmW7R4cq8TYmY5hM+fEBYsa2m9uxQrnM8tD1QpjiSZbA+gyXk/9yldft9RishBy1+L8ww==
X-Received: by 2002:a17:90b:1b08:b0:1f5:b65:9654 with SMTP id nu8-20020a17090b1b0800b001f50b659654mr15574210pjb.77.1660520674041;
        Sun, 14 Aug 2022 16:44:34 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016c4147e48asm5861479pln.219.2022.08.14.16.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 16:44:33 -0700 (PDT)
Message-ID: <09689854-b7b7-9a5c-cda7-f1f4de42b5fe@acm.org>
Date:   Sun, 14 Aug 2022 16:44:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] block: Submit flush requests to the I/O scheduler
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20220812210355.2252143-1-bvanassche@acm.org>
 <20220813064142.GA10753@lst.de>
 <f4e10a9a-313d-ce24-c610-f4e8d072d4f4@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f4e10a9a-313d-ce24-c610-f4e8d072d4f4@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/14/22 10:13, Damien Le Moal wrote:
> And writes to zoned drives never get plugged in the first place, scheduler
> present or not.

Hi Damien,

I agree that blk_mq_submit_bio() does not plug writes to zoned drives 
because of the following code in blk_mq_plug():

/* Zoned block device write operation case: do not plug the BIO */
if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
	return NULL;

However, I have not found any code in blk_execute_rq_nowait() that 
causes the plugging mechanism to be skipped for zoned writes. Did I 
perhaps overlook something? The current blk_execute_rq_nowait() 
implementation is as follows:

void blk_execute_rq_nowait(struct request *rq, bool at_head)
{
	WARN_ON(irqs_disabled());
	WARN_ON(!blk_rq_is_passthrough(rq));

	blk_account_io_start(rq);
	if (current->plug)
		blk_add_rq_to_plug(current->plug, rq);
	else
		blk_mq_sched_insert_request(rq, at_head, true, false);
}

Thanks,

Bart.
