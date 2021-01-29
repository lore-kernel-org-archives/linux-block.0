Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391D4C433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 03:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E3464D99
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 03:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhA2DZD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 22:25:03 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:41080 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhA2DZB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 22:25:01 -0500
Received: by mail-wr1-f49.google.com with SMTP id p15so7407733wrq.8
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 19:24:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5GG8/DHZriqjxDmM2Ga/OsXfYmbiNsvsK+fvLtzb83I=;
        b=tMhNNjS3LMUBQcDZ1rBg2RhVotTueUiTePBrI71com92r3+jgDanOLzYXDfUOIyRPm
         0jKCYY7h/lLTx79sUJg/59cSu+By/ZNlEXr+rmgP+EcCpk3GXH56k2Slr8o39HQS0E8O
         oXFVSltks54aclSbxZdbIrgPeeGXzQrW1s+EyUQthpH3ZkGWUnEf4OMRf3yHCB6k5x/6
         ibOwE5hPuRdo7F/4/vR3HSZYu1sJVm4DEwsgi/55isugoOWF/F7p1cr0u2l0fDoQ08Mq
         bBaXC+8j3zFlCIPZkxhZIUTyirIurND/e+V+JZKiKXSxUmhBhvVLn/8i/Xs4CwDzf8IT
         F+YA==
X-Gm-Message-State: AOAM532tOWm6WDsAHtnZA25YL9Mj0CfgxyzI2xZapsvVkBbH7Z0qDu55
        gweRhlO47kGCMfGNPEtizUY=
X-Google-Smtp-Source: ABdhPJzRi2JjEDG0HDYiPXvDBSUHQbkXPJaoF4QHN4wOgx9Xzw+WAGzmwgArCjMQsVl4OWS7SxaFNg==
X-Received: by 2002:adf:9261:: with SMTP id 88mr2073565wrj.227.1611890659229;
        Thu, 28 Jan 2021 19:24:19 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578? ([2601:647:4802:9070:3d48:4849:d506:e578])
        by smtp.gmail.com with ESMTPSA id h15sm9650294wrt.10.2021.01.28.19.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 19:24:18 -0800 (PST)
Subject: Re: [PATCH v4 4/5] nvme-rdma: avoid IO error for nvme native
 multipath
To:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de,
        linux-block@vger.kernel.org, axboe@kernel.dk
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-5-lengchao@huawei.com>
 <5a368693-65fd-1bdf-924a-f90df7f59b2a@grimberg.me>
 <9c30b18a-6fdd-be1c-f3bc-1d44c35ae274@huawei.com>
 <ca300cac-1f6c-01b2-8691-9a545381523a@grimberg.me>
 <29ccc5e0-66e9-93db-e9b9-09012f1c8fe2@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1651456a-3251-77db-42c9-fc1a2d2c5c13@grimberg.me>
Date:   Thu, 28 Jan 2021 19:24:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <29ccc5e0-66e9-93db-e9b9-09012f1c8fe2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> Why not just call set the status and call nvme_rdma_complete_rq and
>>>> return here?
>>> If the err is ENOMEM or EAGAIN, I am not sure the err must be a
>>> path-related error for all HBA drivers. So reused the error check code.
>>> I think it would be more reasonable to assume any errors returned by HBA
>>> driver as path-related errors.
>>> If you think so, I will modify it in next patch version.
>>
>> Meant to do that only for -EIO. We should absolutely not do any of this
>> for stuff like EINVAL, EOPNOTSUPP, EPERM or any strange error that may
>> return due to a bug or anything like that.
> ok, please review again, thank you.
> ---
>   drivers/nvme/host/rdma.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index b7ce4f221d99..66b697461bd9 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2084,8 +2084,13 @@ static blk_status_t nvme_rdma_queue_rq(struct 
> blk_mq_hw_ctx *hctx,
> 
>          err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
>                          req->mr ? &req->reg_wr.wr : NULL);
> -       if (unlikely(err))
> +       if (unlikely(err)) {
> +               if (err == -EIO) {
> +                       nvme_complete_failed_rq(rq, 
> NVME_SC_HOST_PATH_ERROR);

I was thinking about:
--
         err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
                         req->mr ? &req->reg_wr.wr : NULL);
         if (unlikely(err)) {
                 if (err == -EIO) {
                         /*
                          * Fail the reuqest so upper layer can failover I/O
                          * if another path is available
                          */
                         req->status = NVME_SC_HOST_PATH_ERROR;
                         nvme_rdma_complete_rq(rq);
                         return BLK_STS_OK;

                 }
                 goto err_unmap;
         }
--
