Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54483D9045
	for <linux-block@vger.kernel.org>; Mon,  9 Mar 2026 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070312; cv=pass; b=eU3tzY3Brq4/JvY1D+8Upx9KsyKe4H3GKjlhE02d0MK5kiivxyLj3hjdTNBtruj1LNnYK1S+LA0XeD6rRkmKk6WV81USQ25YnnyWRiOIMt3atcfbxvg4nICZsIZ51dgJP4TnoGye0GkO0GbjtqZkMmNPKDAdc7kCKv5xBpBQwJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070312; c=relaxed/simple;
	bh=X4iZhElZiqQhLsc+HE815O54rp2BjBnsxJg+ObtrQac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKnbQKwy23ln+OaZhqrOm9i9yMwFmPy2ir85h+Nd013YHsIs9hONR4zUhMosiN7u1s8rldUHPc7kjH3zhsMO0wHqVgdjKn5vA+m4RVBTb+CLUiQUlfDI687CIHd4VGQ2g4vP3Ww7zVZmF2O7N6jm+qSg9BHK6v7cpMSo2TJG2Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MlKUimUG; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MlKUimUG"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d746975576so46016a34.3
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2026 08:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773070310; cv=none;
        d=google.com; s=arc-20240605;
        b=JJpRkXpxr8pXlZ8o9Pn3QdtI/1zVRYUkjHxhFvxWoxnSl9KxcST4jmc1QYCupfBvZs
         Cfe0oA8ldMTjPoVzUVfDxHIk9sgM1tIlsF5SIdGSCsZa0hhD8lrrPg3M3jVumyyqDXv3
         lQUdUqgn60MBxqeIe3HC9Ed0XpMuFzC9PCm6Vfe0tbrb05byLC40/5iXn9GvYWktJem4
         X9NAFP3D1zjh3c/D3IocxWipy/C314Vam7bivyl+poxCu+8fMthELUTkzMK34wQhuTbg
         TZ8UqGM2Z7XWm51a9k8+67LYpcYvvs6M1aiP6S1ry7Z7VdryHJMxKvC93rE73sh/NTGc
         qIQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oeNCYoeh9aVUManQKA2h7rmbYGtX7bI6QzEClpFzvxQ=;
        fh=zKhjsPn3pkiwBCWcNz7wOlKRfL0w3iLO+fBNw1U8PAE=;
        b=C2LZFvu3C9YwIGM1f+bNc8R7L+Ugw2PjksOnSGSfwcnuWIPVxX+jyFnxcFRXqUmeSV
         jb92mAfa0mhEKSPEFF3oWadOqJDHczcN+fdFF3/H6/mlYmnMk+dzP15Bd2CU1bvFEzC+
         MERHGc4j4yKJ0hFCD1ccrOS/JbtLt2a5v2rdz10LPL9+Lh+EDJBEiA/qHgF7AS7v6mrS
         dTogCZ8tqdiHiBtRoL81DnE3iOmKyJ6a1XfolxxCUacUuPYkZlKSHHL2ngilDiw0YdAR
         4SmndLXcJBKZcokGWe4KLhsQjOx8ViOmghwO/z7PN8eU6lujULw1VBIJikfZINxAebSj
         kwAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1773070310; x=1773675110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeNCYoeh9aVUManQKA2h7rmbYGtX7bI6QzEClpFzvxQ=;
        b=MlKUimUGje76EscbzLWcSlldqq111vtCpVcyo/wqC3rEMLkggIaJYPQ5AZQNQyihZs
         3ckPLpELVWUhsH1zg3WeNE8Jni+YaIjg/7CJERYYjynYc5kaGbWgeowbFNmJmEfzvFpt
         5ObBykiAohDjN4EDRisb0wT/BsZKh1kgXNqIK6FM1bQmQ+MsD8+WMQQ0N0r0IN6DmQvC
         Jnpow2om0w7St/ILTer4drfq6zGiEWKWS4W2LB6u1cZ8x9hi0Gwp4bzxS+Jpp82hS0fi
         VhzFedI3MMB6aDgc3a7W983nJDl2xZBgggGLLqmZEbMEatoBqk4jVBusq8YwPVGb5EmI
         wAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070310; x=1773675110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oeNCYoeh9aVUManQKA2h7rmbYGtX7bI6QzEClpFzvxQ=;
        b=gIbaepajiYqLx3jQFvrberEq1/rXepP6bg2KyR51/WsEWgNeHHoXhfwnAILOWxlawt
         4NbHFPhDOEABtU9oUAOyWj9OrVNcoCLZ9UP5NuVIG+wjP9RCHMkb1CtTCqUbp+CZ0USB
         /z4uYeGpaNWGQM0/G7PK4k5GhuDxqF0V3Bu3+3CVHx2IBIzE2rd4AMRKs1ZX/cObl1qM
         XlEHPnXpl11JKKbqQLYoGvPRCWrWY/HjdhAdMROEEBNcxmNm+F1V81hbTaEo5ddHacpJ
         4UmAfmRZEhZaLCA7NeIAg1es2wwuti9DhOpKNKZON03XrgMgjl2c0535Xgkl00AMCbpR
         g/gw==
X-Forwarded-Encrypted: i=1; AJvYcCUfInZjmfRqz43peQr3TWnC0Az2zSzylBKqmuDktBxtlvSRD8YfxK1BdJxNScftyPgHrJMfjw+g2YCWmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRU3U3DP8slYt/701BnExSWDPUSOOfBdeZSdGfqxP2cw9jxMJy
	3pRAqStvMUN3fu5sUbQrZIyfrSkuxTONQm7wpcIepe34WPau3tygPNv/tGhFZ7v0iCmy38JIQc9
	mIy3/9laZo8J7xsDngdBqE738bS/bdl+lSXxM/g7Aug==
X-Gm-Gg: ATEYQzxdkqNmzvPt4liCiF+K8GY1IiY7l56JBv8GVDSbt3NOmNKWjB0QozrevkmrHd5
	NdBZHpSllR1KnkLAuIT7K80r0DjFdnrJMFnJnoumxPHLRAbRakqxnhMv5cyZkzEJGW5ISdBARG1
	HF2acuFXmeFEb6lTadiSzVQ5rham5gqCBJvNojEVJnzvkCUUFojMSsT3OZvXFxlZaVjTZMGXa9J
	H5fMkcs8nggQPGfIYuyOZQdpHSe2LnRE/3yW5rVfSjpKaeIvbuCSmVH8RtmxhTSkKrUyOfLkOsN
	rHF8bIZGFrurpUZkXg==
X-Received: by 2002:a05:6830:4486:b0:7d7:4cf3:76eb with SMTP id
 46e09a7af769-7d74cf37b02mr2194872a34.4.1773070309370; Mon, 09 Mar 2026
 08:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309062840.2937858-2-iam@sung-woo.kim> <202603090911.0DdOwjTR-lkp@intel.com>
In-Reply-To: <202603090911.0DdOwjTR-lkp@intel.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 9 Mar 2026 08:31:38 -0700
X-Gm-Features: AaiRm52Z14MD0OSGkRezE5rp23B4YvHF_3hxCrYP4X9p-5DR-qWhmespFt1uSGc
Message-ID: <CADUfDZqBZWwy+6XOde_aZTwLisRP8j5qRqB6X_EJJPr+wmdGZQ@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: nvme: Fix general protection fault in nvme_setup_descriptor_pools()
To: kernel test robot <lkp@intel.com>
Cc: Sungwoo Kim <iam@sung-woo.kim>, Jens Axboe <axboe@kernel.dk>, 
	Josef Bacik <josef@toxicpanda.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
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

On Mon, Mar 9, 2026 at 1:42=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Sungwoo,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on axboe/for-next]
> [also build test ERROR on device-mapper-dm/for-next linus/master v6.16-rc=
1 next-20260306]
> [cannot apply to linux-nvme/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Sungwoo-Kim/blk-mq=
-nvme-Fix-general-protection-fault-in-nvme_setup_descriptor_pools/20260309-=
143107
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git f=
or-next
> patch link:    https://lore.kernel.org/r/20260309062840.2937858-2-iam%40s=
ung-woo.kim
> patch subject: [PATCH] blk-mq: nvme: Fix general protection fault in nvme=
_setup_descriptor_pools()
> config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/202=
60309/202603090911.0DdOwjTR-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
> rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260309/202603090911.0DdOwjTR-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603090911.0DdOwjTR-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> error[E0308]: mismatched types
>    --> rust/kernel/block/mq/operations.rs:274:28
>    |
>    274 |         init_request: Some(Self::init_request_callback),
>    |                       ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^ expected fn p=
ointer, found fn item
>    |                       |
>    |                       arguments to this enum variant are incorrect
>    |
>    =3D note: expected fn pointer `unsafe extern "C" fn(_, _, _, i32) -> _=
`
>    found fn item `unsafe extern "C" fn(_, _, _, u32) -> _ {block::mq::ope=
rations::OperationsVTable::<T>::init_request_callback}`
>    help: the type constructed contains `unsafe extern "C" fn(*mut binding=
s::blk_mq_tag_set, *mut bindings::request, u32, u32) -> i32 {block::mq::ope=
rations::OperationsVTable::<T>::init_request_callback}` due to the type of =
the argument passed

Looks like the type of _numa_node in the signature of
init_request_callback() needs to be updated accordingly from c_uint to
c_int.

Best,
Caleb


>    --> rust/kernel/block/mq/operations.rs:274:23
>    |
>    274 |         init_request: Some(Self::init_request_callback),
>    |                       ^^^^^---------------------------^
>    |                            |
>    |                            this argument influences the type of `Som=
e`
>    note: tuple variant defined here
>    --> /opt/cross/rustc-1.88.0-bindgen-0.72.1/rustup/toolchains/1.88.0-x8=
6_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/option.rs:597:=
5
>    |
>    597 |     Some(#[stable(feature =3D "rust1", since =3D "1.0.0")] T),
>    |     ^^^^
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
