Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686E9329E79
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087586; cv=none; b=nAU0Wnkd+5illKz4kFECTSURklzN83W/TPzEiu+Cpm3PosDCWF5aCfBiZstaBIIBF3f5zE94YmqKEwdddKH75YV1Kl1OoRcWmyGStE+XiReWS6kJ/VXrxeIfuudBIV+axdj+ZzO34xBbRUF4QdP1vvlondOqJp1OOt16e6O2ZNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087586; c=relaxed/simple;
	bh=Dgt9gdgsSTGz25LNKdlg6p96v9ORYzbnwBkkNl+zH0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCkN95nQIA3qOrZw+4eQnUlJKPjRzTgrJwbPpaIs2iZdLJSPZgeYwKV40qWdg2Hg01Gx5vs7rRo4ba/DkuF4RFa5tPafNTjINOiyN/NKxl/C4rHvPBjN4STAnRM5YgLALJdksiEj6G8J7Z66W7//YV2G/m7+TcgN7c0SMQ/VqFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=fNdL0jd2; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="fNdL0jd2"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TKgG3Q3728100
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 16:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Tu3y
	zxbzT574lf/x8+7GuddK+9mUu+iNaUikqjzhrDc=; b=fNdL0jd2jEZLLdEDzHwo
	hg9oAn2A09Nc/UhTjZBmS2wSISfSJcrx7iHnycx2ggqMsmdYhM48Qp6dn8zJwdYB
	985sLAgkwtmSCT8teAzwTA6OhaIFRxvl6MhKiUIHzXRQSYgRkuDKU0XNg2X2RpBr
	0P7NHA2+A2rGk69mahYeBod1zrBCcJUIzU4maJzE4t8BG1N9Hc/8nKnhiSDo4Nh4
	Ch5XzOjEOBE/jVetXJBtepua7x9ftMeGTiaGWhJ+DI1yELSJMypkbL8bJpLS0OQb
	sCO7ehhxuKMpXZEyP0t++n/X9s8DuU67L6dejzRsJ12iZiflWRTJYEZgsZtHx+T6
	gg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4efhpf05q1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 16:46:18 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-90fb4c8390aso1439376385a.3
        for <linux-block@vger.kernel.org>; Fri, 29 May 2026 13:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780087578; x=1780692378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tu3yzxbzT574lf/x8+7GuddK+9mUu+iNaUikqjzhrDc=;
        b=QS/oyooq9kfpHYa4RtxsXpG5wQNDoy9ERO2xiK0FqQTe4bq4+8HIEsUv22f9lONy5f
         ZzvMOe5v3CHxCCOnDqMD9uzm3tfYQJLwjd9beryb0Te41TLOtkAWuSlyx7rNRUnNDbuB
         uuzFbJkgMXuRGjigP8HL2m3L+6fX4iUUSJ4aKV3F7X3/rm7cVH0ey2kubWGuzOTAg7G9
         AJygq8EC2RrQ50c+7e0IYLgEDuqy8f6UtJmrXvBpEzwFM+obV1mMsfwawVnlUHeuhhkW
         u7yorbPnDR8Qy4h3N2Sh0EazYtmdwlEtVbuZd3m+riw7sToIzIaxP3n0RPfoBl5pdyT6
         A0Qg==
X-Forwarded-Encrypted: i=1; AFNElJ9pjch8zRfYtt6pjffChYrt//xiCOtzrfqAYV/YNmye7VXPF8WLL/pudqBFGHXPlCraOD4dR+SajjcW9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWOAiOFCjLVc79VmIsVNSup0kT0MYB6tgSwyIeDS58v239srp8
	r5/mH0EpMfx9xerScFrzRwhZe0zvm8Y/lh4CctCojPe7+WiSuJLdjMFtpuzRIMHuxaq81ESzpMy
	Ly9zZYUsawz8HwYOQ5BqCvt25Poa1c88Wcv4YixexyYOpjNkWd+we51GvZfnk
X-Gm-Gg: Acq92OGqA1mtIzNRTMxWi35ZNGa6P7xkATDosIPkL1v1lX8tRmgzLw2gVcw8RWTBooq
	IwzTYAZnOdwmNMfad8cazNLcITAiPvmQxfmuMwvDSUrIOlaRmzECTg6T3TynFdzk2jb+tu+74HO
	3FjGJDb+JvoMPBKX5tPoDKSGHiY+ZP0gWmRX6XP/9c0w4Nu6D1bmtTcjqMvbWWUwPMIAeIakYNq
	+mZHj6XwhCcikeyYo89vwAAq7c7CyKPo7W5m/zcIJRaEkwmwBgsIM7zd+YNMMF5kMo26qj5nTjr
	T7Naap+C/DINynJE4oX/Ji8Ri9RYLX9KnAYP1xNpjmKhM7IG4pPaOHmvhMfQzBLtXZJfeFwNP+O
	HB/BUh5B1CJ00ms8X3fR8+4rQvDYbazwyhe0CVhuyFT4gW4/3KUyuwiSctloL7U98PxYfR3FrVM
	5tlDUcBCco3x+P8W42ztrDdhIZ1w==
X-Received: by 2002:a05:620a:27cf:b0:914:b65f:6afe with SMTP id af79cd13be357-9153d93295cmr223977985a.1.1780087577724;
        Fri, 29 May 2026 13:46:17 -0700 (PDT)
X-Received: by 2002:a05:620a:27cf:b0:914:b65f:6afe with SMTP id af79cd13be357-9153d93295cmr223970285a.1.1780087577139;
        Fri, 29 May 2026 13:46:17 -0700 (PDT)
Received: from ?IPV6:2600:4040:974e:fe00:c8bb:325f:9d37:a5f? ([2600:4040:974e:fe00:c8bb:325f:9d37:a5f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324a5502sm300290485a.21.2026.05.29.13.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 13:46:16 -0700 (PDT)
Message-ID: <80cb53f3-e7e5-4f96-bacc-f9fb7661d976@columbia.edu>
Date: Fri, 29 May 2026 16:46:15 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] block: add task-context bio completion
 infrastructure
To: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Gao Xiang <xiang@kernel.org>
References: <20260514-blk-dontcache-v6-0-782e2fa7477b@columbia.edu>
 <20260514-blk-dontcache-v6-1-782e2fa7477b@columbia.edu>
 <agq2KRd8RkP1TAf5@infradead.org>
 <ea1fa305-3ba2-4cfd-b7cb-86875032a300@columbia.edu>
 <ahPbaSEoNA755Nt3@infradead.org>
 <f1b8eeb6-2397-4f48-a21a-a023eb0c80ab@columbia.edu>
 <rkb5oei6cx2erbyininczz6ukbnquqheexhu7tznn5rslkkdn7@b4kpdyhdwdb6>
 <ahbq0RdUyLIPiItB@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <ahbq0RdUyLIPiItB@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIwNiBTYWx0ZWRfX3ypBNQVZZyQh
 DYT3Uq+A73xLf05LamUGH6M9Lg3bFrfy+P+3emQ99xPmUrVNsLCDl2baoALKzPuA/bzUYbF4b7u
 GF///GXnyzVCBfFoRmfsv9ojQOan+McqrWYNcADxq7TBiP0y8MRYxVMoCt/NDKgnKJet27E4upK
 hyD7pSZFDJeMYGWNmPHENBf7vZHNHmVX7oEhp1KOIIsrAacZwuP3AQbb/722ewAnmVDXU6w+xUq
 +3Q/D9KXyZzV+bj4CYbUPjbUseoNqKOlPB1EC4H/prXN2Le4AedJfHaBLvRJnb5aGWrE56Ojavf
 7cayPtup69LbN057YYEhXwkkDLR3/pvHGv+uk2ztK6ajqt6tdH+myrCB1/9LJJJDkpgOy6vC2X0
 wmMdYq5rIqA2QkLtXAcutIopkY7bENrVbCsxK4SbcAJJ3fUdTXVBU/KtRSsoFjSSjgnmfAlWJUz
 QKvpbH/mVS1TSRmqFOA==
X-Proofpoint-ORIG-GUID: 1NZQMaJEB6c4-qUOmcwPsj4stH7dQjie
X-Authority-Analysis: v=2.4 cv=L7UtheT8 c=1 sm=1 tr=0 ts=6a19fb1a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22 a=glsx1xNwX7j2ZVJJCoYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 1NZQMaJEB6c4-qUOmcwPsj4stH7dQjie
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11801
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=10 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=10 spamscore=0 clxscore=1015 impostorscore=10
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290206

On 5/27/26 9:00 AM, Christoph Hellwig wrote:
> On Wed, May 27, 2026 at 11:42:28AM +0200, Jan Kara wrote:
>> > I ran some experiments with fio on both XFS and a raw block device. Five
>> > iterations each for 60s. Results below.
>> > 
>> > TLDR: Removing the delay doesn't significantly decrease user-visible
>> > latency or otherwise improve performance, but does significantly reduce
>> > throughput and increase context switches in some workloads (e.g. C).
>> > I think it makes sense to leave the delay as-is. Thoughts?
>> 
>> Thanks for the test! One question below:
> 
> Thanks from me as well!
> 
>> 
>> > Results:
>> > 
>> > Workloads (all `uncached=1`):
>> >   A: rw=write     bs=128k iodepth=1   ioengine=pvsync2     # XFS
>> >   B: rw=write     bs=128k iodepth=128 ioengine=io_uring    # XFS
>> >   C: rw=randwrite bs=4k   iodepth=32  ioengine=io_uring    # XFS
>> >   D: rw=rw 50/50  bs=64k  iodepth=32  ioengine=io_uring    # XFS
>> >   E: rw=write     bs=128k iodepth=128 ioengine=io_uring    # raw /dev/nvmeXn1
>> >   F: rw=write     bs=128k iodepth=128 numjobs=4
>> >      + vm.dirty_bytes=64MB, vm.dirty_background_bytes=32MB # XFS
>> > 
>> > Mean ± stddev across 5 iterations:
>> > 
>> >     metric                     delay=1           delay=0     delta
>> >     --------------------------------------------------------------
>> > 
>> >   A seq 128k qd1
>> >     BW (MB/s)                4333 ± 27         4374 ± 34     +0.9%
>> >     p99   (us)              36.2 ± 0.8        35.8 ± 0.4     -1.1%
>> >     p999  (us)               3260 ± 75         3228 ± 29     -1.0%
>> >     ctx-switches          184 k ± 59 k     3.68 M ± 65 k    +1903%
>> >     cs / io                0.09 ± 0.03       1.86 ± 0.03    +1888%
>> >     avg bios/run            80.4 ± 0.6         1.1 ± 0.0    -98.7%
>> 
>> So 1 jiffie delay is (with default HZ=1000) 1ms. That means for this load
>> the completion latency should be at least 1000us but your results show p99
>> latency of 36. What am I missing?
> 
> Yes, this looks a bit odd.  Unless there's multiple threads submitting
> and somehow the completions get batched this should complete one
> bio at a time and be the worst case for the delay scheme.

Sorry, I should've clarified - the latency here is the userspace-visible
I/O completion latency (i.e. fio's clat value).

I ran again and traced to get the actual time from __bio_complete_in_task()
to calling ->bi_end_io(). The results match the 1 jiffie delay now:

  metric                  delay=1  delay=0

  A seq 128k qd1
    fio clat p99             38us     36us
    bio cb p50             1.23ms    2.5us
    bio cb p99             4.13ms   1.44ms
    bio cb p999            5.01ms   2.63ms

  B seq 128k qd128
    fio clat p99           8.74ms   8.85ms
    bio cb p50             1.27ms    3.1us
    bio cb p99             4.05ms   2.27ms
    bio cb p999            4.91ms   2.77ms

  C rand 4k qd32
    fio clat p99           8.16ms   8.11ms
    bio cb p50             1.09ms   97.7us
    bio cb p99             3.73ms   2.06ms
    bio cb p999           11.87ms   3.79ms

  D mixed 64k qd32
    fio clat p99            981us   1.03ms
    bio cb p50             1.14ms   39.5us
    bio cb p99             2.83ms    275us
    bio cb p999            3.06ms    595us

  E raw 128k qd128
    fio clat p99          26.97ms  27.34ms
    bio cb p50             1.58ms   41.5us
    bio cb p99             2.98ms    325us
    bio cb p999            3.02ms    575us

  F mem-pressure
    fio clat p99          29.75ms  30.43ms
    bio cb p50             1.32ms    2.5us
    bio cb p99             3.73ms   2.48ms
    bio cb p999            4.62ms   2.83ms

Note that in the above, the C degradation didn't reproduce as much. The
bandwidth does go down from 64.5 MB/s with delay=1 to 54.9 MB/s with delay=0,
but it's a much smaller drop. I ran it several more times and ran into the
degradation ~20% of the time. The lack of batching means the completion
kworker fires for nearly every bio, leading to heavier preemption when a
writer is placed on a CPU that receives many completion IRQs. The degradation
seems to occur when the writers are migrated less often, leading to more
preemption. But I haven't dug into why the scheduler chooses to migrate more
in some runs vs. others. However, when pinning to 16 cores, the difference
between delay=0 and delay=1 goes away.

C specifically also seems to get worse because we're doing random writes to a
sparse file, so each bio goes through the IOMAP_IOEND_UNWRITTEN path and the
completion path is heavier, leading to more CPU stealing from the writing
threads compared to the other workloads.

>> >   C rand 4k qd32
>> >     BW (MB/s)               66.2 ± 0.8        44.6 ± 7.4    -32.7%
>> >     p99   (us)              8002 ± 174      17990 ± 6800   +124.8%
>> >     p999  (us)             11390 ± 554     31890 ± 11076   +180.0%
>> >     ctx-switches         3.67 M ± 45 k    3.59 M ± 106 k     -2.2%
>> >     cs / io                3.78 ± 0.04       5.62 ± 0.83    +48.7%
>> >     avg bios/run            32.3 ± 1.0         3.1 ± 0.3    -90.5%
>> 
>> I'm somewhat surprised how larger is the completion latency is here without
>> the delay. Is that due to a contention on local lock between the IO completion
>> interrupt and the worker? Or why is the completion latency so big here when
>> the case B with more IOs in flight, less bios per run, still had significantly
>> lower latency in the delay=0 case?
> 
> Note that in the past we had major problems with workqueue scheduling
> latency.  At some point these got mitigated a lot, but if they are back
> for this workload that might be one reason.
> 

