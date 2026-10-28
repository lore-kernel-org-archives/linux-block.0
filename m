Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205937;
	b=YU7RSfW0xlcyz3er03MNEVbWCp5Mb+9P2Ov9mN+FrMWQqRZwG4SPM2uNz5oayqHWppO5
	 AC/cBePbRiwDZAav0lHf+o1umuPwa8DCzkJmRSXh2ReX7bDqqMQfN1elbc6+Gzqxj98zo
	 iwKbgjhIOKf2H1siIP3zXrFU9EcOmz2n+gDCvN7XqCLCo1EKUsASGdMRkn2skrec6tM9s
	 Li51o6A0sQp1IN39u5KIJyL86fOu/5Tnaxg/T8obhHwTay1XkPwfqMhPs18h3TBRb1OKo
	 0lxe3qKzht8VyMDiDfM+9rMP9lIAsyItymhamIxiiX7BvnAO/hH185Xfi0VkICoZYLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ohYNwY9OJNBKvxRB/pOQzxSCOvswNRsBtDJHAfeF76A=;
	b=XN1E+gir0h0qVjOx/Ar+U9YkEdDUTOvVgfmi12O5o9ASFuVK2k5JeLdDwVGnRoQaEBY8
	 iuZbuJ16CK8AyshmM5AHC+kRPZ/WEPx7tlZTHJR+vvSiiG0mobKla2zvPvsJiDQdUpmOg
	 uQ0kM2/gd5FYoiBbGEf95Q3bC5z5vV+rIoafQkpVwYE2U2RhPEsxGC9FrOGxcuRLjphE5
	 ++Hfwx48wgPN3CaKqMAgjPXWqCZPEjelzQ6e//+s52YzJ6z97AyiafSFIT+tWGMT4XTkF
	 J9vffeYq2LwUiBJOu1r2rax60fTJbL1dp4sHZxf+jgOQ6LF3mXu/plgxorIoITxMQIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RE17UTAu;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6484A606A327
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6484A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RE17UTAu
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-8451a619da7so831703a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205936; x=1793810736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ohYNwY9OJNBKvxRB/pOQzxSCOvswNRsBtDJHAfeF76A=;
        b=RE17UTAucNFdrhAT28WkvUQqFF+UpWqmcCSlgl18e4vwbiSxbymJUosDeNHwJVdkRT
         c9AVU1RjFce4G8p9NqAhcHx2TC8LD2EOig6E8VI0IaB0rHI8gYvAzFAcEY0AlLDuVKfc
         0mRvpuUnDENDr23vn9+MJSiDSD/rCBixKEjYUObZlmSDrRXR5lbVzLRoo4zd/ejVyMJ+
         mdD14/RaMXDWdVxqq4AzpslvAPROh7b3Z5pLp9WlMLtZqrlbuMrRI3v9ui/4j6k9pqX0
         OpxaQGnXGIdLu9pl/BK35iM+pDlHDC05wlHPTcRVY93mRw5uXP1D3fMcnLyyGCkFMIkt
         gCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205936; x=1793810736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ohYNwY9OJNBKvxRB/pOQzxSCOvswNRsBtDJHAfeF76A=;
        b=WIU5tPcbfJPmQkhjTUeE7ASmHAt4o3V5JdeDa1rPeoCEOv8wrzzh9J17sJ4tw/taLd
         BpiXo5Is+M12Hj3FfisGmCqZ+xRtcxEtLXA/QAXjoH/LgjDGr5z57ALqyOWdR4nk8M1k
         luYfuXMtdCalygEFKpRtvSo/Jk4mWGyrsrjrDNkOedRdYD6xIRFTYi1gi/z7feSQOxya
         IMJtcEHynz/DeF4p76wNn2ZVz2SYFwYwrLEgr06g9PfAwSS0E+/rTKuXwGT6SiqOlRya
         n4GrV/IOCvJFGSPw66Z438twjZDvbo3fty//qqq2ejKppmbG4cw/uthP+RhZ3tyvwfpK
         xFaA==
X-Gm-Message-State: AFq9FYJMKc20XLnqDayVMym0e2tzgJg4/8JLGThZtJrgTbRJpaEAyrpn
	mq2sqHhU45Ezun5TgEA+egsAQs9JzFw2LLrL2Nt70MhjyBnWT7QtU4Dv90sZlJD7u5l9fuHCKrY
	cVDoo87Y=
X-Gm-Gg: AYBFou1cPpWTp3Z1qefaXp/DT6dZUDzAooBrmhMIOc3G2jrU+OLezCiqgktpteML5jY
	rG75DM80THAe+gGrOyD6xwfEgAudeIG3Bn7hyBR4CerfvXaNIg7Uyv0FJ3iaUP2A8CYVABttBMQ
	9nzTBDByDji+4fH0skRYhtiZ9o/pygY9S7QT6qgqfIZ+srtbyIpkQpmACjniXNIjNYQ3zb8APUK
	VlTslrAij0BAq/wFPXRz3WmO6H8e79ZxDySogGCGwFnOglt2iELwT9IDhPkSQEOhB+/kYdUbR5o
	KQawxIVsfJd9LVJV6a2ntlV6SWgoteClwbHylV9OcyH4uPtdRPEDV6aUmlsd8+p2yXQtJ81c69w
	riDvhuVL408b5XC2OFr72mG7BC2bVCxqoTDial/JsZlNYG3LnzekAGLX2SDRrpJXwWDI9H8n/ir
	uJsk7MtkRQvWJOQVRy9PXpcCXmmqGL8RNzqFffaBgHmAA4sKEBvj+pua9Ae7mLzEOThtrT8PTSq
	n4sGgnMmr3L6W6Z7dxRh6QE7kjLXyvyinextbUwjKFSxnHdPuJsqjwTwdla+WIl4dBw9PiPomfv
	I2xViacOpfLEpWlQIE2KtoL0yuQxO3POxsObw2njR67SURT4OUFUQQTpVSrJ/GcZeg5QKwFQM3f
	Sm+LFjUrCbWGjFGO4UlCz
X-Received: by 2002:a05:6830:4393:b0:822:a76e:95c9 with SMTP id 46e09a7af769-85ab8cbf5e9mr2891280a34.14.1793205936460;
        Wed, 28 Oct 2026 09:45:36 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 63/98] nvmet-auth: refuse a reply without a DH value
Date: Wed, 28 Oct 2026 10:42:06 -0600
Message-ID: <20261028164415.1262013-64-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

With a DH group configured, nvmet_auth_host_hash() augments the
challenge with the queue's session key, but nvmet_auth_reply() only
computes that key if the DH-HMAC-CHAP_Reply carries a DH value. Without
one, whatever the queue holds is used: nothing on the first transaction,
so the DH exchange is skipped, and after nvmet_auth_sq_free() a NULL
pointer with the hash length still set:

  BUG: KASAN: null-ptr-deref in __hmac_sha256_preparekey+0xa5/0x250
   nvme_auth_hmac+0xb7/0x160
   nvmet_auth_host_hash+0x2a5/0x530

Refuse such a reply, as the host refuses a challenge without a DH value,
and clear the length along with the pointer.

Fixes: 7a277c37d352 ("nvmet-auth: Diffie-Hellman key exchange support")
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/auth.c             | 1 +
 drivers/nvme/target/fabrics-cmd-auth.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 9ae8293cc734..d1af4a921e7a 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -237,6 +237,7 @@ void nvmet_auth_sq_free(struct nvmet_sq *sq)
 	sq->dhchap_c2 = NULL;
 	kfree(sq->dhchap_skey);
 	sq->dhchap_skey = NULL;
+	sq->dhchap_skey_len = 0;
 }
 
 void nvmet_auth_sq_destroy(struct nvmet_sq *sq)
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 841fd2683702..a559fec3aa65 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -180,6 +180,9 @@ static u8 nvmet_auth_reply(struct nvmet_req *req, void *d, u32 tl)
 		if (nvmet_auth_ctrl_sesskey(req, data->rval + 2 * data->hl,
 					    dhvlen) < 0)
 			return NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
+	} else if (ctrl->dh_gid != NVME_AUTH_DHGROUP_NULL) {
+		/* No DH value, no session key for the augmented challenge. */
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 	}
 
 	response = kmalloc(data->hl, GFP_KERNEL);
-- 
2.56.0

