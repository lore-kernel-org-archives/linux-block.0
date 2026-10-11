Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6CE3BFE2B
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700583; cv=none; b=Xc0AyEeMHYgeAR+vepMHfGqRFDMjcK44MLgQ0KHEJiLkMiJhRmPgz3h4NhuN8ktC9MeEAaWorJeKi14Jrj9YyRPOde1JuAYZIUrcTE1M3Y6ZaDnYzoC/9tpRnl4cO3qUsDWqJChUfcatiFp8HxbQncGJTMksp/nwDE6ab1XfZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700583; c=relaxed/simple;
	bh=prUNl9Z3gcOH8KCwu2iLC11/emUOJ7Zx5E9zrzmAYjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=be5ZQhRqa247X3lUzfqc62+OnX1RY7JIvMbd1hg5ouwr62vCONcGVy46DxjEoUOQDUzm8w5sGA74eYXaBxjUqOeYltBiFsxQNZqT0DOsKtxnvaLhqXjx0x45s9tSCDJETfJiiy5CoT6qzh6G4HR/H0rmZIZlfxsx6ALwR7LPwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5VjmON+; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5VjmON+"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-82395ae2ea8so806870a34.1
        for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 23:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791700579; x=1792305379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eLizfgiIkYBIN6spMs2WJIgN1i9NSTMyDsWz9E36Flw=;
        b=Q5VjmON+C2lP/Xv3+4/f/FqigU0ONXlxgYtVDu5c2pwvwgqnt74yyyZRjBLQUw3Hhp
         zNCSQKF6HlcPkzks1h3PLqgvvRgz8IxI9/f0+lROGqL5/RAyGnaQngSMX/+Y5ERoobtQ
         RKuCtU0Lagmvq26N1MBtivkgZprExw4743Uu1uzqK2+PnBfqtu8mC/7zJHFhhT2o4xpT
         rDf5sFRw5fQUaaWSK92WIg4T+Si+VfLGe3V1pj/tnRlsuUmoYc2tQFGhzdd9NDsCyuob
         JqnpRfhSW69aJ4neEcdr+kISoEzFovsLIbekUd6SvfjKxqFcXthYAzVMfdDJKeAlvz31
         uaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791700579; x=1792305379;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eLizfgiIkYBIN6spMs2WJIgN1i9NSTMyDsWz9E36Flw=;
        b=truDmC0LfdfXp/VqohdUVbH2E78UNmJgiscpKsYeAUwZRzKuUP7Ms138GdfnrCrTQg
         rxkHz2MtJ+jaBfBk563IZG9dm4xNTWMGHnmSq/mOxlsE9iXn5/3S7Dvk9PSFs9Y8YMtJ
         n3nmYoRPxb7FJM875vTBtpbss0X6lrKgRA9fUQVgUN2oW0Fy0PC+y5SfM1fmAoixRzH6
         OSFD3hGlkgzEHc32sSVi7sQt67u4T2GC0tIc5UxkJOxzoWlFocP7526rkrpfJsS2Rp2Q
         1/LbXj1V2SOxMGYLKZWZNe2sjGVTVAa9te5Vn4k/oUz5ajrRAWu7plqUrXD8HwAlHqfm
         sGKA==
X-Gm-Message-State: AFq9FYJC87hMsQ5QVWPztF277S/4KK3t90MCEGvGHF9VJ0zgOcclMPzW
	dqATRIgimqGaDwLsquUbXhljjZDvXAy7ozaB02nOcOBv1nffJ+ZkXcyX0XzCMoSk
X-Gm-Gg: AYBFou0AU1qEwdApaNag+iq3tFLq+7alU0m3eCe7OT7ortad6VgGaOiQ78QpT7Z4j4H
	HFeS2qeicMX5QQg4DZl1ZWwZ1DYynh+1AAY0O6eKJZm7yP7SWxrfNjqmQt1lSv5YFlH9xCGxdc3
	X6DQbAXhQjxQocgJvKillR5ZLpM9DKbTmzI1FTasNqDvJ+kUs2jYhNtkfq6rVpEvBgD6JRuBtxe
	4lQIirL9bkJAHao+MX0nYX4vgXYAC3xa5n9kYrQkUvzHpgzDYEoMM0mJshrLbcYItZLuU0F82uA
	uLBmpGY1K4DxKujNtTWmgYpjkNu6sSrjk5DQ5xjFkvvolRJY4px58zcpKC/BuLzavMl9T9nEepw
	S8jkPqSmfpqjQA/7ohPoaRdLsMhE1k3oR1em3rigCNJwYnSeLyi3E9F6ylMhf0lYB4ZIcPpLcNT
	3NZkKGRgdYY5IUwHfKW9kNZEbV3arOTx3FtK4pHJBx1TfixHf9V6VKAQn5+101Rf/EsGcsa4bxk
	lPqvcRROT9iz0jOKIny100gnj6gaKARkcooI3x/BRVH9HHrGj3ftRt+DLLTuh1LJAsGJNmW2KBY
	+ZdHp97NcOtItpDT6xiEUmlCwDY=
X-Received: by 2002:a05:6830:3815:b0:830:43b8:72db with SMTP id 46e09a7af769-83096fad2f8mr4487779a34.24.1791700579004;
        Sat, 10 Oct 2026 23:36:19 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a515aa9sm6593164a34.25.2026.10.10.23.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:36:18 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Li RongQing <lirongqing@baidu.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 04/12] ublk: reset the FETCH round in release also without a disk
Date: Sun, 11 Oct 2026 01:35:47 -0500
Message-ID: <20261011063555.1142277-5-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011063555.1142277-1-tom.leiming@gmail.com>
References: <20261011063555.1142277-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The release of /dev/ublkcN resets the queues only when the device has a
disk. Without one it skips ublk_reset_ch_dev():

  server fetches, never starts;         old server exits
  or STOP_DEV removed the disk           release: no disk → skip reset
                                         ios stay ACTIVE / CANCELED,
                                         nr_io_ready stays full
  new server opens /dev/ublkcN           FETCH: -EBUSY (still ready), or
                                         -EINVAL after a partial round
                                         → the device can only be deleted

All uring_cmds are done when the release work runs, with or without a
disk, so the reset is safe either way. Do it in both cases. Then a new
server can fetch and start the device again, as the STOP_DEV entry in
Documentation/block/ublk.rst says ("ublk device is ready for the new
process").

Fixes: 82a8a30c581b ("ublk: improve detection and handling of ublk server exit")
Cc: stable@vger.kernel.org
Tested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e57c0626b84f..35202789cf98 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2551,12 +2551,13 @@ static void ublk_ch_release_work_fn(struct work_struct *work)
 	}
 
 	/*
-	 * disk isn't attached yet, either device isn't live, or it has
-	 * been removed already, so we needn't to do anything
+	 * No disk: the device isn't live, or it has been removed already.
+	 * There are no requests to abort, but the round still has to be
+	 * reset, so that a new server can fetch and start the device.
 	 */
 	disk = ublk_get_disk(ub);
 	if (!disk)
-		goto out;
+		goto reset;
 
 	/*
 	 * All uring_cmd are done now, so abort any request outstanding to
@@ -2617,10 +2618,9 @@ static void ublk_ch_release_work_fn(struct work_struct *work)
 unlock:
 	mutex_unlock(&ub->mutex);
 	ublk_put_disk(disk);
-
+reset:
 	/* all uring_cmd has been done now, reset device & ubq */
 	ublk_reset_ch_dev(ub);
-out:
 	clear_bit(UB_STATE_OPEN, &ub->state);
 
 	/* put the reference grabbed in ublk_ch_release() */
-- 
2.55.0

