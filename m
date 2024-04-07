Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0598BEA4
	for <linux-block@vger.kernel.org>; Sun,  7 Apr 2024 00:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712450330; cv=none; b=J9UTCtpluTNqDZjQnOEy0m9EvtAjVcdsJ0BKUXkhld8khBUzD/ugHOKIldQmmBkDmv4x2Pw/+35Dvz6J2kKEfBGfVm2dm8DOqGXiutajti6wT6Uy7E9KodJvLYCN96uCqLilzJNyOFc/Z2OiNFnNOUV7I5Xy77Pp/z7NuCqeY9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712450330; c=relaxed/simple;
	bh=6CGiEXLT7jPM40/crj7dW/YjqRdVMyeByrmf1EsSKj0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KhA8IjJz2X/Y2Y6A3dIJNvEAUo6Qj5ktKJnWLXaoGUIYgh0/sEmrLw6JrRXhB89FI+EEVw5QXkntcIF7KbFGpdEmhA3SEZ+9xDojxJpEEiXGAKc7LKj3dGp9c83HhYYmgGmLyucu5trFvu/LT4d45qRIWF2mtN14u8Qaj5pboUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXBq+q9m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXBq+q9m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712450326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5vk4SKV6/MxVBF1e0lW7EvQe+xAgZSwGpbhrG/UrULU=;
	b=DXBq+q9mKzgF/M4nDiyGHI0dtnzkA40rRgyDJM257aSFafBXgfw90JbEGYqnLuZcPjVGD9
	ZSZ2PQnIq1vL0/XLcTg5lmkJcvMZuedp88kLoIrKj3aQClyi2Nxj6jAE9wvEWcbOS5GVVN
	YTbZsywuEaGv9bOAEfWMRrG9bgijjhk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-71boEOksMo2HHRisXhLU2w-1; Sat, 06 Apr 2024 20:38:45 -0400
X-MC-Unique: 71boEOksMo2HHRisXhLU2w-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a2c3543b85so2955685a91.0
        for <linux-block@vger.kernel.org>; Sat, 06 Apr 2024 17:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712450323; x=1713055123;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5vk4SKV6/MxVBF1e0lW7EvQe+xAgZSwGpbhrG/UrULU=;
        b=lSfSIGL1Z3mKWNW+5wCK5QQ6gL7YejDJGVjuTkxuAkaqOlehw8WpZWv8UaUcSvOj8q
         Mp0rDJEGmCpmctFS1bqdPWn8vMQPlCgMWVAxsR899Yh+xbi1r6rLtiFy4swWulyk1iyA
         qtaKRKZGhIVX2JN+zqHGT3YL5XSK8jkXVbEluK3VD/0CU2bV7LRlkmVzl5O2oqWi2ao+
         Kjw3dHWCkCfQDJdC1kHkvdpJy0jtmig5JE1vIh3k71GdTFp2nNejc4VGfD9YbgCa7+gH
         oI2+7IjjYhFM+2W6F8EoadajS10yFqNzhA824CsMSrUvgzQ/n0hsvHMYtnzoP88C1IPt
         4XgQ==
X-Gm-Message-State: AOJu0Yx7mS7StZngRMOoLN8mfZHGJd2wI9sbfe1YN1r/rvdm1dYPZgjV
	mTRG6wrGG7BIKcF0Z4z1Ts+AfLkRvIdtKS7pfbRME9PQGxL8QeLH1hgbmYRrdOxKenc0qOVY/9L
	hxRpFNJHZgVK9ptCpDW+cFeJOuJGTjcLWGnjpg8BLfMbN4SkT0Hqq9v5p+W6FxUbpuMpp6ggarV
	tnnMBl3Xizl/9u05iVmQcon4YlpdULImG4Ye5pBlmdqSj2E4rN
X-Received: by 2002:a17:90b:1056:b0:2a4:752f:b7b7 with SMTP id gq22-20020a17090b105600b002a4752fb7b7mr4383038pjb.26.1712450323218;
        Sat, 06 Apr 2024 17:38:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxYxH+o7f3ceWId3hKUNgLZ/izPf6b5eHBpT73903OfPtR7mPlqIFeGcybfig4AsHzUrv9+hI0ZyEWa3x1cvk=
X-Received: by 2002:a17:90b:1056:b0:2a4:752f:b7b7 with SMTP id
 gq22-20020a17090b105600b002a4752fb7b7mr4383029pjb.26.1712450322886; Sat, 06
 Apr 2024 17:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sun, 7 Apr 2024 08:38:31 +0800
Message-ID: <CAHj4cs8xbBXm1_SKpNpeB5_bbD28YwhorikQ-OYRtt9-Mf+vsQ@mail.gmail.com>
Subject: [bug report] kmemleak observed with blktests nvme/tcp
To: linux-block <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

Hello

I found the kmemleak issue after blktests nvme/tcp tests on the latest
linux-block/for-next, please help check it and let me know if you need
any info/testing for it, thanks.

# dmesg | grep kmemleak
[ 2580.572467] kmemleak: 92 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)

# cat kmemleak.log
unreferenced object 0xffff8885a1abe740 (size 32):
  comm "kworker/40:1H", pid 799, jiffies 4296062986
  hex dump (first 32 bytes):
    c2 4a 4a 04 00 ea ff ff 00 00 00 00 00 10 00 00  .JJ.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 6328eade):
    [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
    [<ffffffffa86a9b1f>] sgl_alloc_order+0x7f/0x360
    [<ffffffffc261f6c5>] lo_read_simple+0x1d5/0x5b0 [loop]
    [<ffffffffc26287ef>] 0xffffffffc26287ef
    [<ffffffffc262a2c4>] 0xffffffffc262a2c4
    [<ffffffffc262a881>] 0xffffffffc262a881
    [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
    [<ffffffffa76b0813>] worker_thread+0x583/0xd20
    [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
    [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
    [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff88a8b03647c0 (size 16):
  comm "kworker/40:1H", pid 799, jiffies 4296062986
  hex dump (first 16 bytes):
    c0 4a 4a 04 00 ea ff ff 00 10 00 00 00 00 00 00  .JJ.............
  backtrace (crc 860ce62b):
    [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
    [<ffffffffc261f805>] lo_read_simple+0x315/0x5b0 [loop]
    [<ffffffffc26287ef>] 0xffffffffc26287ef
    [<ffffffffc262a2c4>] 0xffffffffc262a2c4
    [<ffffffffc262a881>] 0xffffffffc262a881
    [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
    [<ffffffffa76b0813>] worker_thread+0x583/0xd20
    [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
    [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
    [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30

(gdb) l *(lo_read_simple+0x1d5)
0x66c5 is in lo_read_simple (drivers/block/loop.c:284).
279 struct bio_vec bvec;
280 struct req_iterator iter;
281 struct iov_iter i;
282 ssize_t len;
283
284 rq_for_each_segment(bvec, rq, iter) {
285 iov_iter_bvec(&i, ITER_DEST, &bvec, 1, bvec.bv_len);
286 len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
287 if (len < 0)
288 return len;
(gdb) l *(lo_read_simple+0x315)
0x6805 is in lo_read_simple (./include/linux/bio.h:120).
115 iter->bi_sector += bytes >> 9;
116
117 if (bio_no_advance_iter(bio))
118 iter->bi_size -= bytes;
119 else
120 bvec_iter_advance_single(bio->bi_io_vec, iter, bytes);
121 }
122
123 void __bio_advance(struct bio *, unsigned bytes);
124


-- 
Best Regards,
  Yi Zhang

