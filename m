Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795230038;
	b=wIkzQexwnNvpFekgedDY1BKbnl5lx8CdsSpJh0EmYQeEexdQpQog/JloZOTbgrZhTizI
	 H2f8UHlX5gDXqiqEqL3/piptrAizTJ1uPoqftHH/K1CtEMU3UUiiHp8SjX8VvaI1xek9c
	 Uqprv+FDfzBb6Z0KeXS1CCh8KuiIPIX82+ZB8zi5YA+MWRM6NXaAaADdG6Qs7vHFa0fwd
	 vLKZW/0C5hKYvEpxd3bG9UGLBOrgHeHLJkKycY6LmY7KhhxhHlOxaiAjanVqo0ha/SZw9
	 In/fkTvgFc1KxQ39sYXO4O5dcesKWCJIVkbXZorjXc+qZHIDLAXyTAzAOee9k+VCgQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795230038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=RgZMItNPZrMi+x9FSQCZl0pzUINCzbAlg3Rn0KAaenQ=;
	b=UR4U4UjehiqFO/COqx50IsL0opWRBeaQqoKvFtRYYFvjb/s5AOMkg+IkScGU4V7SoU08
	 v7KZUzjC6I2bAsFpD5ITsFf8WKpiPIuMJwsn20/9027dUtW44m5dxzgZg5pGWhremw8Df
	 qZ+K2FA98ma9SitGUgev5yqMDLUGYmkiz9mCP+hRYhLfsV5J89cTkofU4PIHf8iVgArlv
	 SlxCm9tnUbaobmZR04ZC8yUT9N7BWCCm63RRSYbSui5J1KLbyFV/zy28DrG7hfBhtgU6/
	 3jnGiK0YOkcEnQkOMsqK3G8suzjCdhfqdCHQGePelFdQLbCrF53LawVpQow+yWs5b3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uyms6YSt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4239606A6B1
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 03:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4239606A6B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uyms6YSt
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3869b68caecso550600eec.0
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 19:00:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795230036; cv=none;
        d=google.com; s=arc-20260327;
        b=miW2Qixkhc+wLBqxjtl6Ez0n2XmrWRqIsLRnUXf3bznxyxmTX0ZWhwy4+sHi3omYcE
         L1zAm1Ztr1Pgv3xqnr8Lz+wrInqDFFF8YHSiHIsd8scY0oKgb+LYaQjMNIaKgPpoFfjv
         biDUB3TJTBL5qbeCDO8MBexv1VNW0T/YNFmNLUYkg1J/kA2Ak81WBzc7GpEZZKWLJxhj
         5XJNKyYdADRGFY5dnosHLTgljh2ztrzch1Kf4mofiCGpjwTJLHxvbJ6SP1n/NjwZyfuG
         HYeWmdgUxNB6hCRUKvuxhxcMlEtLO4YdBzOgpnkg1uMR4sXUGuZXfg0FjJv5KUDHPGD8
         Vwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=RgZMItNPZrMi+x9FSQCZl0pzUINCzbAlg3Rn0KAaenQ=;
        fh=hRvFqUU3PSbPPQqAGahflgl4zmHQvsRQpGmuVHoJFpE=;
        b=O4ziYVLQEzqlUYn7sXuoTyCKI8BWdbDEiNfT7ggSF9r9aDXejz0l9gwcK6S9SlwGvI
         6SEpYQsS7WO00+RKH1YppKrQtgNqhnTPCyTMXlsNTySG/VKpEYm+CFtoBPbi2e/DzcYo
         sxyNRQAmAoe7t/Z9dvWEfrQtkcsI9yHUQkgS7BMOtaZOuHg19qN/CyaVcMlWwgKvd+lp
         UxDyI4QQxzpNNpuY5bR/z9nbQYwyZTCLJQkJpP6p/bKhB5RP4+2semcHEOpmjclmHX6m
         UX4qU9Sr4MQdgwfHAmEGftfznpANOWvOm1ftVN/Nr4iqNY5Y9+BleB4996ZsHxWK6sM1
         XLfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795230036; x=1795834836; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RgZMItNPZrMi+x9FSQCZl0pzUINCzbAlg3Rn0KAaenQ=;
        b=uyms6YSt9FpqrVCjcdOBYp+ctXnX3qNvVTUEFrmurpvWi7GEq0Dik5HAaJnTgyEeb0
         ewxGBW/NWJApX1xSG42IJyivrhZ+JiuERVfuPrqgAY/ZotiOaQI+NSqzu4m6D32eNbsN
         KoPvrajxozyLx/Q8Y4e3f67InAPXJoLS+86QZPltVYXaQX36TN5JsyAGi7XJNnn3LK31
         KlnlF07KXG/JFdyxj0K6/A5+PZa2wAiO0JreqmOz5ELSfaEJODArRJPtAsMamfu5Tw5b
         G1TIH4ME9uFm0748hMzh1cXt5/YTdMbtONEDEgTHw9pdWjQ+3ywlBXc4whsm/JQx7Kzp
         QafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795230036; x=1795834836;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RgZMItNPZrMi+x9FSQCZl0pzUINCzbAlg3Rn0KAaenQ=;
        b=2lg3vi8B9CaupoRAz1u+TF46OfbbmA+YZ9Y8usJL8JmhSuFHTlgeXXaBPohj5qvouz
         CG1dGIHUmmXhsSsnFUlx5ISaTH7U9ipsl74DADoTiKF28MMCezYhb896lzzK8jrdYWPS
         TanTfps8oossoICply8xserW5Li1b2qPNgE0tlro2PntHRP0J2yq68jmv9tOGHvPy+g2
         PpAjLLnJGjx6S6nN7QDcBT5kiUEQe+d2Osnc6vA7l6/5cKtBy6Dbe4TBPdc+GuZOZ1AK
         D2QYkVpjOA3AL8ttKj2SPfV02SKKXImFwXPqg5cJS99rO6xXLRClhwSc1I1qn1POlEIG
         RDKw==
X-Gm-Message-State: APuU4Z9bTwz+S8WYTyir8o7ief9UesWMaGPA7ybkrtaNyWionFPhC4+c
	VySYJqAY10CaEk8pthdzW6bwD2zgqc7Z5Np7JcUOXyxEMDqg8qjUMnPaTuSxLi9IH1kFwxrrToE
	vr9kXG7AIHT2+auGqPkZsM1LNWrl2QZjwJT+V
X-Gm-Gg: AZFdTZdVgm6AC/Zspsxk8XAJVmaMHSchQzC8sx9x4OX6QCDmCweSnq5uvAG4lSrM321
	cuQX3eFGAKxg8ovLQrfJjJwgRh2Rscv/0yyTb+mORt/jTLSAwrX/i8tNkX9JnSqXa9XUvGPSGLm
	MLuwubgTtVjMbhn1rRNKNp79ivcSH30W7B4p2iTdvPd04ioAkCsHEMCkMQ5d+HXekZKtNM2tmgN
	Fc3liiaWshFilzO9n9gRaMqiCCcOOi0dvqczaOrg9EiAEggjaPSGizLIWjYRuzppXgH1WCx08J3
	6C3Vw1xMqD+I7oxU4UMHKlevlRTx3Qk7cW9HnmmaxytM98GKOyLODIPgJ8UQmqRqsQwptJy1CHH
	C60uwrObRKnLrcZqVsclxlcCP16Z46BctS/f2GNmFJmwqJj1iEwIXGXoi4qiBwsOc3bVeYw==
X-Received: by 2002:a05:693c:83cf:10b0:376:b957:c01 with SMTP id
 5a478bee46e88-3856f755152mr5436872eec.16.1795230035470; Fri, 20 Nov 2026
 19:00:35 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bouldrenough <bouldrenough@gmail.com>
Date: Fri, 20 Nov 2026 22:00:25 -0500
X-Gm-Features: Aa3M54q2azp0-VsVsQFBPWLoIlwPAvZjAvZUiyO9HrjIH93wvjCc_nI5a6EgYYU
Message-ID: <CAB0dmhH+Bc=A-3PMneQaEzkMsQxnhjpNYtA+OAaUUwZEcgTxPw@mail.gmail.com>
Subject: floppy: buffer_chain_size() misdirected DMA in 2.6.12..5.12 (gone
 since 3d86739c6343)
To: linux-block@vger.kernel.org
Cc: efremov@linux.com
Content-Type: text/plain; charset="UTF-8"

Hello,

This is a report for the record, not a patch for mainline: the code is
already gone. It may help anyone still maintaining or using older kernels
on low-memory machines.

The bug was found, diagnosed and fixed by Claude, Anthropic's AI model
(Claude Opus 5.5, in Claude Code), while building a Linux distribution
for a real 386SX/20 with 16MB of RAM (Linux 3.7.10). I am the owner of
the machine and am sending this on its behalf; the analysis below is
Claude's, and I have reviewed it.

In drivers/block/floppy.c, buffer_chain_size() decides how much of a
request can be DMAed straight from its pages:

rq_for_each_segment(bv, current_req, iter) {
if (page_address(bv.bv_page) + bv.bv_offset != base + size)
break;
size += bv.bv_len;
}

rq_for_each_segment() is two nested loops (bios, then segments), so the
break only leaves the inner one. If the next bio's first page happens to
sit right after the run so far, it is counted as contiguous, and
make_raw_rw_request() DMAs across the gap. On a write, the floppy gets
another page's data, silently; on a read, the DMA would land in memory
outside the request.

It only matters where the page cache is below MAX_DMA_ADDRESS, so in
practice machines with 16MB of RAM or less. On the 386 it misplaced 4KB
blocks of dd-to-/dev/fd0 writes about one write in four, and on every
write under memory pressure. A debug patch logging each write just before
setup_DMA() showed, for one request:

  DEC pos450 chain14 segs ac5400+3072 ac2000+4096 ac6000+4096
  W c12 h1 s1 n14 DIR phys ac5400 -> sectors 456-463 held 464-471

(all pages still under writeback and at the right page-cache index).

The same loop is in 2.6.12 (written out as rq_for_each_bio +
bio_for_each_segment) through 5.12. Commit 3d86739c6343 ("floppy: always
use the track buffer", 5.13) removed the direct path as a cleanup and
with it this bug.

The fix for affected versions is to leave both loops:

- break;
+ goto out;
 ...
+out:
  return size >> 9;

It was tested on the real 386 with 3.7.10; patches for 2.6.32 to 5.12 and
the full write-up, with a test method, are at:
https://gist.github.com/agmorion/bc94c0f989334e28e2f1b03ec97733a3

Thanks,
bouldrenough@gmail.com
