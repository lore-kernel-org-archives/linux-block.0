Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82CC64A8D
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 05:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789450526; cv=none; b=ZeZEterG16LruKe2mBziDqKY9Kx1hP63W1plbaGIkzvD8aF+fBE2sZ7BXj3/3vo7hjKx4FPpXR07SwoQSE2dqDDR0e9qaGvXD333dStm88m4CgDXXRW6wzIITZEljEJR/2r5k1KOjhheiGiM+nrUqRGHTklMGLlXiT+KB/J3mh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789450526; c=relaxed/simple;
	bh=+hyCTRlyc0QNcS65JMtIZEPNo3AVH1S8Ev7UUp3zaQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jq/2kr2aSJjNKXyKkDd7VW/BVZY4H52zVrRIbSOyvu8tb7+2BgzWxh8iwFwKOieCH5USQkvkaqgPhxDVpcRQwOkn5vcXRhNBX02BCKB3pcHFym31TbCkofRftFub5q56fDEJZV6rhWG62Mkz6fJjY9cr/ofL7+skbwszUCB3vcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BefiyVU1; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BefiyVU1"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so2934862a91.0
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 22:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789450523; x=1790055323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OYhi4NJVlhoOAQ0HdJzU0jvm/8c0ymeQ0nH4iCFec9U=;
        b=BefiyVU1nBmW1ukaWPhAJDI8tdIYX9jnY5fitr+W2fEBXuI3YUNXYkgvyKyDdcGAHx
         6HaHfdok+uy0iLu8CJlaEqZqPXq6wgqXLtBMUSCE6tjAUAbZG75FnRVAi6BFyHRgg++5
         Nem/GUXXAID2e7G9RtP/ozAWLTqRZiJ9ZUfxpceXoWK5hncxn0f+23sZ0xFlg+Xs6XWZ
         Irda5MHZ+ltwdYtQAbi2oYm0tj24PvPgaZuadc93VWT159KNBSjmWL6O58FNRmoQIOGy
         AC1erdfSRxihOb1STVePQmuu0GjA1R3CucLYLUvwfFu/iRLfrfevkc6BJblQvhX2034q
         8M7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789450523; x=1790055323;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OYhi4NJVlhoOAQ0HdJzU0jvm/8c0ymeQ0nH4iCFec9U=;
        b=NWNfvo/qKOWB4KR6ruayE4+/x0FvmH7xUM83ALpP/MKoHdBdx4nUcXaafyDORHo8u2
         iAxZxOg2UcuiF53E4j433w8GxnfhXf/6ASksLTpbkcBMpsJdovSd4XRgEPzm7C8eFbwp
         AlNB67FtqwSNqjXhtYsHGQaSY+uxPcvshlsVbwDf6MN/luDDLcRAqdf2A4/gwyPYnsxB
         ylAoOgVyuaR927ZozdxE2sH7zJIBhEJrwVqfrYSACVL7yhPo3buGJFkT8V/fZ0595php
         UN+HDlgTYWe9+wcl+p/ndXa3iWNI4PEr/RIrjjpRrMxSR+dtFkDNSQYhvew+eI8ODa/4
         H+fw==
X-Gm-Message-State: AFuF++m76GQRMeKeogI1/TnpaEARQLRvHO1MMl1IIE825KqgKBa6OIIm
	/sC5pYXNYimynvoWPYT+OFE/oRtuC9K2ZP3LFjc9vEdMq/HQm68A/BdQCumFUKt0SAfVwgzmaxh
	veXFZ
X-Gm-Gg: AYBFou2rHlmqmPhf1HiOzOwLemou9EvE2w5FJI+v1pxDQtySMLa8ErWL+KEMgt9LWNv
	D/DDMUkFVGXayDb832HZkHqpWZK5Rwf9+u9S1+h5S1gP/i9bhfcr9a1Nsbf4nq9ZCt5wirxC6fV
	M5L6seA4d7RopsEUAG7FxeIJEbbSUDPQ3PG/1Ka/0/9q5IdbUj3O7vhKCnowdJdQTv+eQAlV8wT
	P+9BlNloz9Y+q4cam8aCNryttH/5lLeUwRnY4FU+9j9pMVVmppwBp9xiFvNQED83P3nhcJmGroO
	yMAZFDDmAnekTv4gw3HnO+W3tokNxWjuQDG9kdbtCVX+2V49buyuqomHJ8hI1mny6XGQjxLdpTI
	daz56qQK3vtABA8GbzUPPUgSXFtVdCxeLTk3rNx2aFrC3tw0uTnaX1yh/BKlSoGstLmC6zWyvbS
	KXrLD8TRrRKBNohApfD8ZL7a7Z4p6JcP0nBtTjUyOC0QeYjgB2Ix3szV+IjkIADAUtmfrUhyqEV
	qLsyjUpVWPwKTzPzQtp0GLObV9WNy6FMJgh56owviM=
X-Received: by 2002:a17:90b:4d07:b0:39d:f6a6:60d8 with SMTP id 98e67ed59e1d1-39df6a66122mr7696866a91.3.1789450523152;
        Mon, 14 Sep 2026 22:35:23 -0700 (PDT)
Received: from [100.81.12.150] ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd28acbsm2912867a91.10.2026.09.14.22.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 22:35:22 -0700 (PDT)
Message-ID: <eba0295b-268a-4573-aeeb-de79b9ca6063@bytedance.com>
Date: Tue, 15 Sep 2026 13:35:18 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] memcg,writeback: flush foreign bdev mappings
 separately
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 axboe@kernel.dk, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 willy@infradead.org, jack@suse.cz, rostedt@goodmis.org, tj@kernel.org,
 linux-mm@kvack.org
References: <20260914103119.1708452-1-sunjunchao@bytedance.com>
 <20260914205947.5aab9d7261ef0f26ec8f3213@linux-foundation.org>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <20260914205947.5aab9d7261ef0f26ec8f3213@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/26 11:59 AM, Andrew Morton wrote:
> On Mon, 14 Sep 2026 18:31:16 +0800 Julian Sun <sunjunchao@bytedance.com> wrote:
> 
>> Bdev inodes are routinely shared by multiple memcgs. Recording their
>> owner wb as foreign can cause dirty throttling in one memcg to trigger
>> writeback of unrelated file data belonging to that wb.
>>
>> On one production machine, bdev mapping snapshots showed as little
>> as about 10 MiB of dirty data. A queue snapshot of its owner wb showed
>> 599 foreign-flush works, with an average requested writeback budget of
>> 43 GiB per work.
>>
>> In other words, a small amount of foreign dirtying in the bdev mapping
>> can trigger owner-wide writeback requests, whose budgets averaged
>> 43 GiB in this queue snapshot.
> 
> What is the overall runtime effect of this?  IOW, can we see some
> before-and-after numbers?

I tested this series using a QEMU/KVM VM with 4 vCPUs, 8 GiB RAM,
cgroup v2 and ext4. Virtual NVMe write bandwidth was capped at
200 MiB/s.

A fio job repeatedly overwrote a preinitialized 256 MiB file using
64 KiB buffered writes, at 64 MiB/s, for 9 GiB of logical writes.
Four memcgs, each with memory.high=32 MiB and io.max=2 MiB/s, generated
metadata and buffered writes to trigger dirty throttling and foreign
flushes. Concurrently, foreground fio performed 16 GiB of sequential
direct writes using 1 MiB requests and queue depth 32. Normal periodic
writeback remained enabled.

Three comparison pairs, with alternating execution order, produced:

Run  Kernel   File I/O (GiB)  Time (s)  BW (MiB/s)  p99 (ms)
1    base              7.19    114.74      142.79      1434
1    patched           1.57     88.62      184.87       480
      change         -78.22%   -22.76%     +29.47%   -66.52%

2    base              5.13    103.59      158.16      1434
2    patched           1.74     88.65      184.81       497
      change         -66.06%   -14.42%     +16.85%   -65.35%

3    base              6.14    109.27      149.94      1434
3    patched           1.73     88.68      184.75       480
      change         -71.77%   -18.85%     +23.22%   -66.52%

File I/O is completed block I/O matching the overwritten file's extents,
including final sync, not requested writeback budgets. The other metrics
are for the foreground workload.

Across these runs, mean file write I/O decreased by 72.7%, foreground
bandwidth increased by 23.0%, and completion time decreased by 18.8%.

The baseline varied noticeably: runs with more writes to the overwritten
file also took longer to complete the foreground workload. With this
series, foreground completion time stayed within 88.62-88.68 seconds.
This is consistent with preserving overwrite coalescing and leaving more
device bandwidth available for the foreground workload.

> 
>> Following Jan's suggestion, this series records foreign bdev targets
>> separately and flushes their mappings instead of their owner wbs. This
>> preserves a way for dirty throttling to initiate bdev writeback while
>> avoiding owner-wide writeback triggered by these records. The existing
>> foreign-wb mechanism remains unchanged for other inodes.
>>
>> Tracking is best effort: each memcg keeps a bounded set of device
>> numbers without persistent device or inode references. Closed devices
>> and devices with a busy open_mutex are skipped. Device removal and
>> device-number reuse may race with lookup.
>>
>> Flushes run asynchronously on a dedicated workqueue to isolate these
>> frequently triggered tasks from existing workqueue users. If workqueue
>> allocation fails, the existing foreign-wb mechanism remains in use.
>>
>> Julian Sun (3):
>>    block: introduce bdev_flush_by_dev()
>>    memcg,writeback: flush foreign bdev mappings separately from owner wbs
>>    writeback: record bdev targets in foreign writeback tracepoints
>>
>>   block/bdev.c                     |  24 +++++++
>>   include/linux/blkdev.h           |   1 +
>>   include/linux/memcontrol.h       |  15 ++++
>>   include/trace/events/writeback.h |  22 +++---
>>   mm/memcontrol.c                  | 113 ++++++++++++++++++++++++++++---
> 
> I'd consider this a memcg patch, and not only due to the line counts.
> 
> Please cc linux-mm on memcg patchsets.
Sure, will do.

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>
