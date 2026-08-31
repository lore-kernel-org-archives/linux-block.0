Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D646C82A
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189671; cv=none; b=CRqQ6NvDddd9JITldxyl91qKZ2yF+Iv+yfh+yCzu2jn2B2KKm1F+ItYfhc+5OEDjwwC65qAVZdTjKiwUI2bq0L2R0lbFic0GWcxdWn1wX6BdXT3I3Y8IpUr94NtWy+YZfOW0G0/H+hfn0x0GIPD9bOspsleP6+I/fmAlgPO2CGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189671; c=relaxed/simple;
	bh=I3IR3GBHdAkVdNiESsyYvrip0q0uu2T6kLFw5nY8Hio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u70JSF8v+o4uDJCo7IOiEGIo5iKNMa/z91qJnBkprn1837ZhBXewrV9WNzgIbQxnbs9V42JGsNuc/l8XGC4p2M+Jdhw0PJVz7YlM1QRX38M+ixUIo6quGC7wHzYjLAOa5TyrLnulg/qaS/CJr/S6XTXFfbRjAnyq3tS4RVQwWso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkCL/YRx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkCL/YRx"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so20422365e9.3
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 08:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788189668; x=1788794468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Upu5Sph9WjD5dUvZLJCJ1CVmGjImMqIfnouv4erWVM=;
        b=NkCL/YRxe0THu+EQa4D3X21RcS6Lr+FXqoG/ozqCCntah4y08W37h9nOUt1bRkmT9r
         IERuY2Bh355v3WbGOYH7zUsMzWNSNWvsD4Bv1FxGs1pyTa8+igGnuZakoAv3XhQHx6kr
         EzHqFaVbfOboJNY9wX564biV3mOnCZGc0lxcNN3JGYSlk30plp8sQiiOwxTKwsrJLRj+
         F7MwQGUUeqZL5GZ7mqe6lCFUO/wc4d+V7AU9EKt2G0CHhT9EZQK33j2wU2J9OMmYzViG
         a4+WX7FW8zFTv+juPIEe+9G2eQJXa+2rZRjubzYhmzoYS9ljUQlxYeVWp1k7jhLhjcj5
         NzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788189668; x=1788794468;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Upu5Sph9WjD5dUvZLJCJ1CVmGjImMqIfnouv4erWVM=;
        b=kwcStxmYLUnglKXe18Swluo8w8tScbxh4cetNFvTQQdpAqLqRBJpR0tHFZE+QMNRzp
         SLcZ3shM93oMr68XEGVEKaVx78DSi+ZCpYL8oql7RtUmSMrP3XD10WuthZUYfrf7YbVC
         d09DD5x/pTPU6QyJXkxRLYp9gh9LfRiamSL5mcF64RmKEDiTp6BufMmVWLt8t2EWM7k7
         oOjl9sFcdEAkA2IK1UqaEAV/Q7IHVIn1xM1OP4RElpl3T4xED6kT997IbgpL5yK6o5Sr
         hL90hBDQi+kx5vab+UgRMiUmEMHCdHPu39qMnlO5chU4J/7T7E3KjqzJXuh2E58YtWQx
         stPQ==
X-Gm-Message-State: AFuF++k9y1YPt6Re9wEijguJVHnJybhWgQ1dskgkwCNfZyjRcxT8JX00
	Z8Z0N8afn2SOqml9UJ2fiFidm5RXE1s8rczPvLmEk0bKKCgePn5/89XY
X-Gm-Gg: AR+sD12L3ukBBURK+Mg+N0WuyMV9QPcgyx/qEFEgkX3bKH0fpyNgxm8Im+zCWnFtqp+
	HDKnh5YpBK8JvOYwDlF+f7+qqF5In+D3yvJfsDy2x6MXbfA+hwutgRK2Uoxc8nC9H+s8uthpCGW
	pKkrmQx1geJEYeU6kdp6R/u1Gpc3MZanKK1MWchehCVIuS1+iyeltZdK24mbgf+RXOO2K8DTRcn
	axzWCTxD+prwxAd1RocF3BhRixz0SipJuZOiltSvrSx082zQoHPEyOQx+x3gmTDQm35gBcBSgAi
	2753RVuF9Kra7iBgKXQOyBF+McA8tzizdZ55FUhasNYy78EdQsaFjQW7f4lLngPdW38QH8BRNu9
	KT3b+zd6Ap4szDUIWcnAOnRGYVH+K5VY7nTscxxhQCHVvgy88qRjXKGHqp0mfyZ9q3+4gz/YkGM
	V9a3t/pco9pTBG+RShsRboNeg/X54tU8634PtiIW3fnKHq7NgLL6L47wcUkopYyEz7jD9hnsRN0
	7UAckotR/6BKNfNoHRvJEd6
X-Received: by 2002:a05:600c:1d1d:b0:499:ad2e:f7bc with SMTP id 5b1f17b1804b1-49b91c3ddbcmr332472335e9.10.1788189668022;
        Mon, 31 Aug 2026 08:21:08 -0700 (PDT)
Received: from unix.. (244.red-81-44-253.staticip.rima-tde.net. [81.44.253.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b963c3c0asm528166815e9.10.2026.08.31.08.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:21:04 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH v1 0/2] block: brd/loop error-path cleanup
Date: Mon, 31 Aug 2026 12:20:42 -0300
Message-ID: <20260831152044.166353-1-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Two small error-path cleanups in brd and loop.

Patch 1 destroys the brd xarray on allocation failure after xa_init().
Patch 2 restores backing-file GFP mask, clears lo_backing_file /
lo_device, and re-enables uevents when loop_configure() fails after
loop_assign_backing_file().

Base: v7.3-rc1

Tested: built bzImage with CONFIG_BLK_DEV_RAM=y and CONFIG_BLK_DEV_LOOP=y;
booted QEMU initramfs smoke (ram0 present + LOOP_CONFIGURE happy path).

Thanks,
Iván

Iván Ezequiel Rodriguez (2):
  block: brd: destroy xa on allocation failure
  block: loop: restore state on loop_configure() error

 drivers/block/brd.c  | 1 +
 drivers/block/loop.c | 7 +++++++
 2 files changed, 8 insertions(+)

-- 
2.43.0
