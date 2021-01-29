Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7FBC433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 01:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3506024A
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 01:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhA2Bg3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 20:36:29 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:45607 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhA2Bg1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 20:36:27 -0500
Received: by mail-wr1-f50.google.com with SMTP id m13so7271370wro.12
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 17:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xCjG12+ISZQS2TVMmwKooqoDXwGno5KAZlsJxtlGsPw=;
        b=nYXbpRdnW0JGr6h5g843A2cUz6Tqz+J8HcjWaMnhVNhAQ3W9wJ9D6DkpbrFfxRzFff
         8hrjbeqin7rAp1hmT7YVDr9UODjFEFvhb9iIwuK4FaRUnGtVITf8VgDjzsq/nGUkKZNf
         duFZXGYVp3np26kKFk9cx4wk4j55jTsahYe4loTjvswHvACefjynccUMkP5N5U3uNSkZ
         8oSzpL3qCfOlKi0g0N11iSqccBRjix9RWiQanPAeV0cMcDWoCfiSflSwy/q8Nhtr5OeF
         RmFj6rSDQ+MdmhMkCTKXWTyjxW4lAHv9kvfnDxZUh65cdUc+6msHJbnUDI2kUCFsGKEv
         CYjg==
X-Gm-Message-State: AOAM531jv2YbLq7ab7N+x8s8/NjwzD9nnv+BXCwm4IFRmNhfEKuTQ81Z
        vrzbAByu3d86kqcEhIXg1c4=
X-Google-Smtp-Source: ABdhPJwcwTDlDxKtnqDUvi1/9DN3EVExRSNov3nX2OV93vX+Bt0jcOjNCdFtwI3XzHVphEILFRVK3Q==
X-Received: by 2002:a5d:6685:: with SMTP id l5mr1828528wru.176.1611884145218;
        Thu, 28 Jan 2021 17:35:45 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578? ([2601:647:4802:9070:3d48:4849:d506:e578])
        by smtp.gmail.com with ESMTPSA id f17sm10021308wrv.0.2021.01.28.17.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 17:35:44 -0800 (PST)
Subject: Re: [PATCH v4 4/5] nvme-rdma: avoid IO error for nvme native
 multipath
To:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de,
        linux-block@vger.kernel.org, axboe@kernel.dk
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-5-lengchao@huawei.com>
 <5a368693-65fd-1bdf-924a-f90df7f59b2a@grimberg.me>
 <9c30b18a-6fdd-be1c-f3bc-1d44c35ae274@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ca300cac-1f6c-01b2-8691-9a545381523a@grimberg.me>
Date:   Thu, 28 Jan 2021 17:35:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9c30b18a-6fdd-be1c-f3bc-1d44c35ae274@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> @@ -2084,8 +2085,10 @@ static blk_status_t nvme_rdma_queue_rq(struct 
>>> blk_mq_hw_ctx *hctx,
>>>       err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
>>>               req->mr ? &req->reg_wr.wr : NULL);
>>> -    if (unlikely(err))
>>> +    if (unlikely(err)) {
>>> +        driver_error = true;
>>>           goto err_unmap;
>>
>> Why not just call set the status and call nvme_rdma_complete_rq and
>> return here?
> If the err is ENOMEM or EAGAIN, I am not sure the err must be a
> path-related error for all HBA drivers. So reused the error check code.
> I think it would be more reasonable to assume any errors returned by HBA
> driver as path-related errors.
> If you think so, I will modify it in next patch version.

Meant to do that only for -EIO. We should absolutely not do any of this
for stuff like EINVAL, EOPNOTSUPP, EPERM or any strange error that may
return due to a bug or anything like that.
