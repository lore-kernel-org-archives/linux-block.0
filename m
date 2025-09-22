Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248AE279DC6
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758542328; cv=none; b=cqquTKa0y0e3irZuvwmEL7ouT23AeMceKnhEN86iWuUJrJbiUKqdUO5zAVbLfHcF9ebpp67mmzwmAYGQWepCTLWY/bzcoETu7zwmqpUx5RZ1ZVtv20s05ztCOR2o+o7bNW8e5zllda2E66WQ+TvdQ9QxPjcEpHF33k8z7CnrZhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758542328; c=relaxed/simple;
	bh=6K9s20zy6FPgwuNZrwabg3CoCH6/seIUVdTbhaUP/Uk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=CBirnwiKmoE5132pPzbVy7lNe8NsbsHLXynZZfNSGHf2s5MVstIdCwfcGLXjIyY5wiBVSpR6qMCdaDiDgjIFqvhwAq9zAA2vsDCb2z0gM+erZ3XJDKZwgoBlByjl0LI4j8gO0iaIfM/9fguzP/veV8LbjbA03q/f4wMcKb1EHps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UZGkBolg; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UZGkBolg"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e931c71a1baso4986727276.0
        for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 04:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758542324; x=1759147124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Qx6yh/FhwuQO1fIVWPWuSHppwVBjoHfdF31LksyMFI=;
        b=UZGkBolgZ+xJrhJsdeM13yYITEPZjcr0K3nW0b2PLRBtAMQhxhShILo55O+mx102yh
         wfzz+i/qVqO3RqwREceUzDykdClwFvryJoprrzfW/4JUNDZvJ1QZA7v7DJXU+aE/W0LS
         Ef/BeWkesePR4z0JLATz6jrSvjuga8xSu+n34lVoPbKVjgU6fx9luy0FKgcyCqjUa4dk
         sTHw+1BvX3z7V+wsHNudGbqb8SJoIzYhFXfMUdcIAm6MfYbjbYXuCIJnwC4NcFxIfRc4
         TOglc53KMNR8UJY89CnDx9tufXXNKkbIu1Z+Bfip2APgbCLO6jGakNvEJEPG5TmMmgBf
         0egA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758542324; x=1759147124;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Qx6yh/FhwuQO1fIVWPWuSHppwVBjoHfdF31LksyMFI=;
        b=FLRPeEMS2uG/6sdfHn03ZHUZ5yTEJOQntjL5kwRkYQnhCYbp98hhe6kOZ3ZhYEX4Wv
         YhfTIhn13Dbl+bkrWdSIkfnCYPAEmBKocM8DWeW3+m7PQv9rTs7a+dzcSssQWbNzeBsm
         isFJENNZCndUWt1fNslQ7Tl2MwtP83MBXx8of5p5gYdsoAFproJ9fU6TY2HF1u3YtxHi
         Y5PfnMcoxXfkS64sF+FhMSRNeFWm9VIrCoZVd6hz5d7/lSNl6jqn0caxhz6OJd0pTfy7
         ew1sYrJiweiUSIsFPfMwT8doiofEOf9ZA8JfB3IjSYzV6scclu6O9bzDJAXSvBmXEHsc
         vpIg==
X-Gm-Message-State: AOJu0YwmgWu3sEeqf7MphujP1Iv9qFf3oPha5Sp0Tdhvloe1ceZSzX2e
	GdoX2f7gghrxVFbOqg7nP1DCZksb7m32l2n3nZ7XNNJgqBrKrjXZY/55M3DkwpPkOAoa+JM1JaW
	sfG1bW2A=
X-Gm-Gg: ASbGncuMq8ptL+oZhtrDFRldMKrQShIk1gSmvNsxg/K5k4SO3LsYhwdk6yRoNR6pvq6
	Ov3tHsJGs5KTjTJ5H6k/Tew4i0Shv0hXg4mRcTR0MBtIDhLeOYNgR5fGxXR3nT8XJzIHTtCz7ct
	tOB3cObWF+flj9awx+x3sCqALgdWdPTgABjF6JeGGgHo+8Ncv5L9Qp23aAE0sizyBSSago1PqAa
	/lLG1YcIMq0SVTjQR6yWQ73CZbUc5hH3IRltRGdm/XEUc0qGDl27dDzQiYAPJPTN/AoSmxoHxrz
	pdK9vswjDHFc/elfQLP/PQM13Qnj3CtqdO3qHznXy/PYVK85SsDpbZAZa4GvYrtrfNkmURsTqap
	MqAxYQ9k/5gwgEKx0NAFUmn2+llx/I18PYoAI4Zcq3Lgspn2YlN1N0IlVux3rtet8WA==
X-Google-Smtp-Source: AGHT+IGf3bKArhkLeuUftLWkSb92tiVM0P7Srof61kg4oNg7QxYUz2dXj6Co/Gp7z7Bb4Wa+tMLNSw==
X-Received: by 2002:a05:6902:400c:b0:ea3:ca1a:571d with SMTP id 3f1490d57ef6-ea8997f7d15mr9743748276.10.1758542323811;
        Mon, 22 Sep 2025 04:58:43 -0700 (PDT)
Received: from ?IPV6:2600:380:9e50:8ddc:ef63:e01e:eaad:c699? ([2600:380:9e50:8ddc:ef63:e01e:eaad:c699])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce99130dsm4093192276.35.2025.09.22.04.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 04:58:43 -0700 (PDT)
Message-ID: <855243b5-1226-47d5-9ca8-c023209f5ee7@kernel.dk>
Date: Mon, 22 Sep 2025 05:58:41 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: fix EOD return for device with nr_sectors == 0
Cc: Sahil Chandna <chandna.linuxkernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A recent commit skipped dumping the usual "attempt to access beyond end
of device" message if the device size is 0 sectors, as that's a common
pattern for devices that have been hot removed. But while it stopped
that message, it also prevented returning -EIO for that condition.
Reinstate the -EIO return, while retaining the quiet operation for
triggering EOD for a device with 0 sectors.

Reported-by: syzbot+4b12286339fe4c2700c1@syzkaller.appspotmail.com
Reported-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
Fixes: d0a2b527d8c3 ("block: tone down bio_check_eod")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-core.c b/block/blk-core.c
index 4201504158a1..a27185cd8ede 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -557,9 +557,11 @@ static inline int bio_check_eod(struct bio *bio)
 	sector_t maxsector = bdev_nr_sectors(bio->bi_bdev);
 	unsigned int nr_sectors = bio_sectors(bio);
 
-	if (nr_sectors && maxsector &&
+	if (nr_sectors &&
 	    (nr_sectors > maxsector ||
 	     bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
+		if (!maxsector)
+			return -EIO;
 		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
 				    "%pg: rw=%d, sector=%llu, nr_sectors = %u limit=%llu\n",
 				    current->comm, bio->bi_bdev, bio->bi_opf,

-- 
Jens Axboe

