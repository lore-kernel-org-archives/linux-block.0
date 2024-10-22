Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B53D14A09F
	for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729584176; cv=none; b=rPstjP7CAB/0EZK+gotHCQqzxIYU7JN+YJY73MNo2wbQmTiJOK3ky0aadQD1/TUUzOoDntSAI7i8EopZ5RW1Ib5AnDNiqGXVYZVUpynpqNOX4NgmwpsGKN9pr2G71nVGhgD3e2dbYNLojjgdr3LJdwOSP4+KVLHgVoAeDNGU8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729584176; c=relaxed/simple;
	bh=+F0JhNdgzeINwJGp8wLr2K56CdFX9zvu92jlmDr2FQs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SwwWeodqGEdQDnl9RW9I2FzctQOFIxxBlQ5ef1mktuYCjGn3TaacLgo0ROcxY9Wn59+EBRxCpEt3s7G6vvOUkiLxOvuG4x+odoxdiCg+ei2U2E/vBGJdmcWcyDcAtb8JrNcz1+NZ5qObQrWwSvDXHdZdRHR025uooZ1YtrFQKIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K6uBTYvk; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K6uBTYvk"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729584172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MNvdWP267aP5o9FLGaB5KaigNk7jDTNgJvyHFcfALiU=;
	b=K6uBTYvk2SRHTpQPbDtBnARpREGqFyHQk6pP2hVJdTafViKwieJNvCottH+Ugiz7peJ/E0
	Fa9pd4AdMwCuE6AYqswexHWfo0FIUkOGLq6IZsqRbK3yWl8XB1h6J4N/c001QsY6gMheM0
	LdMLYlkFuTk5biLBFMqgEbOfVBIye3g=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] block: remove redundant explicit memory barrier from
 rq_qos waiter and waker
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <c297cba9-5136-46b6-b2a4-5169a1a3f7cf@linux.dev>
Date: Tue, 22 Oct 2024 16:02:11 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 axboe@kernel.dk,
 josef@toxicpanda.com,
 oleg@redhat.com,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A88698A8-4334-4521-BEE9-39910D37C3DF@linux.dev>
References: <20241021085251.73353-1-songmuchun@bytedance.com>
 <c297cba9-5136-46b6-b2a4-5169a1a3f7cf@linux.dev>
To: Chengming Zhou <chengming.zhou@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Oct 22, 2024, at 15:53, Chengming Zhou <chengming.zhou@linux.dev> =
wrote:
>=20
> On 2024/10/21 16:52, Muchun Song wrote:
>> The memory barriers in list_del_init_careful() and =
list_empty_careful()
>> in pairs already handle the proper ordering between data.got_token
>> and data.wq.entry. So remove the redundant explicit barriers. And =
also
>> change a "break" statement to "return" to avoid redundant calling of
>> finish_wait().
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>=20
> Good catch! Just a small nit below, feel free to add:
>=20
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
>=20
>> ---
>>  block/blk-rq-qos.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
>> index dc510f493ba57..9b0aa7dd6779f 100644
>> --- a/block/blk-rq-qos.c
>> +++ b/block/blk-rq-qos.c
>> @@ -218,7 +218,6 @@ static int rq_qos_wake_function(struct =
wait_queue_entry *curr,
>>   		return -1;
>>     	data->got_token =3D true;
>> - 	smp_wmb();
>>   	wake_up_process(data->task);
>>   	list_del_init_careful(&curr->entry);
>>   	return 1;
>> @@ -274,10 +273,9 @@ void rq_qos_wait(struct rq_wait *rqw, void =
*private_data,
>>  			 * which means we now have two. Put our local =
token
>>  			 * and wake anyone else potentially waiting for =
one.
>>  			 */
>> - 			smp_rmb();
>>   			if (data.got_token)
>>   				cleanup_cb(rqw, private_data);
>> - 			break;
>> + 			return;
>>   		}
>=20
> Would it be better to move this acquire_inflight_cb() above out of
> the do-while(1) since we rely on the waker to get inflight counter
> for us?

I also noticed about this and I am working on this. Will send a separate
patch for this refactoring later.

Thanks.

>=20
> Thanks.
>=20
>>   io_schedule();
>>   has_sleeper =3D true;

