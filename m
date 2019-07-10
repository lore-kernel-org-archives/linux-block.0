Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A04C73C66
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 02:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA50520651
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 02:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfGJCcR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 22:32:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39602 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJCcQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 22:32:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so418175pgi.6
        for <linux-block@vger.kernel.org>; Tue, 09 Jul 2019 19:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L6J63ikJ611WsBHrWhhsL+l1tZ/eVonvgyA8+nHVZ0g=;
        b=JmeihkRCjK+RcP+EStVT7oS7CoYq4UO9u6VrEGRW70f5hKHKJQnZ6RW1DDh6E/AWtQ
         5qeEmtnHIFFRPDQe/TxJGNUTJYvXMcsNHYHk64q0/8fU4nCBzOFTwTt7v1BGiGQca5LO
         mox/CrNUPdnJ/3kUSu4b2UqHjNisuCqDq09NXM3FSmqe1/5hbdWx7CE89a0ZMevwSnNm
         QIwW0ZQtP3czye8dTkHfxVMcm2WAW+dDOTjL1SkDgG3fxmJi/twUAp5QNQAesWgwXooh
         2lyzQcXDelS4mxLQegOv8aQnEmPuOuxgmXO4/XXCsWwMspbu7KpcYpIt7hbQfOB2gty7
         35VA==
X-Gm-Message-State: APjAAAWBCk6uqHaO1drrObd5bZHJyCHHpEfj6sGqEkhvbxwE8myDjE/O
        KpzHd+EhWiFrIyoOSaaaa9V575LG
X-Google-Smtp-Source: APXvYqwxbSmGhIP3zqzJnu04h76z5MW3f9ItZGqhn1ubb8NOQpOap2KHzaUGA9jS7nY/xbtSmi76/g==
X-Received: by 2002:a17:90a:35e6:: with SMTP id r93mr3877275pjb.20.1562725936194;
        Tue, 09 Jul 2019 19:32:16 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:3d99:9227:6568:8c62])
        by smtp.gmail.com with ESMTPSA id m10sm343328pgq.67.2019.07.09.19.32.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 19:32:15 -0700 (PDT)
Subject: Re: [PATCH] block: Disable write plugging for zoned block devices
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
References: <20190709090219.8784-1-damien.lemoal@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <29cfbb53-36c9-1e03-183d-572223eb01f3@acm.org>
Date:   Tue, 9 Jul 2019 19:32:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709090219.8784-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/9/19 2:02 AM, Damien Le Moal wrote:
> +static inline struct blk_plug *blk_mq_plug(struct request_queue *q,
> +					   struct bio *bio)
> +{
> +	struct blk_plug *plug = current->plug;
> +
> +	if (!blk_queue_is_zoned(q) || !op_is_write(bio_op(bio)))
> +		return plug;
> +
> +	/* Zoned block device write case: do not plug the BIO */
> +	return NULL;
> +}

Can the 'plug' variable be left out from this function and can 'return 
plug' be changed into 'return current->plug'? Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

