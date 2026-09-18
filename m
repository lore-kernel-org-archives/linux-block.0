Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AAD43498F
	for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 04:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707436; cv=none; b=TkXa+R4CigXwXx7Yx2NXa2hEqMZMqZmFlwN8iwJy3oKf5ON/PFXMy4XX2QiOetfGzlqDvitzONUMRrtV4I7D0VW3NG6EgJBzisFIDlbAkO2ohOc8mPS/e9kP94rKJsxQPEH3wBC3RIr7X6VKpc7opvk7Foo++sqiiU07HL8QIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707436; c=relaxed/simple;
	bh=TFzzOp0Z45QYFc//FtBFfyXHOBCbHRc8WvTkq51K8Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJH5lVuie9Es/39A6mAUZDGUfRRRNO12tO4QA2JuJO6JD+IJK3i5fK5OVIdjf8GHHobyOmD3HYUP1cnGK6gIm+rFa6G/65mR9OW1D2uyIH+Pwq0EacFPPsHcxGhMHCED0hjLgnCX+eXeYYp6sV3c9bLlez5nA61ylYEfoc51PGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ob9jhD4k; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ob9jhD4k"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8686f46e4adso325500b3a.0
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 21:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789707431; x=1790312231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BINWNM6rAXczaz/wqYMANaQxaxCeH43keYl+j5zAlsg=;
        b=Ob9jhD4kH337CR6E+PYmdkGd/NogIsCLwvD3AIrnZA7vVaJwbyfpNNsfa1GNMyFOlr
         E45h+7iotnuCvWnJvyIYrKj31Zw69CWF0hU4Pzm6GdoA8Q9XTJvUj78VuVQlGXauGDjs
         bxmp90bmmhyrkjZh4shEwJJQGTxfz0ImLeJr1iegUkWroLuCHNBDxkhACDs+IYJZZSAs
         mpwuldWBteVuwMEf0bCioneMdKFAO6XKxXnQ55eCmx1TjRDWhzRvFWC2RNqJzBttoA7M
         pd4H5EritUQqn9ODaZ2/KAuWdADz4gJt6vIwQWicIEtQ+J+l3XUfc8izmxjOr2i8smof
         NKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789707431; x=1790312231;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BINWNM6rAXczaz/wqYMANaQxaxCeH43keYl+j5zAlsg=;
        b=CJDmHRKkoUKf+RW0YTqZ99bY85Wg5/4OdSFOrUYDZH36C6hcGSE9g//elXECY2UoJm
         we3WAXhO9U0iqymeXSAu5HcRtZGdH66QmnzvAWx7NZeRbuu6xLv2AKxNuTY5jkskiI06
         3a9HrHECKhRtNbniF+DUCWqrMNL7Go/KqHLON+Q3tT0vkmjpWBBReicj1C8flVtZC+tt
         IJMk3eRKdXjfo9Em5q1gNXDVotaiz2tAvcrxM/vVHj5cmjyPSMHQJA+HKTaBy/yAbeER
         3jghpVKLCcrJ+xG6W3yyPcdruBVeHlLkGkzVMzPuY53lfonolktFOdlUQhyJ6bz72GP+
         mbgw==
X-Gm-Message-State: AFuF++mUJVeo5IKVUH2qoacsbE4fcx0iKWsParvYlb4H4quMkMh7PLoq
	11NeEcTpv6g1LuTWC6QqRStQLC+o4q/kOw9JWnh3IZ+XHuDJ/eSDJZPsQ38CgD9+d7w=
X-Gm-Gg: AYBFou3igshqgCv3ttwgej+LeTBb/a7RDLv43WZcmJZfbgfCVgmpZMltk9bgklylG7Z
	2yrOBlwfX4GoRX0K8/QiokJROx197/KRG88QEDKwlSMmQFnbWk5cCu/1NGoP5pP/zgKhtCb9i8j
	Nc/xMsVlGoD5H1K/dQWepAaxvFc9JN2gV43SY9g42A1jbi1sZk9f3h9JNU7uID1xsorPFN4yx/B
	Z9OPrRXB3e9CxsvwlvTJvi/gUUEPDyqoC3iXRb+zhwRAM3vz23O3Rd9XxmM6cRvKmZFPXmFvQ1k
	lLrPVfQ8Q/RXoXe1+/mZIjbgQ+Gg6ixHr27UaN5B88vbH2RwV99Jkhd878wZm8zsamqBK2vi5LL
	lUuHgqSfykeEkzAw2PqHA1Rt9mIDdcGHIRo+RMS+EYJtBMw46/MtlOaOXMb8nIWW/vzCVejEDXR
	z9NR39VUyE4jYgZ22bPmAKmP+AsPycNY8pL+K+FQWMcrTETvsSNlWUxzimfrr13jg1g90RNQbzK
	N3DlZr137hr5Mbf8zIWUNsX/fXM8A==
X-Received: by 2002:a05:6a20:ce43:b0:3b4:7e2d:a3c2 with SMTP id adf61e73a8af0-3dd8c44e218mr2662348637.18.1789707431275;
        Thu, 17 Sep 2026 21:57:11 -0700 (PDT)
Received: from [10.71.180.110] ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287b0293sm1111628eec.24.2026.09.17.21.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 21:57:10 -0700 (PDT)
Message-ID: <836b5192-ef11-4f16-8c90-049d570959a2@bytedance.com>
Date: Fri, 18 Sep 2026 12:57:03 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] memcg,writeback: flush foreign bdev mappings
 separately
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, willy@infradead.org, jack@suse.cz, tj@kernel.org
References: <20260917065759.2643940-1-sunjunchao@bytedance.com>
 <20260917155305.7a63e01ba3ed34ed0aea537f@linux-foundation.org>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <20260917155305.7a63e01ba3ed34ed0aea537f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/26 6:53 AM, Andrew Morton wrote:
> On Thu, 17 Sep 2026 14:57:56 +0800 Julian Sun <sunjunchao@bytedance.com> wrote:
> 
>> Hi,
>>
>>
>> Measured impact
>> ===============
>>
>> The synthetic test used a VM with 4 vCPUs, 8 GiB RAM, ext4 and cgroup
>> v2, with device write bandwidth capped at 200 MiB/s. Background fio
>> repeatedly overwrote a 256 MiB file using buffered I/O, while
>> foreground fio performed sequential direct writes. Four memcgs
>> generated metadata and buffered writes to trigger foreign flushes.
>>
>> We measured completed block writes to the background fio file,
>> including final sync, and foreground fio bandwidth, latency and
>> completion time.
>>
>> Across three runs per kernel, mean background file write I/O decreased
>> by 72.7%, foreground bandwidth increased by 23.0%, and completion time
>> decreased by 18.8%.
>>
>> Metric                         Baseline    Patched     Change
>> Background file write I/O (GiB)    6.154      1.680     -72.7%
>> Foreground bandwidth (MiB/s)      150.29     184.81     +23.0%
>> Foreground completion time (s)   109.203     88.652     -18.8%
>> Foreground mean latency (ms)      212.84     172.74     -18.8%
> 
> Thanks.
> 
> As I understand it, this is basically ext4-specific.
> 
> I don't think btrfs or xfs mess with the bdev address_space at all? 
> But google tells me that "roughly 70% to 80% of all Linux machines use
> ext4 as their primary or root file system", so there is that.

Yes, most of our systems still use ext4.
> 
>> Approach
>> ========
>>
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
> 
> This part looks plain nasty.  Why are we messing with dev_t's and
> risking these races?
> 
> At the very least, this description should explain the reasoning behind
> this decision at some length.
> 
> Surely it's cleaner and safer to grab a ref on something (the bdev
> inode?) and hang onto that object.  Use it for these operations, let it
> go at the appropriate time.  Clearly there's something wrong with that
> approach, but what?

This follows the existing foreign-writeback mechanism's best-effort design:
it records IDs without holding any references and tolerates occasional
stale hints. I followed the same approach for bdev tracking by recording
dev_t.

Taking a device reference would introduce additional lifetime management.
If we acquire a reference during foreign tracking but the memcg does not
enter dirty throttling for a long time, no foreign flush would consume
the record and release the reference, then delaying final device-object
release. A timeout mechanism would only limit this delay, not eliminate it.

There is also a locking issue: dropping a record happens under mapping->i_pages,
but dropping the last reference may sleep. We would therefore need to restructure
the release path, adding concurrency and lifetime-management complexity.

Recording only dev_t follows the existing mechanism's best-effort design.
Device-number reuse may cause a stale record to trigger writeback of the new device's
own mapping. In my view, this occasional unnecessary writeback is an acceptable
trade-off for avoiding the complexity above.
> 
>> Flushes run asynchronously on a dedicated workqueue to isolate these
>> frequently triggered tasks from existing workqueue users. If workqueue
>> allocation fails, the existing foreign-wb mechanism remains in use.
> 
> Unclear what this means.  If a kmalloc/etc fails then we fall back to
> the current (mainline) behavior?  Fair enough, failure of small
> kmallocs are so rare.  The main problem is testing the failure-path
> code!

Yes, if allocation of memcg_bdev_frn_wq in mem_cgroup_init() fails,
foreign writeback falls back to the existing mechanism. The workqueue is 
allocated once during initialization. The new tracking and work-
queueing paths use preallocated per-memcg slots and perform no dynamic
allocation at runtime. please see patch 2 for more details.

I tested this failure path by forcing the workqueue pointer to NULL
and the results were as expected.> 
> 
> Also, and most importantly, what the heck is "frn"?  Would the world
> end if you did s/frn/foreign/g?

Emmm, the naming follows the existing code. I'll rename the new uses
of "frn" to "foreign" in the next version. Renaming the existing code
would be a separate cleanup patch; I'd prefer not to mix that into this
fix series.

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>
