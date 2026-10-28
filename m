Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205879;
	b=w0pUHIkZtvHuR/SIjL+42PaDc04MunbVbDPzntxVICR6IMJ55BSBICYD/p05Bg3fkPxy
	 BLoA7bGeXf0iz+g8bApcjV33cxs9N+vRanDAYi7EN8xj/prZiDaXylD9V04eFDWm0kRxf
	 xJlaLS1UkOd6/vuxvp3lEilLZZIA2fGUZxl8UkofzS5khqf8qmyvZ8ZhVsjxDJ8SSqMTc
	 14LKYItRIrZJcGwz5RAZPsplL7bWsG3hEVl/fmDauxlRvdz9fXpvT+6P1N1dhCS9LXUSb
	 4CEQs1zFJ9j2ya5nsUlcG6LGzjFzLIyEdsqlHOcXQtoyLDwpk7+Mm7QNJHOz33DfDSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=J0xUkTNFr6seTcki+ti3k5OnyqCFLX6M/RKIcdbvF3g=;
	b=zgqaDMteD6fWIqk02MgfQuzkfHNgau3wfLxBFA9oIvqm+B4hSHlF9KePr7iTKxNkj3es
	 39v0g8cxKIbGJqAagCMcZB5UgIDxUkmGElu3X6UTnyBuYOqrzuhsovtj+oMkj8qbNPUqu
	 fS6DE3T6VlgePuikKiv9ljJZliNz9ijYaqYQOHl+9cDt+eU0Q4gmB9jWcg0/IRFl7XR8x
	 ctO+WgrlX8vW4yt9Vpd5gUxY8gFa2AFjMZqZGB9L58Hzx5xM+SBW/Al1d4421ITZCAc+t
	 mblX+9vtjyLMCfS46D5e5tb5c6mqiEpIS4oL9R3j39OFaOBiM6WQBH0VtNoCv1hH73A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=k9Uxbyzq;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B46D606A31E
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B46D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=k9Uxbyzq
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-84a2bea315dso833016a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205877; x=1793810677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J0xUkTNFr6seTcki+ti3k5OnyqCFLX6M/RKIcdbvF3g=;
        b=k9UxbyzqDxDW/Hm8vxkoO3I6bAOaHBVok2OOU0KXw+PyCLyCZMQq7Eh3vbO0FENtsp
         7/pXh9/ee5EauQffQV/WKfZ1QFMeMrYR5p9cWAT32QFelOs7ro9Y+JSsriOZm29+Rx3v
         BuvyEsW12V4jb6hr5hAJ0D+UiwqcRKMInWH4r241qMny/7d9jFYpYTlQIgPzITWbhvpk
         3yxB8iRT1ApVRJZXYVIWW4aVNZR/lDpJeF9C077qPNmO+NSrRF6N/pZLCIghufsIE1ay
         nuKnymVBbGp2xhgU/AeNsq5Nzx4FIB+GQvzT27wA7SEFkgT/SdeXUzlHXD5JnE5q9zvw
         Pkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205877; x=1793810677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J0xUkTNFr6seTcki+ti3k5OnyqCFLX6M/RKIcdbvF3g=;
        b=hp2CGgBt21ysebkv35tCMlY6DDpft7WVQ947XMI4nB5Szga6VCggXML90nSZT/HlKS
         n4hYl1dx7aEUemRuBfcXWMGCPt9HkNkGcXBnjN54OFMXTJhiy578xHAy8m+V9y8YPwz0
         porujRBAFJI/1N/WnsNvmf4Hg22Ezu663LFOePX/6aSaowe1sd+RCFDLZvuQbYkJwt4b
         aOY6vVjTmuPQpjugOtYHqLl//W8VE/6l+yv0qdQdQeuDg+ZtxalTi/+5+IQOOVhTKmXW
         OVoippldODbHiZ0GehpUb1UvF9dkwmdbB0CSpTMPS+eRACSKZgnG/kJXUCDVkB3a7nOO
         TuRQ==
X-Gm-Message-State: AFq9FYLi2WCsb7WLs1SabKbRZxV9nYGYfRjlAjx2/w9NkauHIRwDeKax
	d+vEn/hOVitqkQlfIc6jl1YdnZxlBqiajcseK8KMKFlssiW+R6a/XO4xx4zQkEFWF2nnfYOB8GW
	CYGJJ7+w=
X-Gm-Gg: AYBFou1E28dgxJljOcgg/QfPDDayISqRoJcaz6lXU16EqCNWM7WvuCgfWWEc5xveeep
	ue5KhbzLHegdyrxYVFlVcTkaF628wbpBWyj7Hu3wlddwOx2KZlTk9NLJiI4ivZp3LUR9i3xUz/i
	94e02Rway27qX4YtTgMpjrhbrmJcOsbEfz8V1QyOS6kqxLh2SUAwItb9/8zVAeHR5BgX4ZPYW5w
	0t+CI7Q8mCA/RL+4opfC7VODEh/5SqIMQiR/FbYl7pQHd5fTyDd28HXSInf0rDxuzixo36Bskhs
	qp5urc/c7hc3RabH0Ecrxu9JJoPvQSrspA020qHZNZqiyM40q+ey5Boi1lD+AZTcQ3TN+0VYoN2
	lV6XQfKru+Ze6dZrABYpqD3/8RObLc7uj0KrLgmro7uocw8dt5/PqY0HNiNMbPaUhOUogKudGks
	mEGKhZ199JBPbm1o1uu6bd5ol7pIXLa6kinULBdy54yIDeFpT4lbfyRI0ysP21e8JoM3LiJp11U
	xtxP0iNiJR7ACjcL4XznHi+XG9K4iipp/Z260ojSDakrNC5ZxIK5el4VflD7EykfVd9qi/ANzO5
	xPtZES+wTnIR+Iccu9inzvjfcu80u9HbU5KnctcxcLr6mrlmshLYaPvT7sSLAgcK+YrEV2zeJQ=
	=
X-Received: by 2002:a05:6830:640f:b0:806:e047:cd6e with SMTP id 46e09a7af769-85abf9642d0mr2393434a34.8.1793205877660;
        Wed, 28 Oct 2026 09:44:37 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/98] zloop: refuse zone files without read/write_iter
Date: Wed, 28 Oct 2026 10:41:18 -0600
Message-ID: <20261028164415.1262013-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
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

From: Josef Bacik <josef@toxicpanda.com>

zloop_do_rw() calls ->read_iter() and ->write_iter() on the zone files
without checking that they exist. A base_dir on hugetlbfs, or zone files
that are links into procfs, create a device just fine and the first IO
jumps to NULL. Check for both when a zone file is opened, like loop does
for its backing file.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/zloop.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 9145e0f98d56..b4076940ae7f 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1056,6 +1056,16 @@ static struct file *zloop_filp_open_fmt(int oflags, umode_t mode,
 		return ERR_PTR(-ENOMEM);
 	file = filp_open(p, oflags, mode);
 	kfree(p);
+	if (IS_ERR(file))
+		return file;
+
+	/* Zone files are accessed with ->read_iter() and ->write_iter(). */
+	if ((oflags & O_ACCMODE) == O_RDWR &&
+	    (!file->f_op->read_iter || !file->f_op->write_iter)) {
+		fput(file);
+		return ERR_PTR(-EINVAL);
+	}
+
 	return file;
 }
 
-- 
2.56.0

