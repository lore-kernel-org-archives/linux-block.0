Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FBE19992C
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768259973; cv=none; b=IMnOtvTdVlwko3PlOWlVJajTHzO+JxnTr07BUf3vFyYq8iyH0mrLjB3dQ+uAtwflxUvO3LTNX9Ndvtz2vCRq3NDOHnZ4H/8MzzMfqGE3v1Uzu/KaPqh1AFDLwsPtHj7IcVD07shspi66wUReU24BXEdVixEVBdP+daQLiJ77sDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768259973; c=relaxed/simple;
	bh=PUwXMI8rdnCFDJ9gUGvWdtS20G17WlYUWfNH9mlqAW8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PqkkrijhhZwOrgsdZhT3xbIeQkoB4ZnTRg+VDYqa5boUIJmej/y9enIXY+kHl4Xh/qE7e8GK2AhaaZ43R3/mulAB/7sPIFiA2/OT0g6JL7pHMvQjOnfYhfB/eaSc5WwvlNiT9vXd2hpu4yUlTHPXDiDF1z7uoWhd40S9nVgEgu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTfrEDSV; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTfrEDSV"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11f42e97229so10822298c88.0
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 15:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768259971; x=1768864771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XlOVVds3svBuxVzBfTrZzJ0fohoEn+GwfZV9WRnQpzE=;
        b=GTfrEDSVhkl0Jor3OENBxh+Ga9XQppkVaE0GXekPzi644q+uOvRFl+KrM8hshIAB9k
         rFSjyY4nvmJu8aGIr26tBsEOwVKhckFpIlAeeOr5z9wyhpgegjvZ4RoYCpL3S0pWJCn9
         24pXBc1bO7uUjZoEPqj39xrFfG4MniHrg9f6My6TlppKjLeDFff3cP45oHnAfFCAKNoL
         de96RVnsolkqMThf+4hKsfEbCpVDgCOBcbspmwwxeVVSfzjMOnnKVEw8dHrN10nUIbyJ
         qcWAqrWdriGwPnsXcJ1zMJG0wtPstMWO93I7FXZl4wl160vENICROweKFbBAjsGd5ioi
         ks3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768259971; x=1768864771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlOVVds3svBuxVzBfTrZzJ0fohoEn+GwfZV9WRnQpzE=;
        b=jiCB61nCk1HbqVWi++wu4ACNFNFysogHtZW+fePe++9n8aXGSNc+DdOVppoSizhmaj
         G8g/8/+0WlPtTdghJ6tvlA8jWEfKAEgot8j9Uennv+JC5husL1kauP84mpc/hmm/xfjR
         jWUd42Jr+9uacR59PFwbab5Nlds1Wijz5G6cmY+8KnSLRw3IKE6jrVJEcekPvpC9sjuC
         6RXHVo6WS9FNUh61OxQvCQtHMa3oDapLH4JCXGpPGoWMTwsmXG7DX9TbK/qvIeehFDTu
         rRdsB2HShstcY2Agg+7dDjvGkG4Vx20f0kk/Bqoc7fPk2zgqq4vkTDd7Y62eAELmcPjF
         3hZg==
X-Forwarded-Encrypted: i=1; AJvYcCW0I3f3KCzTV431snGmbE8Afi6yiWRxAvmUhTqxWpMeVuUi6Y05G6otNncHt+JnJKCxeCDfBXmX/X2RVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzBrGateXaqfCKa+13hGOUnmLYgU9czmpC0E8hTjahkly88ZPy
	5b+z9Q5w2FiNugUCQuIgNaiEmqOG1wrFL6x8N2WLrlLLQHB1vIz9fg7IjKpM8Q==
X-Gm-Gg: AY/fxX70DLAgrSFDm25eJldjyGfYYeHJL2E2cBeCmy5RhRZMYrHbm9hNg4dqXVANtCH
	6bmwrOeqIlrM6xHaS00GBKBx5op2EK7VdH4f8q26H1B5le9jmXbzO/oo2nhsui7Jqx4xAeTizSS
	dhE5h021YCq2oPtjDN5WvEP5T0/lCQJouxC6BhLXbCHOMdX1fGu0I6uR1jMeCGZfO+FNbIiDfbh
	Q13eRCiXcZlgKTK5KakLIEtLn3SlBsks/GEm/LsEKX5QDmCm5XIIzGU2w7Xfq/zqFFRwA/68/H5
	iOXCbzvh9dptYEXPqQewhM8t0kwWcGIyjQ6PWN2Gam4rYogJDktorDq1aaAcxGvABgCaBUcZgh9
	iMMcK4PSFktdljOedK07jb/Y7wKBMGH6imuAxEzjZaFOreCf6RZ8VzfDQ4CrRj7XJWwuIY4z3Vk
	o=
X-Google-Smtp-Source: AGHT+IHqB8gK66MmVCKMS4urLtGt0x3XGjVTy8USnGC2U0ZbDONh0hinmitGzbeMcJ9sAXmShb6vkg==
X-Received: by 2002:a05:7022:38c:b0:11a:51f9:daf with SMTP id a92af1059eb24-121f8ad8070mr19853946c88.14.1768259971294;
        Mon, 12 Jan 2026 15:19:31 -0800 (PST)
Received: from localhost ([2600:8802:b00:9ce0::64f3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c246sm26144626c88.11.2026.01.12.15.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:19:30 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	yanjun.zhu@linux.dev,
	grzegorz.prajsner@ionos.com
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH] rnbd-clt: fix refcount underflow in device unmap path
Date: Mon, 12 Jan 2026 15:19:28 -0800
Message-Id: <20260112231928.68185-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During device unmapping (triggered by module unload or explicit unmap),
a refcount underflow occurs causing a use-after-free warning:

  [14747.574913] ------------[ cut here ]------------
  [14747.574916] refcount_t: underflow; use-after-free.
  [14747.574917] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x55/0x90, CPU#9: kworker/9:1/378
  [14747.574924] Modules linked in: rnbd_client(-) rtrs_client rnbd_server rtrs_server rtrs_core ...
  [14747.574998] CPU: 9 UID: 0 PID: 378 Comm: kworker/9:1 Tainted: G           O     N  6.19.0-rc3lblk-fnext+ #42 PREEMPT(voluntary)
  [14747.575005] Workqueue: rnbd_clt_wq unmap_device_work [rnbd_client]
  [14747.575010] RIP: 0010:refcount_warn_saturate+0x55/0x90
  [14747.575037]  Call Trace:
  [14747.575038]   <TASK>
  [14747.575038]   rnbd_clt_unmap_device+0x170/0x1d0 [rnbd_client]
  [14747.575044]   process_one_work+0x211/0x600
  [14747.575052]   worker_thread+0x184/0x330
  [14747.575055]   ? __pfx_worker_thread+0x10/0x10
  [14747.575058]   kthread+0x10d/0x250
  [14747.575062]   ? __pfx_kthread+0x10/0x10
  [14747.575066]   ret_from_fork+0x319/0x390
  [14747.575069]   ? __pfx_kthread+0x10/0x10
  [14747.575072]   ret_from_fork_asm+0x1a/0x30
  [14747.575083]   </TASK>
  [14747.575096] ---[ end trace 0000000000000000 ]---

Befor this patch :-

The bug is a double kobject_put() on dev->kobj during device cleanup.

Kobject Lifecycle:
  kobject_init_and_add()  sets kobj.kref = 1  (initialization)
  kobject_put()           sets kobj.kref = 0  (should be called once)

* Before this patch:

rnbd_clt_unmap_device()
  rnbd_destroy_sysfs()
    kobject_del(&dev->kobj)                   [remove from sysfs]
    kobject_put(&dev->kobj)                   PUT #1 (WRONG!)
      kref: 1 to 0
      rnbd_dev_release()
        kfree(dev)                            [DEVICE FREED!]

  rnbd_destroy_gen_disk()                     [use-after-free!]

  rnbd_clt_put_dev()
    refcount_dec_and_test(&dev->refcount)
    kobject_put(&dev->kobj)                   PUT #2 (UNDERFLOW!)
      kref: 0 to -1                           [WARNING!]

The first kobject_put() in rnbd_destroy_sysfs() prematurely frees the
device via rnbd_dev_release(), then the second kobject_put() in
rnbd_clt_put_dev() causes refcount underflow.

* After this patch :- 

Remove kobject_put() from rnbd_destroy_sysfs(). This function should
only remove sysfs visibility (kobject_del), not manage object lifetime.

Call Graph (FIXED):

rnbd_clt_unmap_device()
  rnbd_destroy_sysfs()
    kobject_del(&dev->kobj)                   [remove from sysfs only]
                                              [kref unchanged: 1]

  rnbd_destroy_gen_disk()                     [device still valid]

  rnbd_clt_put_dev()
    refcount_dec_and_test(&dev->refcount)
    kobject_put(&dev->kobj)                   ONLY PUT (CORRECT!)
      kref: 1 to 0                            [BALANCED]
      rnbd_dev_release()
        kfree(dev)                            [CLEAN DESTRUCTION]

This follows the kernel pattern where sysfs removal (kobject_del) is
separate from object destruction (kobject_put).

Fixes: 581cf833cac4 ("block: rnbd: add .release to rnbd_dev_ktype")
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 drivers/block/rnbd/rnbd-clt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index b781e8b99569..619b10f05a80 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1676,7 +1676,6 @@ static void rnbd_destroy_sysfs(struct rnbd_clt_dev *dev,
 			/* To avoid deadlock firstly remove itself */
 			sysfs_remove_file_self(&dev->kobj, sysfs_self);
 		kobject_del(&dev->kobj);
-		kobject_put(&dev->kobj);
 	}
 }
 
-- 
2.40.0

