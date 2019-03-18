Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD80DC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 17:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB85820989
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 17:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q45Hqk/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfCRRhM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:37:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35466 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfCRRhL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 13:37:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id j5so11759762pfa.2
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 10:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mSabTb/t1DFx7TFyt4RiJNPOTUnqDtthywb+FVHwt9Q=;
        b=Q45Hqk/bQWtg5tErhpUtfhDlfFRr/VE63i5b1NPikuQPCeOfzKfrIErSHupa8r6rrl
         jfdNhLK8gx+mfitt1wIsrjjh+B9qejGnybljGgUrbvh6xYrBOdxMry89N9kuXYRyBxGO
         nJHQ2Y5mtdjI20FUT/p3tq06m63BabLhbpH1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mSabTb/t1DFx7TFyt4RiJNPOTUnqDtthywb+FVHwt9Q=;
        b=lA3frgc4zTDSOVwtvRxkucjYDwpF85miqXHk4tktNYmJWfzcM3AZgQ1sWr3RyO6dg6
         I+DyUzjJXdNheO9wFxY9AojrGjSmVbSgnRrKEMtaV330v7XKLeCH3cOpbfNqGvNOZcy/
         /ht2ckNuRBeT62m2jjR6YQPN7qo2Ei63mCmN+y0ZLMQhNWJbS8eCRWhWQ33fLKGWS2S3
         wlom8idWSMK1/h50pIhf7kpjIu3rXD8fgd7WD73Pz0DIzHCGxszIiiLGfXVZBNvTnodO
         hkPJkNccVdzNgm9fcvbBXWCYIPkCmsyrBm6X/2IXIaVW2ViXBKXGDFdo1J5Ep/TOlJ0G
         RZ/Q==
X-Gm-Message-State: APjAAAXsWmv4xinZGuJxRFEAUIaMgSeiTiQsHbIqzwYvvShxQdIU4ODe
        aSjQrCQ9PfZpBvKgxPF4hFhkUw==
X-Google-Smtp-Source: APXvYqzL9hcGHtcXifnxwMYAoz5zPt9T8n6F2BQ8Dax1JeVsabe8zGDdeu9OsyfmcwqJCOjNV4CWXg==
X-Received: by 2002:a17:902:44a4:: with SMTP id l33mr20865673pld.292.1552930631037;
        Mon, 18 Mar 2019 10:37:11 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 9sm14087724pfj.8.2019.03.18.10.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 10:37:09 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <4563485a-02c6-0bfe-d9ec-49adbd44671c@broadcom.com>
Date:   Mon, 18 Mar 2019 10:37:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190318032950.17770-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/17/2019 8:29 PM, Ming Lei wrote:
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
>

This won't help FC at all. Inherently, the "completion" has to be 
asynchronous as line traffic may be required.

e.g. FC doesn't use nvme_complete_request() in the iterator routine.

-- james

