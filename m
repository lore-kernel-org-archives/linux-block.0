Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D1C19BB9
	for <linux-block@vger.kernel.org>; Fri, 10 Nov 2023 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEDFZyYA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DD637AEA
	for <linux-block@vger.kernel.org>; Fri, 10 Nov 2023 05:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699623849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DnjW46Abv0ej124limqrwWwe0lfQZ5JkYvMeGFC1Tqc=;
	b=KEDFZyYAcoVhr5TU2L7S7bq0hmWxZ1QtmBsqVqAALyxIcUf7pPnUXzVty9L4IJEfbCtdlF
	Zv5aP2p2DtHGA+VDeJ0ADtZi5X1IYtA+BI8KOlGvEU5/R+TXBakTqW/GX4xXeOLnUaC881
	gmVDD9m2tESadZ6aSXRb+g5TpBK5tW0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-rar2-X2nMu-kISOW1m5VrQ-1; Fri, 10 Nov 2023 08:44:08 -0500
X-MC-Unique: rar2-X2nMu-kISOW1m5VrQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-282dcfbcc0aso2170996a91.3
        for <linux-block@vger.kernel.org>; Fri, 10 Nov 2023 05:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699623847; x=1700228647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnjW46Abv0ej124limqrwWwe0lfQZ5JkYvMeGFC1Tqc=;
        b=PqE9CxNeEy6Zlc46KYN2yTmjP+ZpIVNe6UkjvOxhxv5+5aJruCG2M8qO8Fsq8TBcct
         DCsj0puYLS65IOzajU49/wwAjyh/7uyvyYJ5wuFzJPh4jZ/NW2FYJ3prrT8kuOcoV8Ah
         x55c0eIpA1wOBcR1W7GrktD2g4FYuKzGbOkbiC1PEzxuDQqzPrxwPSkvQ/ueHSmAokeq
         RpBqFfzMWqksvwy31tzCR0Di37WaIWtcekUPxQ0iCLdalOYwzf5vZ27XN4eewJjHtQmb
         VKJ0+WhXM8ptwrKdRMfVIfKYYeSweFAQ5ioanbltE0F6Mhm+FURv4Iz7ULMnpEcjVW+7
         64Jg==
X-Gm-Message-State: AOJu0YycCfEojF4qEFkWj0lJnFhN5rTzMNBb8hP08K3Kkg/WxUG3qVcw
	wcG6uWASeacYGuoj489YjiffTtlCKar1FKXxHQO8jYyQncmEjV8DXH3cmHaHQ6aSRqAKoaNdPPN
	X7eote5F2Iszd/10c9UZJPP0fUqy3M73qBHnVjd8=
X-Received: by 2002:a17:90b:224f:b0:280:2c16:2186 with SMTP id hk15-20020a17090b224f00b002802c162186mr5009640pjb.30.1699623847051;
        Fri, 10 Nov 2023 05:44:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwGDKgTGsCWIuxpPtl3GMkMC2r0R+YMM3Xh/h0luoEWAAEtgkR451YJ/4Zt5QgiQCYMvTKuLukHgtujEsvAao=
X-Received: by 2002:a17:90b:224f:b0:280:2c16:2186 with SMTP id
 hk15-20020a17090b224f00b002802c162186mr5009622pjb.30.1699623846740; Fri, 10
 Nov 2023 05:44:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs8yZ4-BXqTK4W0UsPpmc2ctCD=_mYiwuAuvcmgS3+KJ8g@mail.gmail.com>
 <CAHj4cs8vqrePA-TE_GGNAZLG3iqZBq9L1GkanA4A0wRF_TXDeA@mail.gmail.com>
In-Reply-To: <CAHj4cs8vqrePA-TE_GGNAZLG3iqZBq9L1GkanA4A0wRF_TXDeA@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 10 Nov 2023 21:43:55 +0800
Message-ID: <CAHj4cs9HvFCB4XKwu_jtkV1HDVE_dY7XKOZ_aJrGS8tA8ROLRA@mail.gmail.com>
Subject: Re: [bug report][bisected] nvme authentication setup failed observed
 during blktests nvme/041 nvme/042 nvme/043
To: Hannes Reinecke <hare@suse.de>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, 
	Maurizio Lombardi <mlombard@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hannes

The issue still can be reproduced on the latest linux-block/for-next,
do you have a chance to check it, thanks.

On Thu, Oct 19, 2023 at 3:16=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> Hi Hanns
>
> Bisect shows it was introduced with this commit.
>
> commit d680063482885c15d68e958212c3d6ad40a510dd (HEAD)
> Author: Hannes Reinecke <hare@suse.de>
> Date:   Thu Oct 12 14:22:48 2023 +0200
>
>     nvme: rework NVME_AUTH Kconfig selection
>
>     Having a single Kconfig symbol NVME_AUTH conflates the selection
>     of the authentication functions from nvme/common and nvme/host,
>     causing kbuild robot to complain when building the nvme target
>     only. So introduce a Kconfig symbol NVME_HOST_AUTH for the nvme
>     host bits and use NVME_AUTH for the common functions only.
>     And move the CRYPTO selection into nvme/common to make it
>     easier to read.
>
> On Wed, Oct 18, 2023 at 2:57=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wr=
ote:
> >
> > Hello
> > Just found the blktests nvme/041 nvme/042 nvme/043[2] failed on the
> > latest linux-block/for-next[1],
> > from the log I can see it was due to authentication setup failed,
> > please help check it, thanks.
> >
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/l=
og/?h=3Dfor-next
> > e3db512c4ab6 (HEAD -> for-next, origin/for-next) Merge branch
> > 'for-6.7/block' into for-next
> >
> > [2]
> > # ./check nvme/041
> > nvme/041 (Create authenticated connections)                  [failed]
> >     runtime  3.274s  ...  3.980s
> >     --- tests/nvme/041.out      2023-10-17 08:02:17.046653814 -0400
> >     +++ /root/blktests/results/nodev/nvme/041.out.bad   2023-10-18
> > 02:50:03.496539083 -0400
> >     @@ -2,5 +2,5 @@
> >      Test unauthenticated connection (should fail)
> >      NQN:blktests-subsystem-1 disconnected 0 controller(s)
> >      Test authenticated connection
> >     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
> >     +NQN:blktests-subsystem-1 disconnected 0 controller(s)
> >      Test complete
> >
> > # dmesg
> > [ 2701.636964] loop: module loaded
> > [ 2702.074262] run blktests nvme/041 at 2023-10-18 02:49:59
> > [ 2702.302067] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [ 2702.447496] nvmet: creating nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> > with DH-HMAC-CHAP.
> > [ 2702.447707] nvme nvme0: qid 0: authentication setup failed
> > [ 2704.099618] nvmet: creating nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> > with DH-HMAC-CHAP.
> > [ 2704.099688] nvme nvme0: qid 0: authentication setup failed
> >
> >
> > --
> > Best Regards,
> >   Yi Zhang
>
>
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang

