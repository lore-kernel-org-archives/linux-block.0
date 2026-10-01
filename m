Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB643D79EF
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859285; cv=none; b=Wd2lawsv6KS8L+bKcU6fv2A1AuVbagPDE4aumKRMX+4WpBhSUKrrRUOXXCCmKZS1zUtUPnk9V8hAz0VL7QU9JtMmvbCB8sOlEYH0wTk6hjK7fqxA0DWzcLT9q6P+ZuxBus+zCdJSS0ihqPAVmvs4NVPo5Xu3mj9qkc9Ql24M4bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859285; c=relaxed/simple;
	bh=NZMnZvAC9ETNiBEcby7IEa/Oyk3zsqvLoP5gjbLIy28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLha1GNwWea+kwFAdzA7CDMhOegNUxfTyjyUz2tiz/33QaddqD75zUaN4grFEWZHJWsLRO+wY7yo5Ypmbzk0Arwxf9Ngk/lwtpYXy1kzUrj/NXV7ZfG9Wv+qBiDW4OdUaKVFHMCaZNoHDsYusDoJM4temMxxra3mppiGZsYU6fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOZ+cVnz; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOZ+cVnz"
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6d8709e0de8so2342137eaf.3
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 05:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790859283; x=1791464083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eo7CDGZepJPHK70Y4vauIYJ4hL9H48grkqrrF4SVuLI=;
        b=QOZ+cVnzfLGAchVBSpp0kw8Wu0ZS2oBH2N6nJlihs5ckgQjOZFdoRPOGPnAQb7hlLg
         gtBm1Hy6GmmBJxogenfgIx5Y1099S2PuwMp+fF7aKzJ0FMwD/HHHKh4Pymo/gRAuafWm
         iUXwlVQiLcmcFWw0a4BBnLC3ZFDzoiiXf7UEMQAkKNZgcWCIDTlGY2gubcZZ2MU+QEKR
         czjG/FnmFfIlwS78v67AYqIs2ydccDxYCx2uzsYYlWhKjsbmwMOIkSzT5ZHP5Xv71IEZ
         VBs/edOBJ1AWYJ+tVVRZZIcPp7Fhybt1XxheOQGsP/dWZdqoxUf8Eyb9M6nuYv39kjmu
         rUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859283; x=1791464083;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eo7CDGZepJPHK70Y4vauIYJ4hL9H48grkqrrF4SVuLI=;
        b=jLOzqWzd/pQXv1VIXHGEaDc12EVx03Wr2zeYQ/8rDxfU1B/spmC3/zySk2QznPrpZv
         hf+yhSbrFoLFNXPpFlStH6LnxN4qkTwC9bmTATvK+z53/dKeSjKDHQ56BElYJn3ISHEa
         POq64n4b798p1alaAA4MPuNo8IgwuI+jux8T1ARQp9rBIHki0CnlpRX0ITlcCleZnWFH
         JXWRUv2P+S8COUs+TrJi2mZw80AmV4mcYBtEpjIF396r3E0MO5ncs4i05BAwWjVmrTiX
         BRhSDXROD+TZh1ez64FKwAAFc9aPCHrjwoOIVMjOppjOIywWmwrq+48QaK36M7LOr2j+
         Urbw==
X-Gm-Message-State: AFuF++nU5btoNiXzE+a8K9hoW++yrx69+FbOrPrmmhbtNklT2w5Z6QB7
	qr9jsFGPK6D9p4W05Ltagu8qVO/XrDRuasOV9E1NeVOQCYT8fV2Byebc7hNSQw==
X-Gm-Gg: AYBFou2/kTpVFYByWZ0DZ+cqJtOuhN5+UXognOGLuq2SzYSYj4tLk3jffH0SYejwRvd
	uW3s2GFUJq0kQBe66KPSgRYKvScx9cavZqnElihjoLuWVZLCUmujymfSyqNU3FHPmD5qJUgrmYe
	1WtS4k0osOsIPlAfjNsgWegyhKeZHKloaElj30bC3QRiIoksrMMqCNpd0Z8LNtYTchwjOsOeFdP
	GsZEaWRwPExjsZ2FFRdVnTdct77ShzhIg4nscxCOt8gATHRgucXYTjf1JGURqBcBaYCjlug7d1J
	+odgQSazRXhr4iBkElZHWRuwzfiVymK5rocQA7+UqrVo/QTdxBshgN1Ea1z/GqtFaSP40wTRxcw
	PSQwvEQu05iZfP7niqdiNnY8HJriqcD30cIXyELU5FE7pWWx1z5wC4cxek3xLr1dbzo5oxVWE9M
	1ynu1L5aO+cnS5VZD91CFilar/TY2m5UaaKx3vTcmGIzcUe+y8NJhRGRhfW9DHp0kCKeS0rx4I8
	E+KdI/ywPV2z2GobdcaIi8DBTPH3x74UCynQf+2zNBRQUc9wupij+Be7i/7iq9qdNgZyIW9NXnf
	F90Qr8PjBfFze56edzjYWYP5vmo=
X-Received: by 2002:a05:6820:1845:b0:6d7:6278:2d60 with SMTP id 006d021491bc7-6dcf592adffmr3883010eaf.55.1790859282937;
        Thu, 01 Oct 2026 05:54:42 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212b937bf2sm2504806a34.27.2026.10.01.05.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:54:42 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 4/8] ublk: reset the FETCH round in release also without a disk
Date: Thu,  1 Oct 2026 07:54:18 -0500
Message-ID: <20261001125422.1364260-5-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001125422.1364260-1-tom.leiming@gmail.com>
References: <20261001125422.1364260-1-tom.leiming@gmail.com>
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
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5e37b8e9d9ac..8bf0739539c0 100644
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

