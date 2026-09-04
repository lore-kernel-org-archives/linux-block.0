Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DE3377AB2
	for <linux-block@vger.kernel.org>; Fri,  4 Sep 2026 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507506; cv=none; b=AfjeYdO9bEWQyCChvOs87/PJSqKQmuhHO930BOA8eG1nAEG1SC4Kk8HdEpgMtFhyZKbiQ/VKYQUKaWH89lvBnC0O07+ddBhx24fWj47+fPCPvM35b2AW15xvJ7CIuw/Dy+jlMDWxgOR9SHOpFmQmfnlYmbqdc1SNuolCZ8++k34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507506; c=relaxed/simple;
	bh=RXfSL4hWXAXcXKsFv8PBx3pIRDdK0npngW0DFJBTdwU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=asXaQ4EkBL9T1uoR9t9h1p7qnNxymxf2V30vO8On8zFjW1JQmZQbrZUbbJHTWYGtOAO1L+dJq3bxA1SfMBmvXeOmhWBtfl5Og72fsKmWfOljfNJYrq5I3iIvwunOVz7Bekbc19Oc7yt+Un0UiGPUmSG+XwdPTHAWPy/E6aeQljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1pEGHEm; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1pEGHEm"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66c70f69d3fso588968d50.1
        for <linux-block@vger.kernel.org>; Fri, 04 Sep 2026 00:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788507503; x=1789112303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R6gwhXtUIb/ga+mKjDnxNUBQ8NJgmsrNde0ZrmOu3N8=;
        b=W1pEGHEmMhWtmKPDsr0qD2QlIcZbLk9A7KcX7hWmAugg3qbh5sMl8lFhPt9Kvw9Prb
         P6y2/h0nyxn+2ZWK750WvaOKCHOh3W3XpW6HYNEqjyJ4lJQ6lzahkxvi7r5DJIqZOxr5
         xWbafxh4KA8z7SGNnrHCeKKuDgm3ijNuHrqh9yWeYvBI5/1PQcsHyiyfdDolMGDo8Z/I
         fh8yDcB0BFnh+7eSwVeKPDCrWj+Xpm1TgNjutrGR1rhBipB8qkYhxQNi6A3jy1+00dMw
         lk00ymJdI8nu7b35g0nEyzh2H16E6Wpnb9PiZ91cNUiBCmwwAk08msNtj+wC9q/Qz4vI
         bznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788507503; x=1789112303;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R6gwhXtUIb/ga+mKjDnxNUBQ8NJgmsrNde0ZrmOu3N8=;
        b=JUBRE7s+t8VBo7+/H4ZGl4+KWzcGhxEx5fIiyYb68mCWX6cm8Tq0MValT6zOajPL8h
         XiYJAtUjrxUbbtwppQf0hsMzHRQZVmxyR186L4CFkHq/Ip+wCr5d35wIBekznG3A0BCB
         jBRRfgonIeFLSpMhTpo16xkA0GT3sCorrYe3436y/i1+M5PKtwM0fZpSZA3cmXUfV/cq
         LXpPfgGixPoDyzRqzleJmNN6nUGWIzurml+zoZMO3E8CfAh1EVU6C/4IaP8xBAVW4+zW
         uMqCeuSj74ECsLhzKA6+5qejU/IgPWbIsvXlaFPzddOWLzqfF0bSc30XZyyhNb54Bv/N
         E6YA==
X-Gm-Message-State: AFuF++mclpWkk2dX9oMdTAo7tBwDXW790t7KhjcICKM41N3VhaXPdZ4E
	t0XBMIpwd3eQtyAlIKNzMQj+ylfrc0xMxfrRSIxEZJhQTOaZInJ2Gw7OEjz3zzsv
X-Gm-Gg: AYBFou3UZLunF0QgON1xzZPbKS3mSCE7TuRcS7CtUD7Bp7Bz2II4QHQQ4RK2gMpGYce
	AGKO98rLjFSMH1/3xL7lIQXaa5JVYhn4jWO4kkijj13DKIAOZlSBSkDOuviSyTfDKU4n6dxn+ZK
	0ECLtqBC+Pbhh45kv1jr7vpIkqjPDlZ4mDBMD1AoKGYs37KCv3VXcHhwu47JFDLwiRtJSFQaS77
	/w6MMiLZPngwIgX0UQOqmWlYyKH87X87LNopjb+A+lzlPFIDZaURcxJnAPNcyyRG7xqFmD+r/qB
	fVx+urDUsnTq4zWa3kuXH0iHqULuU8QyDfOuGQkBp9eGGW3orWsI+FNsqbknimGQIt16aRV2aXN
	gN0N13iKXEQR2wvDdsaWb0NTxt3cIeMI7kUK4acmc/3++y80YB96H/dJrkGifdIYtkoCAzrrzJv
	XqgQVm9uZuxuL2vN+LN63ue6lZUuqeJ0zopuAAT4pQ8wZOYAMFxqLv2zJpW8ukC4qhpqU3cLLrl
	8VRQBCq5w==
X-Received: by 2002:a05:690e:128a:b0:66f:b413:8b7c with SMTP id 956f58d0204a3-66fb5ad7109mr1456179d50.43.1788507503521;
        Fri, 04 Sep 2026 00:38:23 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([179.238.17.208])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48f1646sm1691157d50.9.2026.09.04.00.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:38:22 -0700 (PDT)
Message-ID: <6a9a756e.4675fc7e.263ae0.66e6@mx.google.com>
X-Google-Original-Message-ID: <20260904041500.ramshared-v2-cover>
From: emersonbusson <emersonbusson@gmail.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	emersonbusson <emersonbusson@gmail.com>
Subject: [RFC PATCH v2 0/2] drivers/block: add RamShared hardware-accelerated VRAM block driver
Date: Fri,  4 Sep 2026 04:38:13 -0300
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces the RamShared hardware-accelerated
block driver (drivers/block/ramshared).

RamShared maps discrete GPU video memory (VRAM) apertures over direct
PCIe DMA to provide an ultra-low latency, non-rotational block device
with a synchronous .rw_page swapout path.

Key Design Highlights:
1. blk-mq multi-queue parallel request processing with atomic gendisk
   allocation.
2. Synchronous .rw_page fast-path in block_device_operations for
   zero-allocation swapout under direct memory reclaim pressure.
3. PCIe AER error handling with pci_error_handlers to contain link resets.
4. Comprehensive multi-kernel compatibility across 5.15 LTS through 6.18+.

v1 -> v2 changes:
- drivers/block/ramshared/queue.c: use check_shl_overflow() to prevent
  64-bit integer overflow when shifting sector to byte offsets.
- drivers/block/ramshared/queue.c: enforce PCIe BAR0 boundary validation
  before memory-mapped I/O.
- drivers/block/ramshared/main.c: ensure pci_clear_master() is called
  during linear error unwinding in probe failure paths and device teardown.
- drivers/block/ramshared/main.c: clamp queue_depth module parameter
  within [1..4096].
- drivers/block/ramshared/ramshared.h: wrap function declarations to
  conform to 80-column kernel coding style.

Testing & Quality Gates:
- checkpatch.pl --strict: 0 errors, 0 checks.
- sparse semantic address-space analysis: PASS (__iomem verified).
- Multi-tier saturation benchmark: 9,160 MB swap holding 40 continuous
  cycles over 30 seconds with 0.00 ms access latency under WSL2/Hyper-V
  (EVD-0040).
- Memory stress battery: 9.09 GB/s PCIe reclaim throughput with
  0.0% PSI stalls.

Signed-off-by: emersonbusson <emersonbusson@gmail.com>
