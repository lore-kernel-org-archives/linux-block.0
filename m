Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9294935E953
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306952; cv=none; b=YUdKVRjD9XggtMU684Xc05cy00+aka/eni6WpdamQI7vQtMsOIqoze7Oe4V9jioUr0j07ekdMZJWLThzqafycjFDy5UbKA53miOQuaoX80mgi6X6P7zBHdJPF2nZWEVpLxZKH9+ZuzWVoqObFArHTgwlxnacPKWan456TRQZFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306952; c=relaxed/simple;
	bh=hCCGajtli712D3U8h4Ma3ed7yZx2pK0pPUNDH9Ebgmc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=XM0NOqVWSVFxE7sJLIVCFFtNXNWPP8RmI//4yq5sbDPfHzu0TFKByzLG/Vef6l9B1L71V+HzVaOj83Vph22pfu804ytCYo362LxcFa5ktZQ4rPxuwCIWupyRwDo3KtqEk+1yXbaCobkB7aGTtPbDAzDXlKVwRX7+O/Yj7Ts8l7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=fcYdv+bh; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="fcYdv+bh"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-918df0c71e3so8997266d6.0
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791306949; x=1791911749; darn=vger.kernel.org;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0ZQiw8K62IEDDDX0qjm61k9O0EHmc2uqOwATSUTzFtg=;
        b=fcYdv+bhlzyp42JuZuRMHMTFtsmBp9ia4dRPNH5Vc7OPY+0EKWwkshOozuKFq5++WE
         lC0Zc7HG5wkR9EMelGSOe3ETZyx6BdO1tWJTm2uuJCuXng4B8FmHDJ2CGZ+NRBttdFby
         mo3SNlHxtrr2+2WA8GIK/E2HlX45GFzskY8GRNMVfKxW6W6PeDxVCXoynkMhWk3aAYx0
         omzR6+5WRKXW8WtptznNB/PzydGPKGsWdF2woH+x68gH/wYIRTFrYqBzO1qhySjQ3AuY
         qmSXouoqxfdtPijxGKe4NitYmEY90dTVlUu9BPEX9h60WIUnZj8C3octk6FM9mYD89vS
         RSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791306949; x=1791911749;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ZQiw8K62IEDDDX0qjm61k9O0EHmc2uqOwATSUTzFtg=;
        b=zmd4eW2qeTddVbflJ368OYkLWU7aoVnAsAQt/oa0afEUfKO9TQFqO3UnGY4yelWyzN
         x14BbldCqubpE6Qd5C4jbZIdX/ATVbPwjf4PoLjwZ5gALMfzvzoaF8RHqEjUjkms1iBf
         5wxT3HIC0ekCY7vCNxHt3gjX5Uu7l42WWTf+raN+Pla8VBGJuIP4vmXkA8vQpjZt56jw
         sVQosKqxorOGnYRY3Vg+vkx705MaWD15/Abx6/tqjeTnZiDEny+TbFxk1rq+vAsK+iTJ
         TU5jNwNpMeDbKWCR+F+0Y89EHFvtwNwhjM3zS2NWJ6cQhPbLQjkSh1Zfqw3jkb9BTcXt
         aVeg==
X-Forwarded-Encrypted: i=1; AKwUvBxR+aXSgdE0b17WQJ71tpbWpJQg16uTLV/FuPqPF3LJ7k2otWd6EVlMqEjUxtv7Q/YdRMZbFPWrtnC96w==@vger.kernel.org
X-Gm-Message-State: AFuF++kK/o13PD0ctNCZ757+BnFZ3UGUPoz1IGZkli6dCbybWNxM0F6u
	cdLModEERaIY39rNqtXkc+qWUF5/to3KEveuFsQFD7EgYSp0XXfNKX5vpqhHeaxf8js=
X-Gm-Gg: AYBFou2coOttEG9p9AMRv1FRiu72RkouS78UZaoCAtDNWkU8gE+aGw+XZ0CA57PfO0r
	S6rDyPdVxRhEsbfp12RfnvbRKOpe7oyAD+HLidDNYsqUHNfDJSoxzCjnjnoSs1aWd5FMX2BlHVV
	ngc7XaTBay7PDqJKbfmybPuSwb1UlBVzS3LwyucHGRiDlmWBtKmPlXKLu+ecZDaomP6AiD+W0Rv
	TdO6LMpshLzxv7YuCTga5fEG24Orxb539RMJk90/W0fBAQN+6V12ilqCUwhb32HkWrMhqzTxuIz
	BOWKbVCNFE/lyRIEyAcUzaw186p/ticCcOUe0BWO4RwTLDG1fALjO4RnSffd6jmpKOdMRS9A6CI
	s5pRQaNE+Hy8MQHjnb0CSm4iTp4L03oATRoEzjk/IBVulgECjdX6Uw+ytxdei5NZrZa+rWdk6Ra
	MKg6cXdVa17pIzNa92qiJSXKXdrwa07r93rVmTrhRcDsUSJGit5DWb35HjvGdRszl+bdm7DjOkr
	6wSBm06Ljn+fMk=
X-Received: by 2002:a05:6214:5b05:b0:919:952d:f5ba with SMTP id 6a1803df08f44-919952e6836mr9099406d6.52.1791306949376;
        Tue, 06 Oct 2026 10:15:49 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-919873f5f2asm23530006d6.25.2026.10.06.10.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 10:15:46 -0700 (PDT)
Message-ID: <28e99b5949ffa9005596098f5a16b71b497f2123.1791303049.git.josef@toxicpanda.com>
In-Reply-To: <cover.1791303049.git.josef@toxicpanda.com>
References: <20261001125422.1364260-1-tom.leiming@gmail.com>
	<cover.1791303049.git.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 6 Oct 2026 13:05:58 +0000
Subject: [PATCH 1/4] ublk: don't cancel commands in QUIESCE_DEV on a device
 that isn't live
To: Ming Lei <tom.leiming@gmail.com>,
    Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
    linux-block@vger.kernel.org,
    linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

QUIESCE_DEV on a device which is not LIVE returns 0 as "already in
expected state", but ublk_cancel_dev() still runs after ub->mutex is
dropped. A device which is QUIESCED because its server died may have a
new server fetching its commands for recovery at that point, and the
cancel completes them without marking anything:

    new server                       QUIESCE_DEV
    START_USER_RECOVERY
    FETCH part of the queue
                                     device is QUIESCED, ret = 0
                                     ublk_cancel_dev()
                                       io->cmd = NULL, command done
    FETCH the rest of the queue
    END_USER_RECOVERY
      device goes LIVE
                                     ublk_queue_rq()
                                       NULL io->cmd

Skip the cancel when the device was not LIVE. Its server is gone, so
there is nothing of the server QUIESCE_DEV is meant for left to cancel.

Fixes: b465ae7b2524 ("ublk: add feature UBLK_F_QUIESCE")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/ublk_drv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 39eb7775a351..0bd0b95b3217 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5413,6 +5413,7 @@ static int ublk_ctrl_quiesce_dev(struct ublk_device *ub,
 	/* zero means wait forever */
 	u64 timeout_ms = header->data[0];
 	struct gendisk *disk;
+	bool live = true;
 	int ret = -ENODEV;
 
 	if (!(ub->dev_info.flags & UBLK_F_QUIESCE))
@@ -5427,8 +5428,15 @@ static int ublk_ctrl_quiesce_dev(struct ublk_device *ub,
 
 	ret = 0;
 	/* already in expected state */
-	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
+	if (ub->dev_info.state != UBLK_S_DEV_LIVE) {
+		/*
+		 * Nothing to cancel either: the server this was meant for is
+		 * gone, and the commands of the next one, which may be fetching
+		 * them for recovery right now, are not ours to cancel.
+		 */
+		live = false;
 		goto put_disk;
+	}
 
 	/* Mark the device as canceling */
 	mutex_lock(&ub->cancel_mutex);
@@ -5447,7 +5455,7 @@ static int ublk_ctrl_quiesce_dev(struct ublk_device *ub,
 	mutex_unlock(&ub->mutex);
 
 	/* Cancel pending uring_cmd */
-	if (!ret)
+	if (!ret && live)
 		ublk_cancel_dev(ub);
 	return ret;
 }
-- 
2.55.0

