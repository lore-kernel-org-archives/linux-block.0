Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73EF213E89
	for <linux-block@vger.kernel.org>; Sun, 11 Jan 2026 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768089630; cv=none; b=Txi6wJES1yZwB0mk7v7BuFBBhcydtjFSEmxNTq0TjltslJlPNCzKQU2AIF+54DodutfJU3Fck+slrLQEllxP12ozvNsvkS39DAWuL9V51/g6GOs9y7cq6FCI1xTu/1JWhP7t+CzWJ82Csy+pb8e+/pg3d6LcmY5D0J3KtladDKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768089630; c=relaxed/simple;
	bh=TSIAFfl6gXmnHEhx9JOQjNokNmOCw28b9M2WP+wobCk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nVlSNBbScOg9wHLaEdHs1Pu2fbiQGxj6MrERnaA8j8ak1KZJHEq1xsPtngguIHI5FCXYlYXXjX8ctrdvoDJiUwEBUsZPmMOM0ztHipuCrWTbXtN2XMQZaq478jP4Oyj2lE/Kpb6YLXMvb5cmFc8qysTYvSU9QF3KzL2fWK2uuFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LyZ/MAQj; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LyZ/MAQj"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4edb6e678ddso84787381cf.2
        for <linux-block@vger.kernel.org>; Sat, 10 Jan 2026 16:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768089628; x=1768694428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BohFfe8rqrTJiLhqptfzMv3P20bgrOfUsb/RU+PasiI=;
        b=LyZ/MAQjrHGe9w4x9PExgj+y80743dy0SsXM1GMxT2P5zn5sEnJEDy57P9P7RccspQ
         gD0IeSf1FbVsKPmV5zLWd/J9BlmtYaFarX8JfBDYtXnVwmQlnyH8mbqlC7YvHhZV30BG
         jayBgaZbEahaG6EcbSjnn/uu0m+twv7WN3yGRBZOzHJ4620SIAdAq+kl1rZJN9NsS3Yh
         Pmio8iebtBUAh4tv40fliCDaAYeWMCL/c03K1b3hXhrSsZf990zBlvIcMJFnIN6GBr45
         rkTadZfvdAwlR6Z38CljED2gzNjgi0Nan2xCJTyxR1xVumXoIHrIuFOfOarVqJaqx5oT
         5+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768089628; x=1768694428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BohFfe8rqrTJiLhqptfzMv3P20bgrOfUsb/RU+PasiI=;
        b=oyrHnn6Z2PbmEg0mcIGBIOq9NklmyEriuypTAKTbKG4u46S0k7MGVywPZgGwbUoZkt
         u3hb8IlcgfSfxQwJL4jgo9r0gNjUjlG7AlVFpGknX+egstEmWjAN8GisgXe7v4mY6q0G
         foD8pLUG9ZAaOqh8PVMSE6YNaD7A0oJoK/IlxDiRESvdSkhj2EUQLKJCxOYpk11bEZFc
         kX3bjEWjI/4g3B7Y0zBQUCL9ihC7iuEeqn+aiOXo/fNS/mDFqem039Ref7vqqLftvzu8
         MZfu3Lvbb3aMmN6WjCwhA1+iisctdrN3oFV6OE29/18DYJeO8vbXTkaTMSaqXYVWLOPu
         C0bA==
X-Forwarded-Encrypted: i=1; AJvYcCWsM6Ugvx6ZE2ltjQZM0ugI146amc1c+V2IXseJ3V7gk/VHCxjEFnzA6zqxTjQ9CDdVw904Ient+A0QkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1n+MTRnzDCb3f6AvkafCFvIHHto6LV0EUhnynqZqnqiKSUV4O
	HeEuPY0Rg+7jMzBvmcFoFEwlMcjnHAdQeF+uBqffgtCt3Dgdbymc6Bm5TJqqeoWdcZ5GdY71zmh
	0+1ZC227gdcACGhTZZzhp9z6uKh8+KVJ8J/dbvrGf9Q==
X-Gm-Gg: AY/fxX4058vfZDzp1pruotbJmm7jIAg9QybL1vXewAVtimC7ZAQpp+GzlJamc8IIBLI
	3vZ5k+tnq9Hbc5gXtDpDdlXIW7aW2lCpSV+tArOPmJwdY95Mx9oYZ/oBNsKm+uv0PiV3DcxA1Vj
	TdECoKsd9iCMLgesHHgM9AgvHGWnlufp2s9OVvK+yFcae4ukkYdGPKmbl0beQnt1DiHL33+2xGt
	QYAoR2XGFNMrNLJMz+6LhMnv4NWTF47sxM5Cr74mQmN6jOpb4TlWJa3FZsOPym8vII71j7ENmL/
	uXM87D2oi8eS1NDfyQP90C5XiIUZ/p4sdFdd2pF/
X-Google-Smtp-Source: AGHT+IEd6ZKTNxO1f5VuT7ubvWy4nlU5LWjHwzTJzQoNwXPf3xQBpOP8pJaO9rMXYpmqMtsPdttoNw4H8xXnKQYpzXQ=
X-Received: by 2002:a05:622a:1451:b0:4ed:b441:d866 with SMTP id
 d75a77b69052e-4ffb49bb3fbmr210046571cf.65.1768089627625; Sat, 10 Jan 2026
 16:00:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Seamus Connor <sconnor@purestorage.com>
Date: Sat, 10 Jan 2026 16:00:15 -0800
X-Gm-Features: AZwV_QjSZrkFaMe_1xbT0YoqMDfIdotKf8Ma0weUX6zt6rTVvZhAs4ewJcHftXg
Message-ID: <CAB5MrP5YbxdUe0378VfKBMb_n9=6G-C=TPixYoMaV48trgtWBg@mail.gmail.com>
Subject: [PATCH] ublk: fix ublksrv pid handling for pid namespaces
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Caleb Sander <csander@purestorage.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When ublksrv runs inside a pid namespace, START/END_RECOVERY compared
the stored init-ns tgid against the userspace pid (getpid vnr), so the
check failed and control ops could not proceed. Compare against the
caller=E2=80=99s init-ns tgid and store that value, then translate it back =
to
the caller=E2=80=99s pid namespace when reporting GET_DEV_INFO so ublk list
shows a sensible pid.

Testing: start/recover in a pid namespace; `ublk list` shows
reasonable pid values in init, child, and sibling namespaces.

Fixes: d37a224fc119 ("ublk: validate ublk server pid")
Signed-off-by: Seamus Connor <sconnor@purestorage.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 79847e0b9e88..9ef6432fef7c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2858,7 +2858,6 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub=
,
  const struct ublksrv_ctrl_cmd *header)
 {
  const struct ublk_param_basic *p =3D &ub->params.basic;
- int ublksrv_pid =3D (int)header->data[0];
  struct queue_limits lim =3D {
  .logical_block_size =3D 1 << p->logical_bs_shift,
  .physical_block_size =3D 1 << p->physical_bs_shift,
@@ -2874,8 +2873,6 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub=
,
  struct gendisk *disk;
  int ret =3D -EINVAL;

- if (ublksrv_pid <=3D 0)
- return -EINVAL;
  if (!(ub->params.types & UBLK_PARAM_TYPE_BASIC))
  return -EINVAL;

@@ -2922,7 +2919,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub=
,
  if (wait_for_completion_interruptible(&ub->completion) !=3D 0)
  return -EINTR;

- if (ub->ublksrv_tgid !=3D ublksrv_pid)
+ if (ub->ublksrv_tgid !=3D current->tgid)
  return -EINVAL;

  mutex_lock(&ub->mutex);
@@ -2941,7 +2938,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub=
,
  disk->fops =3D &ub_fops;
  disk->private_data =3D ub;

- ub->dev_info.ublksrv_pid =3D ublksrv_pid;
+ ub->dev_info.ublksrv_pid =3D current->tgid;
  ub->ub_disk =3D disk;

  ublk_apply_params(ub);
@@ -3276,12 +3273,32 @@ static int ublk_ctrl_stop_dev(struct ublk_device *u=
b)
 static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
  const struct ublksrv_ctrl_cmd *header)
 {
+ struct task_struct *p;
+ struct pid *pid;
+ struct ublksrv_ctrl_dev_info dev_info;
+ __s32 init_ublksrv_tgid =3D ub->dev_info.ublksrv_pid;
  void __user *argp =3D (void __user *)(unsigned long)header->addr;

  if (header->len < sizeof(struct ublksrv_ctrl_dev_info) || !header->addr)
  return -EINVAL;

- if (copy_to_user(argp, &ub->dev_info, sizeof(ub->dev_info)))
+ memcpy(&dev_info, &ub->dev_info, sizeof(dev_info));
+ dev_info.ublksrv_pid =3D -1;
+
+ if (init_ublksrv_tgid > 0) {
+ rcu_read_lock();
+ pid =3D find_pid_ns(init_ublksrv_tgid, &init_pid_ns);
+ p =3D pid_task(pid, PIDTYPE_TGID);
+ if (p) {
+ int vnr =3D task_tgid_vnr(p);
+
+ if (vnr)
+ dev_info.ublksrv_pid =3D vnr;
+ }
+ rcu_read_unlock();
+ }
+
+ if (copy_to_user(argp, &dev_info, sizeof(dev_info)))
  return -EFAULT;

  return 0;
@@ -3414,7 +3431,6 @@ static int ublk_ctrl_start_recovery(struct
ublk_device *ub,
 static int ublk_ctrl_end_recovery(struct ublk_device *ub,
  const struct ublksrv_ctrl_cmd *header)
 {
- int ublksrv_pid =3D (int)header->data[0];
  int ret =3D -EINVAL;

  pr_devel("%s: Waiting for all FETCH_REQs, dev id %d...\n", __func__,
@@ -3426,7 +3442,7 @@ static int ublk_ctrl_end_recovery(struct ublk_device =
*ub,
  pr_devel("%s: All FETCH_REQs received, dev id %d\n", __func__,
  header->dev_id);

- if (ub->ublksrv_tgid !=3D ublksrv_pid)
+ if (ub->ublksrv_tgid !=3D current->tgid)
  return -EINVAL;

  mutex_lock(&ub->mutex);
@@ -3437,10 +3453,10 @@ static int ublk_ctrl_end_recovery(struct
ublk_device *ub,
  ret =3D -EBUSY;
  goto out_unlock;
  }
- ub->dev_info.ublksrv_pid =3D ublksrv_pid;
+ ub->dev_info.ublksrv_pid =3D ub->ublksrv_tgid;
  ub->dev_info.state =3D UBLK_S_DEV_LIVE;
  pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
- __func__, ublksrv_pid, header->dev_id);
+ __func__, ub->ublksrv_tgid, header->dev_id);
  blk_mq_kick_requeue_list(ub->ub_disk->queue);
  ret =3D 0;
  out_unlock:
--=20
2.43.0
