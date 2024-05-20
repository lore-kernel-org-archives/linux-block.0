Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8953379
	for <linux-block@vger.kernel.org>; Mon, 20 May 2024 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716201556; cv=none; b=qpdHp/nl30wMiVOmRZ8MztkNyQu0Gxn65w7pJk94g8Bb1bV4r3WHLsO4FnBZ7hge4CG7ir2UxrjFoX6NTJiK1GjBogaVF8ECQw5SJBxam6TjOWKYkgDggQNHKKfWcS5a7EOPT6t2XVMLUhVK2C7lOO0xg0RWa7zxDaD/8DfhczE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716201556; c=relaxed/simple;
	bh=HFgWWZL2wifN2cwpEjonm57Q/k5K+tvVYKfhgGUwrSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkXyhqjZYnNkp64gMP3Q7pGn6xQbbpX6z30DYVFLSWG7U/XUvCxcISyTWaS46TkXpRFdRdmhch5nxHRyhfo9CvnOTnncSEdGhULujQzdQyqAIyLNWdfIrunLXJ5cEQNes9oQVgVRc2N5ioE0gxSPB5bzx9pQnzGx4Muc0BtOC2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVxIr+/h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVxIr+/h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716201553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RlAqBOlKtvveeTtrv4Z304b9Esia2ku08LBiVu9x3+g=;
	b=gVxIr+/hbME8jpQOyZ0vXVnooZsNUsRSgFZ1km4cdy0zDwovgMCltSzn4+4++ZSjGJXjaT
	kQO12Jcioz8xo+xhp/SCNJo+5NjpPVMUMlfTZzNgtw/mJZ34HSfqmMuWHz8ym6MHaVBl0R
	wMScRPgNFhiC1F2dz4VTVduVuLdohS0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-YDynPmxQN6enrZ7qg3Xbxg-1; Mon, 20 May 2024 06:39:12 -0400
X-MC-Unique: YDynPmxQN6enrZ7qg3Xbxg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1edcfcaa2a4so109897925ad.0
        for <linux-block@vger.kernel.org>; Mon, 20 May 2024 03:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716201551; x=1716806351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlAqBOlKtvveeTtrv4Z304b9Esia2ku08LBiVu9x3+g=;
        b=osz+zl+rKZ8gaqkReAcu04VBXqyGvDBpCu0O9OSom5YT5CXgi+t66MQou3OyYtGO/Q
         4L/J6OcQ8EvEw9HpO9g7THnEh0AN2d5l/VxJPjkEPJhvjt3C6nroxJmjitLuINy0JW2+
         UxXwB9A6ZLgLhScE96ElNfE0mjy15GPrEzWCnG1ccqlECiqYvmdXunR/LIHZFh7Q/QeQ
         NENJGoizAk99sCjUauDvg+j7CgHJtPrK//q+NO7X/FmybzKxSzeaitMrUelLGrzj4zuM
         JN4CjLDeYpIaDOxLuKPZ3ARp9ovyo9c4CbOJfdi62w4m85ie7WHr+8Mb9Kdu+Vvg65tj
         oRDA==
X-Forwarded-Encrypted: i=1; AJvYcCVPQNM3n5IWQqHbKIhJMOS0wg1SUF3AAI9Qz6PU9Nlly9biSpiBm3rgDm5RzWGHL1FB+5RmXH2eh1OtedHuBtd1n/s6HJqwb9O5OSU=
X-Gm-Message-State: AOJu0YzrDeLSAP7BnyqGJ2wP5blCLjHNZNcUKHPkjgB3V6q7e4bnHATC
	bIaVsomH4Mroy8AnZaZKh+f0v3KuTSgJN0z2Mr7VdUBUyDa7WDndV3h3coxwFqX/Syl7njRuX8Y
	VdHmltHckl43XtoFxkx0ZoqkeFOkR4u/DWp5lVnZDL/QIQUsCb3RrAc4qlEUKFLpP/GFe94WJi6
	e3U3tJohoQcLYBHTjwOXjeetrjFYXPaqPEZ1U=
X-Received: by 2002:a05:6a20:dc95:b0:1aa:6613:2387 with SMTP id adf61e73a8af0-1afde1b01femr25864179637.47.1716201551309;
        Mon, 20 May 2024 03:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGweEbarBn6gVZIYtzMprWTNE7rrULCXr2Qkpb5hkVGaFeKkeBNZgclYJeiXDISg78hKS6RDFcIMHNXzq2EwxY=
X-Received: by 2002:a05:6a20:dc95:b0:1aa:6613:2387 with SMTP id
 adf61e73a8af0-1afde1b01femr25864167637.47.1716201550946; Mon, 20 May 2024
 03:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+Xsmzy2G9YuEatfMT6qv1M--YdOCQ0g7z7OVmcTbBxQAg@mail.gmail.com>
 <ZkXsOKV5d4T0Hyqu@fedora> <9b340157-dc0c-6e6a-3d92-f2c65b515461@huaweicloud.com>
 <CAGVVp+XtThX7=bZm441VxyVd-wv_ycdqMU=19a2pa4wUkbkJ3g@mail.gmail.com>
 <1b35a177-670a-4d2f-0b68-6eda769af37d@huaweicloud.com> <CAGVVp+WQVeV0PE12RvpojFTRB4rHXh6Lk01vLmdStw1W9zUACg@mail.gmail.com>
 <CAGVVp+WGyPS5nOQYhWtgJyQnXwUb-+Hui14pXqxd+-ZUjWpTrA@mail.gmail.com> <f1c98dd1-a62c-6857-3773-e05b80e6a763@huaweicloud.com>
In-Reply-To: <f1c98dd1-a62c-6857-3773-e05b80e6a763@huaweicloud.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Mon, 20 May 2024 18:38:59 +0800
Message-ID: <CAGVVp+UdBekv2udwxtXBrtn0CMTrBa94oE4taUfynWncYF5ETQ@mail.gmail.com>
Subject: Re: [bug report] INFO: task mdX_resync:42168 blocked for more than
 122 seconds
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Ming Lei <ming.lei@redhat.com>, Linux Block Devices <linux-block@vger.kernel.org>, 
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>, linux-raid@vger.kernel.org, 
	Xiao Ni <xni@redhat.com>, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 10:55=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> Hi, Changhui
>
> =E5=9C=A8 2024/05/20 8:39, Changhui Zhong =E5=86=99=E9=81=93:
> > [czhong@vm linux-block]$ git bisect bad
> > 060406c61c7cb4bbd82a02d179decca9c9bb3443 is the first bad commit
> > commit 060406c61c7cb4bbd82a02d179decca9c9bb3443
> > Author: Yu Kuai<yukuai3@huawei.com>
> > Date:   Thu May 9 20:38:25 2024 +0800
> >
> >      block: add plug while submitting IO
> >
> >      So that if caller didn't use plug, for example, __blkdev_direct_IO=
_simple()
> >      and __blkdev_direct_IO_async(), block layer can still benefit from=
 caching
> >      nsec time in the plug.
> >
> >      Signed-off-by: Yu Kuai<yukuai3@huawei.com>
> >      Link:https://lore.kernel.org/r/20240509123825.3225207-1-yukuai1@hu=
aweicloud.com
> >      Signed-off-by: Jens Axboe<axboe@kernel.dk>
> >
> >   block/blk-core.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
>
> Thanks for the test!
>
> I was surprised to see this blamed commit, and after taking a look at
> raid1 barrier code, I found that there are some known problems, fixed in
> raid10, while raid1 still unfixed. So I wonder this patch maybe just
> making the exist problem easier to reporduce.
>
> I'll start cooking patches to sync raid10 fixes to raid1, meanwhile,
> can you change your script to test raid10 as well, if raid10 is fine,
> I'll give you these patches later to test raid1.
>
> Thanks,
> Kuai
>

Hi=EF=BC=8C Kuai

I tested raid10 and trigger this issue too=EF=BC=8C

[  332.435340] Create raid10
[  332.573160] device-mapper: raid: Superblocks created for new raid set
[  332.595273] md/raid10:mdX: not clean -- starting background reconstructi=
on
[  332.595277] md/raid10:mdX: active with 4 out of 4 devices
[  332.597017] mdX: bitmap file is out of date, doing full recovery
[  332.603712] md: resync of RAID array mdX
[  492.173892] INFO: task mdX_resync:3092 blocked for more than 122 seconds=
.
[  492.180694]       Not tainted 6.9.0+ #1
[  492.184536] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  492.192365] task:mdX_resync      state:D stack:0     pid:3092
tgid:3092  ppid:2      flags:0x00004000
[  492.192368] Call Trace:
[  492.192370]  <TASK>
[  492.192371]  __schedule+0x222/0x670
[  492.192377]  schedule+0x2c/0xb0
[  492.192381]  raise_barrier+0xc3/0x190 [raid10]
[  492.192387]  ? __pfx_autoremove_wake_function+0x10/0x10
[  492.192392]  raid10_sync_request+0x2c3/0x1ae0 [raid10]
[  492.192397]  ? __schedule+0x22a/0x670
[  492.192398]  ? prepare_to_wait_event+0x5f/0x190
[  492.192401]  md_do_sync+0x660/0x1040
[  492.192405]  ? __pfx_autoremove_wake_function+0x10/0x10
[  492.192408]  md_thread+0xad/0x160
[  492.192410]  ? __pfx_md_thread+0x10/0x10
[  492.192411]  kthread+0xdc/0x110
[  492.192414]  ? __pfx_kthread+0x10/0x10
[  492.192416]  ret_from_fork+0x2d/0x50
[  492.192420]  ? __pfx_kthread+0x10/0x10
[  492.192421]  ret_from_fork_asm+0x1a/0x30
[  492.192424]  </TASK>

Thanks=EF=BC=8C
Changhui

