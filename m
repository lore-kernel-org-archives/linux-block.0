Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63994C4F73
	for <linux-block@vger.kernel.org>; Mon,  5 Oct 2026 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213692; cv=none; b=JVpXjKxNSK29k0JKeyBd5BhU+iCbMNaOFh4Kr+bD3yIRd1bvhB7ieGzJeNvRH8NnaqkYonuhS8IOUMHbZW8Ma74dbOPvW0KBXWJN1DroCyaiXF8I1KjBjG541DlyHveT4ldgdv74LPZjx4vXQNb5i2eeevL7Eu/QNNL5LuxTZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213692; c=relaxed/simple;
	bh=tSJ7DA2uB4DJctm4lIPofOqJU6pfSFeFKaeAUMVo3Ik=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UGLvTCXjuNn9tOFCX+H3pZtSbxSxtQLxqS/1FY1ov4rvdi630adCsifM2EAYIHirCK1ua5BO2sgLtr2HA4pTV+G/fMcWq5PmI/QXq6LfTkQfbzxYcvdFXDhNgwfo0ajsfaiUUxnID0ckmDsMZPCKKvBADjDvJwuV5LWhMv1Khao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a174a3dc9dso6077965e9.0
        for <linux-block@vger.kernel.org>; Mon, 05 Oct 2026 08:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791213688; x=1791818488;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:reply-to:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5xwy1bVKutOBgBtdDauDgxu1J//ur8mtxlnL5sPwa+I=;
        b=1EZza2izzyjWGdT7GFJWJHRiU2NUT9RyyKVEDgm4zvM61BYQZqns59qmCSfHfjE+/z
         BrKt0V1tLXdYnFknJAtKqO4D60LqjQg72Naq51S/L4XxSEl7isRE8pmZB81YOGpn2XM+
         Wt2jWBkeHoVHEGebVGGxiPj7xmtA2RC+oPHgq0rafk3vYiuczBnaiuQK8keoGyQgfeS+
         YUatEDyJJA3pQMl2ztFqXAIAcyMv+W7TS7VM+pq+u5dwHP6AKNYe3Xbn4YjZ8FSn8BDk
         91/9lfAsxmcpHX7TdFwYITsqG/+eN1uFuLBbdYnAG7neIp2ErIuFQ3T1QiJVKEmfiMIV
         T/yQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRCPr68YkBOQvZlZbY7AkDV16BFrEc5KMRZxy9h4KmZdDFZfWSOgUiCQ6Vd8cH1erlx44ZJRApZ/hJlA==@vger.kernel.org
X-Gm-Message-State: AFuF++mS7flRgTvRgifzLeTfI7ucNdyRtc7VdyPxoYzwtbLKDL4mdXm+
	XkuhAw+voAOj+reCph4xIXQPKA13eyVdHvZGlAjJ3eYuEjl5WKvvB6Ch
X-Gm-Gg: AYBFou00pMbM+A+aPRL1v7wJnXb7fpHnhoeK0vR4qTujcbjBnqH4CdwfzrWnCLrHyQW
	2B/iLyEBDPI112VsZRnQc7R3+kqJGoiH61pUjzEvaG2dhTWasZKvHceXoHeTyUDIE+1ccA/ezFZ
	2VtA3l/V1WQR+4qbJckLuu6aRf4N8gYUOvD6UuTR73ooD/FJdq1ZqLRkTYFywSbRfVUjCx7yecO
	UcTtawb4S2OFd2aT/iGZCIGEsRfC/UimznbWH9yY6zy5VxDnQFj5Q7LZwQvi7J4p85dOZ3kv6vH
	WMMUyiSGu1y5W5MKVrtWUpA3+AO8EVj+62DacEzCwRbveMtozSxn3xUi/D94Mzux/rZ9hlnMibt
	6vqMRhX0ytIX777sfHaU3750/gZVV28iuMLaOZCOTEFqEA6fF9GS6kJlaIC094K0oGXdHqgYXFL
	OsID85t1AZ2UViAL0P1weOUydDyAhQUNw4huQ9iviWuX7XEvbJqZWIeOVswrA/j1VahQ1mjuIy+
	d1+3RA75zOMwrBOC4y8nweh7T0KPajAh00q3Q==
X-Received: by 2002:a05:600c:6217:b0:4a0:1aa0:7cfa with SMTP id 5b1f17b1804b1-4a027583efbmr163836505e9.12.1791213687918;
        Mon, 05 Oct 2026 08:21:27 -0700 (PDT)
Received: from [10.68.32.41] (bba-217-165-185-173.alshamil.net.ae. [217.165.185.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178542326sm1279635e9.5.2026.10.05.08.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 08:21:27 -0700 (PDT)
Message-ID: <348194a3-e542-45df-8be9-eaed588c07a7@linux.com>
Date: Mon, 5 Oct 2026 19:21:25 +0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Content-Language: en-US, ru-RU
To: Jens Axboe <axboe@kernel.dk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: "Denis Efremov (Oracle)" <efremov@linux.com>
Subject: [GIT PULL] Floppy fixes for 7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jens,

Floppy fixes for the 7.4 merge window, based on your for-7.4/block
branch.

Please pull

The following changes since commit 9690943353cec1690a715e000ba6a74e5139f530:

  block: amiflop: synchronize flush timer before track flush (2026-10-01 08:37:58 -0600)

are available in the Git repository at:

  https://github.com/evdenis/linux-floppy.git tags/floppy-for-7.4

for you to fetch changes up to bb38473f1bcb287567f2fa7980e483a778092504:

  floppy: return the drive state flags from the 32-bit FDGETDRVSTAT (2026-10-05 18:59:41 +0400)

----------------------------------------------------------------
Floppy fixes for 7.4

Six fixes for long-standing floppy bugs, most of them found by syzbot
or by race detectors:

- Flush pending work before releasing the IRQ and DMA when no FDC is
  found, from Karl Mehltretter. The work queued by the probe could run
  after the IRQ and DMA were already freed ("work still pending").

- Unregister the platform device when add_disk() fails, from Guangshuo
  Li. The failing drive's device stayed registered after the module
  was unloaded, and reading its sysfs attributes oopsed on freed module
  memory.

- Return early from reset_interrupt() when cont is already NULL, from
  Yang Xiuwei. This fixes the syzbot GPF in reset_interrupt(). I decided
  to take v1 as a partial solution; the full fix will require
  additional rework.

- Replace volatile on command_status with READ_ONCE()/WRITE_ONCE() and
  annotate floppy_work_fn and current_type[], from Cen Zhang. No
  functional change.

- Don't keep a pointer to a stack buffer in timeout_message.
  show_floppy() printed it from the interrupt handler after
  request_done() had returned (syzbot KASAN report).

- Copy the drive state flags in the 32-bit FDGETDRVSTAT and
  FDPOLLDRVSTAT. Since 4.13 the compat path returned flags == 0, so
  32-bit fdutils saw every disk as write-protected and never saw a
  disk change.

Tested in QEMU with a floppy test suite (including the compat ioctls
from 32-bit userspace, and fdutils/mtools/dosfstools workflows) on
KASAN and KCSAN kernels, with no new warnings.

Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>

----------------------------------------------------------------
Cen Zhang (1):
      floppy: annotate data-races around command_status and floppy_work_fn

Denis Efremov (Oracle) (2):
      floppy: don't store a stack buffer in timeout_message
      floppy: return the drive state flags from the 32-bit FDGETDRVSTAT

Guangshuo Li (1):
      floppy: unregister platform device on add_disk failure

Karl Mehltretter (1):
      floppy: flush pending work before releasing resources on init failure

Yang Xiuwei (1):
      floppy: avoid NULL deref in reset_interrupt when cont is cleared

 drivers/block/floppy.c | 56 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 22 deletions(-)
