Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931023BCEE
	for <linux-block@vger.kernel.org>; Mon,  9 Mar 2026 23:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773100740; cv=none; b=R2H/D4tC6CH2x37VM/CVzBfFET8KizAwbp60n71npyDRq5jSbnRTXmeLNgkrN25rMV4lZu9/QTdVbNC73tqU+GIAspsbphdF65FIu7pFFNDVcbkqC0QXpzHMmNVCunAKycyr6uZVx5r/VGwbJZ7tAfqsMUBdiAzNG/pIi5C6DXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773100740; c=relaxed/simple;
	bh=40Mlp2c6INEworHVA8B/tjgxxnGjEAtQ2cBtMbRWvDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVxZWuf5o2Gkm5QB9zmkZUDZ0lTbRrsKYGU1f4Tdykz+Ng4vsJBcz3rGleu81aKRzZqPZwYNKQltO6/PAhZlg8+pLedBx8pfJQlubIKScx0zXpZBWnvzgKWx5NFBj345dRdzJ0LDmoJvl3OUFKlycAPSYScEjt4ZMClDkIJMw/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-661f8ea8a2bso4245818a12.0
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2026 16:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773100737; x=1773705537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oe74yVewJW4EdL4NdMuEiANgmdgDMqRgsPaxoV9IVrk=;
        b=wT5arzTiG/qXAkZvximl536HzWCWGwriZjEol93oBH9chW5oNZXZ91P5iOjDtGoEPN
         z8BUCR5l/6bQ+opUcoF83yb/0Ondw/BMIR0gbESpmnt9whNmT9qVEDL2NiNWZH+aK5MH
         +q08RmRMXdudSp3kYlgQ7BCEf7N/5dKK/KlKYX50HuhRo8jbXKrp9riESCWFF6zAmJMj
         HqkRFVvbNrRlMa/bad8soR8FFOVjoys4CybDSP8cW46ohUuRzBkpxxCTZfvSgGLMhNng
         NWEhl0yK4qNk5j8vHbEewwmzS7rVKQq7YpZcfnteX4yZk3Hv1j7IVkKKdqccuKXv1cOU
         TyAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3H2cjxDHa9ameMj1OjRoUEsptA6iyx5z0GlDP9+33pF8M3s8aKm/sDlRCHXIb5kBs95vwzNwUQ1MAUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxelFOmJDW42tIQg3tBLj4SNCAN9EsIBpznup98ubbc1ZWgWMQV
	R6n8LQ6+UCw3wiIFcftRVFN1aICVXeQydF3Mgx7iTORfSf40AF75cmZ8mcaU304wx1o=
X-Gm-Gg: ATEYQzwjndLjvR3do7nCnT+CvARqX1tyDjOt8YjLqIvRZS9r/0GAZHhLgQlPlQvYGHB
	ET6IDfV1E8oSWpkGDda9AogZDQnpUzoC8z/1CjRh4+nvDOLlvo9GKt0HcL1v61wn7JdRB/mAWZV
	5+jQXvHXl5B/Qxi0hi0HMCjZdyrAumJ03zV2ik5t5QQH8CnAyLHk7SFF031fWZrXBu+rmt++vCZ
	Vefz6bvSwYYXRT6w/d7DargK1RxkfzD16hskcEQGQFfFJCwlIncyQrw1B/iCAHClqt8u3UdUSC0
	ZXRPb/BOx/u6TxbzQ/0isBpBvzLsngt/YpFGXpUsK2F25uJlhlzYKM1e4jXDeiPl8WzJ3XuEPPG
	iCDTR6QUZomGQnxyItv7KWoNxRT229/fAylr1rnZkgId+iz+1cTx5xp5JNNYKSJVvotqX1Bw24Q
	OHMIMviYqizicOHIsAuotK3CMdZJSmhJJx+t7+47+EtSmHPYIUVBW/WLA=
X-Received: by 2002:a05:6402:1447:b0:662:d23a:d653 with SMTP id 4fb4d7f45d1cf-662d23ad82amr79750a12.1.1773100737060;
        Mon, 09 Mar 2026 16:58:57 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-661a3c66d6dsm3741866a12.6.2026.03.09.16.58.50
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 16:58:53 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439bcec8613so6462391f8f.3
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2026 16:58:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7CnDKnvHtaqiyfK3EcMS945agfQdnJWqjKwVXHQYcrBkiB9jtsQ0mqKI4yl6TrfiAiofwF7nBXYqIXQ==@vger.kernel.org
X-Received: by 2002:adf:f4cb:0:b0:439:df33:827f with SMTP id
 ffacd0b85a97d-439df33828emr14050045f8f.10.1773100730271; Mon, 09 Mar 2026
 16:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309062840.2937858-2-iam@sung-woo.kim> <202603090911.0DdOwjTR-lkp@intel.com>
 <CADUfDZqBZWwy+6XOde_aZTwLisRP8j5qRqB6X_EJJPr+wmdGZQ@mail.gmail.com>
In-Reply-To: <CADUfDZqBZWwy+6XOde_aZTwLisRP8j5qRqB6X_EJJPr+wmdGZQ@mail.gmail.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Mon, 9 Mar 2026 19:58:34 -0400
X-Gmail-Original-Message-ID: <CAJNyHp+a8FqB7Y8DobMxKOn9KAQXH0KvHTRgTjFuMppneSznvw@mail.gmail.com>
X-Gm-Features: AaiRm50FODLuR7mIvmUavdQJgpvkliqN2c7Myo_nPa5e2Uo34ON5h-NAjYa6-ys
Message-ID: <CAJNyHp+a8FqB7Y8DobMxKOn9KAQXH0KvHTRgTjFuMppneSznvw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: nvme: Fix general protection fault in nvme_setup_descriptor_pools()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: kernel test robot <lkp@intel.com>, Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, oe-kbuild-all@lists.linux.dev, 
	Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nbd@other.debian.org, linux-mmc@vger.kernel.org, 
	linux-mtd@lists.infradead.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 11:31=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Mon, Mar 9, 2026 at 1:42=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
> >
> > Hi Sungwoo,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on axboe/for-next]
> > [also build test ERROR on device-mapper-dm/for-next linus/master v6.16-=
rc1 next-20260306]
> > [cannot apply to linux-nvme/for-next]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Sungwoo-Kim/blk-=
mq-nvme-Fix-general-protection-fault-in-nvme_setup_descriptor_pools/2026030=
9-143107
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git=
 for-next
> > patch link:    https://lore.kernel.org/r/20260309062840.2937858-2-iam%4=
0sung-woo.kim
> > patch subject: [PATCH] blk-mq: nvme: Fix general protection fault in nv=
me_setup_descriptor_pools()
> > config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/2=
0260309/202603090911.0DdOwjTR-lkp@intel.com/config)
> > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87=
f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> > rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20260309/202603090911.0DdOwjTR-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202603090911.0DdOwjTR-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> > >> error[E0308]: mismatched types
> >    --> rust/kernel/block/mq/operations.rs:274:28
> >    |
> >    274 |         init_request: Some(Self::init_request_callback),
> >    |                       ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^ expected fn=
 pointer, found fn item
> >    |                       |
> >    |                       arguments to this enum variant are incorrect
> >    |
> >    =3D note: expected fn pointer `unsafe extern "C" fn(_, _, _, i32) ->=
 _`
> >    found fn item `unsafe extern "C" fn(_, _, _, u32) -> _ {block::mq::o=
perations::OperationsVTable::<T>::init_request_callback}`
> >    help: the type constructed contains `unsafe extern "C" fn(*mut bindi=
ngs::blk_mq_tag_set, *mut bindings::request, u32, u32) -> i32 {block::mq::o=
perations::OperationsVTable::<T>::init_request_callback}` due to the type o=
f the argument passed
>
> Looks like the type of _numa_node in the signature of
> init_request_callback() needs to be updated accordingly from c_uint to
> c_int.
>
> Best,
> Caleb

I will change it in V2, thanks.
Also, I may need to split the patches by driver as the cc list explodes.

Sungwoo
