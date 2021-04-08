Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D3CC433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 16:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD47561139
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 16:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhDHQM4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:12:56 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:47058 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhDHQMz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 12:12:55 -0400
Received: by mail-pg1-f170.google.com with SMTP id t140so1720873pgb.13
        for <linux-block@vger.kernel.org>; Thu, 08 Apr 2021 09:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4plhv6/ij46Ko9Q5YGxg/ywq0SjvSzL5MfjyvGzz2fw=;
        b=hszTTWMsQj23l9h8Hd3zsCLpEkw30y0TbPz4SoYNYoTz6e75Wyvxr7tn+Mr7q4YBkB
         72abBQPRlk6//fMyPZwq0Mkt9t/k12OGcbkcUMRf8VypAE6s2tcfDvlt0nAhlu/1QOFM
         WXDia8JKNqNtyuAa3tlv3szgCXGQfDKjT04JoHHlX6b5Q07K49FpjvXLIc4Jc/UpnC/k
         h91PzXOj72wBrVV5Lxg4nYJyB9aK/znkzDnSb/Op9aSo24eo7NmabBOkqMprCSsHwtDj
         oLMco2opFA0eUpjHxaZO25Gygp7LzBxVLD5NFC+zuSm1BxLZmr1sB6baHgYK6SmtR7HF
         a9AA==
X-Gm-Message-State: AOAM531yog7ksrZ4F3AH9P4Q0AqMy+NiW9C4TmMAUGg26ohzzJxbr0+g
        RsUSdf9YMTXxODQQHhOFM7E=
X-Google-Smtp-Source: ABdhPJzASP3kj1WwFRj59AHoxzEoW/i0Pol6y6uOZZn0vcKJYDf6Ut/Hmeg85HPLINAQwIGg9g6nOw==
X-Received: by 2002:a63:1d18:: with SMTP id d24mr8996301pgd.402.1617898362991;
        Thu, 08 Apr 2021 09:12:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:7ef5:d4a7:50dd:fa70? ([2601:647:4000:d7:7ef5:d4a7:50dd:fa70])
        by smtp.gmail.com with ESMTPSA id e7sm24430602pfc.88.2021.04.08.09.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 09:12:42 -0700 (PDT)
Subject: Re: [PATCH v6 2/5] blk-mq: Introduce atomic variants of
 blk_mq_(all_tag|tagset_busy)_iter
To:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Khazhy Kumykov <khazhy@google.com>
References: <20210406214905.21622-1-bvanassche@acm.org>
 <20210406214905.21622-3-bvanassche@acm.org>
 <31402243-57ca-8fa5-473a-d5ce20774c50@huawei.com>
 <1610af81-ce46-26c4-5aae-d84aba5cf1f5@acm.org>
 <14be9975-fbd1-796a-e44e-3342c5a330fb@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9774f2c5-0d76-59b4-c272-22a627c1ed84@acm.org>
Date:   Thu, 8 Apr 2021 09:12:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <14be9975-fbd1-796a-e44e-3342c5a330fb@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/21 5:48 AM, John Garry wrote:
> The following does not look atomic safe with the mutex usage:
> drivers/block/nbd.c:819:        blk_mq_tagset_busy_iter(&nbd->tag_set,
> nbd_clear_req, NULL);
> 
> static bool nbd_clear_req(struct request *req, void *data, bool reserved)
> {
>     struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
> 
>     mutex_lock(&cmd->lock);
>     cmd->status = BLK_STS_IOERR;
>     mutex_unlock(&cmd->lock);
> 
>     blk_mq_complete_request(req);
>     return true;
> }
> 
> But blk_mq_tagset_busy_iter() uses BT_TAG_ITER_MAY sleep flag in your
> series.

I will mention the nbd driver in the commit message.

> As for the fc, I am not sure. I assume that you would know more about
> this. My concern is
> 
> __nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
> {
> ...
> 
>     ctrl->lport->ops->fcp_abort(&ctrl->lport->localport, ..);
> }
> 
> Looking at many instances of fcp_abort callback, they look atomic safe
> from general high usage of spinlock, but I am not certain. They are
> quite complex.
I have not tried to analyze whether or not it is safe to call
__nvme_fc_abort_op() from an atomic context. Instead I analyzed the
contexts from which this function is called, namely the
blk_mq_tagset_busy_iter() calls in __nvme_fc_abort_outstanding_ios() and
__nvme_fc_abort_outstanding_ios(). Both blk_mq_tagset_busy_iter() calls
are followed by a call to a function that may sleep. Hence it is safe to
sleep inside the blk_mq_tagset_busy_iter() calls from the nvme_fc code.
I have not tried to analyze whether it would be safe to change these
blk_mq_tagset_busy_iter() calls into blk_mq_tagset_busy_iter_atomic()
calls. Does this answer your question?

Bart.
