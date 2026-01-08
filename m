Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484C72FD7B3
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892952; cv=none; b=JxWDb6tNUWUAuYdr6kegOiP52dMb1qd5ijGaW5lrX9VeG1xPpkaqboQhI2Gbm/dkL7Kp/GbVgnH0p8aF13wVI06DJAXGW03oldLD3ldrEx4MA7FuHLuScwPl/N45JcFbXeZWmU8kOZXlE75QbK1CF6iU7yh1oskPyJWjB2A2Lg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892952; c=relaxed/simple;
	bh=CckKC6RZ+oPaTv9HyFuTRMTDCyj+fC6YhxQ/fz2Myrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZviyQkoYGrgq1UFW8JcgA8bM39E1JJnrH8QKa4fY4azwv5/axdA6Huo+uZaqVBNjBCChbnko22pe+0vTy1IqycSNGvPTgljMZOrNLVQqH2XQzo14irt/M2Cqs/tZJ9MJYXk0c8nh2LV0HdNB8rSKSFNvmg1KDY+FoXLQ5exJ7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AiP22DXU; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AiP22DXU"
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-7baa5787440so309161b3a.0
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 09:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767892951; x=1768497751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QhEY7hgCdpB6RVRGnQ1mrXyT489vZO6/9jC3EwBTpg=;
        b=AiP22DXUhsrmiaFupdsP/BdQmi48/LcRIkhZup+vl04oAhIIGO5f3wtI1Vvf4zDr5L
         t6XPCJ8JfeFecK5zaYPyJylY1w+1LDWOe6mdgN9InyPZRjrC3R1dHdBE8WrbZnnPd7EO
         6xePVJ+0GqsPYcM2ZGHUtrlrnwDN1akFcGuv/oqSdBFO8QiCuXIZyUceW9fnewn/Y0du
         dLZ3UldiavYwWU8X0ACyPoc9madfn4vPux124qYV8M1ioQ1WqR0Z9ddAYOvdQOH25RwT
         X0H7XTPdBnDhgF0qZpHCkK3cDftC7SFlIlkKCzkJSy9ADSomGPsTu4W3iv6tDisu06kx
         6y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767892951; x=1768497751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2QhEY7hgCdpB6RVRGnQ1mrXyT489vZO6/9jC3EwBTpg=;
        b=XEZkLt/JCYBJsdy/1eWWuwinbSPU9YiF2UWM5ZDJn8ZCQOY9aoPtDjoxL+ORNlmhzi
         Ue6+8A0cJoKcPce/3gHMd8kLrew//I6KAf/s0pgrDkhCk9v8qVNjK/wue3w1L/urQnDM
         cfpMmXm6SZNLqAYivPKJpPHDqpa0YvRcS9NZuREq0KsNnld+yML23w7lOZsQNpFB8hBz
         ks7yWEYvGEmC8YC0mMq2LojSns68YGj2/M4y+BX7oFYSdHWPJImXYT4IAVVbu2TMu6RZ
         BMY2HPBD8wF6BOJANex4QfGBdXR/13KQaGbO7BFSv/q6KiblHAWVBD+nkmgILtVL2JxG
         YINQ==
X-Gm-Message-State: AOJu0Yy9VC8iOHuqahldNSWz14ArtCmvLrwaqjrpuIdSsJC6UTnG1Ktk
	bypxvXFF/gTKXD+cwsZZ4Wll4Outvthi93+/qwKEw63JneGLukCLHYdfg++fX3lLY3Yc4+KIy5A
	dFIC2L1zhIqQpy2VjfXT2Reu9Y2qpEC1xT+FN
X-Gm-Gg: AY/fxX6zbnIUv7v1yyOKItqDp4IVwIrd6jnegcqmPF3S9yPvrJUx4/RZou70zslROY7
	69+qNKWsUXNNjyu9Fk8snz/E0NRta3jOQGvomQjoFIlaQB6KhZfuiMGoqNtWghtODukTbs+OOFT
	b9Hdfk6lsJLUIdB6eHlFqXTVDT7+d1Z4qvRYA2POjoDeqFLLHFp+BevYmb/xo5ki73USO0hFymU
	U2LPxT0jBEUeDIfUPPffJkUkwGiqMhG9qr8jsJXb6RbYX//Ragsw3XzOLoZYMvqeDDC9PjEzU2/
	i7x7SlsQK1Jsw+KbhsCOlZTpzcpIPwnRIW9pTTz6+JE1WIRcKTHz1Pa+sOykJ/8HeR7FpNZ6p4f
	oyioCPq7WSIuTwVMY3yWZxZxKvtU0mQLBE9VBFDkyig==
X-Google-Smtp-Source: AGHT+IG6KNczYB0X/xd9Rc6/z8KE+B7GiusKbrx8S6lyyK2KJmERN2c2OQbFVpoYg/jZDIam4cmzYsw5IxpM
X-Received: by 2002:a05:6a21:3996:b0:341:29af:3be7 with SMTP id adf61e73a8af0-3898fa60c6cmr4313070637.7.1767892950617;
        Thu, 08 Jan 2026 09:22:30 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c54d23d7235sm78957a12.1.2026.01.08.09.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 09:22:30 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E83EB34059B;
	Thu,  8 Jan 2026 10:22:29 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DD892E42165; Thu,  8 Jan 2026 10:22:29 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/3] block: zero non-PI portion of auto integrity buffer
Date: Thu,  8 Jan 2026 10:22:10 -0700
Message-ID: <20260108172212.1402119-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108172212.1402119-1-csander@purestorage.com>
References: <20260108172212.1402119-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The auto-generated integrity buffer for writes needs to be fully
initialized before being passed to the underlying block device,
otherwise the uninitialized memory can be read back by userspace or
anyone with physical access to the storage device. If protection
information is generated, that portion of the integrity buffer is
already initialized. The integrity data is also zeroed if PI generation
is disabled via sysfs or the PI tuple size is 0. However, this misses
the case where PI is generated and the PI tuple size is nonzero, but the
metadata size is larger than the PI tuple. In this case, the remainder
("opaque") of the metadata is left uninitialized.
Generalize the BLK_INTEGRITY_CSUM_NONE check to cover any case when the
metadata is larger than just the PI tuple.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: c546d6f43833 ("block: only zero non-PI metadata tuples in bio_integrity_prep")
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/bio-integrity-auto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index 9850c338548d..cff025b06be1 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -138,11 +138,11 @@ bool bio_integrity_prep(struct bio *bio)
 		if (bi->flags & BLK_INTEGRITY_NOGENERATE) {
 			if (bi_offload_capable(bi))
 				return true;
 			set_flags = false;
 			gfp |= __GFP_ZERO;
-		} else if (bi->csum_type == BLK_INTEGRITY_CSUM_NONE)
+		} else if (bi->metadata_size > bi->pi_tuple_size)
 			gfp |= __GFP_ZERO;
 		break;
 	default:
 		return true;
 	}
-- 
2.45.2

