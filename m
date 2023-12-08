Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274EF12E
	for <linux-block@vger.kernel.org>; Fri,  8 Dec 2023 10:40:59 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so18609805ad.1
        for <linux-block@vger.kernel.org>; Fri, 08 Dec 2023 10:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702060858; x=1702665658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvsGteVqkqV679LQCDjr9/8jq2E4Fr7HUCXpQ4D7aXI=;
        b=GErpB52Q+aipvWXBrwTIkvK+Z7KgkAAWnwUYMbu7dOjFjcvSwsB7FmXApbk/aO8ERQ
         dLm98E39npUUjABONM24rr4j1YguXASwwxyISwqCJ0x3s2NaokTY1vDB2T4l02kqF1KJ
         CiltMPvsCEJLxtPErhxDi/ku8PotePrhB/TQ3CIP0yCJLch7IRru9/D1LYkJ2izOtBeU
         XMYmWXgUjZJB7eTkghsM7qlq4SeLa/KAnPg/dtf/pcC0TeL9wr035NCE/t3hhdUL66VZ
         nXmBIffXA18+BMa4rsDZMEza41M7nQFBaFaKZ1pmiqv72uLRi4W7wGV6wdhkgb0QuuUj
         9CXA==
X-Gm-Message-State: AOJu0Yz+5gD49ekf4stjnWGrhD3DxRaM+P5TPHA8IaG8b13ejFr98yDN
	WH4JYu1dQ8ZC2RxSYmarmQU=
X-Google-Smtp-Source: AGHT+IH0J+tytiXjJk3cuc7oJTX8nB/T9r3/i7Mb4ndColI2AO1XiYgigfyIKzZGAogM2BqYYZqQYQ==
X-Received: by 2002:a17:902:704c:b0:1d0:6ffd:f222 with SMTP id h12-20020a170902704c00b001d06ffdf222mr496868plt.120.1702060858388;
        Fri, 08 Dec 2023 10:40:58 -0800 (PST)
Received: from [172.20.2.177] (rrcs-173-197-90-226.west.biz.rr.com. [173.197.90.226])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ecc200b001d05fb4cf3csm2029118plh.62.2023.12.08.10.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 10:40:57 -0800 (PST)
Message-ID: <e8d383c8-2274-4afa-9beb-a38c9f56127b@acm.org>
Date: Fri, 8 Dec 2023 08:40:54 -1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
 <20231205053213.522772-4-bvanassche@acm.org>
 <100ddd75-eef5-44e9-93ff-34e093b19ab7@kernel.org>
 <4d506909-e063-4918-a9d3-e91bfa5a41a3@acm.org>
 <37f3179a-9add-4ee6-9ae9-cf84c1584366@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <37f3179a-9add-4ee6-9ae9-cf84c1584366@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/7/23 17:37, Damien Le Moal wrote:
> On 12/8/23 09:03, Bart Van Assche wrote:
>> +static bool dd_use_io_priority(struct deadline_data *dd, enum req_op op)
>> +{
>> +	return dd->prio_aging_expire != 0 && !op_needs_zoned_write_locking(op);
>> +}
> 
> Hard NACK on this. The reason is that this will disable IO priority also for
> sensible use cases that use libaio/io_uring with direct IOs, with an application
> that does the right thing for writes, namely assigning the same priority for all
> writes to a zone. There are some use cases like this in production.
> 
> I do understand that there is a problem when IO priorities come from cgroups and
> the user go through a file system. But that should be handled by the file
> system. That is, for f2fs, all writes going to the same zone should have the
> same priority. Otherwise, priority inversion issues will lead to non sequential
> write patterns.
> 
> Ideally, we should indeed have a generic solution for the cgroup case. But it
> seems that for now, the simplest thing to do is to not allow priorities through
> cgroups for writes to zoned devices, unless cgroups is made more intellignet
> about it and manage bio priorities per zone to avoid priority inversion within a
> zone.

Hi Damien,

My understanding is that blkcg_set_ioprio() is called from inside submit_bio()
and hence that the reported issue cannot be solved by modifying F2FS. How about
modifying the blk-ioprio policy such that it ignores zoned writes?

Thanks,

Bart.
