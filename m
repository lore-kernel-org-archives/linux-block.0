Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EDC1FCCFF;
	Wed, 11 Dec 2024 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886240; cv=none; b=fIM7qkeYq1khVimSvW49w/LWocq6/2roYAnd3TFxUQ7kiSJkwkLgd4PeQqRuAV0UfK6CMQnOkcO1fB7h8Jv8sHkMz2yxkXkP7HkhBOvZgExWENpiKt2WDeJWOuAE6FOGe3+VWd17tECcnILOzQree7tT3yJKJLwtX8JOcCMfDOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886240; c=relaxed/simple;
	bh=DDpAtKF/oowSoN8XffL/c6pDjqE88/M5myb+dT2M7Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfmJEvEK2wvjWs1CDCj8wYfGAjOm4tbTXwf8ZBHwPtR9PvFQQThU+RnB6DZScKgz8MLc9OSCrQglLwUfV960O0KNDnWbWAjskhSS/TECz/4E5UmL+sBkt0rqe4fxYD6Z6/cxZS74jvuGdSIiUD3G+gYXDZz8hPGxpKIpDtVvY58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlJmHNOi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlJmHNOi"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43616bf3358so1292055e9.3;
        Tue, 10 Dec 2024 19:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733886236; x=1734491036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XSI9POCm7SdknhGW4h9dj1RnB/B3vkPocb0A/f7nkM=;
        b=OlJmHNOiIkPO2hyG/M/obbfZDfti8FavtiV9RM+yDHXGbuiz9pn383Ookqzc7ZsRtC
         S+bJwmPQ92sl7tp/rUvo44kRmCYp+xW9VqT0TDyOq3M+4ZegvpW70NBt7ixDCZG6vo9w
         TVvlAGQHZQpxlZgrPMgVkdD1Wvk3Uzd1JwcC1TJa+ghYAk06un0x+A/NcAtQSeh4xv+o
         Mib5YLZFjvi3nMV+R/lEPdrW7yrlro2cPxBKdWXet634OqCR8YBFmxpKIpwjAU6TPWJK
         MiAX7qBd/IMpw9KhkCvn1Jk3gSVUcuIslx56beNxirDC/QEDyEl0bj8rH0873SekcbJD
         XfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733886236; x=1734491036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XSI9POCm7SdknhGW4h9dj1RnB/B3vkPocb0A/f7nkM=;
        b=ST2vZQCvm02kayiNCnBnmntIlvPVP0P4nfoMwsRvRKdySQHWkhvtXbCp4QjMg+vnVw
         qpsIudAFCVLvV5kVlUm2K5NgWWp7Xkr0vgpCPDdX5rBTxQza7kbFfannWBYH2giT9kOD
         jxfoqy0V8wd3bx4RTZ2vUN2oPuyBiVHaKlTg/Ez0BVJijmY6Sj2Fvg0lvKpiAmnLzwq+
         aO+3ZBkiJS+wLLaZvzZeBGAZDeZnQAxFQ7e/Gg9wwSzh3viD79WLcPJIr+2G3NnVMFZ9
         g8z6Exgc0GTFSgXV3TwDRlM7dfdIj/GopXJk9n2lM7e/+k6JFGTbMPZh0LR8qE4NCWSa
         0g4w==
X-Forwarded-Encrypted: i=1; AJvYcCVwdIuXw9C8M0tjaoxBOnNfzyzL9No6+wGLx5XoVQ/g8wj5qX1ElVHZyIUX9K9UsG2OsT7DKdYPxNaAJVoz@vger.kernel.org, AJvYcCWzQsCaJvgj4iyfXVq8oJ5Duh2LYD6dmpa7pLr16t28inK2CPpgzTC6UyLI0XTUWY1nhAFACg5C7O2Wfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YztKrEV+r+pDUsyW0tiPaGq21Hpqj5wQ8+nATkxlsraixqe59CX
	SHtpaIuX0m93I7psMXSf5Fv54Np5Vb+dLKbpIbhCi3hARDW0+7X2v577ZViL6YNXsvmbY95Ditr
	oXsuwb2FHFMMgTjfBpbTHuqxSgoY=
X-Gm-Gg: ASbGnctLgLTzE9+Oj5fAStN9SwpKGK5bRGYdKZFmSh9kJ3SJbJI5KgURdo3vpTOFc8F
	R7TMpGfitx2yKM2Z0hUq5eOEJYH97fHeLRdLD
X-Google-Smtp-Source: AGHT+IHKkv5rLmj5rSA7P4IhKZ3DF1Y1dC0Gjq3K+6f1TGnoWkwDbt4bi4uuNqkdr8c9T8zRhC01Xv6CJzGLkIj94T4=
X-Received: by 2002:a05:6000:1acf:b0:386:3c21:b1f7 with SMTP id
 ffacd0b85a97d-3864cea3a60mr352113f8f.7.1733886236178; Tue, 10 Dec 2024
 19:03:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209115522.3741093-1-yukuai1@huaweicloud.com>
 <20241209115522.3741093-2-yukuai1@huaweicloud.com> <bef7b96c-a6cc-4b83-99b2-848cecb3d3b1@acm.org>
 <6e384b29-50d2-64bd-0d08-fc0f086c1cbd@huaweicloud.com> <7081765f-28d7-f594-1221-6034b9e88899@huaweicloud.com>
 <d9733af5-b16b-4644-9d6d-84fbacf334e0@acm.org> <CAHJ8P3J-KwGU_ZffmSmoFkhUX1q=9Q7Dk15yPEXYME_JQHH5tA@mail.gmail.com>
 <48ee35f1-dbbe-b4ff-2507-9c0e7bd4db0d@huaweicloud.com>
In-Reply-To: <48ee35f1-dbbe-b4ff-2507-9c0e7bd4db0d@huaweicloud.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 11 Dec 2024 11:03:45 +0800
Message-ID: <CAHJ8P3KcCB1OT9UDqcU3q7d+xQpVpqnFnsJ4Qav_fB6EZ3QB9Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] block/mq-deadline: Revert "block/mq-deadline: Fix
 the tag reservation code"
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, akpm@linux-foundation.org, 
	yang.yang@vivo.com, ming.lei@redhat.com, osandov@fb.com, 
	paolo.valente@linaro.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yu Kuai <yukuai1@huaweicloud.com> =E4=BA=8E2024=E5=B9=B412=E6=9C=8811=E6=97=
=A5=E5=91=A8=E4=B8=89 10:58=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> =E5=9C=A8 2024/12/11 10:38, Zhiguo Niu =E5=86=99=E9=81=93:
> > Bart Van Assche <bvanassche@acm.org> =E4=BA=8E2024=E5=B9=B412=E6=9C=881=
1=E6=97=A5=E5=91=A8=E4=B8=89 04:33=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 12/9/24 10:22 PM, Yu Kuai wrote:
> >>> First of all, are we in the agreement that it's not acceptable to
> >>> sacrifice performance in the default scenario just to make sure
> >>> functional correctness if async_depth is set to 1?
> >>
> >> How much does this affect performance? If this affects performance
> >> significantly I agree that this needs to be fixed.
> >>
> >>> If so, following are the options that I can think of to fix this:
> >>>
> >>> 1) make async_depth read-only, if 75% tags will hurt performance in s=
ome
> >>> cases, user can increase nr_requests to prevent it.
> >>> 2) refactor elevator sysfs api, remove eq->sysfs_lock and replace it
> >>> with q->sysfs_lock, so deadline_async_depth_store() will be protected
> >>> against changing hctxs, and min_shallow_depth can be updated here.
> >>> 3) other options?
> >>
> >> Another option is to remove the ability to configure async_depth. If i=
t
> >> is too much trouble to get the implementation right without causing
> >> regressions for existing workloads, one possibility is to remove suppo=
rt
> >> for restricting the number of asynchronous requests in flight.
> > Hi Bart,
> > I think it is very useful to restrict asynchronous requests when IO
> > loading is very heavy by aysnc_depth.
> > the following is my androidbench experiment in android device(sched_tag=
=3D128):
> > 1. setting heavy IO
> > while true; do fio -directory=3D/data -direct=3D0 -rw=3Dwrite -bs=3D64M
> > -size=3D1G -numjobs=3D5 -name=3Dfiotest
> > 2. run androidbench  and results=EF=BC=9A
> >                  orignial async_depth
> > async_depth=3Dnr_requests*3/4      delta
> > seq read             33.176                                216.49
> >                        183.314
> > seq write             28.57                                  62.152
> >                           33.582
> > radom read         1.518                                  1.648
> >                          0.13
> > radom write         3.546                                  4.27
> >                            0.724
> > and our customer also feedback there is optimization when they test
> > APP cold start and benchmark after tunning async_depth.
>
> So do you guys writing async_depth? Looks like you're using
> nr_requests*3/4. If this is the case, the above option 1) is still
> working for you guys. However, in this test, I think the lower
> async_depth is, the better result you'll get.
Hi Kuai,
yes, we modify async_depth to nr_reqeusts*3/4 by sysfs.
thanks!
>
> Thanks,
> Kuai
>
>
> > thanks=EF=BC=81
> >>
> >> Thanks,
> >>
> >> Bart.
> >>
> > .
> >
>
>
