Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE91C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 18:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15B42175B
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 18:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfCTSw5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:52:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40914 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfCTSw4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 14:52:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so2438352pgo.7;
        Wed, 20 Mar 2019 11:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o3gjSzDbZy8TGgUbY1hplnA38xjEf5kt0+ATtlYXGkQ=;
        b=IVPkHH2O5SLRqjCt08twRjGdoOmB0CKBBv2/bAxwgEAOi+AN6xtdH9RcJ9JAtVN2It
         zpOqsZYsDpco1w8oPnAA6XQHponiG0lIjJ5vHf7hm5B4wubC/QaMnbtGVh2Twcoj0Aei
         Kg+DdN5CbZ+bE1+eXeK/ZdLVLV0qL5FvShoC3NqUr2VNaXXdKWKhru2uHG1VJ53OFsED
         5tOj6a2P24TQo1pOTKYZnK61LTI0/20KFu/wU25O2Sun1LSsNEdiIBSAtSOHjrP1mku0
         lRSAONB+sX0sbbu8+ELZWH1Su1p6dqF0UknPFXnTYDsJjLIxiuNxyj1wwmCfckPF0AIH
         G5gg==
X-Gm-Message-State: APjAAAW/LLJyQO9JUocr2Ae34tNGVZIEvDWN7KCgtrJDQYWpRutRrcuA
        9KgoACvSgNu5U4KReifLkaNoso9Y
X-Google-Smtp-Source: APXvYqyVtY1KfZxna9aMM3PcNny3diMbUjPRe/DzZiuefUN3g735V+/p8Q3PgJlkLlRnPcvnAm+1lg==
X-Received: by 2002:a63:c242:: with SMTP id l2mr8839587pgg.138.1553107975560;
        Wed, 20 Mar 2019 11:52:55 -0700 (PDT)
Received: from [172.20.40.56] (50-207-206-41-static.hfc.comcastbusiness.net. [50.207.206.41])
        by smtp.gmail.com with ESMTPSA id v2sm4258202pfg.118.2019.03.20.11.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 11:52:54 -0700 (PDT)
Subject: Re: [PATCH 2/8] blk-mq: change the method of iterating busy tags of a
 request_queue
To:     Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, keith.busch@intel.com, jsmart2021@gmail.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-3-git-send-email-jianchao.w.wang@oracle.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bf563d09-c243-5bf5-ab3e-0fa2bd583edd@grimberg.me>
Date:   Wed, 20 Mar 2019 11:52:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552640264-26101-3-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/15/19 1:57 AM, Jianchao Wang wrote:
> tags->rqs[] will not been cleaned when free driver tag and there
> is a window between get driver tag and write tags->rqs[], so we
> may see stale rq in tags->rqs[] which may have been freed, as
> following case,
> blk_mq_get_request         blk_mq_queue_tag_busy_iter
>    -> blk_mq_get_tag
>                               -> bt_for_each
>                                 -> bt_iter
>                                   -> rq = taags->rqs[]
>                                   -> rq->q
>    -> blk_mq_rq_ctx_init
>      -> data->hctx->tags->rqs[rq->tag] = rq;
> 
> To fix this, the blk_mq_queue_tag_busy_iter is changed in this
> patch to use tags->static_rqs[] instead of tags->rqs[]. We have
> to identify whether there is a io scheduler attached to decide
> to use hctx->tags or hctx->sched_tags. And we will try to get a
> non-zero q_usage_counter before that, so it is safe to access
> them. Add 'inflight' parameter to determine to iterate in-flight
> requests or just busy tags. A correction here is that
> part_in_flight should count the busy tags instead of rqs that
> have got driver tags.

IMO, instead of this parameter, add a wrapper like
blk_mq_queue_tag_inflight_iter() or keep the parameter out until
we actually have a user that calls it for busy and not inflight.

Other than that, I think that iterating over static_rqs is a good
solution to the problem described.
