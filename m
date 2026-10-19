Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8611A4F4056;
	Mon, 19 Oct 2026 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412925; cv=none; b=Z+QrX2OmgoR060MQUFP18mkWPZH3o852vw4PdGReqO+dBdHyM2zOeb6/VKcGc2VysOdvwnFFiiWgDB4gpNoQ6xzUcm4dpwAECiqZFfMz00kge+QcSu4eX/PrNaqCQB/9GoS7UHKUod4vAHtz5rE+ZROnBzHVDtQ4T0l5qDVIRvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412925; c=relaxed/simple;
	bh=xbSh8VFjeWbczn6NsKFf0SSrACNOGn/g7hZOMC5LA9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvyFDjF2MG2lGUtXpJqLMW1Mj6LvwFOseb9mV2SXDiGF7HPCDFJH48ZWGGkdW7y1aeMMsk9J25+aWH6HwALw7PgUXMIwHyxRxRhdaGm5lJ/b1HSlJ2QdJEdSezoroDbruGOhGj8Os4QlXwcjfdO2oBlcXPrpZMEIorVRWLDNkRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4z7gAYy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4z7gAYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2851B1F000C4;
	Mon, 19 Oct 2026 12:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792412916;
	bh=IIFCsAWGRSuf5M4nA5xTawVUSTiDV+swhik6qxRLBec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=b4z7gAYyBZK2V5Hjkl1dtfzWkor3tqf3Fk2S0O7SCCrVm3HV/dXEfsg2okE7fi6Ma
	 uC3uDftePYJmqrr5xLAutJh5e2jU0n6SJFEwQKm8MgIHZkdUxWp8Qwl1NcnBX1rG38
	 8LaJtLsf0F9i59m7ZuyO616+KaexOl9FXadzb16kzPCUCe6O78sgYBz7dYo7Q1Sbdo
	 t4OYsM8pPkvDjr4jnHQT1BckvFoxQsCcceTDL+oHo+uWerBxwdgpmE9vWAm3j8tcX0
	 CzQyUpUvQzQxwasC3f7hdEYGF2BU9spElvcn4i43HZLl8Hp3Zj4ixU8AFqJ6vxQ0QK
	 nVnoGwgpH7QPA==
Message-ID: <e4f8e0b7-4359-46fa-86f0-add298de21ad@kernel.org>
Date: Mon, 19 Oct 2026 14:28:34 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: annotate lockless task ioprio accesses
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261018071636.79198-1-ngocthang2710.1999@gmail.com>
 <20261019121816.9202-1-ngocthang2710.1999@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261019121816.9202-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/19 14:18, Nguyen Ngoc Thang wrote:
> Hi Damien,
> 
> Thanks for looking. I don't think RCU is needed here, because the reader
> can only be the owner of the io_context:
> 
>  - The only path that drops the task's reference is exit_io_context(),
>    which the task runs on itself in do_exit() (and on the copy_process()
>    error path, where the task never ran). It clears task->io_context
>    under task_lock() and only then puts the ioc.
>  - So when __get_task_ioprio() runs lockless, p == current, and current
>    cannot be inside exit_io_context() at the same time. Once the pointer
>    is non-NULL it stays valid for as long as current is executing; the
>    ioc cannot be freed under it.
>  - For p != current the function already requires p->alloc_lock
>    (lockdep_assert_held()), and that is what serializes against
>    exit_io_context().
> 
> The only thing another task can change under the lockless reader is the
> NULL -> ioc transition and ->ioprio, both done by set_task_ioprio() under
> task_lock(), and that is exactly what the KCSAN report shows
> ("value changed: 0x0 -> 0xffff..."). The patch only needs to make that
> publication and the ->ioprio accesses well defined, not to extend the
> lifetime of the ioc.
> 
> I can add a sentence to the commit message and a short comment in
> __get_task_ioprio() stating this lifetime rule in a v2 if you think it
> helps.

Yes, a comment would be nice.

-- 
Damien Le Moal
Western Digital Research
