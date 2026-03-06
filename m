Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B12C2C0F91
	for <linux-block@vger.kernel.org>; Fri,  6 Mar 2026 02:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765041; cv=none; b=DcTXGI9S3YqDF437VALC4BGxsuisQYiqPf40id8fD+B3/21m3RkDK3+XI/t7Nkmt9xjPouAH4AaVx3ay9kCsrSf3G7BfgIDDiCPiuxuDjnv2jS+bOEAYCO3I07mz//yHrZxVTlPYLXK39xh7BK8gqsJsir6Z6mxF1vc5pNWZvng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765041; c=relaxed/simple;
	bh=9AApLOJSHpGyNZ8myRg501PguOgyID8eMpf17KvIszM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=N+qXfCYsaUbiRDF2L7sxDyrLuFUdAffmIS/6ATog9uAuI7XYgAhMe1Rt9h0LS4gaKhBDw2lj5vIM6q/jyberG7r7Ofr8k788XOWZwSiyU6zvxtjTDIpU14Be+MDWVF09OnXOqjhU5nZhuJdXjBdohglb8+rPEsWYUHIa4JNxP9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zFncREUB; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zFncREUB"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-794719afcd4so82412217b3.1
        for <linux-block@vger.kernel.org>; Thu, 05 Mar 2026 18:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772765038; x=1773369838; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqiOPvOWW/GelYuqIh4FSO7QNH3uZYLCA/QAQFtnX2k=;
        b=zFncREUBRbJiDMIWD+8Xd85R4STtD8mXBq88s4hVt5GfrvCmPmYZWFBzpAqvG/77hb
         EscNLx/sfzBwxe8MqPFsiXDaKjOzsLy3gHd8yk7Nt1qbax06r01O3PLb8Ng+m6ctiOUP
         uZWY5XZzBFol6SOcrEQvtYxc7CAmqWqre0H8KzrMc8O8QIShCFjpmQRhRwNxzDnQrVAy
         VT4+ECAdoYkgpJqtkC93gOPVJcBmpiCDxa0rDxP5+WcJB6nc8h1m/4mHzeGDoA+HxWPR
         TLHasU8y0+O9QK4ZAm+TnyQRwEl6A682yIWthhqxo/CWulmQkMyNO9Eisn0nGymUzihg
         oPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772765038; x=1773369838;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqiOPvOWW/GelYuqIh4FSO7QNH3uZYLCA/QAQFtnX2k=;
        b=oQrCeHE6ID1RdrARqz6QRDv/7KzGw+L0affu8IH0mBuO1KoI1a5qqIP4d9CW9av9/L
         SKVvW6rcVHTf3vsibskUcW8oE6tNATzaPF8aMM5EmC1L+VzFC0iqNxFwQZ2wv4KClXf/
         jFj/Oa98uObee72WsT4sZO1WlJtGbVhJodNje0sDlxrY+a7mpcUDvzFqo3WDwJ2eJp6s
         bbEX954LBSGDpZ3HZDLxZ2mMQ2OYjWjYuG/2fI/kFg1vq2k+FF8OgmirIQt3nbbiYnxY
         0yQ5nKj2g7iig83WFsjFKEFLghzdV7Nw5IXSbpi9Ehmkd7tgMUYzoCk87VbcpoC4sh7o
         lKLA==
X-Gm-Message-State: AOJu0YzJiKW4HXcyFjVqt7lv5usLygtOSaohHAN/3UKdm/vkM4EZPJ1Z
	OSKpQ7syz7/AosoO9xtYnkNbXZGguNOkUc0KQ2GLcJnRCvd249ozk4RAsK8ohumgsYK/CJOFD96
	9/lsqwHY=
X-Gm-Gg: ATEYQzzltG+UqrfFF2GKVDQSQpIk3xr2YyGnjl9enyNHy7Poartp4GF6p94kwh9dcoL
	gSHPQdbVVAwe1AWNja4Ysbg1AdAKc0nRbFqMRJybgP8dgEMGCAuu4x9CXm2j1YrGsPErpPGDq7Q
	kkl3VTFr2w3e900bthxAffVIwT0ZSyBKkmIIrm1HM3fzQd3pQlDSbQpwbCiQofUUXf9cEHaoVYB
	6y8e153BL9ZLoems7q9X2AiULM7HoAea6udGcPuWDyDfAWUbQ2304Ex+TPeEr4oelZVTaVApTSn
	nMcORBU3Hh0MVbc8tWsKbHl10mKWwVLo8i3l9g5kCchzA2MfY5XRnFhZltoHcalnpYg76TSXyCN
	YkNlvIG8G1J5MD1Z6cRm1D0DtUhsr/pdsPurU5xPkCSVpin6wlW7Iu/ltH9ihS82gHgE7e2RSn6
	sXdbmWkLacnDLWXWQ4TtI2+v6eOLUNo/3YUK9M2feaI9P9KWlmMb/pN2WqbuJQXT4/RdY6La/Wj
	OHeDB+e9c99qY1JCr9EGkO+OQuv
X-Received: by 2002:a05:690c:6e86:b0:798:6042:12d6 with SMTP id 00721157ae682-798dd7ae9c2mr5325747b3.60.1772765038383;
        Thu, 05 Mar 2026 18:43:58 -0800 (PST)
Received: from ?IPV6:2601:703:4183:37b0::7115? ([2601:703:4183:37b0::7115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798dee68c47sm828827b3.43.2026.03.05.18.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 18:43:57 -0800 (PST)
Message-ID: <70536a1f-5d9e-4014-a051-f3a6aa7e8dea@kernel.dk>
Date: Thu, 5 Mar 2026 19:43:57 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 7.0-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Fixes for block that should go into the 7.0 kernel release. This pull
request contains:

- NVMe pull request via Keith
	- Improve quirk visibility and configurability (Maurizio)
	- Fix runtime user modification to queue setup (Keith)
	- Fix multipath leak on try_module_get failure (Keith)
	- Ignore ambiguous spec definitions for better atomics support
	  (John)
	- Fix admin queue leak on controller reset (Ming)
	- Fix large allocation in persistent reservation read keys
	  (Sungwoo Kim)
	- Fix fcloop callback handling (Justin)
	- Securely free DHCHAP secrets (Daniel)
	- Various cleanups and typo fixes (John, Wilfred)

- Avoid a circular lock dependency issue in the sysfs nr_requests or
  scheduler store handling.

- Fix a circular lock dependency with the pcpu mutex and the queue
  freeze lock.

- Cleanup for bio_copy_kern(), using __bio_add_page() rather than the
  bio_add_page(), as adding a page here cannot fail. The exiting code
  had broken cleanup for the error condition, so make it clear that the
  error condition cannot happen.

- Fix for a __this_cpu_read() in preemptible context splat.

Please pull!


The following changes since commit 3c4617117a2b7682cf037be5e5533e379707f050:

  zloop: check for spurious options passed to remove (2026-02-24 14:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.0-20260305

for you to fetch changes up to ce8ee8583ed83122405eabaa8fb351be4d9dc65c:

  block: use trylock to avoid lockdep circular dependency in sysfs (2026-03-05 04:01:42 -0700)

----------------------------------------------------------------
block-7.0-20260305

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      blktrace: fix __this_cpu_read/write in preemptible context

Daniel Hodges (1):
      nvme-fabrics: use kfree_sensitive() for DHCHAP secrets

Jens Axboe (1):
      Merge tag 'nvme-7.0-2026-03-04' of git://git.infradead.org/nvme into block-7.0

John Garry (3):
      nvme: stop using AWUPF
      nvme: stop setting namespace gendisk device driver data
      nvme: correct comment about nvme_ns_remove()

Justin Tee (1):
      nvmet-fcloop: Check remoteport port_state before calling done callback

Keith Busch (4):
      nvme-pci: ensure we're polling a polled queue
      nvme-pci: cap queue creation to used queues
      nvme-pci: do not try to add queue maps at runtime
      nvme-multipath: fix leak on try_module_get failure

Maurizio Lombardi (3):
      nvme: expose active quirks in sysfs
      nvme: add support for dynamic quirk configuration via module parameter
      nvme: fix memory leak in quirks_param_set()

Ming Lei (2):
      nvme: fix admin queue leak on controller reset
      block: use trylock to avoid lockdep circular dependency in sysfs

Nilay Shroff (1):
      block: break pcpu_alloc_mutex dependency on freeze_lock

Sungwoo Kim (1):
      nvme: fix memory allocation in nvme_pr_read_keys()

Wilfred Mallawa (1):
      nvme/host: fixup some typos

Yang Xiuwei (1):
      block: use __bio_add_page in bio_copy_kern

 Documentation/admin-guide/kernel-parameters.txt |  13 ++
 block/blk-map.c                                 |   3 +-
 block/blk-mq.c                                  |  45 ++++--
 block/blk-sysfs.c                               |   8 +-
 block/elevator.c                                |  12 +-
 drivers/nvme/host/core.c                        |  28 ++--
 drivers/nvme/host/fabrics.c                     |   4 +-
 drivers/nvme/host/multipath.c                   |  14 +-
 drivers/nvme/host/nvme.h                        |  57 +++++++-
 drivers/nvme/host/pci.c                         | 186 +++++++++++++++++++++++-
 drivers/nvme/host/pr.c                          |   4 +-
 drivers/nvme/host/sysfs.c                       |  23 +++
 drivers/nvme/host/tcp.c                         |   5 +-
 drivers/nvme/target/fcloop.c                    |  15 +-
 kernel/trace/blktrace.c                         |   3 +-
 15 files changed, 362 insertions(+), 58 deletions(-)

-- 
Jens Axboe

