Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756581;
	b=iIuGzmNvO7vKN2qJ1rNtg7dfq3Es3n3v+5TUz2CTjobQdvZyeCk3SbNGzf+1F2EmXkah
	 oF82/pTZ9YTD40WcaH4ema9BySQuhexMBsf0INQrUN4vWdC76OylITYcH95FmmvCejKaP
	 iaWY+EODLYxyWbSSJLaU8B/0VvgZPADKGKmn8z4+9DJ/Tqu/ElkLEi1xCN7V6YQP50D/k
	 4qjV+BdSnqaQgICJ16G34pgGI7yzIICWUIo+qLoYrdQdEVQYGTWOFrVPKMICCupkP03BT
	 4LmeIkG5YUbRdKD6WMtlKexuI9a6LTDKpNJDj3V/+J8boZMKqvJoCIv6sRpC2W4l3Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5dCvo6bsmgCaQ8DMa8VWGE76Rg99fDHT/+IeuLzD3dU=;
	b=S8W5znlzUlCiPLty8Zmu32zfBpixD4vxBQAq08K62O7RsfSHhFfSqyyqXjNqtJywT+Wx
	 J5zj6t+jA7qe9WyCdNZEaqubZGaLBY8P2SB8WMZs2rnqtaeFsfI/qQBPQuq8WYXoh+Ali
	 1cGgkH69OJ8Eo/bh5Ee1NXSR/xxAoIBTeMMUGvgOhCuZVPS7OYMLAs6MES+ARm/0nVElH
	 ZHNbv+6VoEdLKa71IzjxVZQ/OLkgljcDEahvvybzUHkMNImW0OivQ2IgMpv/Yw5xBNMWV
	 Tb+ZNlcgMdZrdBvL1GIB3vQGPKQhAfGZKPWQanQBnL6OB8+TfWTYQyCnCmd8VXE/9Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s+adkAZn;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44A3606A31A
	for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 11:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B44A3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s+adkAZn
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso295171b3a.2
        for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 04:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792756580; x=1793361380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5dCvo6bsmgCaQ8DMa8VWGE76Rg99fDHT/+IeuLzD3dU=;
        b=s+adkAZnr3Kn/RfzSY3qYmRNyUA+d6aAnEkHDvskSdcJXybOUl2qWdYoWfXIe/mRqw
         a2I3e04I28t18EGam2ykHEQ77LPPqltfwIrbBPbL+S22/YWcW2FvsOLK9O6robRcDIhU
         KqfB1+RThj2NzvK3U5/zZJJ4m4dFYwNmIM+YY5nGAy5wDPyQr7TgfFo3vPZ+nL/B5bvQ
         4D+yM3u2B0Baiv67oUg8R1eZcV7Qv659c0Bb75v0F6TT3yJ8Ywzwp928vOcENIpOZD/O
         4vVMO6vosD7KIzYUHnMA2vvfCDDHXAM1pZaaiC4UHsxPihzj7tV3OCHGY3lQkfJ/TCpG
         DOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756580; x=1793361380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5dCvo6bsmgCaQ8DMa8VWGE76Rg99fDHT/+IeuLzD3dU=;
        b=phnaytmHF7Qpw6iiEWv+t1Aits53e9oEP4BxIDOtEn4mBGlyvzycvb8Vh5juDvy/rV
         mx78X+wrqAeveMhzUR8+2W/0cx3d5zIr36g87bn8kXgxkdPGHBKUgpk86kLxeUALbPrb
         ZobWC0QF+iS7vnStzTE5QBNfQw7F+U4RRZ6AGGBAAagdfCajQZRjYIW6YvSLCx5R67P+
         ixhzDh4t+v71zOKowGZ0uT9zNYCvVYsCbRb0rjSxL2dvHKWuyq3OzILDMRCmIG489+md
         EYtmv9pDUusIoyGWg+/2wddyTAAc8oGEZuTJMZGCpKHNsggXRmOACoviPLfH21ODyv0I
         UmHg==
X-Forwarded-Encrypted: i=1; AKwUvBz8YLa9Ll/A0Ntp1zfISTDvlDrOqxU2EadzK/FtcQgt3APcnlshAiqaxOYQxhJxAHmYOLamWNs52rSxvA==@vger.kernel.org
X-Gm-Message-State: AFq9FYI9u81C7XF0MRzKxEIbVFgt9RAiG1782h9dk5zf77UqgxjBlGMx
	GrYKlGxsY0YDkTTJFONjLbRG6agisXxT5/HcuFatFRjpD6G4mY8r/07qB8FWUoec
X-Gm-Gg: AYBFou1ZQKQKC8A8CwdtSrRr35pBDV65AMwYFmmwkhZMnE1VeIHmyYMJ75BRxL+27NQ
	USf3r4L1KDedPqBz0yoksKUTmNQSjf3ciLBPgLBb2KXlV3iHFN707/fnEoHemQ68gDG0F3k1pwZ
	ShLsjTA5UYHojkSm9iHIWo016Vki9FH14NovHhEyIdgUGWIMgk0aUwSkopwqfAW54+b8zqd92qU
	6so019DZsjyRK9jQE4YjG1kpw1yPQlR7ekX88mnqyIaQYbF+Ipr0gHZf3f5lwIar2AHWDyxyunk
	dXzJ5p7xT8teqKltGwuE/E4jsyauGVS+3PtMl8lCMXw8IzBOfI0zUvxAz1CfcWVW6CFrXAHJJnL
	jDKmuT2nWnfbgQZ72lvXut3Pj5dU0OI1ONBTRKxYrMapSTGmjKg/cvVM0xfXHyWcDS84ET9GMch
	ZPzsGrrzcw4gm6GDJbrpTDqaQNgTrJTkw6thMpSpgHiK7r/6MDBVxEPD1KAkU8W3Jtoj+zxJ33I
	+GodCDNnkMvSZnnyhFa9mH115kPcQ4KeNS2b/mY76y93fJ1he8gKA4=
X-Received: by 2002:a05:6a00:3496:b0:89f:d254:7c74 with SMTP id d2e1a72fcca58-8a2c626f0e5mr1846740b3a.9.1792756579962;
        Fri, 23 Oct 2026 04:56:19 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7ae0:50::498:6a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a2d2948e11sm604419b3a.31.2026.10.23.04.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:56:19 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+feeb9b5352b9ff89618a@syzkaller.appspotmail.com
Subject: [PATCH v4] block: use READ_ONCE() to access the task io_context ioprio
Date: Fri, 23 Oct 2026 18:56:15 +0700
Message-ID: <20261023115615.12260-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020125233.9820-1-ngocthang2710.1999@gmail.com>
References: <20261020125233.9820-1-ngocthang2710.1999@gmail.com>
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

__get_task_ioprio() reads task->io_context and ioc->ioprio without
task_lock() when called on current, e.g. from init_sync_kiocb() on every
write.  set_task_ioprio() can update both for another task at any time,
including the first publication of a new io_context.  KCSAN reports it:

  BUG: KCSAN: data-race in __kernel_write_iter / set_task_ioprio
  value changed: 0x0000000000000000 -> 0xffff888109813730

A stale or torn value is harmless, a task simply gets the old or new
priority, but the compiler may tear or refetch the accesses.

The io_context itself needs no extra protection: only the owning task
drops it, in exit_io_context(), so it cannot be freed under a lockless
reader running as current.

Read the pointer and ->ioprio with READ_ONCE() and write ->ioprio with
WRITE_ONCE().  Publish a new io_context with smp_store_release() so that
its initialization is visible before the pointer.  The reader only
dereferences the pointer it loaded, so the address dependency of
READ_ONCE() is enough to pair with the release, as with
rcu_assign_pointer() and rcu_dereference(); an acquire is not needed.

Reported-by: syzbot+feeb9b5352b9ff89618a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=feeb9b5352b9ff89618a
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
v4:
- Retitle: "annotate" was too vague (Damien).
- Explain in the commit message and in a comment why smp_store_release()
  pairs with READ_ONCE() and not smp_load_acquire(): the reader only uses
  the loaded pointer, so the address dependency orders the access, as in
  rcu_assign_pointer()/rcu_dereference().  No code change.

v3: https://lore.kernel.org/r/20261020125233.9820-1-ngocthang2710.1999@gmail.com

Tested with a KCSAN kernel in QEMU: 26 data-race reports per run before, 0
in two runs after (v1 code, later versions differ only in comments).
 block/blk-ioc.c        |  9 +++++++--
 include/linux/ioprio.h | 11 +++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index d15918d7fabb..fac62f2858ec 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -277,9 +277,14 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
 		if (task->io_context)
 			kmem_cache_free(iocontext_cachep, ioc);
 		else
-			task->io_context = ioc;
+			/*
+			 * Make the ioc initialization visible before the
+			 * pointer.  Readers use READ_ONCE(), whose address
+			 * dependency is enough, like rcu_dereference().
+			 */
+			smp_store_release(&task->io_context, ioc);
 	}
-	task->io_context->ioprio = ioprio;
+	WRITE_ONCE(task->io_context->ioprio, ioprio);
 out:
 	task_unlock(task);
 	return 0;
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 5210e8371238..be999cbe7c91 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -56,9 +56,16 @@ static inline int task_nice_ioclass(struct task_struct *task)
  */
 static inline int __get_task_ioprio(struct task_struct *p)
 {
-	struct io_context *ioc = p->io_context;
+	struct io_context *ioc;
 	int prio;
 
+	/*
+	 * Only the current task itself drops its io_context, in
+	 * exit_io_context(), so a non-NULL ioc is always valid.  However,
+	 * another task may change ->io_context or ioc->ioprio, so make sure
+	 * to get the latest value with READ_ONCE().
+	 */
+	ioc = READ_ONCE(p->io_context);
 	if (!ioc)
 		return IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
 					 task_nice_ioprio(p));
@@ -66,7 +73,7 @@ static inline int __get_task_ioprio(struct task_struct *p)
 	if (p != current)
 		lockdep_assert_held(&p->alloc_lock);
 
-	prio = ioc->ioprio;
+	prio = READ_ONCE(ioc->ioprio);
 	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
 		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
 					 task_nice_ioprio(p));
-- 
2.43.0

