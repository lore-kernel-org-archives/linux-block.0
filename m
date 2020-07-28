Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB702C433E0
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 00:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B97622173E
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 00:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgG1AyU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 20:54:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53740 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG1AyT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 20:54:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id g8so4552186wmk.3
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 17:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u1gkGeFetF3rGlY8qaDx45rMkpu77Cqvm7xU95VZwvg=;
        b=Yd7SwTxPbI9UkVhzuBP3eZ/AXahQRHBRdPA0Zqxw719VdLHwWlLnGiiSYCuWAWMf/c
         McjK9mKPXCxwTkDjOFI08mJ93qq/D4CUWnP9nYoeeLI/fIdSWQ54AFWYDWNr66Mbhcnn
         JYNTKxF5OwLxswL22xRLUuOEf1bcueN4p+h/M1A9prrvgZzsols1XrMOhZejgaE0oKh8
         PceYMnSJg53R8XF5HiNNaI2lGXzuzz1Az9AzWBPyzyOU/q27MiEQ9CcTFJtHh0bg6uta
         jxvH5uDKHUb2TY4kRMS37SfkexmZWJ3sdV9gnKVmw82arwtpVUHmkeuK0dD6hkdcvnFV
         eWUw==
X-Gm-Message-State: AOAM533m/v2eYct0LfAGo/Cfpm2jgFjEcI+b7nUKUwG70GKiHtbEJXF5
        in9zTIISc4Qcn+hBi+0YRns=
X-Google-Smtp-Source: ABdhPJyqlT5/XpeujbzEqr4rTTyCXKfrzmjXsJxZWao90G/LQ4HFBP9GBDeN4iiyY1+usdLm4YDADw==
X-Received: by 2002:a1c:9a07:: with SMTP id c7mr1563152wme.147.1595897657677;
        Mon, 27 Jul 2020 17:54:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b? ([2601:647:4802:9070:5d7d:f206:b163:f30b])
        by smtp.gmail.com with ESMTPSA id s14sm14032320wrv.24.2020.07.27.17.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 17:54:17 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] nvme: use blk_mq_[un]quiesce_tagset
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
        Chao Leng <lengchao@huawei.com>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-3-sagi@grimberg.me>
Message-ID: <56517f9c-2d4e-0fee-52d6-20ef9be54bc0@grimberg.me>
Date:   Mon, 27 Jul 2020 17:54:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727231022.307602-3-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 7/27/20 4:10 PM, Sagi Grimberg wrote:
> All controller namespaces share the same tagset, so we
> can use this interface which does the optimal operation
> for parallel quiesce based on the tagset type (e.g.
> blocking tagsets and non-blocking tagsets).
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 05aa568a60af..c41df20996d7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4557,23 +4557,13 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
>   
>   void nvme_stop_queues(struct nvme_ctrl *ctrl)
>   {
> -	struct nvme_ns *ns;
> -
> -	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> -		blk_mq_quiesce_queue(ns->queue);
> -	up_read(&ctrl->namespaces_rwsem);
> +	blk_mq_quiesce_tagset(ctrl->tagset);

Rrr.. this one is slightly annoying. We have the connect_q in
fabrics that we use to issue the connect command which is now
quiesced too...

If we will use this interface, we can unquiesce it right away,
but that seems kinda backwards...

--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05aa568a60af..70af0ff63e7f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4557,23 +4557,15 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);

  void nvme_stop_queues(struct nvme_ctrl *ctrl)
  {
-       struct nvme_ns *ns;
-
-       down_read(&ctrl->namespaces_rwsem);
-       list_for_each_entry(ns, &ctrl->namespaces, list)
-               blk_mq_quiesce_queue(ns->queue);
-       up_read(&ctrl->namespaces_rwsem);
+       blk_mq_quiesce_tagset(ctrl->tagset);
+       if (ctrl->connect_q)
+               blk_mq_unquiesce_queue(ctrl->connect_q);
  }
  EXPORT_SYMBOL_GPL(nvme_stop_queues);
--

Thoughts?
