Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081A37C0F9
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768564463; cv=none; b=g0OjjSXqrL8kPZ3rtFDn7EDycfN9yJfPKsLlRkx3O0W7qcc5PV6bdbhD/rIZJz4oYxSdyoCbMNchr5BCokrWkQqXxcSaHsd806AWMqa4gErAzVYMZYcZuv3wZlsXMVG3VlhJiHVOd2QwNN85mFyWDBbeU+4Hq6NC0pEbP/7BSas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768564463; c=relaxed/simple;
	bh=0YkcKoSpd1bCexoMcb8rOcqMtAwJhUmwsBUyaRAjeN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5ZRvJxJuZCxBKQqLRlSQnSqEaGCLc6OMQmHe7BcewrkVEu/37lDaVblGZ5qM6SEo5aGy5wTMI9aTI23pakG6MY5F6ooMgEAwSmrh2q6BOeFUJOggol+eWs86vrucVXX/FSfXv6jc/OJmU69q/v4Pj5UyDGLB9WZGybRWlvmmTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=f1oxnlJV; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="f1oxnlJV"
X-Virus-Scanned: Yes
Message-ID: <8c523b07-f868-41c9-88f1-753c77ef85fb@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1768564457; bh=0YkcKoSpd1bCexoMcb8rOcqMtAwJhUmwsBUyaRAjeN4=;
	h=Subject:To:Cc:References:From:Reply-To:In-Reply-To;
	b=f1oxnlJVpi0O1RIbUOkEETpoWTioHZoiQ2FyId5U3ins5IS1wuDb33H+l0ENWG46H
	 3Ml5RKdLcruYw8wvoKLO+zWwS0L9h+cjDp5MhbQxkLKMCMJZ2vjjIiTt45l266pLgS
	 WkwFH9f/QbMfPbxYDt7hbqCti9Tmpa+sbi4vdZ9L/rixJIwqg6X9q2YxNT6KE//aIo
	 NQGF3S8jjENqE/dDpLkJX8AGB6mgG00fChjRESfl3MwMcAklftn0v4OkTFgMS4kA46
	 Gvu49UqgEkDbVLzINuw5NAxNTV49Xoj94+sQmPu+eqjVOjQutp7SpnOnTT3j5GqrRI
	 EiIybpMkY/zoLbSRpdBIYKa8L5xAoT1pTjyIKR9EstpPql1AUtQtueRLPJ4AnwDBUm
	 9UeXE3qluwO09IF2RocLX28ok9X6ZPGn2hRNKBX5W64AZbawb+d7qCmBEsnP9Qx3hQ
	 NSbjTPSpC1gpc0zMXOG0ooVXJfqQ5lsO/sQrXpyXla06jC1Kswuzi9tPjBlw06BhhB
	 1F7DJxzmfAJOqFtLNRxciT402HuxNbDoGyF6xHx6GBE40D6+FVo3sJMRxFabL/9JwQ
	 J7XzV5Mo1VzdisuD0ANixY1Z/Q9+ePj+tkoqVcc8EosuxVP8HSB3mze80H7tHqy66W
	 LuCiEvaCHW2UduvJFgr1ebe4=
Date: Fri, 16 Jan 2026 13:54:15 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bug report][bisected] kernel BUG at lib/list_debug.c:32!
 triggered by blktests nvme/049
Content-Language: en-GB
To: Ming Lei <ming.lei@redhat.com>, Yi Zhang <yi.zhang@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, fengnanchang@gmail.com,
 linux-block <linux-block@vger.kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs_SLPj9v9w5MgfzHKy+983enPx3ZQY2kMuMJ1202DBefw@mail.gmail.com>
 <0e1446e1-f2a7-41f4-8b3c-bce225f49aa6@kernel.dk>
 <CAHj4cs-uHD_cm_5MHAS2Nyd1Dt6=sqNPrD4yWZrbykM+WvyxbQ@mail.gmail.com>
 <CAHj4cs_d81+Tbe+kh=9sz-ort4MZnC1F5gzPLGt2jrDJxA2P_g@mail.gmail.com>
 <aWekEgznso6zkgdI@fedora>
From: Alexander Atanasov <alex@zazolabs.com>
Reply-To: alex+zkern@zazolabs.com
In-Reply-To: <aWekEgznso6zkgdI@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Ming,

On 14.01.26 16:11, Ming Lei wrote:
> On Wed, Jan 14, 2026 at 01:58:03PM +0800, Yi Zhang wrote:
>> On Thu, Jan 8, 2026 at 2:39 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>>>
>>> On Thu, Jan 8, 2026 at 12:48 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 1/7/26 9:39 AM, Yi Zhang wrote:
>>>>> Hi
>>>>> The following issue[2] was triggered by blktests nvme/059 and it's
>>>>
>>>> nvme/049 presumably?
>>>>
>>> Yes.
>>>
>>>>> 100% reproduced with commit[1]. Please help check it and let me know
>>>>> if you need any info/test for it.
>>>>> Seems it's one regression, I will try to test with the latest
>>>>> linux-block/for-next and also bisect it tomorrow.
>>>>
>>>> Doesn't reproduce for me on the current tree, but nothing since:
>>>>
>>>>> commit 5ee81d4ae52ec4e9206efb4c1b06e269407aba11
>>>>> Merge: 29cefd61e0c6 fcf463b92a08
>>>>> Author: Jens Axboe <axboe@kernel.dk>
>>>>> Date:   Tue Jan 6 05:48:07 2026 -0700
>>>>>
>>>>>      Merge branch 'for-7.0/blk-pvec' into for-next
>>>>
>>>> should have impacted that. So please do bisect.
>>>
>>> Hi Jens
>>> The issue seems was introduced from below commit.
>>> and the issue cannot be reproduced after reverting this commit.
>>
>> The issue still can be reproduced on the latest linux-block/for-next
> 
> Hi Yi,
> 
> Can you try the following patch?
> 
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index a9c097dacad6..7b0e62b8322b 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -425,14 +425,23 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
>   	pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
>   
>   	/*
> -	 * IOPOLL could potentially complete this request directly, but
> -	 * if multiple rings are polling on the same queue, then it's possible
> -	 * for one ring to find completions for another ring. Punting the
> -	 * completion via task_work will always direct it to the right
> -	 * location, rather than potentially complete requests for ringA
> -	 * under iopoll invocations from ringB.
> +	 * For IOPOLL, complete the request inline. The request's io_kiocb
> +	 * uses a union for io_task_work and iopoll_node, so scheduling
> +	 * task_work would corrupt the iopoll_list while the request is
> +	 * still on it. io_uring_cmd_done() handles IOPOLL by setting
> +	 * iopoll_completed rather than scheduling task_work.
> +	 *
> +	 * For non-IOPOLL, complete via task_work to ensure we run in the
> +	 * submitter's context and handling multiple rings is safe.
>   	 */
> -	io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
> +	if (blk_rq_is_poll(req)) {
> +		if (pdu->bio)
> +			blk_rq_unmap_user(pdu->bio);
> +		io_uring_cmd_done32(ioucmd, pdu->status, pdu->result, 0);
> +	} else {
> +		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
> +	}
> +
>   	return RQ_END_IO_FREE;
>   }


While this is a good optimisation and it will fix the list issue for a 
single user - it may crash with multiple users of the context. I am 
still learning this code, so excuse my ignorance here and there.

The bisected patch 3c7d76d6128a changed io_wq_work_list which looks like 
safe to be used  without locks (it is a derivate of llist) , list_head 
require proper locking to be safe.

ctx can be used to poll multiple files, iopoll_list is a list for that 
reason.
sqpoll is calling io_iopoll_req_issued without lock -> it does 
list_add_tail
if that races with other list addition or deletion it will corrupt the list.

is there any mechanism to prevent that? or i am missing something?



-- 
have fun,
alex

