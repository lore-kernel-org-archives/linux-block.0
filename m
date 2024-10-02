Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C541D0E28
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899873; cv=none; b=dN9rTFhjKZj/MXnOlD56KqXnuD+OPlZBxnS5X1tG1yVsR3JowkVcSGZUuJbsqcxV5RxsmgfX1MTI/1EIkqDWYU2x3NpOWMO3FyksKfXskQlOoCJ4/FLU+sFRn/8jA2l+gnErf/CvcFi4s6IHUHBw7S37y4DXtTPok9P1vyzuVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899873; c=relaxed/simple;
	bh=TFJv8JZCdQm1fiPRzSCL3h+KmfUKwUIT8a5Q1mnYDIM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=d1VU9oygNvJE6V9J0I1+33SjfMK8lS6V+I/Z50O/i2HxMvtbnoFN1pGPmX1TxHqhGBEZEDBbaf6SlO55BeOLHg/GDYR4tY1IsmboQxnigWr9G29YzwOs9R5SkcrbTFnCSwnKxTUPhrfX2N7xYRYopePa+4vbl56ow3rAzuawnXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eehe88Zh; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eehe88Zh"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82aa7c3b498so8414839f.1
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 13:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727899869; x=1728504669; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIUl5ay0+q5O7PeesFzMGR4SFE6vIEzXh6Yv76TgMls=;
        b=eehe88ZhudTOD2BReg9+00Jgt59sFiqXN7f0vSwxT7DMGi2TgC8yIbKkGA0Pn7Cadz
         UH9iYSUABc4hHs7mt3xInjJ3ZLV4sNrvn/Uo27PSuLr7yrxM+N7rQ/FZWYme8XnMX5Ml
         1+ylomRVcuWNWDY40nAsHOcsZ+6ssccDcnEH4JmfQTcXXvbSsRBjez6+YI+Q21Spl5+0
         QrxU7Tc5AxUEvgUpvYSNGQh2Sop114XYPN0eKC4C0gRalvairlrRwQ5xbWw73nrsmgN9
         S09NL2GSr1oCklOZH5b+3o3z2i3YIRbfJtSYvcfLDjr/6GOS9kLmEXlfM1tpxfVOchhY
         zmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899869; x=1728504669;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eIUl5ay0+q5O7PeesFzMGR4SFE6vIEzXh6Yv76TgMls=;
        b=nRYVedXjmQuW9w9821NC/I4ctlA/zC280nRZk1gchmgre/TE858psdOSY7G1QvFEUH
         w7T9NR0e3FbEBACC+AlAue/AJEQQXkBDOE3RVdRVNzM+CjmyWzvuV9xSK7UwN5TRT9pE
         9tZI5QNAeORXTGq1Ye4WhG8vWY3GFhjS9EAsiarwpqu/PRY2Iz2FroyL1uATpCB3DeSN
         RsIWpWuXoD2tt6icepAvXsWueKSoqpwCut/W4QmWzuZMiJ421Fy+Y9M7kU6WUwXmsMuK
         yWC6vplIliTxAjsZbEcdLaAvtemgOSyW3CSZ4yYaYxSlBuExP06OXYAuZi9ry+DNi8nK
         Bvlw==
X-Gm-Message-State: AOJu0YyMljS0RNchMh1zjyLl/qZqiA5svxhDrJUJjBV7IpZwe2l1CnYZ
	3r6u3ksGAlyVGx+wrMiD5t4VwvBHpl/+7qvmOvuBiBAcN4YZsY6hymZaZfM4dbe+eb4/e9xeYAk
	v+wDsvQ==
X-Google-Smtp-Source: AGHT+IENfyrbRSIGzjvHCbpSVx1rr83P5D6wtq3ds/7pNNWF+ETCIEzGqziZdoqI/RBpOV70Xe0w3A==
X-Received: by 2002:a05:6602:6d0e:b0:7f3:d85e:476f with SMTP id ca18e2360f4ac-834e76ad437mr53651239f.6.1727899869072;
        Wed, 02 Oct 2024 13:11:09 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834937194f7sm349504339f.39.2024.10.02.13.11.08
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 13:11:08 -0700 (PDT)
Message-ID: <2aae722e-e815-4fe9-8321-86b062f517b3@kernel.dk>
Date: Wed, 2 Oct 2024 14:11:07 -0600
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
Subject: [PATCH] block: remove redundant passthrough check in
 blk_mq_need_time_stamp()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Simply checking the rq_flags is enough to determine if accounting is
being done for this request.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 4fecf46ef681..59e9adf815a4 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -857,12 +857,6 @@ void blk_mq_end_request_batch(struct io_comp_batch *ib);
  */
 static inline bool blk_mq_need_time_stamp(struct request *rq)
 {
-	/*
-	 * passthrough io doesn't use iostat accounting, cgroup stats
-	 * and io scheduler functionalities.
-	 */
-	if (blk_rq_is_passthrough(rq))
-		return false;
 	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_USE_SCHED));
 }
 
-- 
Jens Axboe

