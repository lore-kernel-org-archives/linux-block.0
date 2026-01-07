Received: from mail3-163.sinamail.sina.com.cn (mail3-163.sinamail.sina.com.cn [202.108.3.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81E628726A
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770930; cv=none; b=K5rUj5guBFAn2bJWFouKmESRB8D3W8ak2af0HhgqrEhuPkTbRKaZCsY1VhgZ75QqB5yR9eBuBLFbcH0BTlV5naLBKldtZvAP9Ayib4UpwfUs42QsAniCPobopyP8tchC+LojFQj+2LuTEp3fuqYq7+HpCnpZ/jLAD3JGH6NRk5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770930; c=relaxed/simple;
	bh=vYxamPaAEK+1M2FbxLivh0yseffre3SvElcP9FnA6Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUIqVVAeO8sHfKbHWjGtaQnaqKZwH1paNA/3/NjEYVKxqcvwwrV9vSM3nF7dEERNMW82eeJeuXd80PVcSE5qNXE59b0QoL5ORqNL3tipwp8yz/HqMvUsebzSZCY1rJ+7yBcueKrm2lTb/0E9FK1LAndxiQL6KkHJIUZclN9fWf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=JmAFXzuq; arc=none smtp.client-ip=202.108.3.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="JmAFXzuq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1767770925;
	bh=MCDQKkv00dee+7Hq9Qla+ViyMcC4NAiMlT8zc8Ml/os=;
	h=Message-ID:Date:Subject:From;
	b=JmAFXzuq4eJB0AYX565KBK3/oFJ7rKj7s9bMOuS2QdqJGyH0RX8t61Ln4FhXZNAI6
	 WejMDigUlkF0QHGZ9ubBig17bDZPLHILrazyeEmfaYJXCvMoGgnY9gdGQ488UrAwrm
	 U8/1AEfeTmCUshnCuAIu8c8ruloRYP/zNln28uGE=
X-SMAIL-HELO: [10.189.149.126]
Received: from unknown (HELO [10.189.149.126])([114.247.175.249])
	by sina.com (10.54.253.34) with ESMTP
	id 695E0B0300000142; Wed, 7 Jan 2026 15:28:04 +0800 (CST)
X-Sender: zhangdongdong925@sina.com
X-Auth-ID: zhangdongdong925@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=zhangdongdong925@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangdongdong925@sina.com
X-SMAIL-MID: 8978036291840
X-SMAIL-UIID: 5D5FCF9AA3104E0E9780317D09358A48-20260107-152804-1
Message-ID: <2663a3d3-2d52-4269-970a-892d71c966bb@sina.com>
Date: Wed, 7 Jan 2026 15:28:03 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/7] zram: introduce compressed data writeback
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Richard Chang <richardycc@google.com>, Minchan Kim <minchan@kernel.org>,
 Brian Geffon <bgeffon@google.com>, David Stevens <stevensd@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, Minchan Kim <minchan@google.com>
References: <20251201094754.4149975-1-senozhatsky@chromium.org>
 <20251201094754.4149975-2-senozhatsky@chromium.org>
 <40e38fa7-725b-407a-917a-59c5a76dedcb@sina.com>
 <7bnmkuodymm33yclp6e5oir2sqnqmpwlsb5qlxqyawszb5bvlu@l63wu3ckqihc>
Content-Language: en-US
From: zhangdongdong <zhangdongdong925@sina.com>
In-Reply-To: <7bnmkuodymm33yclp6e5oir2sqnqmpwlsb5qlxqyawszb5bvlu@l63wu3ckqihc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/7/26 12:28, Sergey Senozhatsky wrote:
> On (26/01/07 11:50), zhangdongdong wrote:
>> Hi Sergey,
>>
>> Thanks for the work on decompression-on-demand.
>>
>> One concern I’d like to raise is the use of a workqueue for readback
>> decompression. In our measurements, deferring decompression to a worker
>> introduces non-trivial scheduling overhead, and under memory pressure
>> the added latency can be noticeable (tens of milliseconds in some cases).
> 
> The problem is those bio completions happen in atomic context, and zram
> requires both compression and decompression to be non-atomic.  And we
> can't do sync read on the zram side, because those bio-s are chained.
> So the current plan is to look how system hi-prio per-cpu workqueue
> will handle this.
> 
> Did you try high priority workqueue?
> 
Hi,Sergey

Yes, we have tried high priority workqueues. In fact, our current
implementation already uses a dedicated workqueue created with
WQ_HIGHPRI and marked as UNBOUND, which handles the read/decompression
path for swap-in.

Below is a simplified snippet of the queue we are currently using:

zgroup_read_wq = alloc_workqueue("zgroup_read",
				 WQ_HIGHPRI | WQ_UNBOUND, 0);

static int zgroup_submit_zio_async(struct zgroup_io *zio,
				   struct zram_group *zgroup)
{
	struct zgroup_req req = {
		.zio = zio,
	};

	if (!zgroup_io_step_chg(zio, ZIO_STARTED, ZIO_INFLIGHT)) {
		wait_for_completion(&zio->wait);
		if (zio->status)
			zgroup_put_io(zio);
		return zio->status;
	}

	INIT_WORK_ONSTACK(&req.work, zgroup_submit_zio_work);
	queue_work(zgroup_read_wq, &req.work);
	flush_work(&req.work);
	destroy_work_on_stack(&req.work);

	return req.status ?: zgroup_decrypt_pages(zio);
}

Thanks,
dongdong
