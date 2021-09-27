Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8CAC433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 20:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A0160E8B
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 20:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhI0UFL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:05:11 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:38650 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbhI0UFK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 16:05:10 -0400
Received: by mail-pl1-f174.google.com with SMTP id x4so5059622pln.5
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 13:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j6gtUUny0Nh4sMlSn3rvmdrlqCInxGiZEWc9QNcyy04=;
        b=iZKoP3acEqmyUqnq6dsngnQAG1oCKQU8svnl4I96yYPYx3alt01919XOBWtQ77WXTk
         Vh7290f1QWNzl2ZEs10M7dKerXjF7/Dm8exiWDgXMA3s9J3F1w8dIMUMP3442HA7kC3N
         uURvCuTq5bBYKeTDt+ErJoEASKirI+ZfQHWbVZziBxKQVNyN7DoKlbdG4L62FwNldOu1
         BK/hOMmqCsDtCg3nsFyptxFtaIW+tJUVyQCpn2/NVB59z41k7yQ6PdyWlONST71NNV0e
         P/fEB8kcD5dtShRUL+Ohm+YOw4mh7kK2r17bfGLnUvfwBXv0JEZ6rrDGZXt63rAY+brc
         3WLQ==
X-Gm-Message-State: AOAM531a0se3EuXUsB/+JRh8FYU+LLPvHV1NUjt48NtdwYmQHcuFu5hy
        RR1n14GauseEfmOsBZKJsqo=
X-Google-Smtp-Source: ABdhPJwI5sqrLsPOGDQPQs08/5T57f9IcxjyU2yK8vvevNW6XwAFSa99GbfRyJSZWFM56Jgh5T9vCw==
X-Received: by 2002:a17:902:ac96:b0:13d:f848:cbbe with SMTP id h22-20020a170902ac9600b0013df848cbbemr1583242plr.9.1632773012180;
        Mon, 27 Sep 2021 13:03:32 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:eed8:744a:6ba3:d1b])
        by smtp.gmail.com with ESMTPSA id x12sm13631639pfa.98.2021.09.27.13.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 13:03:31 -0700 (PDT)
Subject: Re: [PATCH 4/4] block/mq-deadline: Prioritize high-priority requests
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
References: <20210923232358.3907118-1-bvanassche@acm.org>
 <20210923232655.3907383-1-bvanassche@acm.org>
 <20210923232655.3907383-4-bvanassche@acm.org>
 <DM6PR04MB708107091FD22BC145EDB340E7A49@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7004e87b-a2f0-34e6-42aa-3a9849024f98@acm.org>
Date:   Mon, 27 Sep 2021 13:03:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB708107091FD22BC145EDB340E7A49@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/24/21 4:08 AM, Damien Le Moal wrote:
> On 2021/09/24 8:27, Bart Van Assche wrote:
>> +/*
>> + * Time after which to dispatch lower priority requests even if higher
>> + * priority requests are pending.
>> + */
>> +static const int aging_expire = 10 * HZ;
> 
> What about calling this prio_starved, to be consistent with writes_starved ?
> Or at least let's call it prio_aging_expire to show that it is for priority
> levels, and not for requests within a priority queue.

The name 'prio_starved' probably would cause confusion since this parameter
represents a timeout while 'writes_starved' represents a count. I will rename
it into prio_aging_expire.

>>   dispatch_request:
>> +	if (started_after(dd, rq, latest_start))
>> +		return NULL;
> 
> Nit: add a blank line here ? (for aesthetic :))

Will do.

>> +/*
>> + * Check whether there are any requests with a deadline that expired more than
>> + * aging_expire jiffies ago.
> 
> Hmm... requests do not have a "deadline", so this is a little hard to
> understand. What about something like this:
> 
> * Check whether there are any requests at a low priority level inserted
> * more than aging_expire jiffies ago.

Agreed, I will clarify this comment.

>> + */
>> +static struct request *dd_dispatch_aged_requests(struct deadline_data *dd,
>> +						 unsigned long now)
> 
> Same remark as for the aging_expire variable: it may be good to have prio in the
> name of this function. Something like:
> 
> dd_dispatch_prio_starved_requests() ?

The name 'aging' has a well-defined meaning so I would like to keep it. See also
https://en.wikipedia.org/wiki/Aging_(scheduling).

>>   	spin_lock(&dd->lock);
> 
> Nit: Add a blank line here to have the spin_lock() stand out ?
> Easier to notice it that way...

The convention in kernel code is a blank line above statements that grab a lock
but not below these statements.

Thanks,

Bart.

