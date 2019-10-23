Return-Path: <SRS0=PMby=YQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BADCCA9EB9
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 20:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5599821872
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 20:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390466AbfJWU62 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 16:58:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40685 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390216AbfJWU62 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 16:58:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so10687678pll.7
        for <linux-block@vger.kernel.org>; Wed, 23 Oct 2019 13:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BKRwRi9tPLwg3RgFfY2oh+nSqWzl+lDrw7gx3JS9hgM=;
        b=abhmoBdqpGm5MPqjsYyhRefGfOgm+IJDiQNb8vCQ2ct8ETrDTj0WTyiJO9tt5MmGWl
         3xeSmkRZQIurlvaVSYWwB1uz5nQegcwClkoIh1AJyrNZ6223nrjxvgca7Z0BbF7uCjaE
         pjd6vXN5p4xzK1DH3n316O5KBCQW/0aXcGbOaNSD/EoHtrmooRMmyH2O5gz1wrYkZUog
         RNaFpcOt3Dp9QpFDYiW5VV42YfA7669Y1ybadwn7z3aA8t8hSx9pVIPMlYq0cUx8FVal
         Oye2LSsA5/lSwhL5fBc48XCYeMHers5bCiigBsbBWjoYnQFp59DccGo5fy2qkuNhkiSI
         Pl9A==
X-Gm-Message-State: APjAAAXRVgKR/V/mtAh0Xj85DT34hPGjbrtsFp+FYRVuEQMiQ1lkFI5L
        3CgnYMJG5ESiFAr7XWwcGq0=
X-Google-Smtp-Source: APXvYqw9XooQrp/+kKu51YTMDPCUcCTkTalwzKgnNka3A/RGXyYMAfryqSA0DvY/JzivnLNdt6olLw==
X-Received: by 2002:a17:902:a987:: with SMTP id bh7mr11559373plb.181.1571864307003;
        Wed, 23 Oct 2019 13:58:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:c3:e5ef:65f1:8f3f:3a78])
        by smtp.gmail.com with ESMTPSA id j17sm22736006pfr.70.2019.10.23.13.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 13:58:25 -0700 (PDT)
Subject: Re: [PATCH 2/4] block: Fix a race between blk_poll() and
 blk_mq_update_nr_hw_queues()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20191021224259.209542-1-bvanassche@acm.org>
 <20191021224259.209542-3-bvanassche@acm.org>
 <20191022094154.GB9037@ming.t460p>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <322f024f-6756-aa29-28ac-a17aa8499279@acm.org>
Date:   Wed, 23 Oct 2019 13:58:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191022094154.GB9037@ming.t460p>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-10-22 02:41, Ming Lei wrote:
> On Mon, Oct 21, 2019 at 03:42:57PM -0700, Bart Van Assche wrote:
>> +int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
>> +{
>> +	int ret;
>> +
>> +	if (!percpu_ref_tryget(&q->q_usage_counter))
>> +		return 0;
>> +	ret = __blk_poll(q, cookie, spin);
>> +	blk_queue_exit(q);
>> +
>> +	return ret;
>> +}
> 
> IMO, this change isn't required. Caller of blk_poll is supposed to
> hold refcount of the request queue, then the related hctx data structure
> won't go away. When the hctx is in transient state, there can't be IO
> to be polled, and it is safe to call into IO path.
> 
> BTW, .poll is absolutely the fast path, we should be careful to add code
> in this path.

Hi Ming,

I'm not sure whether all blk_poll() callers really hold a refcount on
the request queue. Anyway, I will convert this code change into a
comment that explains that blk_poll() callers must hold a request queue
reference.

Bart.
