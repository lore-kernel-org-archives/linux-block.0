Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E62222EE5;
	Thu, 23 May 2024 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716444305; cv=none; b=dqZ3iM8VN0gkLqSVkjPFNRnk25/0OS7tUmNc9yhkFFtWGRmoFoHusLwoxsh9XINdUlaGIeFq/i/aHPIcuOHkq6ojVd5CevRhGNeSs847aEtUl1wQssBt1ekmMKOEV7OFfSurZmn6LslISBgnV0xzdSzIaloX10lL3u1euJ1wVDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716444305; c=relaxed/simple;
	bh=xuVFmGnMCHLH9XDU7D48st+tGBOCJEasnB5wNx7cChQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvolAW7bRJi+BltoQJfSz+NTwg8rEasNnE8sxkrc13fuAVYmhS/Sv4bjrqcWXrz0TN8qFXuvSoBOTQcaRRaZLD39+CDqxVGjZqnkbGht2On/wrf9goMqbA09KtVotLaTX2h6E0XZ8VBNHzrdFYQHVjiEsLWRvNCoUmPlnLsG0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miQKIh/l; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miQKIh/l"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b273b9f1deso3469977eaf.3;
        Wed, 22 May 2024 23:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716444303; x=1717049103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haSl/kZ0i8WyM/Os9e23TTkgxdWaac/6pmgJCb9FaF4=;
        b=miQKIh/lSMg6X+it67rQOVE/+vqyogtfkbE0RayE7IhrAujPVK7+tw6mQYWFc8NMNH
         KYnfDmYYc7jkY+AgBKRRb1dDFTbNDaMIG7VpI+g+iXXYXRBLGQS8xGJzZVt7PE7IO0Qg
         Y+W5AYE/OfDgTpaLlgM6Sb73Aecp42raZanEE9Ekdnn4O46tFeCJvpb6KIk2NESgM+rv
         lOKYz7J9YDNiEVVkytZHwKwCSUHxTKOMWWVSPivPyBNfk+vpbN5h6Cc7SIe3QEYgyoRW
         8UE6mSb8rNR8gbNnCH0JAo5ae61M3jGpmOvQ6VExm4NKTrvdc5cnLLkwrp5QrnisOnYk
         hEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716444303; x=1717049103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haSl/kZ0i8WyM/Os9e23TTkgxdWaac/6pmgJCb9FaF4=;
        b=HjENoBPg6JF4azyinNL+iRxPEJUrgaiT1kBF3OQcpMqyBUR4zSFwBLl3TxkGAZPTbb
         qQ4o9cvJxOIHtrxjPgLYQBG7UGiUtYP4ohG5McFzKA2U4coB0tl2z0d0vVRl2Rmgi5iM
         48oCVx/zjezJhUEpEzP758sNihOtau+YnZPPfsCcJHtTxQUzR7z92pX4pepYHFxKM5f9
         O30LgesZNz5E0Ke8vAF38dix+nRbR7/3DQzmq8NBocMu6x/G9znF/lBHRfmhUgkR5Npu
         E1PxVlaIk91NoiR4L9jvSH0ygI42SevQ40qlLI30+1KthbPrB0DQ4+PcP63eEBJgzO1w
         glEg==
X-Forwarded-Encrypted: i=1; AJvYcCXr/NjtvvM7aXqNyB9wUwGQ2bbsd9hrnTdLoTenLL1r2pVcsGpL//JDsNhmid56wCC2GeKaJfpFngewyx1hhD3x+ZDQRrXSjhnQJmAzAB8xTG7/dDo4ngNEdTcudhG2GODwBygx+ubjdnQ=
X-Gm-Message-State: AOJu0YzOnddT+NvDPZHGzBxOUGUYcTWs8wTg+e9yImTt5fqWbkoP43mv
	Y8Y0g+7LgNTf/JkSOa8wJ6G1hMX/V5OIIJZyPyPIoJ6V+U9vFZs5DhVv5gDqi0hLS+ihahEPzSs
	sPP2RWQ/TEViPA1seNIFelUPQuQEPQHvk
X-Google-Smtp-Source: AGHT+IGCYXNBmZeKzkGOUjGlAtH0nACOIbUlvRafCZv+wHRLOplMuFRkyz7m2kXCTWvlD5KC6SRvQrN0UUOrH7lDoHU=
X-Received: by 2002:a05:6820:2585:b0:5b5:3df2:326e with SMTP id
 006d021491bc7-5b6a4d681a6mr4166340eaf.9.1716444303576; Wed, 22 May 2024
 23:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522074829.1750204-1-yunlong.xing@unisoc.com>
 <5166bc31-1fd9-4f7f-bc51-f1f50d9d5483@acm.org> <68cfbc08-6d39-4bc6-854d-5df0c94dbfd4@kernel.dk>
 <f6d3e1f2-e004-49bb-b6c1-969915ccab37@acm.org>
In-Reply-To: <f6d3e1f2-e004-49bb-b6c1-969915ccab37@acm.org>
From: yunlong xing <yunlongxing23@gmail.com>
Date: Thu, 23 May 2024 14:04:52 +0800
Message-ID: <CA+3AYtS=5=_4cQK3=ASvgqQWWCohOsDuVwqiuDgErAnBJ17bBw@mail.gmail.com>
Subject: Re: [PATCH] loop: inherit the ioprio in loop woker thread
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Yunlong Xing <yunlong.xing@unisoc.com>, niuzhiguo84@gmail.com, 
	Hao_hao.Wang@unisoc.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bart Van Assche <bvanassche@acm.org> =E4=BA=8E2024=E5=B9=B45=E6=9C=8823=E6=
=97=A5=E5=91=A8=E5=9B=9B 02:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On 5/22/24 10:57, Jens Axboe wrote:
> > On 5/22/24 11:38 AM, Bart Van Assche wrote:
> >> On 5/22/24 00:48, Yunlong Xing wrote:
> >>> @@ -1913,6 +1921,10 @@ static void loop_handle_cmd(struct loop_cmd *c=
md)
> >>>            set_active_memcg(old_memcg);
> >>>            css_put(cmd_memcg_css);
> >>>        }
> >>> +
> >>> +    if (ori_ioprio !=3D cmd_ioprio)
> >>> +        set_task_ioprio(current, ori_ioprio);
> >>> +
> >>>     failed:
> >>>        /* complete non-aio request */
> >>>        if (!use_aio || ret) {
> >>
> >> Does adding this call in the hot path have a measurable performance im=
pact?
> >
> > It's loop, I would not be concerned with overhead. But it does look pre=
tty
> > bogus to modify the task ioprio from here.
>
> Hi Jens,
>
> Maybe Yunlong uses that call to pass the I/O priority to the I/O submitte=
r?
>
> I think that it is easy to pass the I/O priority to the kiocb submitted b=
y
> lo_rw_aio() without calling set_task_ioprio().
>
> lo_read_simple() and lo_write_simple() however call vfs_iter_read() /
> vfs_iter_write(). This results in a call of do_iter_readv_writev() and
> init_sync_kiocb(). The latter function calls get_current_ioprio(). This i=
s
> probably why the set_task_ioprio() call has been added?

Yeah that's why I call set_task_ioprio.  I want to the loop kwoker task=EF=
=BC=8Csubmit
I/O to the real disk device=EF=BC=8Ccan pass the iopriority of the loop dev=
ice request=EF=BC=8C
both lo_rw_aio() and lo_read_simple()/lo_write_simple().

Thanks,
yunlong.

>
> Thanks,
>
> Bart.
>
>
