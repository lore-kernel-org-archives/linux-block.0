Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993143;
	b=lbB1/mOKFwFZmi0Pd0zNB/qHj434VnkwQ8apq8Ktz23iPhY090T4Qtd/PKq81pyLCRXW
	 DBWErIonmm1rVQTuWl/wt0gSV11hjhyOg19aQd4zNkL5fxdCz9XMkrBEm4qHpqledKvG8
	 4Oc9qJkdY+BJfw2zdaFXBWuWKQaEZjp1ndTRFwd1yPVLPrwj0ZTAKHrw/w41wJw4Rdhp1
	 IU+5GL7dEntjhGMT1nKIBOFVkUYOYIwFpBexgVR6d1d46kam2XYCfiB9AJ57QqM/As9Jw
	 XA1ZmT+1Pv9xJ452QKFsCwzOHMfF/JhUf/I5TXqL+Z/vhCmdDp9zIexpGRehT7EQk9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993143;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=BI3jlQaoExbnk+vPObY1KIVTTk7LgUYkBG0JnOIqAeo=;
	b=XhJAtPl1/ovnMx0OiczgpZi5DtxleI7o1/+WMSL1vhJE1za19nyszRi6LEWEqXg4K2Ad
	 APbLBR5y1EDOLaoKKg3DlRQdDpsJaBSnnAxp1vWEL1hXtiJyELYrH8p4TvhR1Jl0qcIVq
	 oRz67yy5+D70pVIq2bHDIPxkmZ2uHpZLBNC+InsYe//a/m8jRhTmD1ShzLqvNu95B5ZC5
	 r8jHitl+u7gmyWiJFwm3zEfKX2PELjuV/68BgzXYHidXRs/QNJ+9GTPAdmPKBfm+Gy0uH
	 n79GV5bKTtQ7nfpJB/Q3R2PpOxbQTj4ZwLU73e2XHIppsZdo84s7eqLi1fsBCmmbpHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dpqsNx8I;
	arc=none smtp.remote-ip=91.218.175.42
Received: from mta0.migadu.com (out-42.mta0.migadu.com [91.218.175.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E941B606A886
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 09:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E941B606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dpqsNx8I
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AKmb/ylIwU5QcbIrWMlATiUhIAEOL4n1lsJVBH1e2ac=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794993140; v=1; x=1795597940;
 b=dpqsNx8IfAg8LjRnnFH9duu7W9N6LhVSpJT7Ox1ugoicShBnt4BLEyDoPK878w9NCi+NprkU
 gsIO+CKhq/GcHUKqtuVSJxV1C5aZZs9/t2G/DGszBwBN21ZMrTfdEoEIFXQtyvHaEbIShItxz3z
 uNXzCq8qmziPDPDfj9Vdypdk=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 2edfd5dd97a48bf8;
	Wed, 18 Nov 2026 09:12:19 +0000
X-Mizu-Trace-ID: 2edfd5dd97a48bf8
X-Migadu-Flow: FLOW_OUT
Message-ID: <ac42e923-06bf-489d-bb9f-2ebec21b20f7@linux.dev>
Date: Wed, 18 Nov 2026 17:12:15 +0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: run the hw queue synchronously for unplugged
 scheduler inserts
To: Qiliang Yuan <qiliang.yuan@linux.dev>
Cc: Qiliang Yuan <odys.yuan@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <tom.leiming@gmail.com>, Wen Xiong <wenxiong@linux.ibm.com>,
 yukuai3@huawei.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 zhuzongzhen@sangfor.com.cn
References: <20260930-bug-blk-mq-noplug-sched-dispatch-v1-1-ff1e49e52b00@gmail.com>
 <dfa3f8d1-fa82-4c4b-91bc-e2529fbb5ddc@linux.dev>
 <20261115022713.391768-1-qiliang.yuan@linux.dev>
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <20261115022713.391768-1-qiliang.yuan@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

在 2026/11/15 10:27, Qiliang Yuan 写道:
> Hi Kaitao,
> 
> On Thu, Oct 29, 2026 at 09:09:19PM +0800, Kaitao Cheng wrote:
>> Our customer ran fio tests with --bs=4K --rw=randwrite --iodepth=1 --numjobs=1
>> and confirmed that adding bio plugging to __submit_bio() improves performance.
>>
>> Without bio plugging in __submit_bio():
>> fio:
>> __submit_bio                              (17.16%)
>>   → blk_mq_submit_bio                     (16.80%)
>>     → blk_mq_run_hw_queue                 (9.97%)
>>       → blk_mq_delay_run_hw_queue         (9.41%)
>>         → kblockd_mod_delayed_work_on     (9.13%)
> [...]
>> With bio plugging in __submit_bio():
>> __submit_bio                                (26.94%)
>>   → __blk_flush_plug                        (21.36%)
>>     → blk_mq_flush_plug_list                (21.24%)
>>       → blk_mq_flush_plug_list.part.0       (18.38%)
>>         → blk_mq_run_hw_queue               (15.34%)
>>           → blk_mq_sched_dispatch_requests  (14.55%)
> [...]
>> Adding bio plugging increased IOPS from 60,000 to 74,000 and reduced latency
>> from 12.4 µs to 9.5 µs.
> 
> Thanks, this is the same pattern on NVMe with an I/O scheduler. Without
> the plug every request is dispatched by kblockd, with it the submitter
> dispatches the request itself through blk_mq_run_hw_queue(). This patch
> leaves __submit_bio() unplugged and runs the queue from the submitter
> for scheduler inserts, which should give the plugged profile without
> the plug.

I previously submitted a similar patch that went further, though the
implementation differs from yours. At the time, it was not intended
to address the plugging issue introduced by 9cbbac29d752.

For details, see:
https://lore.kernel.org/all/20261017105400.95967-1-kaitao.cheng@linux.dev/

> Could you run the same fio job on the unplugged kernel with this patch
> applied? Ming asked earlier whether real devices see a difference, so a
> Tested-by from an NVMe setup would help if it gets back to about 74K
> IOPS.
> 

+Cc: zhuzongzhen

zhuzongzhen helped with the testing back then. I'm not sure whether he
still has the test environment available.

-- 
Thanks
Kaitao Cheng

