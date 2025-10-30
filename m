Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992F818A93F
	for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833259; cv=none; b=u9V++8+WMwowFCaSMo6zn3sMKbrJZzGTHo60tZ3Qhiu68xSfsJ3hYyAmnCpj0BwMNF86bx+DouezqOT/fm8GirmsQHK2fkKLQjJCMMbWDTkPJyj0hqGttGqqKaLH4qM7o5+0/Pd8qYdMQN8R9DvEnMK+neTOYliPeMQzWH7MdFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833259; c=relaxed/simple;
	bh=P1vXdtD0/zDTrhzDe4WtqYiJG27vKd72yMnPE4sZbxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjxwFdQIBgXXp/0EsGS2H2XnCQE1pW4TAJIyi49F8fUc7CgvB0jhYeHHvRtUAEc6UUPOV52XdEfSTqQ6Q2lYCIgPiMjh8aHbgoHMmnz4kruyrzfq7DohHN5XcP1OQCAJ2129E/HHg96O+HrZyTcj6WSpUYzxzH8wIjhMIUGYis4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PwgnNgs6; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PwgnNgs6"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6d0294865eso23352a12.2
        for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761833257; x=1762438057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAxgp4DobvE+uLPgcEm11YRUjuXuChtKAGj6UrKONnQ=;
        b=PwgnNgs63sFUAdiOI/N4hy65BGVaYSzjIW64Buw6r+IC3dcdBg/ubxtxLBTCOoswBz
         evaN9XcrnUuSJxxHClPAlYnlNEGiqrdvE1YXrkXsUE7euwiXarLUD5+UhcGEriJIWu+O
         FwayDnSwrbMWGpms/4/YyHIftgrDs+8gJ2XjVVQZ2cdmXrozeO+fC4WEwsnOtlU0nRnO
         /8/6R+36+LfCTBcrWa5NaSDv/3Az+czXQQOCqh47qkQI0zsqcHKWjAG6nSYlSVDNwd6O
         dh/gYtQxl37W8AIGgZtwFnv3zlI4LtsubV3XnWr7rIErT/g1L0BfFHPtMiSCm6d/LcpX
         R5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761833257; x=1762438057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAxgp4DobvE+uLPgcEm11YRUjuXuChtKAGj6UrKONnQ=;
        b=ia2/29kX3IG98PnKaGCnp5FVyNYEkOZ3gIwoyzkbPbf93ed4GG7E0vsjazNYl6txj5
         ncFBQfQqVFZ5Tb8wdl0ZQ/gyjkkJIFddOiI36qqGPG1T5/knIkJCt5cpiyhutLKxQ4b7
         XMbVOmSnxPTV701mGepDaMhrkU65WtTbQ0a/WS6s/mzlMuETRM5fZbHgfSk9Wi4BHBGM
         J51H18d7K5TdB/Etl9MlcUWfk83Z9x05HHU6RNodgRTeLJ9U1T44SSO/SUhkvfy3FLLM
         yuj9yNjEDHl8bfHouHZFLXLAKkmq+a9XaQkY4Hk2wWl9XS7TVKOoMi94f6K1gBlwUm/z
         NgRg==
X-Forwarded-Encrypted: i=1; AJvYcCUf/JmUP+alFoSCS2YtRYOP6K97NF7jXK2Br63U6w58jpi2Y8o+nvZ3MjsOYKMvhKghj750m7V8UNqfQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDsiSsHwLOa76DleDu/gHu7/xojkoJfRwNA5Gd0cn9EtjjAJbb
	iuAiqMdIQe2c24jenYV9ntQyKV/axOAMPaLSkfqzWiVgUR0V1bDUYtdLTjdl97YISnwP1XZqN+R
	9pr7yYjFaEgC6eAXdnYQn9TjHQOBxRvQEtLNBJRm7GA==
X-Gm-Gg: ASbGncsqJ5YC+WolYDTTN1liPR0aa1PkVv92pY++VC5z2k/QinM/1lc5mFaOZri7FxF
	kESpklcMN4V24yf7tQNAlSCgBIgqFKDXHCGbAOdxJ72lZQNNh1Esgp44/+OERSx2u4DRYZZiOGN
	FYr7u557ObNNYMWYvj+7+YGdKhKFCaQ95CRpu047Wu6NZW8CWO+kasBZbjUsjHZ19aDKePS8/AP
	8XBa2epBQLhGKLF0TS3qFXXdHbtHbfynvwI89K4GYG39R7yfRnn4p8VNBHpZ/unBByDV/YeH3dX
	NEkC5wwUPRJL1LoE
X-Google-Smtp-Source: AGHT+IGLk7sq7NhL8k8uqBKtrEmQ7vzjjb/AL2MdPgF05B2+INPNj0iaAaA6tgH/ao+zYq6pmzSG5GrrrFudXOsQ/80=
X-Received: by 2002:a17:903:41ca:b0:295:535:1bbd with SMTP id
 d9443c01a7336-295053520f7mr11380015ad.0.1761833256539; Thu, 30 Oct 2025
 07:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029031035.258766-3-ming.lei@redhat.com> <202510301522.i47z9R95-lkp@intel.com>
In-Reply-To: <202510301522.i47z9R95-lkp@intel.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 30 Oct 2025 07:07:25 -0700
X-Gm-Features: AWmQ_bmndyNTmYbHLvKzf_pj338cBa-tg0F7ZytjDWHgVSGpxBT7VI2JIZc-Vg8
Message-ID: <CADUfDZonryeHe1MGTfnUa16VbvEt5C+yu11yh3ZRDbwFqJ_L9w@mail.gmail.com>
Subject: Re: [PATCH V3 2/5] ublk: implement NUMA-aware memory allocation
To: kernel test robot <lkp@intel.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 1:01=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Ming,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on axboe-block/for-next]
> [also build test ERROR on shuah-kselftest/next shuah-kselftest/fixes linu=
s/master v6.18-rc3 next-20251029]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Ming-Lei/ublk-reor=
der-tag_set-initialization-before-queue-allocation/20251029-111323
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block=
.git for-next
> patch link:    https://lore.kernel.org/r/20251029031035.258766-3-ming.lei=
%40redhat.com
> patch subject: [PATCH V3 2/5] ublk: implement NUMA-aware memory allocatio=
n
> config: x86_64-randconfig-074-20251030 (https://download.01.org/0day-ci/a=
rchive/20251030/202510301522.i47z9R95-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251030/202510301522.i47z9R95-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510301522.i47z9R95-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> drivers/block/ublk_drv.c:240:49: error: 'counted_by' argument must be =
a simple declaration reference
>      240 |         struct ublk_queue       *queues[] __counted_by(dev_inf=
o.nr_hw_queues);
>          |                                                        ^~~~~~~=
~~~~~~~~~~~~~~

Hmm, guess it doesn't support nested fields?

>    include/linux/compiler_types.h:346:62: note: expanded from macro '__co=
unted_by'
>      346 | # define __counted_by(member)           __attribute__((__count=
ed_by__(member)))
>          |                                                               =
        ^~~~~~
>    1 error generated.
>
>
> vim +/counted_by +240 drivers/block/ublk_drv.c
>
>    208
>    209  struct ublk_device {
>    210          struct gendisk          *ub_disk;
>    211
>    212          struct ublksrv_ctrl_dev_info    dev_info;
>    213
>    214          struct blk_mq_tag_set   tag_set;
>    215
>    216          struct cdev             cdev;
>    217          struct device           cdev_dev;
>    218
>    219  #define UB_STATE_OPEN           0
>    220  #define UB_STATE_USED           1
>    221  #define UB_STATE_DELETED        2
>    222          unsigned long           state;
>    223          int                     ub_number;
>    224
>    225          struct mutex            mutex;
>    226
>    227          spinlock_t              lock;
>    228          struct mm_struct        *mm;
>    229
>    230          struct ublk_params      params;
>    231
>    232          struct completion       completion;
>    233          u32                     nr_io_ready;
>    234          bool                    unprivileged_daemons;
>    235          struct mutex cancel_mutex;
>    236          bool canceling;
>    237          pid_t   ublksrv_tgid;
>    238          struct delayed_work     exit_work;
>    239
>  > 240          struct ublk_queue       *queues[] __counted_by(dev_info.n=
r_hw_queues);
>    241  };
>    242
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
