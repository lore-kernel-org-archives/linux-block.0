Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB421DDF5;
	Thu,  6 Jun 2024 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663499; cv=none; b=KzM8E0PLNpas9VhYNqB/o5Y7WbU4EULgKiOLZ9jkM7bEVTSb6fwyrxldKAzDqlEbrZgKCbYpJ9kgxSMY0wpsNb5O2DRIzaeRL77puy//i+2lttl23+lfNF/8tJ4tdZU+1XUaFzQSGqxQsZ8Tue2eqk9Sg2E3qJ11/mzjgEL6C9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663499; c=relaxed/simple;
	bh=IMVkFY3EaLLVoBprHKKS4cdze8g7zClWPH550NtMg74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8vzLEYRDCFAXBmNIKlEVoc2X0eaznFgh3R0tX4xWdtLDSgTQqKw9uL+E7EoKPW+K0FrtFA3LItXTSaqfVsSNSVJpGwC9VimcJ+AgR5x81vBpuG5dfXZWbgnv10A87Qf1PUbOvGNAbsqXJoWjzPnyBKbQgYQlA7nuoWJjQwleJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B773A44E4B;
	Thu,  6 Jun 2024 10:44:53 +0200 (CEST)
Message-ID: <343166f4-ac11-4f0e-ad13-6dc14dbf573d@proxmox.com>
Date: Thu, 6 Jun 2024 10:44:52 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix request.queuelist usage in flush
To: Chengming Zhou <chengming.zhou@linux.dev>, axboe@kernel.dk,
 ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com, Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20240604064745.808610-1-chengming.zhou@linux.dev>
 <c9d03ff7-27c5-4ebd-b3f6-5a90d96f35ba@proxmox.com>
 <1344640f-b22d-4791-aed4-68fc62fb6e36@linux.dev>
 <ec27da86-b84a-430b-98aa-9971f90c8c87@proxmox.com>
 <7193e02e-7347-48db-b1a0-67b44730480b@proxmox.com>
 <448721f2-8e0b-4c5a-9764-bde65a5ee981@linux.dev>
Content-Language: en-US
From: Friedrich Weber <f.weber@proxmox.com>
In-Reply-To: <448721f2-8e0b-4c5a-9764-bde65a5ee981@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/06/2024 16:27, Chengming Zhou wrote:
> On 2024/6/5 21:34, Friedrich Weber wrote:
>> On 05/06/2024 12:54, Friedrich Weber wrote:
>> [...]
>>
>> My results:
>>
>> Booting the Debian (virtual) machine with mainline kernel v6.10-rc2
>> (c3f38fa61af77b49866b006939479069cd451173):
>> works fine, no crash
>>
>> Booting the Debian (virtual) machine with patch "block: fix
>> request.queuelist usage in flush" applied on top of v6.10-rc2: The
>> Debian (virtual) machine crashes during boot with [1].
>>
>> Hope this helps! If I can provide anything else, just let me know.
> 
> Thanks for your help, I still can't reproduce it myself, don't know why.

Weird -- when booting the Debian machine into mainline kernel v6.10-rc2
with "block: fix request.queuelist usage in flush" applied on top, it
crashes reliably for me. The machine having its root on LVM seems to be
essential to reproduce the crash, though.

Maybe the fact that I'm running the Debian machine virtualized makes the
crash more likely to trigger. I'll try to reproduce on bare metal to
narrow down the reproducer and get back to you.

> Could you help to test with this diff?
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index e7aebcf00714..cca4f9131f79 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -263,6 +263,7 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
>                 unsigned int seq = blk_flush_cur_seq(rq);
> 
>                 BUG_ON(seq != REQ_FSEQ_PREFLUSH && seq != REQ_FSEQ_POSTFLUSH);
> +               list_del_init(&rq->queuelist);
>                 blk_flush_complete_seq(rq, fq, seq, error);
>         }

I used mainline kernel v6.10-rc2 as base and applied:

- "block: fix request.queuelist usage in flush"
- Your `list_del_init` addition from above

and if I boot the Debian machine into this kernel, I do not get the
crash anymore.

Happy to run more tests for you, just let me know.

Thanks!

Friedrich

