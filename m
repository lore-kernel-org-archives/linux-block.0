Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.108.3.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627724;
	b=DWWwLgW8f7f8+4pKG5nRyIosCmox6uRNE5BsAeO+GWgubJnwY6c4+JT1VyUCSYT+RAI0
	 4HUROIqWnwfCl8UL9lZ5CS0xPIscouzW+LS0UgEe+silG233FQJelN+G8IicTnWcdiUjH
	 Wv69dIl7DJ1XIHuGOAKqsiU75TTotaVyEKxzt/oI4Jx8LbB3fXUaijNUwU51eSN/echEK
	 J8kSRjjTiGeKS7qp1b9jBIwreuGFqSEnKD0T77iYJuwBJt/HrY3GVGv6oJ9G6tU5If4qB
	 2SgQqk/L9LV4eHueFKgOMcx69rA4IeeSNXAzCK58tKRl6UjI3EnsIGcJ2WfiopiFD/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627724;
	h=DMARC-Filter:DKIM-Signature:X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:
	 X-SMAIL-MID:X-SMAIL-UIID:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aW8G8tvB/aSV+Sr88rLQ9L/lx+lE4jps8NAxRfMRF8s=;
	b=a4uqXuZKInSLve4e9U103b3fg/OALOmZb3ov6ruxVy5IBQEJL+j3fyTzc4Iw1PWTHdw7
	 HaGTvvQxYCKwnYHI0LOIFmDZ/JDNAdKPmIHFhonAd2Ze1iBQC87V6//tzLHsFzBo9wU4n
	 HyDguhIuuPJIXteOnNphMBLXHXkDA4xTTGcJeFiNu98xJAy/LsLPDB0v1cow0neYmeChe
	 C6MUaosMJtHo2m/0RaBpzb7XKvAHIrdDZ9q2K5wa1HBqe0nBLWS0Efn4l1x4e7h2Ic069
	 w+YQoQ06N/TUnJ2S6I3uXHq/OumUHE3NKIKMVWPfqWNdEfn01JT9RttDT9tho9yGR7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sina.com;
	spf=pass smtp.mailfrom=sina.com;
	dkim=pass header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=TpaOd5m7;
	arc=none smtp.remote-ip=202.108.3.23
Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D62606A31A
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 00:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42D62606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=TpaOd5m7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1792627722;
	bh=aW8G8tvB/aSV+Sr88rLQ9L/lx+lE4jps8NAxRfMRF8s=;
	h=From:Subject:Date:Message-ID;
	b=TpaOd5m7wqym/8E1q/prX/su+fCo6PGulEu/7KkhxomJUIgM9WpIUaLi2o9OZhXUb
	 bY73Y7oUdgiHYotAiCO2wqU0kCAgivL/TcqPI3EUS1NOgbll4V4nFL+I2r4oaR9Iu9
	 gCQhvMh76/oBXSuV9iKVOKSvoVaETzhkSevOXyH8=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([124.64.22.182])
	by sina.com (10.54.253.31) with ESMTP
	id 6AD953FD00002287; Thu, 22 Oct 2026 08:08:33 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3247236815943
X-SMAIL-UIID: BC0196746BD54520AFCFCA0E0C41DB93-20261022-080833-1
From: Hillf Danton <hdanton@sina.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v6 09/13] zram: split zcomp into separate R/W streams
Date: Thu, 22 Oct 2026 08:08:21 +0800
Message-ID: <20261022000822.938-1-hdanton@sina.com>
In-Reply-To: <20261021075322.923-1-hdanton@sina.com>
References: 
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 21 Oct 2026 15:53:21 +0800 Hillf Danton wrote:
>On Wed, 21 Oct 2026 13:56:17 +0900 Sergey Senozhatsky wrote:
>>On (26/10/21 12:23), Hillf Danton wrote:
>>> On Wed, 21 Oct 2026 11:42:19 +0900 Sergey Senozhatsky wrote:
>>> > Split struct zcomp_strm into separate compression (Write zcomp_cstrm)
>>> > and decompression (Read zcomp_dstrm) streams, and split zcomp_ops
>>> > context creation/destruction into create_cctx/destroy_cctx and
>>> > optional create_dctx/destroy_dctx callbacks.
>>> > 
>>> > This decouples Read (decompression) and Write (compression) paths so
>>> > they no longer contend on the same per-CPU stream mutex (Writer vs
>>> > Reader priority inversion).  Currently, a (low priority) Writer that
>>> > holds the stream mutex can be preempted by a (higher priority) Reader
>>> > on the same CPU, which then blocks on that mutex until the Writer gets
>>> > to run again and releases it, which can take a long time when there
>>> > are other runnable tasks on that CPU.
>>> >
>>> Given lock like mutex, priority inversion happens from Monday to Friday,
>>> but I wonder if you are inventing some wheels in 2026 if proxy excution
>>> works for you.
>>
>> Reader-Writer split is a foundation for further improvements (like
>> singleton recompression stream and so on).
>>
> But that split is not needed at all if PE works, yes?
>
Because PE is good at handling complex priority hiarchy. In a simple case,
task1(priority=1) is the owner of lock1 with two waiters, task2(priority=2)
and task3(priority=3), while task3 is the owner of lock2 also with two waiters,
task4(priority=5) and task5(priority=7).

When the number of locks and tasks grows, I have increasing difficulty even
describing the lock chain that you in combination with Brian are unable to
handle. That is why in general PE is prefered over whatever wheels you can create.
