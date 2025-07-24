Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDD84502A
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753341501; cv=none; b=uAIZ4eUTI953w+3kfv3q0g7e8h2leQxjHtB/Unmnk+PFdubqC/XxvId8uqEnYmb23EmrscUKp7tfe1K9KFuGvStfRwum3P+2jtdEGDMeZ6dX6Z4wzhzZoCJOcqgjgx2Qy/vBTBVyo2Vv4RQN/2EtP4PqcHUXL5Y/ztJadATdPUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753341501; c=relaxed/simple;
	bh=qlEWIA62NRgOhhITR3pzy6EIQK5VxIZd6tbvcUqTUs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGO76sp8NuVLianiEqIwsxGejYHqOtV1Q1sEpyYlycmcddFKmgUlaJtMSqTNAAiZbhocrJZxdzLACyB/Agla6r9BlMOQFL2XN2S6nReTSBb4JHi5By48q1bqNgiuKOPhR9rUPgUGRF+73uQ0cwS4vOz0GBBxGdFx5ho6KOsMspI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGz8RK/y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGz8RK/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753341498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucAcUI0oxjLLcTYAAp5xaRQcTTCmG7E8dOmD+w7aN5k=;
	b=jGz8RK/yMHyzISfatzhc+ERYpAxJj1hrJ1I4930klVI3B+ZEN0FRLPPB/oE3yVVWoxRZPF
	iNzTx8VApqcO+HpiydVia6+63rWGHWlM2w5CAh8tkgrFmoKO1eawsaBlEKcTJKn8npMlB4
	j2DbA/MF3xSPFjDqnO10nf2iOcoCEF8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-hy1JsmyZPLGSG7U-7-M4lg-1; Thu, 24 Jul 2025 03:18:13 -0400
X-MC-Unique: hy1JsmyZPLGSG7U-7-M4lg-1
X-Mimecast-MFC-AGG-ID: hy1JsmyZPLGSG7U-7-M4lg_1753341492
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-553ea44a706so360226e87.0
        for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 00:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753341492; x=1753946292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucAcUI0oxjLLcTYAAp5xaRQcTTCmG7E8dOmD+w7aN5k=;
        b=oZSocr06vOkgRApbxkomST3bifG4GEEWwhbYSMW4BHoeDElvMYNXK680pkm85wKSlL
         z8EYlYlqAYu2kWI9lCS5LkgYb3y5LVPBm1MSAXRmx9KdXxlxD1QLQKmgMvN3saGaqhUs
         iahYy78NTMfPdffOhQM2+gzdOMVdsU6sqYWWHsd9FezH8Us4vlTzYT9fcU8SRsoepLzY
         q02fA3zmPfaNWektoh9qSOSoDMsNZsUHqhRvizGFW+pWkl5I4S3mvDl4/9q75tsIxdyb
         Vi2tOIkt60S4aZy7i+xgWouCe8ab+NK9xQGu7o2xx894CcoQKppjrAJe4BOYTsAKlvLe
         zGzQ==
X-Gm-Message-State: AOJu0YyYBBpElA+MqDJbR5OWFrRhL+MMWdgksX8Nk3cWIwu/MoAMJ4o5
	3KfiUB7QiR0neRNq38xqfqrQNLGAMELFnfFCswsVkI88oe7EA7xaIDtU2sTWK4HVOK/lfGQOjCB
	FnMBws5h+KKHnLBQvDPkJFCxhivppdSfoIW58/V7Xqn9XoVf8mdIjT1UD9yF+EBmGRPoVPIX4lu
	XnsQOMImIIb3cmpi67rHYlyw4GHMU8dDAI1FZnwUk=
X-Gm-Gg: ASbGncuGv7kR4xKTSkVfyg+f0iwgSKFcPnkg0rm9OFEnmKDA/rESD2A6bX66cCrR0t8
	DMtilFkcZtxggzxqGct/CQUK1DnBh1iEYItpkSvTQgXNXDu2aRIBfI0EZRAbSmzx81LtoNA/jHI
	qHmLl2XRX/xsE0V2akTUCUgQ==
X-Received: by 2002:a05:6512:24cc:20b0:553:d122:f8e1 with SMTP id 2adb3069b0e04-55a513a031cmr1469200e87.43.1753341492177;
        Thu, 24 Jul 2025 00:18:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDb5edJwELvHRkbQZM+EcQjmIGAd+QEsxWwJrNVj551Ci8VvY5ZGjpkUXmT6yuDeKxiRjH9eRx9x8tewq3rHE=
X-Received: by 2002:a05:6512:24cc:20b0:553:d122:f8e1 with SMTP id
 2adb3069b0e04-55a513a031cmr1469191e87.43.1753341491697; Thu, 24 Jul 2025
 00:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+X8GYS7yKkq-qxJ5hpTL=vHMBgG=wuSsNJZ0VrjQeMA6w@mail.gmail.com>
In-Reply-To: <CAGVVp+X8GYS7yKkq-qxJ5hpTL=vHMBgG=wuSsNJZ0VrjQeMA6w@mail.gmail.com>
From: Xiao Ni <xni@redhat.com>
Date: Thu, 24 Jul 2025 15:17:59 +0800
X-Gm-Features: Ac12FXyHq_9raNt2rbflET65oGnekZLLf2VwvrGVcrstswcV72irJhPwzEwl5qo
Message-ID: <CALTww2-_9saPOtLC0dXUhQiK+2eV739rjwX3K3KDAz6AgbE6Ug@mail.gmail.com>
Subject: Re: [bug report] mdadm: Unable to initialize sysfs
To: Changhui Zhong <czhong@redhat.com>
Cc: Linux Block Devices <linux-block@vger.kernel.org>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Changhui

I guess you need to use the latest upstream mdadm. Could you have a
try with https://github.com/md-raid-utilities/mdadm/

Regards
Xiao

On Thu, Jul 24, 2025 at 3:07=E2=80=AFPM Changhui Zhong <czhong@redhat.com> =
wrote:
>
> Hello,
>
> mdadm fails to initialize the sysfs interface while attempting to
> assemble a RAID array,
> please help check and let me know if you need any info/test, thanks.
>
> repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.g=
it
> branch: for-next
> INFO: HEAD of cloned kernel
> commit a8fa1731867273dd09125fd23cc1df4c33a7dcc3
> Merge: b41d70c8f7bf 5ec9d26b78c4
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Tue Jul 22 19:10:37 2025 -0600
>
>     Merge branch 'for-6.17/block' into for-next
>
> reproducer:
> # mdadm -CR /dev/md0 -l 1 -n 2 /dev/sdb /dev/sdc -e 1.0
> mdadm: array /dev/md0 started.
> # mdadm -S /dev/md0
> mdadm: stopped /dev/md0
> # mdadm -A /dev/md0 /dev/sdb /dev/sdc
> mdadm: Unable to initialize sysfs
> # rpm -qa | grep mdadm
> mdadm-4.4-2.el10.x86_64
>
> and not hit this issue with upstream kernel
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>
>
> Best Regards,
> Changhui
>

