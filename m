Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA745406829
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591272; cv=none; b=tcAGBIicDowJT8eL7V6BLXJk08e+wYRTJYn/LbN6os8I/agMfenpfB0KFQwFOnCvpegJK7rT20hLSkLMAeBN2kJ8PjcQTIqE49vMClAbo/YEnNeHLEe3vMezhISjkgbDaQAJ5dv6ShchAkfcXPhF66TOAzq4CIh39+o6NpDeArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591272; c=relaxed/simple;
	bh=Mztn6u74yF+5SSFyCqft55OSEjK+jJUbvMV+Lk4c3IY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lw/Gl7AXyvGa4WSLkoDEx58K2nL6AzUrKFEnB1GnwEKOiBrCw6Z2mgRFNFfj0s9gpEOiN1vMQVlHvuaCuuY28LZuxE9DxijKgBxwJUiGQdzg0mRTnhL3bCboQAQzVKUxsJF5T3UnQjUZMsqrIyxLMoyIoQJMZV3JuqX+OV8IpsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3Qf2Hyn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3Qf2Hyn"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8484f229529so1044211b3a.2
        for <linux-block@vger.kernel.org>; Thu, 09 Jul 2026 03:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783591270; x=1784196070; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8opE0cIc56eMJrtCHu79tJ88DzlKD8oohzlcD+qczV8=;
        b=G3Qf2Hyn3fE5tRsohf0XRwgcC5tjUjTeqxmWiPiaVvq/K+fBqTllCFQkxGfZmVH2F3
         mcKTUfO041Ug6ST9t4KRU5a8STp9vqNsgyioaGToUhDh9DO0ByDNd1MxBqUzxmZ7dTLu
         kV3Gc0Bf9GfCye/1S1osUIK2+1XPpLcpTYTyw0VJ3XnlzZq2AXfYLOfnzEGiaZqd2Hrp
         bDYrPU68qGkbr5LXWKhDzaiM3wllFW2HGqhSIgdkr7YnQuKTFva3gV/aUlhlqnUSPfYK
         zmSNuRyFWWdceQZoyfj2cHScvqlFUVCm2BgUViPf4NnqtAjxpZC4QaesJyroyQdvAaFx
         yJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783591270; x=1784196070;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8opE0cIc56eMJrtCHu79tJ88DzlKD8oohzlcD+qczV8=;
        b=cAQcsiBheBIO2x4RgrrcngYWrgJqmGo2/9SRt3yk3q4LL9c0hwiA+RAqRlTud7QOL1
         uHDM59v/HybnLAEKpRyOCpztnc+7j+X3wOeEkZPjAliuODgtdjs9Bbn+iFOZaOXkKCV4
         cu5MVBQKaEnpyZyogdDxoMZSNPJkX+njcaZMUEPVs2RtKcOjbKImEbpgXAx8TkC+Cb53
         M/LgyDaztaRJ8sU4CjrgdpDUSSHYjA//5/rd5GF4Emu2nxqfyHuiZFS6eF0pU4PyK5of
         Oerb7XKshxVYBOFLjZfYMh7dkaxKGcsDxbrm1uATyFM1ZTR3zLCWdRO2k/aR3GqEa+uo
         otiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8lvgeyG946fUyNQ9KZwwGfeyhxFpZF/e41LoIdDxnNEmrY3i4GcT1MnJBEkkiko0h+gmysu+ZMCuWNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCyezK+grxm/KMdYvTLTqBMKhxrMZJz9Vt1g1ZpPVrMNIE6gBg
	ooo99CLHkti6HFhZMs9sCDAlFtT6OSLmguUkcJWmd+nvSpvhL3f7CsqC
X-Gm-Gg: AfdE7ckaStijjx5WgY9G/CrysjNT8xm1G2ZcB5Bhhh211W944oRf9535d+D/I/3+Kms
	RPw4f680r/ug01hwxVn97F8CMlafSofzSBlwd31zCjphB8TcErCl3sidQxTEu+WhCaPI06ypHVP
	sXzv5DLmViICaQl9GBuF344hj4LlFogjZM7/YNEHO7nn7GPM6QhuglOBcszR8dft+3KCC0RfxVl
	e1dLVNKKbJ4D5b6hCtGlbJOCWnF/MQEDKk4ZHvCV+Tsco1DrArQTT8dBPSYofhcLJqM/ByS3rBh
	blCM6W4ihAriRT0GRFDqlFS30NJJAjv220g5Vk6HL9QZJDJFdPCapUenfbkMeaG1enGCsUF+MUw
	/+clPUWbs706YIQnK9ICUnrUGaPtUn5zX0ca7Ke+vowOs40rWFoFgO3+Jw9DYvrKCGHeGBDzQT3
	CVP3ZclqR0TV944iE=
X-Received: by 2002:a05:6a20:3d0c:b0:3bf:7bf7:7903 with SMTP id adf61e73a8af0-3c0bceb7c03mr8033966637.15.1783591270040;
        Thu, 09 Jul 2026 03:01:10 -0700 (PDT)
Received: from homebox ([66.75.253.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659c8572sm29855004c88.9.2026.07.09.03.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 03:01:09 -0700 (PDT)
From: Yuan Tan <yuantan098@gmail.com>
To: a.hindborg@kernel.org
Cc: miguel.ojeda.sandonis@gmail.com,
	boqun@kernel.org,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	zhiyunq@cs.ucr.edu,
	ardalan@uci.edu,
	pgovind2@uci.edu,
	dzueck@uci.edu,
	yuantan098@gmail.com,
	Yuan Tan <ytan089@ucr.edu>
Subject: [PATCH] block: rust: fix `Send` bound for `GenDisk`
Date: Thu,  9 Jul 2026 03:00:59 -0700
Message-ID: <20260709100100.604252-1-yuantan098@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@kernel.org>

The `Send` implementation for `GenDisk<T>` was conditioned on `T: Send`.
This constrains the wrong type. `T` is the `Operations` implementation,
which is typically a zero-sized marker type that carries no data, so `T:
Send` says nothing about whether the data a `GenDisk` actually owns can be
moved to another thread.

A `GenDisk<T>` owns the queue data `T::QueueData` (stored as the
`gendisk`'s `queuedata` and dropped when the `GenDisk` is dropped) and an
`Arc<TagSet<T>>`. These are the values transferred when a `GenDisk` is sent
across a thread boundary, so the `Send` bound must constrain exactly them.
Bound `T::QueueData: Send` and `Arc<TagSet<T>>: Send` instead.

Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
Links: https://lore.kernel.org/all/cover.1780633578.git.ytan089@ucr.edu
Cc: stable@vger.kernel.org
Reported-by: Priya Bala Govindasamy <pgovind2@uci.edu>
Reported-by: Dylan Zueck <dzueck@uci.edu>
Reported-by: Yuan Tan <ytan089@ucr.edu>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Yuan Tan <ytan089@ucr.edu>
---

Changes in v4:
 
Following Miguel’s suggestion, I am resending Andreas’ v2 patch, but with
Priya’s and Dylan’s Reported-by tags added.

I noticed that this patch has not been merged yet, and I am not sure what
its current status is.

Link to v3:
  - https://lore.kernel.org/all/20260611003220.3512652-1-yuantan098@gmail.com/
Changes in v3:
  - Add Priya and Dylan's names to the `Reported-by` tags
Link to v2:
  - https://lore.kernel.org/all/20260609-rnull-v6-19-rc5-send-v2-1-82c7404542e2@kernel.org/
Link to v1:
  - https://lore.kernel.org/all/cover.1780633578.git.ytan089@ucr.edu/

I am a bit unsure how to handle this v3.


 rust/kernel/block/mq/gen_disk.rs | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index fc97dd873974..4d49f33c6fab 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -212,8 +212,14 @@ pub struct GenDisk<T: Operations> {
 }
 
 // SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a
-// `TagSet` It is safe to send this to other threads as long as T is Send.
-unsafe impl<T: Operations + Send> Send for GenDisk<T> {}
+// `TagSet`. It is safe to send this to other threads as long as these two are `Send`.
+unsafe impl<T> Send for GenDisk<T>
+where
+    T: Operations,
+    T::QueueData: Send,
+    Arc<TagSet<T>>: Send,
+{
+}
 
 impl<T: Operations> Drop for GenDisk<T> {
     fn drop(&mut self) {
-- 
2.43.2

