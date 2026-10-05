Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F5832F75B
	for <linux-block@vger.kernel.org>; Mon,  5 Oct 2026 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226933; cv=none; b=IOYTbxHZPJxhIQidCPx5RvvXNWjjk9OFeYjXRpkSjDDCA+RZRmsVWKNmcnCNrfZsMB9bt915uK18T6tjyogRmqGc0eAPvgqUfykhozEOvU+1/v4eIs3vpPNbAGEVyK1BdiANCd21Pp81he1r1nDP6lFE8VOWDKGWuZ43f7P3qBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226933; c=relaxed/simple;
	bh=Q4n0AERx9QUP0tEzrHnmQ2XFk0zGGiZpIszcYMPYv7A=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=BbUIE51ymgna4FTjmsFntUali/gn7faMVeo1gE2tm1fm/+qqM7VczbxTUzc/vrUuKxX280Tg9NpjqcmAaz/bVg9UJR47rjlxDnFzgPO7P67aOkTpFNx+yu6TZjjWA70khOnr6ArAQ20QI4jwARDMzmclNq63tVLF636s68eazEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=RTo/lvJk; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="RTo/lvJk"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-836c4474028so19068177b3.0
        for <linux-block@vger.kernel.org>; Mon, 05 Oct 2026 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791226931; x=1791831731; darn=vger.kernel.org;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+Z7syrAz4LfxPjZQqKgbErbAJrKi+mPtI/lIkPWRbxU=;
        b=RTo/lvJkzOP2jHwV3xNFaElkvXfwbGxgcyeOqBa16n33QrjSyqdYp8vx58qOUcrSuK
         vcjNJ8luAmXg0kHIHjs8JY0BMSyU0FwSho50vdStGWnW35Qb1bQN2xpevvY5gPlRBic8
         wCblcBrm30QEDSQmIuscbiqn2YAiGvKL0+CjMku8QJxprLQ1zdb3aaOK9I+OIDaO8xSd
         prNqlwfzhxXNdwGkAOsDWCkcA0h6puKKN4T0Il/hdC52vx985Skh2rnUG+rImX2mYlgy
         smBpAp6m+JBn1zffJCtbYfa+60ADLnF9vQSJoBOTGSxJv/F4lEcZ+TnpRCaOPvgegt1a
         R5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791226931; x=1791831731;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Z7syrAz4LfxPjZQqKgbErbAJrKi+mPtI/lIkPWRbxU=;
        b=XnEXEbh7Rdt7W0WeSm3r6wrXfHyLEBo23rIXNV1THzUxevmjPKKGZESL2QmvRDII/T
         v/YIvDavnfT4YULpumHEz7tEPXl9qEUnsNoHJ0W55heQKoV7tYzKZioNvM7YntcEd4KG
         np6vZNqvOWi0nk+GJiJ25PD5rr0nBJyHPQ5nNfTsFPwKDQyVP4ApVbZJXzEeixp3Md21
         WZiQWbKfsJVAz+8pjyYzhcipbqYVRxSGsLxcsRt+ArWS9hjlQlE+gNhSyJhDTkI66G9a
         tLNr4vaCQdNG3HazE5SCjUQ7ytGrLp5heVYEHHKev/felhcTr6SwWaEEcNjneyZQtBXn
         whbw==
X-Forwarded-Encrypted: i=1; AKwUvBx3XIoa38XAp/tgw9XccAfaIGlYQZL+yfK0MG6RMMSBz9mLS8hp28LNZkHiaDqHYOpdUc/NjeXMCGK0Ng==@vger.kernel.org
X-Gm-Message-State: AFq9FYKrxPV0zstvtVw9Gr5O6i6GYw8Mk4dMe8qfvGWnRlNBR+zq7lu6
	SNM09wD1AYBnRyHYgXblHVH6SSKEMO4ky+kskF/M6B+gy9IGX00qlpGzGOiw/UpBG+k=
X-Gm-Gg: AYBFou0JOB5+hYpk+ETYCG9z4fxrIzm8DY4hsxq/HQyIWM9HXK+5sWCPrExwG+SeIBm
	DKm8HJSGWjSZXnujLohKGEe4IxsmcwBfFRKnWWOKmAlJ0bZi6K2oTFA46qJRSHrx98n0tupNfUf
	2Nr71Eqpko7mJaYLQJF3PKdwHp5Q/r+tgoxi7W/4f+YKKuhh3W7vGTVZ4Ce+0cXIsXDM9FG2YkJ
	D2tmTQsMJEibxIzWfbvygIneRR3CsUKGpYoIUWLk2r/lWQZa8I4bdosylJ3+W0uiYcC+SyVg/Fn
	QzSBYMCFhjuyvwMRHeaYmotj6y91lHQMFzFHpJgOSzNwyj2eraw81DUnj7GeJFKoTWPH6DkE/cO
	n6pMN4xSLkmCkUDauqpbQe394U9AruNgsqY1blcptcNS85AZfIcNRjb+SsneumyX/8DhWP0ZdN6
	VVqUiT5r1UJd7BJHuGEYKK8q7i2kZbxx7XNBNa/+v1sy7pkzpc21e+7f2t/vjwmfrvc8Hzn0C2K
	sv7T7dgCaZiu+w=
X-Received: by 2002:a05:690e:e84:b0:677:bf19:f063 with SMTP id 956f58d0204a3-677bf19f74cmr3098451d50.9.1791226930786;
        Mon, 05 Oct 2026 12:02:10 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0b67172sm93369286d6.20.2026.10.05.12.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 12:02:10 -0700 (PDT)
Message-ID: <9b876f2c061abc401ec4b9b3c2529eda.josef@toxicpanda.com>
In-Reply-To: <20261001125422.1364260-1-tom.leiming@gmail.com>
References: <20261001125422.1364260-1-tom.leiming@gmail.com>
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 5 Oct 2026 16:23:51 +0000
Subject: [PATCH] ublk: refuse to go live after an io command was canceled
To: Ming Lei <tom.leiming@gmail.com>,
    Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
    linux-block@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-doc@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Since commit "ublk: keep a canceled FETCH round canceling until the
server is gone", a device whose FETCH round saw a cancel keeps its
queues canceling until the server goes away, but START_DEV and
END_USER_RECOVERY still bring it up. Without UBLK_F_USER_RECOVERY, or
with UBLK_F_USER_RECOVERY_FAIL_IO, every request of the new disk fails.
With UBLK_F_USER_RECOVERY, requests are requeued and never kicked: after
START_DEV the partition scan hangs under disk->open_mutex, and after
END_USER_RECOVERY every read parks while the command returned 0. The
server cannot fetch the canceled commands again, so the device can't
serve I/O until it restarts anyway.

Return -ENODEV from START_DEV and END_USER_RECOVERY while ub->canceling
is set. In ublk_ctrl_start_dev() check it and publish ub->ub_disk in one
cancel_mutex section, and have ublk_start_cancel() read the disk in its
cancel_mutex section. Today ublk_start_cancel() samples the disk before
taking the mutex, so a server dying during its own START_DEV can mark
the queues without quiescing a disk START_DEV published in between, with
its first I/O past the canceling check. Now either START_DEV sees the
cancel, or the cancel sees the disk and quiesces it before marking. The
END_USER_RECOVERY check is best effort: the disk exists there, and a
cancel after it is the ordinary death of the new server, which
ublk_start_cancel() handles by quiescing and marking.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
This applies on top of Ming's "[PATCH 0/8] ublk: don't dispatch to
canceled io commands" and needs patch 1 of it for ub->canceling to stay
set for the whole FETCH round. generic_18 still passes with it.

 Documentation/block/ublk.rst | 10 ++++++++--
 drivers/block/ublk_drv.c     | 38 ++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 28300fee22bf..b7875a3cf3fc 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -118,7 +118,11 @@ managing and controlling ublk devices with help of several control commands:
   After the server prepares userspace resources (such as creating I/O handler
   threads & io_uring for handling ublk IO), this command is sent to the
   driver for allocating & exposing ``/dev/ublkb*``. Parameters set via
-  ``UBLK_CMD_SET_PARAMS`` are applied for creating the device.
+  ``UBLK_CMD_SET_PARAMS`` are applied for creating the device. The command
+  fails with ``-ENODEV`` if an I/O command fetched by the current server
+  was canceled, because its io_uring is gone. The server can't fetch it
+  again, and the device can be started again once the server has closed
+  ``/dev/ublkc*``.
 
 - ``UBLK_CMD_STOP_DEV``
 
@@ -195,7 +199,9 @@ managing and controlling ublk devices with help of several control commands:
   command is accepted after ublk device is quiesced and a new process has
   opened ``/dev/ublkc*`` and get all ublk queues be ready. When this command
   returns, ublk device is unquiesced and new I/O requests are passed to the
-  new process.
+  new process. It fails with ``-ENODEV`` if an I/O command of the new
+  process was canceled already. The recovery can be started over once the
+  new process has closed ``/dev/ublkc*``.
 
 - user recovery feature description
 
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f57d544c1da2..39eb7775a351 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2759,9 +2759,11 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 
 static void ublk_start_cancel(struct ublk_device *ub)
 {
-	struct gendisk *disk = ublk_get_disk(ub);
+	struct gendisk *disk;
 
+	/* sync with ublk_ctrl_start_dev() publishing the disk */
 	mutex_lock(&ub->cancel_mutex);
+	disk = ublk_get_disk(ub);
 	if (ub->canceling)
 		goto out;
 
@@ -4575,6 +4577,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 		.dma_alignment		= 3,
 	};
 	struct gendisk *disk;
+	bool canceled;
 	int ret = -EINVAL;
 
 	if (ublksrv_pid <= 0)
@@ -4665,8 +4668,24 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 	disk->fops = &ub_fops;
 	disk->private_data = ub;
 
+	/*
+	 * A command of this FETCH round was canceled and can't be fetched
+	 * again, don't bring up a disk over it.  Check and publish the disk
+	 * in one cancel_mutex section: either this sees ub->canceling, or
+	 * ublk_start_cancel() sees the disk and quiesces it before marking
+	 * the queues.
+	 */
+	mutex_lock(&ub->cancel_mutex);
+	canceled = ub->canceling;
+	if (!canceled)
+		ub->ub_disk = disk;
+	mutex_unlock(&ub->cancel_mutex);
+	if (canceled) {
+		put_disk(disk);
+		ret = -ENODEV;
+		goto out_unlock;
+	}
 	ub->dev_info.ublksrv_pid = ub->ublksrv_tgid;
-	ub->ub_disk = disk;
 
 	ublk_apply_params(ub);
 
@@ -5238,6 +5257,7 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 		const struct ublksrv_ctrl_cmd *header)
 {
 	int ublksrv_pid = (int)header->data[0];
+	bool canceled;
 	int ret = -EINVAL;
 
 	pr_devel("%s: Waiting for all FETCH_REQs, dev id %d...\n", __func__,
@@ -5261,6 +5281,20 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 		ret = -EBUSY;
 		goto out_unlock;
 	}
+
+	/*
+	 * As in ublk_ctrl_start_dev(), a canceled command can't be fetched
+	 * again.  Best effort: the disk exists here, and a cancel after this
+	 * check is the ordinary death of the new server, which
+	 * ublk_start_cancel() handles by quiescing and marking.
+	 */
+	mutex_lock(&ub->cancel_mutex);
+	canceled = ub->canceling;
+	mutex_unlock(&ub->cancel_mutex);
+	if (canceled) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
 	ub->dev_info.ublksrv_pid = ub->ublksrv_tgid;
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
 	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
-- 
2.55.0

