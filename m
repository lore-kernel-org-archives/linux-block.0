Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378A2C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E6420645
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pvi/9e9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfCOQdn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:33:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33689 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbfCOQdn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 12:33:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id i19so6728055pfd.0;
        Fri, 15 Mar 2019 09:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=68b5kLIZgxTrtwgDsXRM9YY/uelHbxYtL6Csh5R1LsU=;
        b=Pvi/9e9Wzpx5KF4A7UtTxaxP53ZTv147zcAB98Hp3JdZHsVEcygOdmYqXbGyc1igaN
         xNYMLyhVOTjbwd6E071tZ63U3llk7mvnh8S6poYMKfH3t3kZ/kfGYgB7aDKjyfdwqcre
         3nJxmQK3YT3HiprrKCEzRm1Qk+3XJbk8PHjtpzfPcsHDIEutM5iNOb0Lh0RiQlUO4+U7
         pEl5hT+Yzvxrh9P3O2cGTIe6qdKmnKqsk+3csCukW0fFYwT3A12zKtBafjguu3zCD1hm
         8d/BsmRN2P1YWpPLcBZC21dDlhfSaMvQQAqCamMpGxtonrl1Paeii9RvXQWmk7Iu6b4d
         Yvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=68b5kLIZgxTrtwgDsXRM9YY/uelHbxYtL6Csh5R1LsU=;
        b=rf9wAdvKpE6Lg5X9LAtbXZDL96NKaId6JpksehEyslCHd2z4Lw4Lmi21NtdoyavfL9
         vbHcuhwxal5b9BZLVEm7q7onKmCqIZvS9G0V5lE1AnMKTVSvy4TxJMog9f2BJQkEfhpR
         TaokdLRGBPvMb3+6zl/18sSxH9GFHT/LgG5Jujf0GEtYuXoo9FjGzX2ULnfZCPxZdG4i
         WonEMiJvjDNuLLILJgE7QNvqB2fLPdyKxvmljOTxfl36ej3AjhDP4wswuSyyx4ojV8bf
         LKKNfCd8RMOv+MVUECb+Zpn/S5XnqZVW1M/T8mJI/ELUy1qZijIvoPq5EvhT69UVuNYj
         5XVQ==
X-Gm-Message-State: APjAAAX++XVcRA5NEf2sM2wqYRVbE0bw5N/XBkZcBh+fOvgdni2dd5gj
        t9xCEygqVsaLcMq539P5xHNbsuJC
X-Google-Smtp-Source: APXvYqx+2bOQYZ9fQ0oTpe4QC8jE1fq4bpXVM8Q+80jjX8WgRivhL8RIGqavWVo+mybeO3+ur/erAA==
X-Received: by 2002:a62:70c9:: with SMTP id l192mr4948793pfc.207.1552667621930;
        Fri, 15 Mar 2019 09:33:41 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k72sm6556003pfb.122.2019.03.15.09.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 09:33:41 -0700 (PDT)
Subject: Re: [PATCH 7/8] nvme: use blk_mq_queue_tag_busy_iter
To:     Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-8-git-send-email-jianchao.w.wang@oracle.com>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <62de99e8-0d8d-910a-bfdc-649f734b152c@gmail.com>
Date:   Fri, 15 Mar 2019 09:33:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <1552640264-26101-8-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/15/2019 1:57 AM, Jianchao Wang wrote:
> blk_mq_tagset_busy_iter is not safe that it could get stale request
> in tags->rqs[]. Use blk_mq_queue_tag_busy_iter here. A new helper
> interface nvme_iterate_inflight_rqs is introduced to iterate
> all of the ns under a ctrl.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>   drivers/nvme/host/core.c   | 12 ++++++++++++
>   drivers/nvme/host/fc.c     | 12 ++++++------
>   drivers/nvme/host/nvme.h   |  2 ++
>   drivers/nvme/host/pci.c    |  5 +++--
>   drivers/nvme/host/rdma.c   |  6 +++---
>   drivers/nvme/host/tcp.c    |  5 +++--
>   drivers/nvme/target/loop.c |  6 +++---
>   7 files changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6a9dd68..5760fad 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3816,6 +3816,18 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvme_start_queues);
>   
> +void nvme_iterate_inflight_rqs(struct nvme_ctrl *ctrl,
> +		busy_iter_fn *fn, void *data)
> +{
> +	struct nvme_ns *ns;
> +
> +	down_read(&ctrl->namespaces_rwsem);
> +	list_for_each_entry(ns, &ctrl->namespaces, list)
> +		blk_mq_queue_tag_busy_iter(ns->queue, fn, data, true);
> +	up_read(&ctrl->namespaces_rwsem);
> +}
> +EXPORT_SYMBOL_GPL(nvme_iterate_inflight_rqs);

Hmm... so this aborts ios for namespaces. How about ios that aren't for 
a namespace but rather for the controller itself.  For example, anything 
on the admin queue ?   Rather critical for those ios be terminated as well.

-- james

