Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E20230EF91;
	Tue, 18 Nov 2025 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431710; cv=none; b=h3koYtsxnspk89GBI9d9RNeQA5e+NsJPhjwVBAam/Spm6mockHf0uH3d/6P2VOyY2TpZfQxLVk7X/6MCiEmAHGkRgQTjEhBHClwVfuVyJaQZORul8q1wJVUC7lBiF7WaG210sCy0xGqUi3t4W2APfY3bE3ikhtxX8/5jLd5Ykf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431710; c=relaxed/simple;
	bh=dX/Twv4UPTWF/mirdUmlPtAFDaVQy5d6AFnrdaY9kcM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=F1o7pAI9BL8SpkR7bPNXGAH8nq0hqJnbDJl0nLBcVtvVl0490YP9BMjhTtueiSIKdvQMtV7Bp+DiGM8CD0Ag7fGCEEVfUsq45Gy/fzgVdjnBB81Row30FWdV+Ys8hpItZ6/mFVPv8jFAO7pdvORIwqSeDrX6BzPV0JZsCxSrC9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=G4V+koqE; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="G4V+koqE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763431699;
	bh=tquW+VVde6gvKkA0FAYyMhS9e7bJNzAzEzLm9Bg7uxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G4V+koqEqCZ86BKR5iEQI28wO1mzk7gV5n/yzoSRsUW3v/3iyUzV897moBGV1ChK4
	 3RDC6fsJPUJMS5k9MYwR+uu2gTVrExvVsQNmHBHpDbH3G47PZXlHW8VRVkM8qD67WM
	 8TDwEdsbaAud/UPiaaeAwQmjuoT5hx5vlPRh+lZw=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 210A36C0; Tue, 18 Nov 2025 10:08:16 +0800
X-QQ-mid: xmsmtpt1763431696t0p1kel6a
Message-ID: <tencent_547137D7C2F3EDBCD52FB12EE2A202EEE307@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4AgmNtjQgJUQ3DtPLGHhkYi3xEiIs9A3ceN4XrokDbFIxMS7U8Ou8
	 EXwCyPeuqsIfkoi2vMqlSknKrOIw2pCrgG0Bq5WA2hNBLwOT2YSXlmeL5TN21B/SBhgYTfA9JR8H
	 sMKoSAbnQzgo/+4ZMSTRLHMBbHMcNriTdaNeGP3Vq3RUDDxp8I3rgqzbxpN5fKTuEMf/143Ra689
	 obsLBbj+SoMkkuCgS9TKKCnTBd+Mhe6moGG8qTy8SlR/AwENm8oZpyVqpz8qSWF9aWF7HlQFFhxp
	 UdBhbGhrouHxhEYpunSblA0pV0X2iL6fPLNB0qccEaYw4tiJ57SWP7C7oKYVZ/Le1nJGUuG2NbUO
	 C24/u+PgDpdT4omNmFB853gPUXFIuTsnhky6g9GIWIuwrFJbeRAHwPVS8gs3RUHNkUDYIl0uDi/a
	 T1PxSm7lAotxSBLHEj8SHnVVbLGlvMsa3PwzOJxawQtreC+u1+jwfxDmmBOkMd/kuez7E9w6YtzG
	 veRvAQM6C7k82XeU5ehPcFdMZO3eAA+qJzkl8l6xrnU3o7hsRwazXBYNFsEPMSA2vDiSXXxnvPpu
	 SJVEBPpnOgXy19OfG//EhGodDU0qFLBEa0/6pKCZlOGr+1lNpSFMfKzdk7G+NE3afTZ6vpZUNc+Z
	 YizBBaOtHdQr7YAe/+bGqERTZNhmh5F3jVxpEYna8G/WZn3Zu6s6l+ttVD8JjZ2d5u+1Lvw4W5qC
	 EIqjKZ9ZHLu3KNzCit4DJYixlhBJbYRDhjKNeJxLNrGKTghTLco3gIOiOEZJv9wr+jMGjc+Rqx5g
	 CCBpze9rzqPp1ULpXexRAhF+XrUVjJab0TWiBJgZvXypYSsXY9E5gIkWDPzlQfR5H/Cvj1Bv9FxB
	 Qbf9vDJhO3/V0KfUOICYp6F8hsqt1jnaJXyb+uMhvQjymqmSkjoa1L7ueBPTF0CINnqISoGokLqk
	 GCHRPuozEK++C5EjPMuppMgRIIr4j87LBOoBsOnHmhM7KoJEmkLUmOA0ih7hPdBkqvLbVMw406DI
	 iF+IUu9zmlXgaTs9ehfVcq7e2q7gNrPeuEQRAR9A==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: bgeffon@google.com
Cc: akpm@linux-foundation.org,
	licayy@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@google.com,
	minchan@kernel.org,
	richardycc@google.com,
	senozhatsky@chromium.org,
	ywen.chen@foxmail.com
Subject: Re: [PATCHv3 1/4] zram: introduce writeback bio batching support
Date: Tue, 18 Nov 2025 10:08:16 +0800
X-OQ-MSGID: <20251118020816.2789928-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CADyq12zxzi+t727B5sm5z-z3SmRQyMDOmr_tTG1GaMVh6VTWbw@mail.gmail.com>
References: <CADyq12zxzi+t727B5sm5z-z3SmRQyMDOmr_tTG1GaMVh6VTWbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Nov 2025 10:19:22 -0500, Sergey Senozhatsky wrote:
- index = pps->index;
  zram_slot_lock(zram, index);
  /*
   * scan_slots() sets ZRAM_PP_SLOT and relases slot lock, so
@@ -775,67 +999,46 @@ static int zram_writeback_slots(struct z
   */
  if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
  goto next;
- if (zram_read_from_zspool(zram, page, index))
+ if (zram_read_from_zspool(zram, req->page, index))
  goto next;
  zram_slot_unlock(zram, index);

I tested the reorganized patch on my end and found that it didn't work
properly. Currently, it has been found that this index is uninitialized.

