Return-Path: <SRS0=jW7Q=YD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CC0C4360C
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 15:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0162196E
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 15:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KBjERMhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfJJPpS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:45:18 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:43523 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfJJPpR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 11:45:17 -0400
Received: by mail-io1-f49.google.com with SMTP id v2so14726134iob.10
        for <linux-block@vger.kernel.org>; Thu, 10 Oct 2019 08:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jG1vSVFd42A8VxlUnazw+9DsccU/V6NMBizBsW1Hoqc=;
        b=KBjERMhYNuhrDthAa6DUlda3ll0Qunv8OTnKbVCR57zchuNftLkNfzHgp0zuUqPnnV
         AEaY9nn7AMT2UFZgc4C9ZFCfMSXHoMomqU9bt4JF/aXyMH+Jmtp6Gap0Pxzd7yYEVxLn
         FkxYIsPLVNcf4FAmfqLIzYnjbwWtRArXH5f17k6AhmeiTzQ0WVt7RUiourC2BCAvZ6C5
         4zT1/QeiPHNckIL/CJSpQUxKErIv3MZT60UhOxeB/dTnu0sf0//0HUGcIJOFzzqMZfm+
         p06M116OKTeYwYFv7DfTjCrpyXIOUSqxgh2Z0tKCwlLg5yFun07/V3Dlz4POoQALarSh
         O5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jG1vSVFd42A8VxlUnazw+9DsccU/V6NMBizBsW1Hoqc=;
        b=TCvSABTFy4HCtGBQ/b+5gq6TFat6zC+gzrNIBRlqFi41629o5HQ+ibww5I0cmTZNrt
         PGpQ0dF4yYZIqxgPsycYwnq0ynmCV6UNoHDhSfyAX8wtRbFeA8+Ei3t6ukmggjMWA/YD
         gGpNRNNbylav53IBZJVfElCjyJjqQ75LvlyuFaA0BVE7y/ejrfHTA8ac2QGcOZHeKRDJ
         WFd+zExMcMH5Dlk+cB9DDDQnD/vvi0seN+Ka9ugzejoMKwPSob+dm8jnMa3cixT2Xcjh
         F8yxbUqRcOGEm9sDKxx4W2os0mENyvLH3Qm5e8kdB9gRBnvpG+fNQxzkF13Cob6MBGPe
         tiPA==
X-Gm-Message-State: APjAAAUNAXaG+HFcckRx037KhjgazB1dkkACP1BdFT7mDrouLjv0qVfC
        7ldPQsV8v4GcGjh0GOs/3nf8DKG9tE5y1A==
X-Google-Smtp-Source: APXvYqwyXWMo/WOt/tQW3VWICdwrtyzTIwJWjktMYeajWMnpv7EZI4T/HNRt/nCm2Oq6eNgaR0S+DA==
X-Received: by 2002:a6b:7c09:: with SMTP id m9mr11693891iok.286.1570722314098;
        Thu, 10 Oct 2019 08:45:14 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 17sm3721769ioo.21.2019.10.10.08.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 08:45:13 -0700 (PDT)
Subject: Re: [PATCH] nbd: fix possible sysfs duplicate warning
To:     xiubli@redhat.com, josef@toxicpanda.com
Cc:     mchristi@redhat.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
References: <20190919061427.3990-1-xiubli@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8bdae3dc-f286-44ba-3348-0542be622c08@kernel.dk>
Date:   Thu, 10 Oct 2019 09:45:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190919061427.3990-1-xiubli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/19/19 12:14 AM, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> 1. nbd_put takes the mutex and drops nbd->ref to 0. It then does
> idr_remove and drops the mutex.
> 
> 2. nbd_genl_connect takes the mutex. idr_find/idr_for_each fails
> to find an existing device, so it does nbd_dev_add.
> 
> 3. just before the nbd_put could call nbd_dev_remove or not finished
> totally, but if nbd_dev_add try to add_disk, we can hit:
> 
> debugfs: Directory 'nbd1' with parent 'block' already present!
> 
> This patch will make sure all the disk add/remove stuff are done
> by holding the nbd_index_mutex lock.

Applied, thanks.

-- 
Jens Axboe

