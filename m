Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32ED232395
	for <linux-block@vger.kernel.org>; Sun, 13 Sep 2026 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789291893; cv=none; b=SOPyNPZ7RoLCQ3CQtJvZHOdkANSK4+MzcbxDO5oDnu+cJftdPNixcLC40QL+MM/g97EiVLyeqmi1+RHYfQqpuQVRp2ZsZ12qHncf1XcZeY5p5tcwAk7T2m34wDsuZRWwLqJazYQojw0Q11zp+qchMnHKivoPcmhcBZXFzXHxtlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789291893; c=relaxed/simple;
	bh=xB5jj8VPvBnGrXDhKdmlbyncIiPk1DJUxDep5ugNJCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnzddWOoZD+jbIEb1WD6jKLqzWn4xSe/CYruNiClSfiAPz3fxANnw48KFPkY2nqHKWhDE9tjqLBYYdG2MmgWkuKXB+ikYv3rWIjX9hCSxC6Gfw2r5WU/CM25wt+fpARyy+gXH3ozcZXIFTWxHKtolxzBDu2LJfyNHoiYe4NQfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcLcZ5a8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcLcZ5a8"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d6e954afbdso17592225ad.2
        for <linux-block@vger.kernel.org>; Sun, 13 Sep 2026 02:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789291891; x=1789896691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xB5jj8VPvBnGrXDhKdmlbyncIiPk1DJUxDep5ugNJCo=;
        b=bcLcZ5a8DOxb8NmSw2onwbJexq9ZvcVI1bEcyaVGrc98NhBLXyjJfK/12ATbGRxGYl
         40X1SgI7Q8PIKcU8JFNgOi02srf/NeZixaLYhlWE8sPwH+5xSAuJj417Q7+rijxUq3Hk
         HL/fUDu47XlOB5Eb4ZYIF4bpPkuFVkxAn9KvMhTJq1/mj/oIdOLys4sK85B8/j9rrcqA
         jaG2/rI+jXTwsi1ZLU6SPmbP+HtosxEtlvCeUk7iysuRx95yNLvJ2KJIuRgI0Z606whA
         vciGxcE/H9rWjjnXKjXcIDIYix9lfGlFk40NyY+8Q0BmaSxvVOhPm1ZqSk3VPF+UuPts
         kBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789291891; x=1789896691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xB5jj8VPvBnGrXDhKdmlbyncIiPk1DJUxDep5ugNJCo=;
        b=k5E+EJTS4wj/9m6vydZeUuG0E4dbMrbMDKIAXtVFVviFQ/B5FgxdpIzSlpwza/HeV9
         x3B0YwbhZ0/Lf5YFoTgg8T1hQn0TIcgi4DAeZ3Q2LNJoHDWvvkSg8mJ0AUuJtpayVaE1
         iiZxMfcIloBpmzPG5luWfWjKdFnFcDaM/TRgI4kViVKxhszC6+Octl+36CX88PuOyv3R
         2F1yfawg69+Tt5GnAm+dkcKjzvuEblak6XM7DQx/6QO/dhiAikrGBZW9+vdlp5U9Pwf6
         3cC4oD3LgLlJXQD3YOtGDx9H269//ohPiUscSW3yTAtkTzxQ82CgegOLPyEUsAn+RyMr
         VtiA==
X-Forwarded-Encrypted: i=1; AKwUvBw0P82Yv/SVm2tK2MTMxPvvjp7ewnU6AomDYAuNafoF696DAn4z4inI9Hdmsb+4bSCGozZT13udU1Lcvg==@vger.kernel.org
X-Gm-Message-State: AFuF++l8PDdsvqi+GVqzToSxyPnA91I1ngKgGTCTLgA2Z7GbcbrhZ7CB
	m0aQ2J7MoRCyGB+h7GDWD9+xgyfEtS8I0BmcHgKK0co/rGmkmDcTXV6vl4bgQS4=
X-Gm-Gg: AYBFou297pv2dya15FRvathvYqog+wOhFUPw481qwPlYM1DVt3lQv85d7jCsrPV96L4
	oIfmLDciBssuoi1BpkzUTvg+KF8hRPH+0CoFQ51ADT5P2Gk3WRXJ6a0atMasAJH9xJVqNdb4QXS
	Wdfl/fKGq2oe4gYo8r2yylq3W9hKwhrwFCNjL85sE3mr9g3RUN/a1Tm222SSMv0xObJawWi+Nex
	13tuPdpxFrrDCEgF0Zog2oZr6SKipULsOiC4BZpvMEZJo84Red2VtPKfromy9BDRo8ZjiPUUhVy
	1wNRHz6vuFLAD/pG48QgdeDgb3k9lRKTGB9miJqwQfgvGC+PcMmaMoYBpbvZmNcJ9USyywbq1Jx
	fnIiw1ViRZcGp2Wk5NJwQKsRjL5/8UGnmQOqM8YzIWa4LIqu+si7/CAF+YVds9qypWdvPs1dsPe
	pX7UEWbm/l7bcXU5V0ReQwGIc9qp8Ml3Y+32eH8jOzUFNg8cg9j+3j1trDTFfTE/1cvnKqeM6Fk
	meoezZca37NEdeybwAlBfiEbQ==
X-Received: by 2002:a17:902:db04:b0:2dd:3ddf:b87a with SMTP id d9443c01a7336-2dd3ddfbb26mr152670615ad.0.1789291890999;
        Sun, 13 Sep 2026 02:31:30 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:b91:ff81:c860:362e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cff67aasm31954125ad.79.2026.09.13.02.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 02:31:30 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Adriano Cordova <adrianox@gmail.com>,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH v3] blktrace: fix the field offsets of the synthesized v1 record
Date: Sun, 13 Sep 2026 18:31:24 +0900
Message-ID: <20260913093124.717495-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913091321.B3C061F000FF@smtp.kernel.org>
References: <20260913090232.715798-1-donggeunyoo.kernel@gmail.com> <20260913091321.B3C061F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 13 Sep 2026 09:13:21 +0000, sashiko-bot@kernel.org wrote:
> - [High] blk_trace_synthesize_old_trace unconditionally parses ring buffer
> entries as 64-byte blk_io_trace2 structures, resulting in an out-of-bounds
> read and info leak when processing 48-byte v1 entries because the required
> dependency patch is missing.

Correct, and as the patch says, Adriano Cordova's patch has to be applied
first.

The read side cannot know the layout: magic and sequence are the ftrace
trace_entry header and neither writer fills them, and the sizes overlap,
since a 48-byte v1 record carrying a 16-byte BLK_TA_REMAP PDU is also 64.
His patch fixes it on the write side, by not recording a v1 entry at all.
With that applied this patch is correct -- measured on a BLKTRACESETUP
trace with the blk tracer, reading a partition for that remap.
