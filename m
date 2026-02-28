Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E40B1E5B70
	for <linux-block@vger.kernel.org>; Sat, 28 Feb 2026 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772272932; cv=none; b=fzrcxHR9mgpodwRADg10eM14oUchomdjkEfLYxzTr/6UAdAEl7EFWXhPnl7zHrrgvslhA1DoKapYiNOPVced0BtWrfmTUwz2KDlM17gn5cdr1K6iv/i9zRTK5mn7zsgeHa6tTUR5zm91/jXOk9TGxwR3pRSv8IdkE+RMeufP17U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772272932; c=relaxed/simple;
	bh=4Aef9vSXCWP2QZRbxrzJQ98mULLXqxmIPAzpcYcNBNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SGmPTdJhrb36pifO9odL23volCXV2KHbaQg6+JptqaoWnt4Adg9V0mMu+qAuUTUx3OyE7sCM03Ayi6U+m/809+bACezTX6h+Ul71Te6TSoRDEcDSc/nb7lvDlxkIM0J5MT/fZvehydJ52SwMguO6rgyLXTsSZDvyUnHBMBVX9zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eop+2DC5; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eop+2DC5"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-bde0f62464cso1098692a12.2
        for <linux-block@vger.kernel.org>; Sat, 28 Feb 2026 02:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772272928; x=1772877728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NemizFckd1NGmEB8vEadoCu6WBOYRc9Jjk19xx9+dh4=;
        b=Eop+2DC5aK+lAGm5knSnz+tM2dSDH2rVF+v+JQHYwE0LfX0RnUadlD0lpKgBglcDIM
         n5a5U9t6HD+t0Vv9Q89CculJHUKMv7scwK2WT+zLxT7UkIu+A7OLQ3Z3hxujf3CTNFr9
         OStwx/hAXK7FhJNJ3jh/KYq9SXEO4J8y4G4cGbd98v7kqi01mmtp1HI7FUlXsgwLLsvV
         jFbltW1+OcpNqVSxlXhoL01BuhRANVzCHSBePi+mTR/pN8RZLc+lAVAmlbScqPxnQi8T
         jaogXA4xUenczV1Xup/OODKI5tc7BGwzOEp7CzN14S2jIVVrwHoY7DPe3QrZ74qDeHgp
         heVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772272928; x=1772877728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NemizFckd1NGmEB8vEadoCu6WBOYRc9Jjk19xx9+dh4=;
        b=l6GUkxgqxJInkxRy7GJIC5QO9fCK6FzG7jkuP2smXLX3hBgILB5Kp5t4BNJfS1ixka
         E5Mi/nXKRYiZictlxk4ARec3ctk0Wdfchf98klIGF88pZx0ceklyacKoT8iST758SXKK
         v20Z4vqezqnW2/c3sx2ASlxgt4SQitDvpuwU4BEv/Wmh2tHrHOty7k2KI34XxrYKixMX
         BHBGdcmj3FTOm2Djt2gxH/uZuPwy47L0aBc/QX2JjI+NezWrhco48WPWHckqaI6sBnn2
         Kn4qUZ5aEXr92l4gaJefEUut26r81LPBr6ALdDiKDcDvQvilVdX/z3JHXDhQNmsjtIwR
         bsyQ==
X-Gm-Message-State: AOJu0YxnpcapkdR/LM/a+sBxn0uPysoArDIk83an5u6r7Kr5fZEI3EaX
	/oc0lNtN1x5aEXuAtZVrlNTh16WxotA90IZPya91SjD3JLqKlSvfkWFU
X-Gm-Gg: ATEYQzzfAaWYDfCs60uDMY31fFL5DvLXXoC4vVw7XuRdSquzzV0rEjIL1DYvK+hhA2N
	xKZ8yEd7YsUYonmjsPnftwXBw/XgYNb94h0XO3sIm8gb8LKnJ7NBNXkOGIP0GlmKTwioxBPgQoa
	OcSVxlpO5ue3cNGVEzahd3yc7E/my0iq8nmGwOzUV32lsSiw6fktO2TI7js8dYjbfvptq6NX8cE
	yMa47lCjOIJV2BXs+xGGoslSho7Ejr8HcmDOIqA+WySUe3xD76y5UQR/Ay+vK1gm5cGweLDjZzP
	RJi8L0PxO8uz/G0Wpz82uNP7H/E1Gs73quZXqztvrQLu9fklDXav454pO+3yuTPyulIUvmNBdD9
	jku+fqVMiM7vOi6kxmWjihz7XSe4fH8rMtV/4mzoeNdEKccyl54bixKsKeXBtBx1uwaRMs+KbKL
	xa55ALJlZX2EJJGzpPm85JzQ2lff5zcwDqXg==
X-Received: by 2002:a17:90b:5747:b0:354:a065:ec3e with SMTP id 98e67ed59e1d1-35965cd0f50mr5149309a91.26.1772272928282;
        Sat, 28 Feb 2026 02:02:08 -0800 (PST)
Received: from archwsl.localdomain ([117.184.79.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593db82627sm7780278a91.0.2026.02.28.02.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 02:02:07 -0800 (PST)
From: Jialin Wang <wjl.linux@gmail.com>
To: axboe@kernel.dk,
	yukuai@fnnas.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lianux.mm@gmail.com,
	lenohou@gmail.com,
	Jialin Wang <wjl.linux@gmail.com>
Subject: [PATCH] block: fix race in update_io_ticks causing inflated disk statistics
Date: Sat, 28 Feb 2026 18:01:44 +0800
Message-ID: <20260228100144.254436-1-wjl.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When multiple threads issue I/O requests concurrently after a period of
disk idle time, iostat can report abnormal %util spikes (100%+) even
when the actual I/O load is extremely light.

This issue can be reproduced using fio. By binding 8 fio threads to
different CPUs, and having them issue 4KB I/Os every 1 second:

  fio --name=test --ioengine=sync --rw=randwrite --direct=1 --bs=4k \
    --numjobs=8 --cpus_allowed=0-7 --cpus_allowed_policy=split \
    --thinktime=1s --time_based --runtime=60 --group_reporting \
    --filename=/mnt/sdb/test

The iostat -d sda 1 output will show a false 100%+ %util randomly:

Device  ...    w/s   wkB/s   wrqm/s  %wrqm w_await wareq-sz  ...  aqu-sz  %util
sdb     ...  16.00  104.00     0.00   0.00    1.25     6.50  ...    0.02   0.90

Device  ...    w/s   wkB/s   wrqm/s  %wrqm w_await wareq-sz  ...  aqu-sz  %util
sdb     ...   8.00   32.00     0.00   0.00    1.38     4.00  ...    0.01 100.30

Device  ...    w/s   wkB/s   wrqm/s  %wrqm w_await wareq-sz  ...  aqu-sz  %util
sdb     ...   8.00   32.00     0.00   0.00    1.38     4.00  ...    0.01   0.20

Device  ...    w/s   wkB/s   wrqm/s  %wrqm w_await wareq-sz  ...  aqu-sz  %util
sdb     ...  11.00   44.00     0.00   0.00    1.27     4.00  ...    0.01  82.80

The root cause is a race condition in update_io_ticks(). When the disk
has been idle for a while (e.g., 1 second), part->bd_stamp holds an
old timestamp. If CPU A and CPU B start I/O at the exact same time:

1. Both CPUs read the same old 'stamp' and pass the time_after() check.
2. CPU A executes try_cmpxchg() successfully.
3. CPU B fails try_cmpxchg(), exits update_io_ticks(), and immediately
   increments its local in_flight counter via part_stat_local_inc().
4. CPU A continues to evaluate the 'busy' condition:
   end || bdev_count_inflight(part).
5. Since it is an I/O start, 'end' is false, so CPU A calls
   bdev_count_inflight() to check.
6. However, bdev_count_inflight() iterates over all CPUs and sees CPU B's
   newly incremented in_flight count. It returns true.
7. CPU A incorrectly assumes the disk was busy during the entire
   'now - stamp' window (the 1-second idle period) and adds this large
   delta to io_ticks.

To fix this, we capture the 'busy' state before performing the
try_cmpxchg(). By taking a snapshot of whether the device is active
prior to updating bd_stamp, we prevent CPU A from being misled by
concurrent I/O submissions from other CPUs that occur after the
timestamp comparison but before the inflight check.

Fixes: 99dc422335d8 ("block: support to account io_ticks precisely")
Signed-off-by: Jialin Wang <wjl.linux@gmail.com>
---
 block/blk-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 474700ffaa1c..1481daf1e664 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1026,10 +1026,11 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 	unsigned long stamp;
 again:
 	stamp = READ_ONCE(part->bd_stamp);
-	if (unlikely(time_after(now, stamp)) &&
-	    likely(try_cmpxchg(&part->bd_stamp, &stamp, now)) &&
-	    (end || bdev_count_inflight(part)))
-		__part_stat_add(part, io_ticks, now - stamp);
+	if (unlikely(time_after(now, stamp))) {
+		bool busy = end || bdev_count_inflight(part);
+		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)) && busy)
+			__part_stat_add(part, io_ticks, now - stamp);
+	}
 
 	if (bdev_is_partition(part)) {
 		part = bdev_whole(part);
-- 
2.52.0

