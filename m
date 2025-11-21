Received: from sg-1-18.ptr.blmpb.com (sg-1-18.ptr.blmpb.com [118.26.132.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2157D263F54
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763727200; cv=none; b=LjIrYQHN5F3dLyY+Gp1RV95Z93YPQvbWQ4E05bNRMizWeV/5yXghF+41XH3/l//M/h2IlPKoC9i6IzEpEpa3JH3AcOKMHztAYooVpHYe5z9hamrPAnS2JOdU99XisVukSUTucysIcwKc9JDF41CG8CQ/6W+ycyRmlxG0z3UaCBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763727200; c=relaxed/simple;
	bh=UYQuDKMSOpZopj18FEqTzyTUDrXX8K4GE6onCo1s1xs=;
	h=Content-Type:To:From:Date:References:Subject:Cc:Message-Id:
	 Mime-Version:In-Reply-To; b=cPYakADcNDR98RpI+WUv9L1VAgpnAHOc5UFJeRuayoegDJf5eZ2QhXxk3/6bXXI3ivFZQfpuJ2L+v4sAUYyab7AI3fTHtETnKANsJhmotGEDjKLFb6Ty9ywSTa0cWFTDFNCvpTTLL4lp8oggiLDHMeDYOcWfNXnUFACdiiGFbmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=CV8/5I15; arc=none smtp.client-ip=118.26.132.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="CV8/5I15"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763727186;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=fTWUveXDuBNk64n4E0vwB+NxmQVzH3R009+5A+g0irg=;
 b=CV8/5I15e/9cztN1KSnv+RhbEMIjnZmqi7s4xe5E+X3uZ6el7RjtP2JVWaIuZjdkBmRzR0
 Z4FkwHS4fz5ztScf3qQY+xuWx2fB1vmJkG09v8QVsacMTxUKLiNJOIy0Ng45MsSaYNWTte
 M2h53o6fsQwQDQ6tKgZGKO4HrZ0zURuEhMlcLQsA8HpyU7HPx71HgUipye/uoWLDZ0AHuA
 luuz6a6UJgEtJROPKrYCQUegN5LYchFV9Taib+FCPLLlnjaaGmyC1O0oV2VKWKLGWHs7O6
 MbTilbxNHOgn/z1tugV8ZgoR3eTFXuLSPSOpIJw8m2tYUrQZw7q/a/wHsNKhTw==
Content-Transfer-Encoding: quoted-printable
Received: from [192.168.1.104] ([39.182.0.153]) by smtp.feishu.cn with ESMTPS; Fri, 21 Nov 2025 20:13:04 +0800
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
To: "Nilay Shroff" <nilay@linux.ibm.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Fri, 21 Nov 2025 20:13:03 +0800
References: <20251121062829.1433332-1-yukuai@fnnas.com> <20251121062829.1433332-9-yukuai@fnnas.com> <400cb68d-6137-4618-9b85-6b43a3732827@linux.ibm.com>
Reply-To: yukuai@fnnas.com
Subject: Re: [PATCH v2 8/9] blk-iolatency: fix incorrect lock order for rq_qos_mutex and freeze queue
X-Original-From: Yu Kuai <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+269205751+ddd383+vger.kernel.org+yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
Cc: "Jens Axboe" <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"Tejun Heo" <tj@kernel.org>, "Ming Lei" <ming.lei@redhat.com>, 
	"Bart Van Assche" <bvanassche@acm.org>, "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <622715fa-2b44-488b-b9c7-b226bf5a3546@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <400cb68d-6137-4618-9b85-6b43a3732827@linux.ibm.com>
Organization: fnnas

Hi,

=E5=9C=A8 2025/11/21 18:53, Nilay Shroff =E5=86=99=E9=81=93:
>
> On 11/21/25 11:58 AM, Yu Kuai wrote:
>> Currently blk-iolatency will hold rq_qos_mutex first and then call
>> rq_qos_add() to freeze queue.
>>
>> Fix this problem by converting to use blkg_conf_open_bdev_frozen()
>> from iolatency_set_limit(), and convert to use rq_qos_add_frozen().
>>
>> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
>> ---
> So with this patchset, we have fixed locking order of ->freeze_lock
> and ->rq_qos_mutex for blk-iolatency, blk-iocost and wbt. But I still
> find following code paths where we still need to fix the locking
> order:
>
> tg_set_limit:
> blkg_conf_open_bdev  =3D> acquires ->rq_qos_mutex
>    blk_throtl_init    =3D> acquires ->freeze_lock
>
> tg_set_conf:
> blkg_conf_open_bdev  =3D> acquires ->rq_qos_mutex
>    blk_throtl_init    =3D> acquires ->freeze_lock

I think the freeze queue can be removed directly from blk_throtl_init(),
blk-throttle is bio based, and freeze queue can't stop new IO to blk-thrott=
le.

>
> Thanks,
> --Nilay
>

--=20
Thanks,
Kuai
