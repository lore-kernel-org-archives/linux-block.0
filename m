Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2209F13B5AD
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719997751; cv=none; b=UnnT7oWq/Wwyu2OcUT1++/bHm82AgcAUQ3liW3zILco6YOlHcbM6quVbF/Q9pK1vR1RqypR14KylnhagxXbHNjwuVItmMakQecKO6Y4iVpjbUqhCVORpHDj2N0saWdDap2nfF0Yx9heWWeQT62RGnGQS/dgC/XwKUv85HU/5uCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719997751; c=relaxed/simple;
	bh=Q+dDCEE0NYhW9N7macndPjBmHx3DgdcFCWy5QsBxmbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCu+XAFf9qXCOdmk+HPOfDVKDxkf4w3K4SBOZ0jmLeBJ3CrIwjWSmmW29htaFsFk5itYZzQYhBM7hC505+L9ws5G0IAEq5/ik+bt9e+P4XNRpWHFv0YYuTVIsImpxnIxpXQOP9ibZzuT/4PjDPDdOnjiRP5DOj3ZYXNIUlmB640=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OqEQBYrn; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqEQBYrn"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4ef52ac0ff5so1563130e0c.1
        for <linux-block@vger.kernel.org>; Wed, 03 Jul 2024 02:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719997747; x=1720602547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J4/FsZ/Xgm2yNtP4JlZEMSDNR2rIdHMnZ1HyaIZt/z4=;
        b=OqEQBYrnrHUPC74EDEvooitGuyq3NmjWfLwrBuB5vbTBfjjAPALoljlhZZ8QMKKMKg
         zksZdlJCZpOgpHDtHscM6yFEEb5wHA6e/4UaVu/LmJPQTEBXurZv8L9xyYyi5vRn/ssY
         yjsQwGTdsIsi991iPFxCswMicLdYHUIg2c7zxtuPiNiuSRVuUre9gwtD0M7Ca3Jh5zJk
         s0doMrCWv4LIyCpAb/o6oPHW/JDzSvoPCh55jVs1GZYObQycfzwV7p5EIX+eGeEdPvHZ
         dGOlakajZry2wYXwxqETTAw0CIATrXOJJJL+nnp5yAwAnn2B+J3qJdh9yEZIDOVs0nKU
         bAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719997747; x=1720602547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4/FsZ/Xgm2yNtP4JlZEMSDNR2rIdHMnZ1HyaIZt/z4=;
        b=Ro84Da20WezxtNMs8MJszNPfW889jotka6uis9iAtFSTdLZzQGYOH29NUOkDviAWJM
         Ed4XqMFsu0sxs8RfqH5VsPHsWv5TOJdIXkmOT8tMdPcJWHtmUu2s6yfoFVCk5vSMGGgh
         j5MkHhNdAueF8e1AEQVx6yisq6lQDZjginUgUGptykY2XwGH+rbrFao8pniEaKpI7pvx
         IChsb8wYmOcVJAsdkjKqIXKpWb5rox1kURvUi1o32cNPmJHVfNx7qDCQUenH9zbI79sX
         S5zHgCsxHvJTLSrAo4NywJYVAS1VEbn9By632BvpsUQy4GekuueBd68wUX1yAdkoiwRj
         BegQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfPQ9t5lnwSMbslmhGhuLIiSKlWlC6YVpNqjfEU04+AFRqSXRoGyK4nwOwtYGwDUSEOs76ATFZEqdyAoyeQxvML1v0TxX5mvxrtT4=
X-Gm-Message-State: AOJu0Yy+aebfAD2RqPNDucbuJ3ovSUInlNQEFPSvxttSAP3IrUJBw8Qp
	+qyUtnSBgsErHfVDKy4JocII3xAtUb5XTzRXGDIqQaUk2N8PzPmlktfa1CAGfa7Lql9MZkK0/rp
	NlgmqED/8lDm3T70byB3guP1vR8Xexf56mprqyA==
X-Google-Smtp-Source: AGHT+IEvzMVTDQNBm4Nvho/bpAhQY9ss01kyvGkjiUkFUnpYA7JCZ5VK1Wb7L+EhxuFg9hFGCFIvApzy1MN/du+FGCk=
X-Received: by 2002:a05:6122:4a84:b0:4ef:280f:96ea with SMTP id
 71dfb90a1353d-4f2a565fb52mr12589732e0c.4.1719997745649; Wed, 03 Jul 2024
 02:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702170243.963426416@linuxfoundation.org>
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Jul 2024 14:38:54 +0530
Message-ID: <CA+G9fYuK+dFrz3dcuUkxbP3R-5NUiSVNJ3tAcRc=Wn=Hs0C5ng@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/222] 6.9.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, linux-block <linux-block@vger.kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 22:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.9.8 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

The following kernel warning was noticed on arm64 Qualcomm db845c device while
booting stable-rc 6.9.8-rc1.

This is not always a reproducible warning.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Boot log:
------
[    0.000000] Linux version 6.9.8-rc1 (tuxmake@tuxmake) (Debian clang
version 18.1.8 (++20240615103650+3b5b5c1ec4a3-1~exp1~20240615223815.136),
Debian LLD 18.1.8) #1 SMP PREEMPT @1719942561
[    0.000000] KASLR enabled
[    0.000000] Machine model: Thundercomm Dragonboard 845c
...
[    7.097994] ------------[ cut here ]------------
[    7.097997] WARNING: CPU: 5 PID: 418 at block/blk-mq.c:262
blk_mq_unquiesce_tagset (/builds/linux/block/blk-mq.c:295
/builds/linux/block/blk-mq.c:297)
[    7.098009] Modules linked in: drm_display_helper qcom_q6v5_mss
camcc_sdm845 i2c_qcom_geni videobuf2_memops qcom_rng bluetooth
videobuf2_common spi_geni_qcom qrtr gpi phy_qcom_qmp_usb aux_bridge
stm_core slim_qcom_ngd_ctrl qcrypto phy_qcom_qmp_ufs cfg80211 rfkill
icc_osm_l3 phy_qcom_qmp_pcie lmh ufs_qcom slimbus qcom_wdt
pdr_interface llcc_qcom qcom_q6v5_pas(+) qcom_pil_info icc_bwmon
qcom_q6v5 display_connector qcom_sysmon qcom_common drm_kms_helper
qcom_glink_smem mdt_loader qmi_helpers drm backlight socinfo rmtfs_mem
[    7.098062] Hardware name: Thundercomm Dragonboard 845c (DT)
[    7.098064] Workqueue: devfreq_wq devfreq_monitor
[    7.098071] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    7.098074] pc : blk_mq_unquiesce_tagset
(/builds/linux/block/blk-mq.c:295 /builds/linux/block/blk-mq.c:297)
[    7.098077] lr : blk_mq_unquiesce_tagset
(/builds/linux/block/blk-mq.c:262 /builds/linux/block/blk-mq.c:297)
[    7.098080] sp : ffff8000812f3b40
[    7.098081] x29: ffff8000812f3b40 x28: 00000000000f4240 x27: 20c49ba5e353f7cf
[    7.098086] x26: 0000000000000000 x25: 0000000000000000 x24: ffff5bbe0a2e9910
[    7.098089] x23: ffff5bbe01f1a170 x22: ffff5bbe0a2e9220 x21: 0000000000000000
[    7.098093] x20: ffff5bbe0a2e9620 x19: ffff5bbe01f1a0e0 x18: 0000000000000002
[    7.098096] x17: 0000000000000400 x16: 0000000000000400 x15: 00000000a63e566e
[    7.098099] x14: 0000000000015eb9 x13: ffff8000812f0000 x12: ffff8000812f4000
[    7.098103] x11: 7cea885bfc7e6700 x10: ffffb0c2e5eb69ac x9 : 0000000000000000
[    7.098106] x8 : ffff5bbe0a2e9624 x7 : ffff5bbe0c828000 x6 : 0000000000000003
[    7.098110] x5 : 00000000000009d3 x4 : 000000000000039e x3 : ffff8000812f3af0
[    7.098113] x2 : ffff5bbe0a2acc00 x1 : 0000000000000000 x0 : 0000000000000000
[    7.098117] Call trace:
[    7.098118] blk_mq_unquiesce_tagset
(/builds/linux/block/blk-mq.c:295 /builds/linux/block/blk-mq.c:297)
[    7.098121] ufshcd_devfreq_scale
(/builds/linux/drivers/ufs/core/ufshcd.c:2050
/builds/linux/drivers/ufs/core/ufshcd.c:1426
/builds/linux/drivers/ufs/core/ufshcd.c:1472)
[    7.098126] ufshcd_devfreq_target
(/builds/linux/drivers/ufs/core/ufshcd.c:1581)
[    7.098129] devfreq_set_target (/builds/linux/drivers/devfreq/devfreq.c:364)
[    7.098132] devfreq_update_target (/builds/linux/drivers/devfreq/devfreq.c:0)
[    7.098134] devfreq_monitor (/builds/linux/drivers/devfreq/devfreq.c:461)
[    7.098136] process_scheduled_works
(/builds/linux/kernel/workqueue.c:3272
/builds/linux/kernel/workqueue.c:3348)
[    7.098141] worker_thread (/builds/linux/include/linux/list.h:373
/builds/linux/kernel/workqueue.c:955
/builds/linux/kernel/workqueue.c:3430)
[    7.098143] kthread (/builds/linux/kernel/kthread.c:390)
[    7.098146] ret_from_fork (/builds/linux/arch/arm64/kernel/entry.S:861)
[    7.098150] ---[ end trace 0000000000000000 ]---


Full boot log link:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.7-223-g03247eed042d/testrun/24504400/suite/log-parser-boot/test/check-kernel-exception/log
 - https://lkft.validation.linaro.org/scheduler/job/7711345#L5312

Details of build and test environment:
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2ihUJNrmztabOMpKVRNzLpixoUR

Build, vmlinux, System.map and Image,
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2ihUHH774XQWba653iwCVtCnpjl/

metadata:
-------
  git_describe: v6.9.7-223-g03247eed042d
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_sha: 03247eed042d6a770c3a2adaeed6b7b4a0f0b46c
  kernel-config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2ihUHH774XQWba653iwCVtCnpjl/config
  kernel_version: 6.9.8-rc1
  toolchain: clang-18
  build-url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ihUHH774XQWba653iwCVtCnpjl/
  build_name: clang-18-lkftconfig

--
Linaro LKFT
https://lkft.linaro.org
