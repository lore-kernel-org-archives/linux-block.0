Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793552003;
	b=oN+Xew2g47MQ/H4U/dS6qiVBN/4nqZydnV8g+2spsD0J1I/UNcY6h9YU5aB6we7hj0Iq
	 WW/Gixb1o93tYTfXUM4ykHq0df8B9E8czhZ4VsF5GqDaPDNPXjxF4+PWtEw2ZViy5AZ6g
	 0ZPmVT5dksWqsNkGxihN4ddTbx1WLsNBBq3d5hNe6+fQM3nw2zReAVGcRnKaid1OsYn7d
	 zkI7MJpi7IAWeE+JdubO2eP4BaXq3VPpW2G2f1JuYFIujBaLmz9/z3eFAVD3hIvNxzhlB
	 g0VOhp1+sHh9bUdIT6rrSDk1prviWHMr/geP8OgBvXgEwjOf1zkzJijKD4DuwrMR7qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793552003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=097R5J/xw41Xh61+p10blxCYZ8kZHC4U5wK3EMQFzX0=;
	b=H4EMKGes3q7iBxvmh3AHLJmR2UMNv28poPJMe4ZcMY9Bs0nildgyHsQnIkB4IJUziNDj
	 c5nAXkgYgm6Hg/JXS7dMp4vEnzciKX+/Rr3QkcqHpZeRud3GZYPsSiuuRcLlogFzOSd7G
	 uh/SEaTByYmJyVeQsH3Kc9CaUtEw7o0148+NDYduLczpcLfFys/+7s6naGsAfzLrtSbJH
	 5YaGIHi36FhdyqLbL0VAKJ/biEUJCwLtdusIjZqZx5bgtoVhUh28PQ4eoeHRLHhiDUx2L
	 m92hBAL6UClnObS/wTiBUOf5o/iP3z84Og3/jmMEtuD6ESaIkbLKekR9gJbj0bKLfow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TTz5lG2E;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC23606A326
	for <linux-block@vger.kernel.org>; Sun,  1 Nov 2026 16:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FC23606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TTz5lG2E
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48afbd2c386so1239881f8f.3
        for <linux-block@vger.kernel.org>; Sun, 01 Nov 2026 08:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793552001; x=1794156801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=097R5J/xw41Xh61+p10blxCYZ8kZHC4U5wK3EMQFzX0=;
        b=TTz5lG2Epant/Yj5Vni5mrCXHG2XP2etVYJSUaKB1IRtqly+mrc2LroXVTxBD+QYWd
         ePbN/gZtjhWOxI2bUX1ADzpXvAijeWD0zf4N7q/mhVX8ImQXn5TCWXJTp8CzV3BF1Ppc
         I0wXCAAJJW1UNIEFiumsUsXs6tpD51vpU5qCDEg/cbWKv22GSwCpSTFpgyiOkDokoq42
         q/EztiRRvmH87DDsjPtGg75sU8XkMfbtowiCOWnaqvE1Ri+1TtFXRfuTA1YVIVhwjIFr
         Bxetfet3sG3ERoOr6rIamvQUlESEDOqD28LZqNe4FXYxH7MtwjIpPjGerf4VnIqxUVG3
         2a9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793552001; x=1794156801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=097R5J/xw41Xh61+p10blxCYZ8kZHC4U5wK3EMQFzX0=;
        b=SBYyqoBmyxxgAxqehMeToGYwT0fbqBWZGWphMohpuqvjlrytGx8tKGYbXIGtJknh4T
         dR0caieWHixX+W+s/z9mLms0iImjNsq++xKIyMUf9qwEkVpYPVxBEf9tsdboA7BmSxBT
         mF6t0mIvph0q4YeHFd1GMgTEqPg/W2DWhfB6rSCbsSGFVSOmu31lMc94/tkxcbrG2+GO
         mZjQ1k7cyHICzx29TCIxXJacAUiUcr9hT8UDUJ3faN4YVCgL5ZM/urT0suK+VMHZHBLO
         7pyjW9l/XfdpLnibonHzsOiqVMCePPY29Ezd1Okm3rAHcMqI8OGs471oSrZso6o6ypYF
         ftyA==
X-Forwarded-Encrypted: i=1; AKwUvBzhcrAi4C7xMTcODizvDtucQyHzrKpRTASbv2KuogirjKgWfo7hWVwYY1sOW4+OP/tI1KY3fQ5Hi4algQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLZLw2pESBkVfSTiPandqLQjtbjfy3Bh1M5b+XGULYGezQyIhZN
	2nAACqRcXzt+9M/5w2IjgngWJL7KmmYIcrdMCeft1dzr8MDb08YBFTzi
X-Gm-Gg: AYBFou0pYrn+CR6kduetR1l0JZ4QiHbYOKnP81krupKUVfgL37KtDEtX/JnyvYAiNdJ
	Kj+APEqQR+ItgktxKjfJItg7IRF8NoKMc2uxxdgvMs/1jTzEvXXgfjbVqB/d+i5pvpLF4kO+sDh
	Ajxt9yOUvvKHAvdJNjJ7P0wuNb9RSnxmf5Z8NoN0hP5voGA1BeXEPwo4+dFdzQw7ouaq8FfW6A8
	IjseZZhh6zu8Y+wvqkgeVKI2i/nJL3O36Zom0cnLJ+D/xNPR1um32IMa/Oeqp3+/DvpFN3bnOd9
	Oe28QfU7noOZv3oLGRbpGBvXEINZzypkt2rUbnweA8DAXjD5napz76GCSEwlySi6XwzBiw/4KfO
	H9yV6UZr6aBoom99RwGafZdbJY9jXtjmsVmCUzZgU5zmXuJeX6duTMUleB30c6/B3XP83ftM9yY
	b+E6tSQS49o0W1dGd62OKNDyzSzlH2Zm/2Qe5RCjNldapcr89JiRwabMxQT5SJwJ0NpcSL0Ev1p
	3fBdh2CWBqyv8qBS6WLPEk0L7lNH5FNqN6+IFvWPwIMnmzXwdYKsb4+ea+9RaNH9OOpmibzdBMq
	QFyq57RB/DMZRF9/1EM8ZgHs10umbG8SgXu8AfFFOlqgbEmrl6E80SWy2cCew67KZjbw9RX5e7X
	w
X-Received: by 2002:a05:600c:3f0a:b0:4a3:7344:13b4 with SMTP id 5b1f17b1804b1-4ac1709a2d0mr182481895e9.14.1793552001474;
        Sun, 01 Nov 2026 08:53:21 -0800 (PST)
Received: from stjepan-Aspire-F5-573G.tailc0f20e.ts.net ([2a00:1bb8:118:d39e:5058:2b49:7a78:eb6d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c76507sm223903095e9.10.2026.11.01.08.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:53:21 -0800 (PST)
From: Stjepan Poljak <stjepan.poljak@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] virtio_blk: fit requests to virtqueues without indirect descriptors
Date: Sun,  1 Nov 2026 17:53:05 +0100
Message-ID: <20261101165307.2557421-1-stjepan.poljak@gmail.com>
X-Mailer: git-send-email 2.53.0
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

A virtio-blk device without VIRTIO_RING_F_INDIRECT_DESC needs one ring
descriptor per segment of a request, plus one for the header and one for
the status. virtio_blk takes max_segments from the device's seg_max
without checking that against the size of the virtqueues, so a device
that offers a seg_max above its queue size minus two gets requests that
can never be added to the ring. virtqueue_add_split() warns, returns
-ENOSPC, and the request waits for ring space forever. A virtqueue with
fewer than three descriptors cannot hold any request, and depending on
the queue depth the probe then either fails without saying why or hangs
on the first I/O.

I ran into this while writing the virtio-blk device of Hearth, a small
KVM-based VMM, with queue sizes and seg_max values like these:

  virtqueue  seg_max  queue_depth  before                    after
  ---------  -------  -----------  ------------------------  -------------------
  128        126      default      boots                     boots
  128        127      default      WARN, hangs loading init  boots, 126 segments
  128        254      default      WARN, hangs loading init  boots, 126 segments
  1          -        default      -EINVAL, no reason given  -EINVAL, message
  1          -        128          WARN, hangs on first I/O  -EINVAL, message

where the message is "virtqueue size 1 is too small for a request". A
virtqueue of 2 is rejected the same way, with either queue depth.

Patch 1 checks the virtqueue sizes in virtblk_probe(), before the queue
depth is derived from them, and fails the probe with a reason when one
is too small for a request, whatever the queue depth: the last two rows
and the virtqueue of 2. Patch 2 then clamps max_segments to the smallest
virtqueue minus two when indirect descriptors are not negotiated: the
seg_max rows.

The seg_max case also reproduces with QEMU, which with seg-max-adjust=off
offers seg_max 126 whatever the queue size:

  -device virtio-blk-pci,drive=d0,indirect_desc=off,queue-size=64,seg-max-adjust=off

Before the series this warns and hangs loading init, after it the guest
boots with 62 segments. With QEMU's defaults nothing changes.

The seg_max cases were tested by booting a busybox guest that reads its
disk with O_DIRECT in 1 MiB blocks, the others by looking at the probe
messages, on v7.3-19954-gcbbddb6b08cc, x86_64.

These patches were written with the help of an AI assistant, as the
Assisted-by tags say. I reviewed and tested them, and I can answer for
every line.

Stjepan Poljak (2):
  virtio_blk: fail the probe when a virtqueue is too small for a request
  virtio_blk: fit max_segments to the virtqueue without indirect
    descriptors

 drivers/block/virtio_blk.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

-- 
2.53.0

