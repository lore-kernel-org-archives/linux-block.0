Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB20FC433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 03:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 686CD23A5C
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 03:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgLHDb2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 22:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgLHDb2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Dec 2020 22:31:28 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2722C061749
        for <linux-block@vger.kernel.org>; Mon,  7 Dec 2020 19:30:42 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id y8so266112plp.8
        for <linux-block@vger.kernel.org>; Mon, 07 Dec 2020 19:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XFuYMDYtSwKWNyWH6jp1aOcL3nAyWOZEAlDqHd4eq7g=;
        b=Sc3jG1E/vxvfJFqpnp9pSqAhjIZgBkd8j9WayA+ZvsrNwabg3wrb+2rDLfXRUeNdYK
         O8ErVucOpvF3CUJQgoYXI62yZneueSbVoUy0zsVxYTrseEfWxApd1wrtwJ8lVla41fqx
         CHnZhkZs6KX/epOpSxdvFEpsdk5zxCJxvt7cNO5diF4sB/1kLZkLe4NZvDddrBPA2VX+
         MYx369hWx4/AedjTPHmz/VmooVq6L0+p2a7/zdymCtMoESZx+h0ksYIa2Mx1aw+7D7nh
         RjVK9cDhnQQzLwPurnflNd9I+Dse3vPc2uIAQuxSbHubDgvZT0CzQJYKp81kfyyhfEql
         c2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XFuYMDYtSwKWNyWH6jp1aOcL3nAyWOZEAlDqHd4eq7g=;
        b=gVXt+i1Lp7Jx4MpDQRVZxfA18wCRZsuKBGVWRtXElHB+q8hwPhJxyAIFhYDYE0wkEC
         cxy1r6LO+dyl5sDnnZLvzX78EMCzTNw8uIZSvGnWsBFLvbueEkVVk3DcyBQiYVcWGrtH
         WZAyGy0XTK3KB7uCZU9/uK7FG3cDy2Lmae+yXP2LOsxu0EvEQgxgnJHvvhtOQqThf+zM
         WFAEjxM935nOIMFbpddAULyCuOfhyUfx3X0Luya7cFJb6/IeUHPp76yLMVr7kSuQrZ1n
         B3AhyzqW3XoortlHVv7dOAl1eluqBq/0dxTspa8CxxCoAmpyR+unbblVk/4ECjkAHckT
         uH6g==
X-Gm-Message-State: AOAM530UvhRhlD4zEvNZoQn+bLCS+gZxBkc4ESJRL0vTYSzBV84mIR/6
        Be5eRSqcnmSNtmef8oxy3ELSDQ==
X-Google-Smtp-Source: ABdhPJzoSBhfFRpmcWsqhAh792nCMcqWhVUSlxJRroO3h/X3tb96uUwbgPJ8DWYh/3kJozNNV/VPkA==
X-Received: by 2002:a17:902:8498:b029:d8:e2a0:e4e7 with SMTP id c24-20020a1709028498b02900d8e2a0e4e7mr19577284plo.49.1607398242205;
        Mon, 07 Dec 2020 19:30:42 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id v19sm868961pjg.50.2020.12.07.19.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 19:30:41 -0800 (PST)
Subject: Re: [PATCH V2 0/3] blk-mq/nvme-loop: use nvme-loop's lock class for
 addressing lockdep false positive warning
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Qian Cai <cai@redhat.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
References: <20201203012638.543321-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f6ab081f-d011-b2cd-3b98-55d623a2a83d@kernel.dk>
Date:   Mon, 7 Dec 2020 20:30:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203012638.543321-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/2/20 6:26 PM, Ming Lei wrote:
> Hi,
> 
> Qian reported there is hang during booting when shared host tagset is
> introduced on megaraid sas. Sumit reported the whole SCSI probe takes
> about ~45min in his test.
> 
> Turns out it is caused by nr_hw_queues increased, especially commit
> b3c6a5997541("block: Fix a lockdep complaint triggered by request queue flushing")
> adds synchronize_rcu() for each hctx's release handler.
> 
> Address the original lockdep false positive warning by simpler way, then
> long scsi probe can be avoided with lockdep enabled.

Applied, thanks.

-- 
Jens Axboe

