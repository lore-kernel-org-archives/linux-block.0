Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF38C4338F
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 19:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F5D61038
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 19:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhHLTXv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 15:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhHLTXu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 15:23:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393F3C061756
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 12:23:24 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e15so8583777plh.8
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 12:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pxeqgUWjVM1hs4EngNxyyNmaNPEZ37MX1im5haIjJVU=;
        b=L+A5OIPg1SlHNaW2T35zzz09rgdDtGMLhtUuhtyDg34yAwVutTzpZkJWbb9LH4Ss+I
         6EsOBelwfPAqfClY3Tgd+iEyYehXDA6iYWOmOzOPjY8+L3gxnDGzP4YRldbCKGsUVwzT
         cdVoheFcrIpHuDY1MA9w9U1Yg+9obr7x3hrj4oV4Oo+ngtRhXBBjfCU2iPpsI2n2RECx
         A1tJZVJ8i1WSHXZ7c7sMxRc7YnP/L6qva2Wivp4cFVg9ni/AEqgbpQjqqrvJFjyYaNum
         Bm+M07VCqGZFk7qiHXkr+hSRdmFlprhhve7GAmVY1TXbRzll4M8H1c2m0RsSWc4QCkRM
         ilqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pxeqgUWjVM1hs4EngNxyyNmaNPEZ37MX1im5haIjJVU=;
        b=RphQUmf+Y/X88i6hrhQfmtkEl/nKor6rNYjzWtWT7QXEmJ3shA6AqzDdQ8ww7lOl5U
         5XJiXS5UVmH1aoPJTtr37xjl95viIUPE0huN9DUwFD71q94Rq9xpHdppGCIUUeQn3D91
         igwe45G0LgrizHQ3BwUvWEHrCTjZoyUjmTOHitXzYimrSiBeFDLUqFc+ItsL4aDCn3jt
         uZWlaz0XNkl9BCGUm9nZaky+jrtAxlQeAdKaMvfpJCrZ2BXO9LBdZhr6YE70dUKHdsat
         n4+60oRqZVPiFkfkFj2L4CE/nJkM5msqR9ncLrB/QzJHL43ac1CDDJ0lyUr8uitFZT2U
         5a0A==
X-Gm-Message-State: AOAM5334YrwvtPkUlrYrUZ6YkCNtXAl0IIMeWomgY5wqFNZ6ptWnIgjN
        0q0iEVqwXtW4E+Lf9lmXxSk=
X-Google-Smtp-Source: ABdhPJyknNeKtifedooO6c3whxKRp1wVEp/YNO5O+COqR6iokpXWzj91oRs2BL3BJegtZ0/NBOIBUg==
X-Received: by 2002:a17:902:ac97:b029:12d:4ce1:ce4d with SMTP id h23-20020a170902ac97b029012d4ce1ce4dmr4727462plr.74.1628796203653;
        Thu, 12 Aug 2021 12:23:23 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:90ad])
        by smtp.gmail.com with ESMTPSA id qe3sm10630208pjb.21.2021.08.12.12.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 12:23:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Aug 2021 09:23:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup support"
Message-ID: <YRV1JkkxozEb4YO6@mtj.duckdns.org>
References: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
 <035f8334-3b69-667d-be91-92dcab9dc887@acm.org>
 <YRQhlPBqAlkJdowG@mtj.duckdns.org>
 <00e13a7b-6009-a9d7-41ba-aae82f5813de@acm.org>
 <YRVfmWnOyPYl/okx@mtj.duckdns.org>
 <631e7e18-52ca-9bec-0150-bac755e0ff24@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <631e7e18-52ca-9bec-0150-bac755e0ff24@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Thu, Aug 12, 2021 at 11:16:37AM -0700, Bart Van Assche wrote:
> Are you perhaps referring to the iocost and iolatency cgroup controllers? Is

and blk-throtl

> it ever useful to combine these controllers with the ioprio controller? The

So, I used controller as in cgroup IO controller, something which can
distribute IO resources hierarchically according to either weights or
limits. In that sense, there is no such thing as an ioprio controller.

> ioprio controller was introduced with the goal to provide the information to
> the storage controller about which I/O request to handle first. My

My experience has been that this isn't all that useful for generic IO
control scenarios involving cgroups. The configuration is too flexible
and granular to map to hardware priorities and there are way more
significant factors than how a controller manages its iternal ordering
on most commodity SSDs. For situations where such feature is useful,
cgroup might be able to help with tagging the associated priorities
but I don't think there's much beyond that and I have a hard time
seeing why the existing ioprio interface wouldn't be enough.

> understanding of the iocost and iolatency controllers is that these cgroup
> controllers decide in which order to process I/O requests. Neither
> controller has the last word over I/O order if the queue depth is larger
> than one, something that is essential to achieve reasonable performance.

Well, whoever owns the queue can control the latencies and it isn't
difficult to mess up while issuing one command at a time, so if the
strategy is stuffing device queue as much as possible and telling the
device what to do, the end result is gonna be pretty sad.

Thanks.

-- 
tejun
