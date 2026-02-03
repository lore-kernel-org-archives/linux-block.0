Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2923921F7
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129985; cv=none; b=VC8d8M8a1+OivJFhoaF6WN76TcYMfWKt8zSMk7w0hTvsZO57ryRcrscQf/BXb3o/ojV2ud+oVlGvdKUMKHh7uL38QffofPS/gq7BtHsnIQVwJmhhrg4atY/OyIGCJkDEOiJiyi0xTltU6fUnYRIbeolz9eRrGmOR7C8tvisQW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129985; c=relaxed/simple;
	bh=MAFQ5WMv7g5W0wOxe78cTJkvFbcpcxg6XzjQZ0plQGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyQP9GTp9G5Kr5FN4gG+huMSxhI+LlDbPUEHp6TklIkdLstSfoAcowWrVJemCnx72N9MS1ISj7nzWt/6R+TISjua8B+h512pCqIrihl5i+xSX68MrawruVsiBwPjiYV0IocBMjRQzYT0/jHNESRiYSZz9w/7sL5XRVJtRWxlhK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Us9E4mi9; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Us9E4mi9"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45c9fdf2a06so3817987b6e.2
        for <linux-block@vger.kernel.org>; Tue, 03 Feb 2026 06:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770129982; x=1770734782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8h3ESOfLmEqhgP4IZ+IYjjxYQsHrPxJrChAZKxI144=;
        b=Us9E4mi9jFMoqA0S8SMHFYNTZvhJeod7qw08PIuv185rTJHlmuqBPqZO/ZLoTOVKRt
         F+EL0Rxp4FdF3QhOusGdCE05bQQKLoRDGm39ALJiU1TIfRrs5ccnRErwaXeYqG2FZ3Xy
         sSsj1YHrXgv9nlgazkLCA6XJbFcwzOCK2DWuzkvoN3VMPSyLMYIygwxDNoUT8oLP6zIm
         nR1y6+Km4txn1UVchrf/LLhF5Ejck89FYcjBdEc6LUF7kIO47zAWiKw25tUzZnWh0yUc
         MUSlXwyvDN7eqydGAnyId5VQ9Vk+fQWQ5MqycdOBM/oAkCnrVPmf3KMt1ndMWxY5skLp
         KYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129982; x=1770734782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8h3ESOfLmEqhgP4IZ+IYjjxYQsHrPxJrChAZKxI144=;
        b=I5S5mkCkb97CmEGdyqjrnFwdcifz2mkeQfJrWQKJDyhKxrKriYkyFVPCPz+eN8fnpI
         LiaMhbIO1nALoEfcf+zK5sriOBUJ2SecFsijwTu5s6Y6WKSbcHW9C5u7l5Gn2RFzAm74
         PI4T/Pux5jhSXEtmdPXqmSEB753uLRdylilXFNSvSNhgjXQQdiPGg3FtCDBNMI9dg/x0
         bf2wcVdGrYCwlWezXshG8+JdgclQOwjMqijTNQfIZIUxXT+nhzl9BbttN+Bxt9pMSzos
         2ObH0VGP8YD5dPCcnvceyLBAiMMmsvL0+UYLOJdTEhu5f6GGmOQG+P+GEPokHdJAmM++
         rJrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDWongX6YfHggTNIgbi92Y2958JdZ9Sxm12kJ4guQ6LS+lM3mh+Jl2QfqPfQg3Coeh2k/Y9eoavAAciA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ZLoXUXH8U722wgLDgaE3dd9UsLMHA6v6h5PD3fG8gmvPLAHp
	BBHm3Eh0lRVgUKn4KYyrNSHL4YaY0pH+l1vrP7e0GgWekbr/NIFgz/65SfDO2oqgoJM=
X-Gm-Gg: AZuq6aIuVJAlsXhU/QAlFW18WEatkHgIGACKiukgFLYrJi038Wd5A0jAOPHkuZpKToO
	1BJil7ePI6Sm157PrViGLtr6TtgJX1YOf2x59RZ/9abf2+CdrfjBC8getG8itNnbJmOXCR1CLnu
	JiAChFVjg9i6s8porsjQFPLFj5si3jhcg/1xGY8gKYcsGOQEOsLIxKtXHD6hRiDeOOZ9TxJqU3V
	L3Yabpll5nJLu4ksgncbksFRns3qbGc9hprHAgwI+PlpATmC6P5msz3mILg76dIWqw91r5m40Mr
	oAMMIyC4wsivX1f98zs1XOXIYIZjOk6p6n/urzVi7AaoNRBGF8ZY0vpzfaZrV3tXmYaL58HFb1k
	tNHrfGwSas9kDH+HufsvSw7Taa+Z0VNPhxhLpA8FWvNw40vwRW29KMXCW6ZFxq8PLjx6Tfx2dLq
	kYmBF0MUJbpo5FiU7DPYtxx0B1/6WVXc2wFyZHQV3LU5IF9Gu0VQEWHuZA1vDeCv57KUyL0g==
X-Received: by 2002:a05:6808:1596:b0:459:a26c:2c3c with SMTP id 5614622812f47-45f34b9d012mr7359494b6e.26.1770129982125;
        Tue, 03 Feb 2026 06:46:22 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08f20e38sm11231499b6e.10.2026.02.03.06.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 06:46:21 -0800 (PST)
Message-ID: <00babfab-5bd7-4b66-a765-f7c6689543c7@kernel.dk>
Date: Tue, 3 Feb 2026 07:46:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 __blkcg_rstat_flush
To: Ming Lei <ming.lei@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: =?UTF-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>,
 syzkaller@googlegroups.com, tj@kernel.org, josef@toxicpanda.com,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai@fnnas.com
References: <CAHPqNmwT9oRpem3J3erS_W0uSQND47LGGSBsNxP8E6uSUish1w@mail.gmail.com>
 <aYFlZf9p4cY0rIbc@fedora>
 <ffzrfu62npwacsl3225qqyjbhd6oue3x3rt46l2wcyp5oq4eli@26gvvst6hrmu>
 <aYHXzyRJbzFSohNm@fedora>
 <l55sz3sgogoyniecolvzscjamxqrxlzgk7w7scds3tt42z6atj@nrfvjqg2agib>
 <aYIBR6eeudRUQ9q8@fedora>
 <74zggmy53vzdb2q7sidvasnnlih5d5b4rp6jb6ibpka5zg7z7x@enl7iqw4prji>
 <aYII17gzXXPCTS3p@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aYII17gzXXPCTS3p@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/3/26 7:40 AM, Ming Lei wrote:
> On Tue, Feb 03, 2026 at 03:16:43PM +0100, Michal Koutný wrote:
>> On Tue, Feb 03, 2026 at 10:08:07PM +0800, Ming Lei <ming.lei@redhat.com> wrote:
>>> I can't parse your question, here blkg_release() simply needs to flush
>>> all stats. Why do you talk about preventing new flush? why is it related
>>> with this UAF?
>>
>> What prevents this fix:
>>
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -169,14 +169,6 @@ static void __blkg_release(struct rcu_head *rcu)
>>  #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
>>         WARN_ON(!bio_list_empty(&blkg->async_bios));
>>  #endif
>> -       /*
>> -        * Flush all the non-empty percpu lockless lists before releasing
>> -        * us, given these stat belongs to us.
>> -        *
>> -        * blkg_stat_lock is for serializing blkg stat update
>> -        */
>> -       for_each_possible_cpu(cpu)
>> -               __blkcg_rstat_flush(blkcg, cpu);
>>
>>         /* release the blkcg and parent blkg refs this blkg has been holding */
>>         css_put(&blkg->blkcg->css);
>> @@ -195,6 +187,15 @@ static void blkg_release(struct percpu_ref *ref)
>>  {
>>         struct blkcg_gq *blkg = container_of(ref, struct blkcg_gq, refcnt);
>>
>> +       /*
>> +        * Flush all the non-empty percpu lockless lists before releasing
>> +        * us, given these stat belongs to us.
>> +        *
>> +        * blkg_stat_lock is for serializing blkg stat update
>> +        */
>> +       for_each_possible_cpu(cpu)
>> +               __blkcg_rstat_flush(blkcg, cpu);
>> +
>>         call_rcu(&blkg->rcu_head, __blkg_release);
>>  }
> 
> This one looks more clever, can you send one formal patch?

I'll drop the previous one for now - I didn't really mind it,
but if we can fix it without, then yeah agree that's better.

-- 
Jens Axboe

