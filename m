Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF8DC47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 17:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4F3613FF
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 17:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhFJRQa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 13:16:30 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:40542 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJRQ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 13:16:29 -0400
Received: by mail-pf1-f176.google.com with SMTP id q25so2169538pfh.7
        for <linux-block@vger.kernel.org>; Thu, 10 Jun 2021 10:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RVRDy4Ag34bTGESyVa6c7a3MXd/OmXbJWdxWkgg80BE=;
        b=XjA3XkY0F3LGniQ0XwPEJKMi69Zvu6xFzLUm5Ax6+PZD1x1lH4ZZyoVUPIVErpUJRm
         92JABQoRnfkBp2eWolvVUS5FlwNUguLkuByQVq57FHl0Ra3pQgJz+AFALrTlp17J9cpk
         egm49Glce7hCyyZSY9Dv2Cw0kFaARSgDhh7sJ6cc93+i/fF1XXhLQ7gcmqqfzd91tQGQ
         dEJcly2hf5XEbL/iZlte8c2/6DfuMivih79BQ6KUs/qEEigUYfVU/CfXLS/ig4LT73cP
         XERpQCHOfiFhAxaLCZuNM4ph0wfjvU2RWdIS0BLdtEr2edmYPFVQ+uVaQ3A+FGq+bJWH
         NT4w==
X-Gm-Message-State: AOAM532j5Vzas30ecDOqWnXIX/aN3xqfgs7jv9sPl1GummQKCFhaVPs6
        aEEVUKxZxX5NFjf3J99GlHg=
X-Google-Smtp-Source: ABdhPJxx4nLpCiuJpBkAgbC/rMVG5Q2vhHUT6jmpts4xEmla8bj9IEL3wdBIJhepUFsN58JIhKT6cA==
X-Received: by 2002:a63:5e47:: with SMTP id s68mr5926124pgb.381.1623345262970;
        Thu, 10 Jun 2021 10:14:22 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id 23sm3031325pjw.28.2021.06.10.10.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 10:14:22 -0700 (PDT)
Subject: Re: [PATCH 04/14] block: Introduce the ioprio rq-qos policy
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-5-bvanassche@acm.org>
 <d68c5b3d-362f-08e0-180e-bfc59b4a9d07@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <1ffd5799-ac6d-5ed8-c0aa-e2481e05de32@acm.org>
Date:   Thu, 10 Jun 2021 10:14:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <d68c5b3d-362f-08e0-180e-bfc59b4a9d07@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 11:20 PM, Hannes Reinecke wrote:
> On 6/9/21 1:06 AM, Bart Van Assche wrote:
>> +static void blkcg_ioprio_track(struct rq_qos *rqos, struct request *rq,
>> +			       struct bio *bio)
>> +{
>> +	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_bio(bio);
>> +
>> +	/*
>> +	 * Except for IOPRIO_CLASS_NONE, higher I/O priority numbers
>> +	 * correspond to a lower priority. Hence, the max_t() below selects
>> +	 * the lower priority of bi_ioprio and the cgroup I/O priority class.
>> +	 * If the cgroup priority has been set to IOPRIO_CLASS_NONE == 0, the
>> +	 * bio I/O priority is not modified. If the bio I/O priority equals
>> +	 * IOPRIO_CLASS_NONE, the cgroup I/O priority is assigned to the bio.
>> +	 */
>> +	bio->bi_ioprio = max_t(u16, bio->bi_ioprio,
>> +			       IOPRIO_PRIO_VALUE(blkcg->prio_class, 0));
>> +}
> 
> Sheesh. Now that is cheeky.
> First defining a (conceptually) complex policy setting (where people
> wonder where these policies came from), which then devolve into a simple
> max() setting of the priority value.
> This _really_ could do with a better explanation in the documentation,
> as then it's far easier to understand _why_ certain policies override
> others.
> IE this comment belongs in the documentation, as explanation of the
> underlying mechanics of the ioprio policies.

Hi Hannes,

blkcg_ioprio_track() is called from the hot path so I want this function
to be fast. Since the desired behavior can be implemented with a max() I
chose max() instead of e.g. using a lookup table.

I will address your comments about the documentation and the code.

Bart.
