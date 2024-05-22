Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2526C141991;
	Wed, 22 May 2024 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401541; cv=none; b=JsZ0d1ZypwpCNPQ6rh8b2aCqsjPdfubaFInu5XwkaE8WFNI4//GpcGORwq1lwOt8UbrIhAXrO8vHtpAvTPF9wzJnhoqJ1GLASx5kV+UFvUSn3iv38FYsSWEK4h3ofSinorp0JgaeVMUYW6sAYnyPKOAeeWH3Y+iZoernqkde7QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401541; c=relaxed/simple;
	bh=/d4v5sYm1m6fuW79UH7BAzTvWviVCQgqSpnXSdESHns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOef6FiDK4yon+/qoVa+XA2xyZgzea3DOHlgOE05aWL5HgRJJTUzxFfIItTyLvObxZUCTDB9bnFU/eEKIDDNrj3k3lVCep7o3mqFqX0CZG2ArrW7bXzb6kA+GVbKstcMZ85szZEQtbiEnBZxh2GusOuWawyvtiIpjExPVRMZybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=BjTuCMuh; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="BjTuCMuh"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vkzsv4W3HzlgMVN;
	Wed, 22 May 2024 18:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716401537; x=1718993538; bh=ovcwOX7c3kKC7VfVSgG2qEQZ
	z0LFgHzfruEwaIPcjQI=; b=BjTuCMuhoqZIW+R/GHbffN1feXO1KNBl5rwqZExO
	tG/h1FfpnC6NETZnWurq0WKpfOFYPq3q5d7vp+iT+c3/FU6etpKyq/4ksMjcf30I
	QmddFHtuxgTM6jHx2HGNeHi6hBu6G7hmB7iNUdVjct1wFcHqH0yyU7mhBbJyfjlV
	7qo2etsKOicPQDolOSeXD7m+O88IQPpczOJ9FLcvJGGo2tUjDiPdqwZGk8FuFI0R
	EgCEaIuqiBV3FW/ReDIh6Py9sUZpZik+UPXvWUCl3dklRc2iPKi5GOPjtjI17pbx
	EpsQ+8TdGEBo/8RqlypYIU/HovgwarKY6msBQ0xZfCBdrw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id lFeQQcOfYWfF; Wed, 22 May 2024 18:12:17 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Vkzsr5hSvzlgMVL;
	Wed, 22 May 2024 18:12:16 +0000 (UTC)
Message-ID: <f6d3e1f2-e004-49bb-b6c1-969915ccab37@acm.org>
Date: Wed, 22 May 2024 11:12:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: inherit the ioprio in loop woker thread
To: Jens Axboe <axboe@kernel.dk>, Yunlong Xing <yunlong.xing@unisoc.com>,
 yunlongxing23@gmail.com, niuzhiguo84@gmail.com, Hao_hao.Wang@unisoc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240522074829.1750204-1-yunlong.xing@unisoc.com>
 <5166bc31-1fd9-4f7f-bc51-f1f50d9d5483@acm.org>
 <68cfbc08-6d39-4bc6-854d-5df0c94dbfd4@kernel.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <68cfbc08-6d39-4bc6-854d-5df0c94dbfd4@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 5/22/24 10:57, Jens Axboe wrote:
> On 5/22/24 11:38 AM, Bart Van Assche wrote:
>> On 5/22/24 00:48, Yunlong Xing wrote:
>>> @@ -1913,6 +1921,10 @@ static void loop_handle_cmd(struct loop_cmd *c=
md)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_active_me=
mcg(old_memcg);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 css_put(cmd_m=
emcg_css);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (ori_ioprio !=3D cmd_ioprio)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_task_ioprio(current, =
ori_ioprio);
>>> +
>>>  =C2=A0=C2=A0 failed:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* complete non-aio request */
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!use_aio || ret) {
>>
>> Does adding this call in the hot path have a measurable performance im=
pact?
>=20
> It's loop, I would not be concerned with overhead. But it does look pre=
tty
> bogus to modify the task ioprio from here.

Hi Jens,

Maybe Yunlong uses that call to pass the I/O priority to the I/O submitte=
r?

I think that it is easy to pass the I/O priority to the kiocb submitted b=
y
lo_rw_aio() without calling set_task_ioprio().

lo_read_simple() and lo_write_simple() however call vfs_iter_read() /
vfs_iter_write(). This results in a call of do_iter_readv_writev() and
init_sync_kiocb(). The latter function calls get_current_ioprio(). This i=
s
probably why the set_task_ioprio() call has been added?

Thanks,

Bart.


