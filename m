Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7411DE3B7
	for <linux-block@vger.kernel.org>; Thu, 14 Nov 2024 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575051; cv=none; b=gyWDX4IJck6dd7OqF+L0dMOI//Kk4xXJAoDnM4M+ecR7lJLXxrawAdzwFLORNzyuKIsFaejFSLyYW6OLlVOGHgHhsanqyOiJrsFEX52uzWGp2av3w4P111E2eOWp/3L/k5NJ5ewcBsKNiYmEXveOk3IA1z7MdNNTKvLJdm4faeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575051; c=relaxed/simple;
	bh=6OL4FN7RRsvRwUk0jgnXvoAGwSh/EBTDB24Wpww0tZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oyAiR9zC4tChYpxEtkCdNtu/Rz/B13tDeMTWC/yMY1mJhHDy9AA1QK4naLjJKSqKyJRLq3sSsnStJDjOFSw+pcxOjIQdV7em+tNbs9B7lihcDEIpFk2y8+Jf0D27NSqgwS3Sym5gD4vQyPdQAw9xiFSDrkB3JTJ6weSbBXPereE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ydDZ89Pn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ydDZ89Pn"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315eac969aso1735085e9.1
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2024 01:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731575048; x=1732179848; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVh/3yk6A2AkZ7Fy/8aicvKmMgfUMp6OC0s3QwciX74=;
        b=ydDZ89PnBjcogfpf3JGbK2LDecpyzTrl8Iki4q6HOkDZ52/UZD1XEsA2oCgnScx1w4
         duKgDJmz1DrW301HiRaFjlsC8rrZBw1G0FiKfnH9bd8Z+MqmgreL9GVTnOlOK/btb9kA
         IcejCqJ8y4LgR1QfgijBCs4fCNRWBjfs76vfejeFpazfwNtjbCPlOgYFc9hKUz1VsN9t
         2RWTtpPgq1M8ssjTZp00CFVMESTR2sY8R/Ty6XQlzPg3tiGOtH82csYvuDJjQO1RQW43
         piBzdCxLGK9Y6ASAzCHXBi9AMTtquiw9MqbV7Lbtgk2fZnrxP+F/apcRgXlscO/GHpre
         15IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731575048; x=1732179848;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVh/3yk6A2AkZ7Fy/8aicvKmMgfUMp6OC0s3QwciX74=;
        b=TokCqRpzRlpAberr+tzGxCiikr6DeXNlH2GMTFBkQgu+jtYEIpRPVXGDU6MQGgIwMc
         C9ft8wXAMBHz0nGbTAttkFsWzF9Q/tYxDBW7N5KAzKXlCJF5By+lvwc34T84KVH2ZNO/
         Y8WVv3R0w4iQRjj9ehZv5KQp0pdapI8yD7eZXCpIrcckXBKEEt8KYYXqsYyHpPcmeSJc
         8rb59y7pncKcRjGCBM0zOAgrM5tbgI1ZN8YbZiORvHzU4CUeQArrikXAM3Ms+JtyQiRl
         +hspxPshK70UJ7LLJb9/fE2VYJ0SaRG73WPhdjCRmaLPbN+fbN3MUwBY8X0p6Mo/kwuG
         1swA==
X-Gm-Message-State: AOJu0YyipnoOmDin3anMRzJm6myZBIKQdON/651fdxxcLUMO6+7jFiHP
	/4uTtppuHEzzoE6sbX3mhpO7HkUdaRpSZnQ8tl+84vmPh+tOKnXXRhDZCY+vcgA=
X-Google-Smtp-Source: AGHT+IGWtleMMmdPaBw+8o5vdj0RC/3nuotKjeFNscva1QkcEtVt56O5mnXkgYTZbYAWyyVFxdfm0w==
X-Received: by 2002:a05:600c:548b:b0:42c:b54c:a6d7 with SMTP id 5b1f17b1804b1-432d9767d80mr22856575e9.14.1731575048465;
        Thu, 14 Nov 2024 01:04:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac0ae5csm12893155e9.32.2024.11.14.01.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:04:08 -0800 (PST)
Date: Thu, 14 Nov 2024 12:04:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
Subject: [bug report] block: remove the write_hint field from struct request
Message-ID: <fff0e493-fc11-4ea1-a75e-454d052d23e5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Christoph Hellwig,

This is a semi-automatic email about new static checker warnings.

Commit 61952bb73486 ("block: remove the write_hint field from struct
request") from Nov 12, 2024, leads to the following Smatch complaint:

block/blk-merge.c:1005 blk_rq_merge_ok() warn: variable dereferenced before check 'rq->bio' (see line 994)

block/blk-merge.c
   993		/* don't merge across cgroup boundaries */
   994		if (!blk_cgroup_mergeable(rq, bio))
                                          ^^
This dereferences rq->bio->

   995			return false;
   996	
   997		/* only merge integrity protected bio into ditto rq */
   998		if (blk_integrity_merge_bio(rq->q, rq, bio) == false)
   999			return false;
  1000	
  1001		/* Only merge if the crypt contexts are compatible */
  1002		if (!bio_crypt_rq_ctx_compatible(rq, bio))
  1003			return false;
  1004	
  1005		if (rq->bio) {
                    ^^^^^^^
So this check shouldn't be required.

  1006			/* Don't merge requests with different write hints. */
  1007			if (rq->bio->bi_write_hint != bio->bi_write_hint)

regards,
dan carpenter
