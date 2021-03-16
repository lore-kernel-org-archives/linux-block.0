Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59C3C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 20:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982A864F3A
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 20:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbhCPT7h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 15:59:37 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:38760 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240749AbhCPT7L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 15:59:11 -0400
Received: by mail-pg1-f181.google.com with SMTP id q5so10679097pgk.5;
        Tue, 16 Mar 2021 12:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bIjRiGnFrYHkFcEHXQt5l/9DSGp09S2kwPNNdRwhwR8=;
        b=bSubJX+xvJPgvcc6mPZX6nH2PuWLy1b9X44MijG9eyEpnS6u/pxopkX5rbNiGxKsVH
         Vxb+P/lulxYZZSGK02KXO5v5+eY1eb6kL/zcm+jBKRBjABav5hloSTW4O3Bv9NiBp0T0
         vbaOID9f4H21kUKzEy6lSDrtAI8Y2TN5VVE4tT4dzNfZprFh68DYOqDn7uDy8gxc6ZED
         4Qze+sZ9FrGM4fOpwJkifddufd28oIWX8N4wQPTgQbFgNG/JGFabd8bPnTpvgwbRnwdp
         K1tQAQKskVkwBbeHuW8vPkc/ricmvoqamshId+IG/Xs4JgsTGLi1ZIzecs4DRIPFHV7f
         mTcA==
X-Gm-Message-State: AOAM5325wEmQ4WLO1v/Y75+zaCteH/07ukNH4zwAn/Jnjm5d112jC1fy
        RVdVBwPQ4kgMQPekGnYsv+o=
X-Google-Smtp-Source: ABdhPJxp+sMkrer89yUTnvvQwpWiTy3UEsuARjy21EPOXD0pAGtydfJ1R8I84yDDLPcnOWD4+1OIYQ==
X-Received: by 2002:a62:6045:0:b029:20c:b6a6:6077 with SMTP id u66-20020a6260450000b029020cb6a66077mr954227pfb.51.1615924750631;
        Tue, 16 Mar 2021 12:59:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:b6b5:afbd:6ae4:8f83? ([2601:647:4000:d7:b6b5:afbd:6ae4:8f83])
        by smtp.gmail.com with ESMTPSA id z9sm16598496pgs.32.2021.03.16.12.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 12:59:09 -0700 (PDT)
Subject: Re: [RFC PATCH v3 2/3] blk-mq: Freeze and quiesce all queues for
 tagset in elevator_exit()
To:     John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>
Cc:     "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pragalla@codeaurora.org" <pragalla@codeaurora.org>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>,
        yuyufen <yuyufen@huawei.com>
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-3-git-send-email-john.garry@huawei.com>
 <YElrSFGyim3rjDN+@T590> <8c6c6783-6152-2332-2f50-14c409e40320@huawei.com>
 <2b0c66ba-03b3-844c-1684-f8e80d11cdbb@acm.org>
 <4ffaba53-100a-43a5-8746-b753d4153be5@huawei.com>
 <fff92b15-d483-ad6a-bb01-ef61117b7cbd@acm.org>
 <82526e78-66e5-fc3c-7acd-38f1813ebe1e@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e0906b2e-6a2b-ce34-84a1-36eaddbb824d@acm.org>
Date:   Tue, 16 Mar 2021 12:59:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <82526e78-66e5-fc3c-7acd-38f1813ebe1e@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/16/21 10:43 AM, John Garry wrote:
> On 16/03/2021 17:00, Bart Van Assche wrote:
>> I agree that Jens asked at the end of 2018 not to touch the fast path
>> to fix this use-after-free (maybe that request has been repeated more
>> recently). If Jens or anyone else feels strongly about not clearing
>> hctx->tags->rqs[rq->tag] from the fast path then I will make that change. 
> 
> Is that possible for this same approach? I need to check the code more..

If the fast path should not be modified, I'm considering to borrow patch
1/3 from your patch series and to add an rcu_barrier() between the code
that clears the request pointers and that frees the scheduler requests.

> And don't we still have the problem that some iter callbacks may
> sleep/block, which is not allowed in an RCU read-side critical section?

Thanks for having brought this up. Since none of the functions that
iterate over requests should be called from the hot path of a block
driver, I think that we can use srcu_read_(un|)lock() inside bt_iter()
and bt_tags_iter() instead of rcu_read_(un|)lock().

Bart.
