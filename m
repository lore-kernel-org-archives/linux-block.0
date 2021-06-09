Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE1FC48BCF
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 16:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4A5613CB
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 16:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhFIQu5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 12:50:57 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:36601 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhFIQu4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 12:50:56 -0400
Received: by mail-pg1-f174.google.com with SMTP id 27so19976411pgy.3
        for <linux-block@vger.kernel.org>; Wed, 09 Jun 2021 09:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RIUHYBL0iS/fQGaq+Gpqnh2rKlcwfYTghmItuHEbiqI=;
        b=ECEtV+lFxqBNdw6qo1L9AAoPaiAFs08hXC6G8qdLubXceyaGq4szxH12NlZxk4MLLP
         6hbGZOqsK7YQfrgPzF4WB78hA+gj8XbOOdH/HnmXns59MYLxRRIo4u3Qy4rBa+BjrDKd
         mXfdTBYMSXQQaAVsAy6jAKQPZhzkB3LwQEymn6CW9ZikBoUcNmXWjJZYTvCA2Beh1pUi
         W/xLelvtDwVF6vtNnPrjm0NyugKKm6jC0CamTvQeWvfFw845Muxz+OZRBt1BI9srIBKy
         eRzMmGCFKer0MhYq+rGwY2obM/Kt4ili+B2Nm9W5v05nENjacc/d5sqYGjwMon25s47c
         iQhw==
X-Gm-Message-State: AOAM530AQNADjfqt6dhNJT0HgkasBFn5ZBvWkflCSBslSKpiEhU+pDk7
        ahF9anvkN1qGaAwJ3OcPq9mr52gINM0=
X-Google-Smtp-Source: ABdhPJzK+a3cs2I5z8Bvpes0a1igthl8SwkNncX05Wu+vv2UHiQ206S2j/SC1Dg5v1jr4HN1a1HULg==
X-Received: by 2002:a63:1022:: with SMTP id f34mr610725pgl.334.1623257341786;
        Wed, 09 Jun 2021 09:49:01 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id u12sm154299pfm.2.2021.06.09.09.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 09:49:01 -0700 (PDT)
Subject: Re: [PATCH 04/14] block: Introduce the ioprio rq-qos policy
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-5-bvanassche@acm.org>
 <DM6PR04MB708135D0C71D2042E6674E23E7369@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <98dbb3dc-d925-f2a8-7f34-94f9c56bb257@acm.org>
Date:   Wed, 9 Jun 2021 09:48:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB708135D0C71D2042E6674E23E7369@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/8/21 9:40 PM, Damien Le Moal wrote:
> On 2021/06/09 8:07, Bart Van Assche wrote:

[ ... ]

>> +/*
>> + * The accepted I/O priority values are 0..IOPRIO_CLASS_MAX(3). 0 (default)
>> + * means do not modify the I/O priority. Values 1..3 are used to restrict the
>> + * I/O priority for a cgroup to the specified priority. See also
>> + * <linux/ioprio.h>.
>> + */
>> +#define IOPRIO_CLASS_MAX IOPRIO_CLASS_IDLE

[ ... ]

>> +static int ioprio_set_prio_class(struct cgroup_subsys_state *css,
>> +				 struct cftype *cft, u64 val)
>> +{
>> +	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_css(css);
>> +
>> +	if (val > IOPRIO_CLASS_MAX)
>> +		return -EINVAL;
> 
> Where is IOPRIO_CLASS_MAX defined ? I do not see it.

Near the start of the new block/blk-ioprio.c file.

> Why not use ioprio_valid() ?

The definition of that macro is as follows:

#define ioprio_valid(mask)	\
	(IOPRIO_PRIO_CLASS((mask)) != IOPRIO_CLASS_NONE)

So that macro accepts I/O priority classes 1..7 while the above code
accepts I/O priority classes 0..3. I think that ioprio_set_prio_class()
should only accept I/O priority class values 0..3.

Thanks,

Bart.
