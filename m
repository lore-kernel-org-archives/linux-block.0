Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F94C4BCAD6;
	Tue, 15 Sep 2026 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493807; cv=none; b=W0aRsK9J1GX7P0W9JQnJXPIEBInb7Wy2/Ro3mrb6rWvLaQMxBBByO2zQDGI4wDz2Rl87gTShomx2/YQ6moM0uaCD/7gOGcrm8czEpvxHwP5Xb+LTfnCc2VJqKLqMwshwBEX/eVETl2h9km9buAenaol4ZHNT2wibYvTw4nz6fv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493807; c=relaxed/simple;
	bh=haCJjpvxdy5Wk+oaFaPh7AyDc26SKJkmUlJxZtfxRw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s63CJsFEWyNPUKvW+uH10u5yn89IvEVjVSu/LQtx3jvX98T1l3oEvrsXYvmITHnqiHdKHhClxKc2jB9ghh9GywsaSBMMh1RYNk0r+58fnzLyfMidgRzd8w0AJRk9XduZNd1TYzMu0ftr63LQXL7lQ1qYbqVGDRRtvu6oiNAj3ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OUKMUYKB; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OUKMUYKB"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hkq2L3yX5zlfvq1;
	Tue, 15 Sep 2026 17:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1789493791; x=1792085792; bh=LVL2tZV2y084omEP1NoRSeYy
	3Kb1se75ERMKZV3zIek=; b=OUKMUYKB6lvNecxG/ZgpZj3UzwXkM6jAaXYchvLP
	KR0ApiVEtIW9xipyPkLRyVCC3PnhhfCYVyGc27GTuOznY1szMcrZavU4LUHvRfYz
	/jBTanELFdbIFLA5jZvqWsplGkUcKZ/y5nnsSua6YH8BnSQ4QyZvuMd52OnpjWFi
	pDWqM5HnjNA4L3X4A69uOo59/i7t8ZJcedjD4dAgi4z5cmhQgeeshcbasnxTG4+P
	nkut8ZWie7hIhzylmsOMV8JGcWDHELRfYN/vNKL5wymx3PyloFQkNxdZDvMADcCn
	L3EnnxKzvmXqBqj2mZ3z4/J0PneATHiDZEKr9Q6YkhrpBA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id P4eRAqqf1Lb3; Tue, 15 Sep 2026 17:36:31 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:c609:318c:4379:cce1] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hkq225l7bzlfvpG;
	Tue, 15 Sep 2026 17:36:26 +0000 (UTC)
Message-ID: <e8fd7e8c-4a14-49d6-8bce-16fd44d864b9@acm.org>
Date: Tue, 15 Sep 2026 10:36:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] loop: Perform __loop_clr_fd() after disk->open_mutex
 is dropped.
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Brian Foster
 <bfoster@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Hillf Danton <hdanton@sina.com>, Markus Elfring <Markus.Elfring@web.de>,
 Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
 linux-block <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org
References: <60bf7af2-b84e-4056-9195-a26ad51ada46@I-love.SAKURA.ne.jp>
 <9f1273a7-6dfe-46bb-966f-fe08876f4375@I-love.SAKURA.ne.jp>
 <3883b05e-0a34-43f7-b2a9-a46d2b0c5ffc@acm.org>
 <08b0057a-280d-4e55-8e94-e510ec1a371f@I-love.SAKURA.ne.jp>
 <d89aa722-2d13-4733-b5c1-f0194bf4b342@acm.org>
 <15037162-0e54-4722-ac7e-c9a863a8a2f7@I-love.SAKURA.ne.jp>
 <b700652d-ed63-444a-b879-ec2725affaa7@acm.org>
 <6fdefda9-c7e4-4368-8d9a-280043b4051e@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6fdefda9-c7e4-4368-8d9a-280043b4051e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 9/11/26 6:22 PM, Tetsuo Handa wrote:
> On 2026/09/12 10:02, Bart Van Assche wrote:
>> On 9/11/26 3:18 PM, Tetsuo Handa wrote:
>>> On 2026/09/12 5:03, Bart Van Assche wrote:
>>>> On 9/10/26 2:44 AM, Tetsuo Handa wrote:
>>>>> On 2026/09/10 4:33, Bart Van Assche wrote:
>>>>>> __loop_clr_fd() is queued from the lo_post_release() callback and =
hence
>>>>>> may be called concurrently with or after another thread has called
>>>>>> bdev_open(). Hence, lo->lo->state should be checked instead of ass=
uming
>>>>>> that it equals Lo_rundown.
>>>>>
>>>>> No, __loop_clr_fd() is queued from the lo_release() callback.
>>>>
>>>> Yes, it is *queued* from the lo_release() callback function but ther=
e is
>>>> no guarantee that __loop_clr_fd() has started before bdev_open() is
>>>> called again.
>>>
>>> Since lo->lo_state was set to Lo_rundown by lo_release(), lo_open() w=
ill return -ENXIO.
>>> What can go wrong if bdev_open() is called again before __loop_clr_fd=
() starts?
>>
>> This breaks LO_FLAGS_AUTOCLEAR, isn't it?
>=20
> Why do you think so?
>=20
>    App1                   App2                   system_long_wq
>    Calls lo_release().
>      Schedules __loop_clr_fd().
>                           Calls lo_open() but fails with -ENXIO.
>                                                  Starts __loop_clr_fd()=
.
>    Calls lo_post_release().
>      Starts waiting for completion of __loop_clr_fd().
>                                                  Finishes __loop_clr_fd=
().
>      Finishes waiting for completion of __loop_clr_fd().
>=20
>    Calls lo_open() again and succeeds.
>                           Calls lo_open() again and succeeds.
>=20
> App1's open() after close() is succeeding.
> App2's open() being temporarily failing with -ENXIO should be acceptabl=
e.
> If App2 wants to avoid repeatedly failing with -ENXIO, App2 should use
> ioctl(LOOP_CTL_GET_FREE) before open().

Userspace applications and tests (such as mount/umount, losetup,=20
systemd, and xfstests) expect that:
1. Teardown of a loop device with LO_FLAGS_AUTOCLEAR completes
    synchronously during the final close() (in lo_release()), releasing
    the backing file references (fput()).
2. Calling open() immediately after close() succeeds (allowing the loop
    device to be immediately reallocated, reopened, or configured in
    Lo_unbound state).

There is evidence of this in the history of drivers/block/loop.c:
* The Asynchronous Autoclear Regression & Revert (Commits 322c4293ecc5
   and bf23747ee053) In December 2021, commit 322c4293ecc5
   ("loop: make autoclear operation asynchronous") attempted to break a
   circular lock dependency by offloading autoclear (__loop_clr_fd())
   from lo_release() to a workqueue (system_long_wq).
* In February 2022, commit bf23747ee053 ("loop: revert 'make autoclear
   operation asynchronous'") had to revert that change after xfstests
   broke. The commit message explicitly states:

   "The kernel test robot is reporting that xfstest which does

 =C2=A0=C2=A0=C2=A0=C2=A0umount ext2 on xfs
 =C2=A0=C2=A0=C2=A0=C2=A0umount xfs

   sequence started failing, for commit 322c4293ecc58110 ("loop: make
   autoclear operation asynchronous") removed a guarantee that fput() of
   backing file is processed before lo_release() from close() returns to
   user mode."

   When autoclear was asynchronous, close() returned before the device
   was unbound and before the backing file was released, breaking
   immediate reuse and subsequent filesystem unmounts.

Bart.
