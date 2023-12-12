Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE9AAA
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 14:44:32 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1f03d9ad89fso4339591fac.1
        for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 14:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702421072; x=1703025872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7/oTSpmKdjc0fK8EYaZmNOw//rjlseoS5KdjcbsqNc=;
        b=f2NvRfLCHVkRHMOHntAXr6AC3utfxTudPtgf7DbIODrDZiub09NbCJJwQdpnW4l73b
         eAIeQrnufAVa1NwV8W5948T/Xc01AR3zHInP41yY0cBDRaFxCDouHqVvDvVUZ3NGdtHX
         Fggg4nX6hyUVyRy0CpJboD3Ao9KZFl4kSz9qKmDrIS8DgQ7QksWim0HWA0FOJ9pSZlf1
         ogRniqe1rMsVXoGgoWTO5/irXpUmAowPt64ybUrm8zuPlpEZTCn5VmNKyeS1U0Pawpxv
         AeasNUlQe6nMybPaLWGAc7QMzgwt984IJ5AfVR45KFNKDas6bwiXRdjGdlgS80juu7Xd
         CmMw==
X-Gm-Message-State: AOJu0Ywd/x+D6KPIjynln7eSc9xmwNcH1gNMT1og+MIItXb1mNV+Jfk/
	Cgz8sRzQqmCLQUXr/0g74ItDxV0ooo0=
X-Google-Smtp-Source: AGHT+IFD4UMkFaBgIOH2Xb/zLAG3RVa/Iscx+IbZH0ohg+Dj3V8KxOVtHQiWhw8JzQTcdtZuIDRz0g==
X-Received: by 2002:a05:6870:b012:b0:1fb:75a:6d26 with SMTP id y18-20020a056870b01200b001fb075a6d26mr8728462oae.77.1702421071997;
        Tue, 12 Dec 2023 14:44:31 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:4cb1:76fa:137e:ca8? ([2620:0:1000:8411:4cb1:76fa:137e:ca8])
        by smtp.gmail.com with ESMTPSA id pt8-20020a17090b3d0800b002839679c23dsm9676483pjb.13.2023.12.12.14.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 14:44:31 -0800 (PST)
Message-ID: <8998e3cd-6bf1-4199-9e21-60fdfba37571@acm.org>
Date: Tue, 12 Dec 2023 14:44:30 -0800
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
 <e8d383c8-2274-4afa-9beb-a38c9f56127b@acm.org>
 <deee82e3-ccc4-42d7-bb54-9f4d1cd886b0@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <deee82e3-ccc4-42d7-bb54-9f4d1cd886b0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/23 23:40, Damien Le Moal wrote:
> On 12/9/23 03:40, Bart Van Assche wrote:
>> My understanding is that blkcg_set_ioprio() is called from inside submit_bio()
>> and hence that the reported issue cannot be solved by modifying F2FS. How about
>> modifying the blk-ioprio policy such that it ignores zoned writes?
> 
> I do not see a better solution than that at the moment. So yes, let's do that.
> But please add a big comment in the code explaining why we ignore zoned writes.

Hi Damien,

We tested a patch for the blk-ioprio cgroup policy that makes it skip zoned writes.
We noticed that such a patch is not sufficient to prevent unaligned write errors
because some tasks have been assigned an I/O priority via the ionice command
(ioprio_set() system call). I think it would be wrong to skip the assignment of an
I/O priority for zoned writes in all code that can set an I/O priority. Since the
root cause of this issue is the inability of the mq-deadline I/O scheduler to
preserve the order for zoned writes with different I/O priorities, I think this
issue should be fixed in the mq-deadline I/O scheduler.

Thanks,

Bart.



