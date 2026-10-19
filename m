Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C666B49A3BA
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404996; cv=pass; b=AUHbnMtbPlZZ0aLdi9mEUgseaUSEVRgrejJNlIjlgdl/pEAB28f7ZNvpDoeA1vM5EycgoEedKbv3i5l75Ww6qmm9hiAKHux2imYuPvXF1Dar3TTBwACUZhYXQGUdX/2wfIf9Cw7u3mJrLlykmyF120IejDi9n60RQQuXM0ECMlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404996; c=relaxed/simple;
	bh=N2Rl8k8IgcLPE2wN1827Zi3sqj27JlxGTNzavZMRatM=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=UU/0BktaOisz7+2ouNhCdTZ69J/PmkHJ3RmwdY4o10IBNNxwlxgpywysL0UuiprHqlNg6g7izqsFuadz4npiJUpV527VMONr7i4mg4FPJkWoD0obPcjm9Q4nyYFnK5Bnf8OZgEF4yJTf4HgTvdaCmppbH41XUigWsydpuyaFhbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mBJGAaAr; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mBJGAaAr"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5337fa12431so334301cf.1
        for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 03:16:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792404994; cv=none;
        d=google.com; s=arc-20260327;
        b=Ce4yfs1rVziytdLpv5NOQWOxz7v3VbOcdKVGwUG5MermsR3/jovqkCFtW4NdVjJ6kT
         SRsfFkmbyV+775QKmOnkwbmHsfB4yAhj5Alc0XrxVWZe2AWdpc0xnWJz9KIsdwHQixC/
         vw0REzJxyXBaYzEcjY15dArx7s0kNIiuUJKb+Z61yRpqKqxGel28/AkxVnA8L3qKM5l4
         BV7Ar7//f3M2SQBYwpmxVHSmyBxJ0V2809hShdd3ygkUVisTmRBUqsQak7fINjMQx3ok
         vCt3m5CykCQb/WqPqdDX//Xtw9f5D/q77Qs1zAlkE7qijcywsKyPemFhbSi/YL2J5kWf
         cA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=1kK0sOjuuFZMI2sdcDCwOn7rxSwJsnk2rOHVdknEve4=;
        fh=68auJKQsedyrsGPCXxenX3ADWsT1G9wG1karCL2VRSw=;
        b=F/6O4/hY9UlspajoAOi0nY7BNdKTuRrZVAkyQLBNGWcZEcE6Zz2e7F3iqqAj6d5MST
         Zl7o+HGfkz5CmbjTJS+l5R1SYya2Mloxc8TqNHjcAwBxEU8oLMPqj070geUI2UVzSY6i
         MDmGb19sSx8sit6ztcfoUc1e8Agddtal2hFNQxAJURkVSjUaoy44wnxfkrVjT5G5nrrB
         7rfqp9851rR/GCI/OPxJyPTX9utq62vto590/eK+kR7N/JHPA230t5JDsUrLiUqP1r9/
         nAe3PrNJv5GGrwdimcl6SuARFDO9UQpxdwMqcYHjWi6yDWLN7j3IfyfYAWYqNv+EC00y
         UjWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792404994; x=1793009794; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1kK0sOjuuFZMI2sdcDCwOn7rxSwJsnk2rOHVdknEve4=;
        b=mBJGAaArAXN1y/eB9UGl7NaIh/lOawxdjAV9wAq5HBTumt8y5g7p5wvLmT/7SnFSI8
         w9ZaIeyAMN/SdAH1u+1lU+yzzF3/IatFnD8yOmkArVQne268VnccaIlQufj2UhZOu+SR
         wXENPkPeEhYXE6+Jh6KpnijVHagbeoJFgtim3f/3pwaEsSfgNlhJW4xwnrUQTVOvouZ6
         zIs8S1Zk27BEerGMPR9n8V1n1xurIb5MvGwL1wCY7umtnhx/ZjR7pKniwP2Tni4BolBW
         4G6K3iPpSiloWFFHaPwbv5UsLJxYl6W+40ZCaGemcLEng8xRLRqXZizivl4xP7wNKh7T
         1zRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792404994; x=1793009794;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1kK0sOjuuFZMI2sdcDCwOn7rxSwJsnk2rOHVdknEve4=;
        b=sDmdFYStP9msk6ufioSX1tBZC2CNueCG91RkQj56A9cRC+iIvfCJOErBnJyagpVGTb
         0ALG3IwxpUvgTzarQX4yuM5tnpNsvqmEKsukU9Gk2CRjKimRlLhIf5O7IVQT/lB06DfT
         Were1ypEQotFHuvwwKZJdrlntg9F4FuHIstCsoXHJj4rC6VhGOM0eUAHpHqiNUVhe3ee
         TmqEWukv6iHl/Kiai78M7Hpyp4D9H4E5tJi1Cc/5utqfmhtF2hU3+AgqJsghyfSUgMN4
         Hikza1UoQAzvDuBiESiSVwGPjK5xSzGQOjdnmssRx9lynywwFzzsrvUJhcTvOabmzG4I
         R5iA==
X-Gm-Message-State: AFq9FYKtYnFLpC+chpelklqys1MwM27gVD6z+n/6vxIw5eMubo75HpMU
	nJpH8dfKHUzytxYSgdDHFGk59fu5k+YJ9iFRjg5wYmbM1jxgpqQTdnBfSmurCofRYYiwMB7V7eR
	2tP0BYxV2+hJlNMRKUafn678afFpBiC3Q7iNCR42f
X-Gm-Gg: AYBFou15GUCTnRVafTGSJyuEZ4jo91kfAspmP8vQ1JiOL/B60Rz6GDuUrutlrvLKDsH
	i3jK5AEGtPG/ROZfSJNLMB/h4d4O5Dtc33lNpBeU6nK2urjOBR4bRK4vmWmhFNa1XOAH60z2m5Q
	SK4Eu+1bpIEagnV7u2go3LSOuCZ9pL/8j+Aazk2BRthELtFOLvzIvypjxj92P9m/XeTrDZUYHHt
	Cov4ORsPk24WxiTtmwYRml11sb/9wYfZ9Nmbo4iFJiHxfh37oiJ0Ml6AdRtEptdI4Sejedvngy6
	te/U86PW6t8VOOsqXn+OTxik0Z4C6sCS8FMRFGu9SzRNH/LXGyqFljmRdstiiKtP4pzvYuuShpE
	P6TF8djePCdRZIfAtwi1zOEywnxSGgVdQdx5KhQxHuBpBNssZD32nbYaYXG0rdd4Spn7qM8jmO5
	1bGY9bzEdAGrmEixdtiIRzCr8cJD/+OIK0WL49cObFlbo29T+ScGIEihydg13fkB4=
X-Received: by 2002:a05:622a:90a:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-53649acf23cmr35163661cf.0.1792404992875; Mon, 19 Oct 2026
 03:16:32 -0700 (PDT)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 03:16:31 -0700
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 03:16:31 -0700
From: Dominik Maier <dmnk@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 03:16:31 -0700
X-Gm-Features: AclHuK-4K0JxYc3Lz7WkFLhYtc-wZM1h57xek6LkSbIdQcb-hWxJ9I3kt2HRq5s
Message-ID: <CAE7N4Sq6_M610g6gOUJCkkoBH06Kqbndb7KhGGLk=WCHOqHbtw@mail.gmail.com>
Subject: [BUG] loop: missing BLK_OPEN_WRITE check on LOOP_SET_STATUS in lo_compat_ioctl()
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, dmnk+artist@google.com
Content-Type: text/plain; charset="UTF-8"

In Linux 7.3.0 (commit c03c1a14507d), 32-bit lo_compat_ioctl() in
drivers/block/loop.c (line 1708) dispatches LOOP_SET_STATUS directly to
loop_set_status_compat() without checking whether the caller opened the
loop device for writing or holds CAP_SYS_ADMIN.

In 64-bit lo_ioctl(), commit 604f275f9670 ("loop:Check for read-write
open mode before setting status") added a check requiring
(mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN) before allowing
LOOP_SET_STATUS or LOOP_SET_STATUS64, but the corresponding check was
omitted from lo_compat_ioctl().

On kernels built with CONFIG_BLK_DEV_LOOP=y/m and CONFIG_COMPAT=y, an
unprivileged local process holding a read-only (O_RDONLY) file
descriptor to an active /dev/loopN device can issue a 32-bit compat
LOOP_SET_STATUS ioctl to modify lo_offset, clear lo_sizelimit to 0
(exposing backing-file data past the configured limit), or alter
lo_flags.

We reproduced this in QEMU by configuring /dev/loop0 with
lo_sizelimit = 4096, opening /dev/loop0 with O_RDONLY, dropping
privileges to UID 1000, and invoking the 32-bit compat ioctl syscall
(int 0x80) with LOOP_SET_STATUS to shift lo_offset to 4096 and reset
lo_sizelimit to 0. The reproducer is available upon request.

Below is a proposed fix (also tested in QEMU) that enforces the same
(mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN) check in
lo_compat_ioctl().

Fixes: 604f275f9670 ("loop:Check for read-write open mode before
setting status")
Assisted-by: ARTIST LLM
---
 drivers/block/loop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6fb4234ab0e7..43dc7ab3d2aa 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1708,8 +1708,10 @@ static int lo_compat_ioctl(struct block_device
*bdev, blk_mode_t mode,

 	switch(cmd) {
 	case LOOP_SET_STATUS:
-		err = loop_set_status_compat(lo,
-			     (const struct compat_loop_info __user *)arg);
+		err = -EPERM;
+		if ((mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN))
+			err = loop_set_status_compat(lo,
+				(const struct compat_loop_info __user *)arg);
 		break;
 	case LOOP_GET_STATUS:
 		err = loop_get_status_compat(lo,
