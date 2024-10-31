Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652B4D517;
	Thu, 31 Oct 2024 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364158; cv=none; b=C5Rx59/vsLN146gU4of2b4u9wQd+/6JsptK9opOyvi5COhrMHqea5iov1i+3dMevcdgbxwpWjixvsH3gFw3TnCZJ73gOSyEncHKAeytMRLj/KpAyF7l8Uk7uMkbXD6zHhUW9uqsnvuRQYZnnUmugLus6Y8W1NN4MMAWCcqJhXQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364158; c=relaxed/simple;
	bh=hLH0hxU1o84KEmljJe2JgUdOwU3TJhrOtVK5+9TOQ5o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RuQVutjpLs9A023fIcmEEkQKNvKaSmjpYhwIiIuaaDR1Y6drmt3qNknYlu8T4HnPaHaZRpRFkF2k+Wau5bGw3l0QTqRWWTbSgeM/4IEmjtsMUTG1z+XqH5FUJoc5d65SDbRzanTDlWYE9Hfqo8bpdp09efr4D/GviNb+u5fzsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZqjw+3m; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZqjw+3m"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso646290e87.1;
        Thu, 31 Oct 2024 01:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730364154; x=1730968954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=02iLbC3iTtITjuPbkEliDJUg4GBHOjEBLS/N9zjh8aM=;
        b=iZqjw+3mTJX3XbJsS5OP+sNJc25K+BNUFHnn+L4xXiEAnsJwsK9OIatdMkgpp7/Wc+
         l5QCexHEaAz1JR76NltG7vYaD2/pF3UmcHwLmwktPEu71O8mPbO8fP0IzpHRNjuIilYW
         TnuAmr/V+/Se17CHpLYkIK9CsWGaqzSKnfHujwYPV6848WFbMtS82ejkOIu+GovtJCUk
         +Gi/X8FeM/qj6rPF2gfLmj8mBsJoeVSvwkyjZQSLq4cdlyPvSkSSdWm7nFQnzkpSrITQ
         yT34/6UYhj+UuNQ6HmaAk/Pts592TJrK1a3KoYmO8q0wlDW69PVKBm03a06iYL1SgajH
         RAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730364154; x=1730968954;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02iLbC3iTtITjuPbkEliDJUg4GBHOjEBLS/N9zjh8aM=;
        b=dDEpWy7CIixEICVRRrabIPa0N0OgmAiK5ELyKu26WL7IVN8ubTLO4fCwQuxhRJt71e
         ce1+4wVFLYlqMGO80chQ3NrajpeQ3Thni/l1DPmiuae5ZMOEGMI3he6EWUXf6T/zcBUg
         MT1vujifsZfhpmvzHBOalAh23POMM0DaEgWuMxXnBkXVkMCWQenBoXFD42vvWVmTHiiJ
         CjLDbftZK79HKFFpD9Q7L3uxd9bS0EoVzmPtCR6UqRnBddZJ6V1QntXz39NFjWRhVWfL
         db2iuZMD3f5mC8gVbn93oQJ6tbJehBRENMB57XJfKPoxcCVTKjdfyKRRY/IMwYs6FqpY
         mjUA==
X-Forwarded-Encrypted: i=1; AJvYcCV8rPfMAjC2gVS3f/Cou3HTD+sF2lrnCaar5h4kEQUAs9yMPvXjErBRaan/2nRXVd04tPi6YbSFxWprmkcE@vger.kernel.org, AJvYcCXHqhuWb4akWrdJCJJquyNhCIYa/iyy9xCJP2ADOEouMMCMq7FXGpvcpvaGnPtuFdJ6ocSoGWtJzm0vtg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdn8IcOwcoiA88bWjeqoM6ro/21rkhC2JLeyqwaIEDED7Kw54u
	RH4GesPQTEkqiYSv4bzM1LFCYn7m8dfgIYjtMaM6Y6oE+nlWQAhe
X-Google-Smtp-Source: AGHT+IGTEi0bPagxhD4bKTKhGYFpyxTC+4bMEYfcQEEu07zU6SWeFBn8aZ9dYYKZZHFHqUP01OEXEQ==
X-Received: by 2002:a05:6512:15a0:b0:539:9720:99d4 with SMTP id 2adb3069b0e04-53c79e4c3f5mr1086583e87.28.1730364154211;
        Thu, 31 Oct 2024 01:42:34 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9c04esm131041e87.107.2024.10.31.01.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 01:42:33 -0700 (PDT)
Message-ID: <2fd45655-9847-44a3-adf3-14ced29abd33@gmail.com>
Date: Thu, 31 Oct 2024 09:42:32 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Klara Modin <klarasmodin@gmail.com>
Subject: Re: [PATCH] iov_iter: don't require contiguous pages in
 iov_iter_extract_bvec_pages
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
 akpm@linux-foundation.org, viro@zeniv.linux.org.uk, dhowells@redhat.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, klara@kasm.eu
References: <20241024050021.627350-1-hch@lst.de>
 <fa2f2722-fab2-4108-8d3a-f7da87bb9efa@gmail.com> <ZyLL-eXIntwBY5q2@fedora>
 <ZyLNqtmxsEt-VYIE@fedora>
Content-Language: en-US, sv-SE
In-Reply-To: <ZyLNqtmxsEt-VYIE@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-31 01:22, Ming Lei wrote:
> On Thu, Oct 31, 2024 at 08:14:49AM +0800, Ming Lei wrote:
>> On Wed, Oct 30, 2024 at 06:56:48PM +0100, Klara Modin wrote:
>>> Hi,
>>>
>>> On 2024-10-24 07:00, Christoph Hellwig wrote:
>>>> From: Ming Lei <ming.lei@redhat.com>
>>>>
>>>> The iov_iter_extract_pages interface allows to return physically
>>>> discontiguous pages, as long as all but the first and last page
>>>> in the array are page aligned and page size.  Rewrite
>>>> iov_iter_extract_bvec_pages to take advantage of that instead of only
>>>> returning ranges of physically contiguous pages.
>>>>
>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>> [hch: minor cleanups, new commit log]
>>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>
>>> With this patch (e4e535bff2bc82bb49a633775f9834beeaa527db in next-20241030),
>>> I'm unable to connect via nvme-tcp with this in the log:
>>>
>>> nvme nvme1: failed to send request -5
>>> nvme nvme1: Connect command failed: host path error
>>> nvme nvme1: failed to connect queue: 0 ret=880
>>>
>>> With the patch reverted it works as expected:
>>>
>>> nvme nvme1: creating 24 I/O queues.
>>> nvme nvme1: mapped 24/0/0 default/read/poll queues.
>>> nvme nvme1: new ctrl: NQN
>>> "nqn.2018-06.eu.kasm.int:freenas:backup:parmesan.int.kasm.eu", addr
>>> [2001:0678:0a5c:1204:6245:cbff:fe9c:4f59]:4420, hostnqn:
>>> nqn.2018-06.eu.kasm.int:parmesan
>>
>> I can't reproduce it by running blktest 'nvme_trtype=tcp ./check nvme/'
>> on both next tree & for-6.13/block.
>>
>> Can you collect the following bpftrace log by running the script before
>> connecting to nvme-tcp?

I didn't seem to get any output from the bpftrace script (I confirmed 
that I had the config as you requested, but I'm not very familiar with 
bpftrace so I could have done something wrong). I could, however, 
reproduce the issue in qemu and added breakpoints on 
nvmf_connect_io_queue and iov_iter_extract_pages. The breakpoint on 
iov_iter_extract_pages got hit once when running nvme connect:

(gdb) break nvmf_connect_io_queue
Breakpoint 1 at 0xffffffff81a5d960: file 
/home/klara/git/linux/drivers/nvme/host/fabrics.c, line 525.
(gdb) break iov_iter_extract_pages
Breakpoint 2 at 0xffffffff817633b0: file 
/home/klara/git/linux/lib/iov_iter.c, line 1900.
(gdb) c
Continuing.
[Switching to Thread 1.1]

Thread 1 hit Breakpoint 2, iov_iter_extract_pages 
(i=i@entry=0xffffc900001ebd68,
     pages=pages@entry=0xffffc900001ebb08, maxsize=maxsize@entry=72, 
maxpages=8,
     extraction_flags=extraction_flags@entry=0, 
offset0=offset0@entry=0xffffc900001ebb10)
     at /home/klara/git/linux/lib/iov_iter.c:1900
1900	{
(gdb) print i->count
$5 = 72
(gdb) print i->iov_offset
$6 = 0
(gdb) print i->bvec->bv_offset
$7 = 3952
(gdb) print i->bvec->bv_len
$8 = 72
(gdb) c
Continuing.

I didn't hit the breakpoint in nvmf_connect_io_queue, but I instead hit 
it if I add it to nvmf_connect_admin_queue. I added this function to the 
bpftrace script but that didn't produce any output either.

> 
> And please try the following patch:
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 9fc06f5fb748..c761f6db3cb4 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1699,6 +1699,7 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
>                  i->bvec++;
>                  skip = 0;
>          }
> +       bi.bi_idx = 0;
>          bi.bi_size = maxsize + skip;
>          bi.bi_bvec_done = skip;
> 
> 

Applying this seems to fix the problem.

Thanks,
Klara Modin

> 
> Thanks,
> Ming
> 
