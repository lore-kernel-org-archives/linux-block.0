Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFF3C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 04:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAC02085A
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 04:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbfCREJL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 00:09:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38583 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfCREJL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 00:09:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id v1so5751248pgi.5
        for <linux-block@vger.kernel.org>; Sun, 17 Mar 2019 21:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Aeg6l35mxnlYsSaviLzgKqp5zZQbG6ssYTEIjLnE0ks=;
        b=ok5jVHwQtxNPsXSTGVRuIPFWh4M7uyyloKyDliVt5ipeVqvoC0079u7cKxhpZxTfua
         HY8Z7tZ09l7KXgqQudNCLuM7CZlzyBdHFfDpNmKAXxdFKZe9rUtorDGU41f6hAK47omS
         pJFVgS3Xp589f6QRq4kA5A3N2eqgXTuCWilvDTK1ec37sOjvtCg+7+rPyj+ztWuQMjwu
         i5/yZNvv6c5rv1CmeWM9oMNVHC3lwsepoYSoHF2Lma8/G/e47ONN6a+vSEP34jpZm+Jj
         RhtJkH17XVXhG1zz6xnRA9e1xkatGxEJc0ULCCJk9DG21LD2DcJuo6EVFrldpFRwsrWM
         Iabw==
X-Gm-Message-State: APjAAAXMhYA/giVM81A1VxrYUtYG987DPuHpE/DJ+nASO6Xx9jGoCMpt
        oLM6gsqq+bFyQlov3WYGj6EU00ER
X-Google-Smtp-Source: APXvYqxVvz4dyBKrtqo3PUq5oyor0+RMVKe5TUy2f56cjhQPe9RFtHw8FAzG2OdS/3Yx2/S9AbpIqw==
X-Received: by 2002:a63:2c4c:: with SMTP id s73mr16006232pgs.113.1552882150719;
        Sun, 17 Mar 2019 21:09:10 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id 202sm3964388pfc.86.2019.03.17.21.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 21:09:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
Date:   Sun, 17 Mar 2019 21:09:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190318032950.17770-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/17/19 8:29 PM, Ming Lei wrote:
> In NVMe's error handler, follows the typical steps for tearing down
> hardware:
> 
> 1) stop blk_mq hw queues
> 2) stop the real hw queues
> 3) cancel in-flight requests via
> 	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
> cancel_request():
> 	mark the request as abort
> 	blk_mq_complete_request(req);
> 4) destroy real hw queues
> 
> However, there may be race between #3 and #4, because blk_mq_complete_request()
> actually completes the request asynchronously.
> 
> This patch introduces blk_mq_complete_request_sync() for fixing the
> above race.

Other block drivers wait until outstanding requests have completed by 
calling blk_cleanup_queue() before hardware queues are destroyed. Why 
can't the NVMe driver follow that approach?

Thanks,

Bart.
