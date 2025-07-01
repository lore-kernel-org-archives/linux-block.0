Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982AE26A0ED
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751357170; cv=none; b=sYm9zLqtoi+iG0rLfjrpdHlwvI1xnIf6rlBbVhSslZZZLJdgjvmbuRmd+f5p8TbosaoSTxUfuVV4DEmQYXeQJUDkdKfvqGhf6i7eaH++VuEK1ejfefDJQlQ5ti89nILrDD9OkoBFZSu+b3JcteeEWCwRU8sj3aW6T4eHZMs/0+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751357170; c=relaxed/simple;
	bh=eP3FP/+t1auRhlAMxVQxgE8U6beXCfkcei1lgZdlmVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIDO8RJzvqOFCJAj3WLPpQpAIh2ba/wHBsusfxZB4Svd0Z3ZTvY4poyYjOjL+6+jmOePsjqXz1Kd5Xu1Zwgib7+/UgM+lc7vVMOL3MvIw608uCWP7aL7IuT7NnMzxmGW2V36IpG2Xg1NpNEDbGmmPSRSu+Drec5aO4nCFFq70es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wp+AWbCI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wp+AWbCI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751357166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5w/4T1qH3qTvqbjmkb3jwOmOH+DLa0AYagvRLvaEmeo=;
	b=Wp+AWbCIVATTlPI8d4u5kmJxfAUoqOyZ2PyHG6FOYYYuq1u45Ld7yjHYVWKSIGTRplhgG2
	OeCF9p8xUuxEU4SOCvRWIW3WOFUIZ6RYG1rj194CxnTYZcE4xZHM5h/66Y5ZucdMy48LrT
	dluV7hCpD3QD+Qk0Vq6cTJn/zkCRj+U=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-WqyAZYTmPGiH_zMA7Z4j0Q-1; Tue, 01 Jul 2025 04:06:05 -0400
X-MC-Unique: WqyAZYTmPGiH_zMA7Z4j0Q-1
X-Mimecast-MFC-AGG-ID: WqyAZYTmPGiH_zMA7Z4j0Q_1751357165
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso3178231a91.1
        for <linux-block@vger.kernel.org>; Tue, 01 Jul 2025 01:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751357164; x=1751961964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5w/4T1qH3qTvqbjmkb3jwOmOH+DLa0AYagvRLvaEmeo=;
        b=BC/5ypip0+f1NmNO2kZ2+CtF2ki+msQ8FqllehA0YhP/R+IsjILU6Y7daD+HmDfdh+
         xbKeKD/kPPBJCS72nNX8tiJOihaDHo+XT3fWn5u0LxTa/KM7SuxGG9SunEluE41tVGyz
         iIUKqHrJw2XVLkga8K6Sp9Gp98xAxaqV/cQM9mFbUffAOE8M4fMZI0kwqWakIcb7gSFo
         KfQeWBdZvfJ1aQgfY7JpnYrsoY2z5eD2iyUc2gwU1J883fj35p5Myol8dT7baRoCKkYA
         nZ+iCZ7Yq60FEB/K6rRWx/wr5vOKPPAMiJv5nRfDPWIX52l4Gi81mhKDcWblOQwyI830
         be9g==
X-Gm-Message-State: AOJu0YwOq5Wlyc6XbTSGLGLv/8ms6DUabd7IE8M1wb7/WzZdVMdlgSi8
	ea+HzUgwKM5kQOQcGI7AaLLXyWskVzKftBffi4TlYMTbhgFE7YPHxWAk/59lIjjnbEcZlJd865w
	bB1Jogc38SRhzBitvxJtvodU0K0QKztooX/ycOWcOcMeqiF47xuIg95JLSRt42rYXs5NtoLPHnx
	pICzXr0GhR+GApAiW7+k9rFHn0AHm8iJzsyL5j5HW6OX1L0+EFFg==
X-Gm-Gg: ASbGncvttQrtA4ezlJ4KdRsyNLXPoA14OAEdZjAujIqjaQCdqi9dsg+qWqAyixyTGHY
	moZ+oPaAvnixfyD53Xy/ztn18i1KgrsyR+giX7s686EHre8WpcTfJ++gz34EaG1LqRFEK6fBXBI
	p+jy5a
X-Received: by 2002:a17:90b:4c04:b0:312:1143:cf8c with SMTP id 98e67ed59e1d1-318c923bac6mr26229410a91.16.1751357164046;
        Tue, 01 Jul 2025 01:06:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEflJwMRD5RPN4KIbXVgqQfMqe5bQEb7SytU1VL3LfIGOKYDVeTOhUOnXWCS4oPhDXbzvs+LkepeWWvial0hKk=
X-Received: by 2002:a17:90b:4c04:b0:312:1143:cf8c with SMTP id
 98e67ed59e1d1-318c923bac6mr26229370a91.16.1751357163510; Tue, 01 Jul 2025
 01:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+UZ5VUYvW4ZktoF055Wg=PXO5vico76O3f_iwnfcLb-HA@mail.gmail.com>
 <aGNRFXWX3JS6GAAy@fedora>
In-Reply-To: <aGNRFXWX3JS6GAAy@fedora>
From: Changhui Zhong <czhong@redhat.com>
Date: Tue, 1 Jul 2025 16:05:52 +0800
X-Gm-Features: Ac12FXw5MmevJRDJl3rjGt78QQm9sE6CaBMjQ4-xgm3IelyGOfdYQFdDx2Ci-ts
Message-ID: <CAGVVp+XnKFQCZO_AgB1raFAvVLB-Ph35YJeqBTPuOAjwJ56hqg@mail.gmail.com>
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address: 0000000000000060
To: Ming Lei <ming.lei@redhat.com>
Cc: Linux Block Devices <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 11:08=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Hi Changhui,
>
> Thanks for the report!
>
> On Tue, Jul 01, 2025 at 09:55:23AM +0800, Changhui Zhong wrote:
> > Hello,
> >
> > the following kernel panic was triggered by 'ubdsrv  make test T=3Dgene=
ric' tests,
> > please help check and let me know if you need any info/test, thanks.
> >
> > repo: https://github.com/torvalds/linux.git
> > branch: master
> > INFO: HEAD of cloned kernel:
> > commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Sun Jun 29 13:09:04 2025 -0700
> >
> >     Linux 6.16-rc4
> >
> > dmesg log:
> > [ 3431.347957] BUG: kernel NULL pointer dereference, address: 000000000=
0000060
> > [ 3431.355744] #PF: supervisor read access in kernel mode
> > [ 3431.361484] #PF: error_code(0x0000) - not-present page
> > [ 3431.367224] PGD 119ffa067 P4D 0
> > [ 3431.370830] Oops: Oops: 0000 [#1] SMP NOPTI
> > [ 3431.375503] CPU: 22 UID: 0 PID: 397273 Comm: fio Tainted: G S
> >            6.16.0-rc4 #1 PREEMPT(voluntary)
> > [ 3431.386864] Tainted: [S]=3DCPU_OUT_OF_SPEC
> > [ 3431.391243] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
> > BIOS AFE118M-1.32 06/29/2022
> > [ 3431.400954] RIP: 0010:ublk_queue_rqs+0x7d/0x1c0 [ublk_drv]
>
> It is one regression of commit 524346e9d79f ("ublk: build batch from IOs =
in same io_ring_ctx and io task").
>
> io->cmd can't be derefered unless the uring cmd is live, and the followin=
g patch
> should fix the oops:
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c3e3c3b65a6d..99894d712c1f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1442,15 +1442,14 @@ static void ublk_queue_rqs(struct rq_list *rqlist=
)
>                 struct ublk_queue *this_q =3D req->mq_hctx->driver_data;
>                 struct ublk_io *this_io =3D &this_q->ios[req->tag];
>
> -               if (io && !ublk_belong_to_same_batch(io, this_io) &&
> -                               !rq_list_empty(&submit_list))
> -                       ublk_queue_cmd_list(io, &submit_list);
> -               io =3D this_io;
> -
> -               if (ublk_prep_req(this_q, req, true) =3D=3D BLK_STS_OK)
> +               if (ublk_prep_req(this_q, req, true) =3D=3D BLK_STS_OK) {
> +                       if (io && !ublk_belong_to_same_batch(io, this_io)=
 &&
> +                                       !rq_list_empty(&submit_list))
> +                               ublk_queue_cmd_list(io, &submit_list);
>                         rq_list_add_tail(&submit_list, req);
> -               else
> +               } else
>                         rq_list_add_tail(&requeue_list, req);
> +               io =3D this_io;
>         }
>
>         if (!rq_list_empty(&submit_list))
>
>
> Thanks,
> Ming
>

Hi=EF=BC=8CMing

thanks for fix patch=EF=BC=8CI ran the test 30 times with your patch and di=
d
not hit this issue again.
I saw you sent a new patch
https://lore.kernel.org/linux-block/20250701072325.1458109-1-ming.lei@redha=
t.com/T/#u
will re-run the tests for the new patch=EF=BC=8C

Thanks=EF=BC=8C

