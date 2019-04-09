Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0FCC282DA
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 13:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FB42084C
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 13:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfDINvz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:51:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38808 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDINvz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 09:51:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id f36so4969926plb.5;
        Tue, 09 Apr 2019 06:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SCidl0ShTZTmmr2d4YPh3KjkANWqBwxXpacidV7HU18=;
        b=HhCFIWnEC9BClNJlCaSU3ePUEWNkhOKTfnr5zLxPqw4P5kMnktmhwBNsX09T8mpvlV
         RSt1JDzL8harwbfc8NO3RTfSmTD/h74mTnMziqjVo4LPzglYW1EX8aqwTWUwMmBmyKa0
         IGi6OJzDKAG+BJISkmsdxATrDU0n3XCg+2wqciQuFDXfNj0j4++7GySJTTHZtQbiBQZa
         Dx5FuE6un0kM5URv5ME6re7eXF6V9JgRYoZVcQ1IBj6GQK90qc16qSU3CvANHyjsPLQ9
         BQ4CtNzcDbsvxIug0W8MdBhRiE9p7/IBCWr++BGAdCgVout71tWDsmzGbYvAUk4v01wO
         KgMQ==
X-Gm-Message-State: APjAAAUfpo/HE0xId7AoolsQ64v5SS13srnt/Zfjb7bYY0fvMh2bUP7H
        ODud/HxHySDcqy/6DS4AZ5jUe8oO9qg=
X-Google-Smtp-Source: APXvYqwA5twtqp5e+ljk86BNTg5IAq0k+UOmKcg2YC84m3XN75I1p+5DY/wI0w0imi3tsr2mVc1sAA==
X-Received: by 2002:a17:902:e4:: with SMTP id a91mr18984539pla.2.1554817914853;
        Tue, 09 Apr 2019 06:51:54 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id q87sm50952507pfa.133.2019.04.09.06.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 06:51:54 -0700 (PDT)
Subject: Re: [PATCH] block: Revert v5.0 blk_mq_request_issue_directly()
 changes
To:     Stewart Smith <stewart@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>
References: <20190404170843.83517-1-bvanassche@acm.org>
 <87y34jwykf.fsf@linux.vnet.ibm.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <17e00997-fd0c-686c-1c0d-f57fff8e52ea@acm.org>
Date:   Tue, 9 Apr 2019 06:51:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87y34jwykf.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/19 10:13 PM, Stewart Smith wrote:
> At least when this patch is cherry-picked back on top of 5.0.7, it
> doesn't seem to fully fix the problem for us (which is ppc64le). We hit
> this at some point while eudev is finding disks and we have a process
> mounting them to see what's there:
> 
> cpu 0x4a: Vector: 400 (Instruction Access) at [c000203ff398b100]
>      pc: c0000000021fe700
>      lr: c0000000002001d8: blk_mq_complete_request+0x34/0x138
>      sp: c000203ff398b390
>     msr: 9000000010009033
>    current = 0xc000203ff3901b00
>    paca    = 0xc000203fff7f3680	 irqmask: 0x03	 irq_happened: 0x01
>      pid   = 658, comm = kworker/u257:2
> Linux version 5.0.7-openpower1 (hostboot@gfw275.aus.stglabs.ibm.com) (gcc version 6.5.0 (Buildroot 2019.02.1-00016-ge01dcd0)) #2 SMP Mon Apr 8 09:14:53 CDT 2019

Can you bisect this crash?

Thanks,

Bart.
