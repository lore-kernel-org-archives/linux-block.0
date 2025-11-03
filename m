Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE04A2A1CF
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183874; cv=none; b=ZnXBgxMIHivqxgRCNGzg7rRwPIr2zXMm5VY1uKP8PV6TjyX/7UWqMGFdMvIaVB/CLJFUDHwnU2JgxQCAhgobZezgQgXa8JbqkUxCUEjCFuA84f+gOv7mPrmz/OQtWmBzNlyk20cFTF0insn5Ek42Rs2f3hT0iZZl1Wl9XAxklPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183874; c=relaxed/simple;
	bh=jLYGDQwIGSlxtnBBjWbPmJm93ml5hhOv9he4uGhp5yw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LAg64vNOySFuS0nbuDkLNWMxHQypIQJSZEIXPRkr26314Sg3bZw1WAyy/RjMoaXWcrc7OGi0V+szZ/36S5A+bOCAXkAUGZQlnyibYEOP+alqvNBr2X1f797Y+dIDeyuwHW0hmPsdlNlJd0OgC4fkyuQhLj9UzsE82cUJMPm2TA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vs2DMvx8; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vs2DMvx8"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-93e2d42d9b4so195608339f.2
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 07:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762183871; x=1762788671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQursU3vQn5dcAzH80PaV+pMX8Ep5Hc5g1Bu5Rspys4=;
        b=vs2DMvx8LShsW/nRBEzkUAnakPhs+nqgqvKbCk8uvMckEV/j+MachiaUSRFsgy9kd7
         rPJabIlHMHr1s+IfyH+rEIPI9Jrzjhi2WCoSit/nJV7JKhdwja44yBjverSWQvpfTYlF
         U2TfXhx8Nwpfqrs4zfROwqu9k7tnrFZncpS13fWi/g20sJzJg9kAhLNjjEDyiL7dQce5
         wusYrCxtCLfKJsgatoPvMHOxT+AvKCpoo4WIPzgYZCpBZZO/1YMS0VrZ5We+LwDV7pWH
         Y1rHcZLeuR8tIg3rx1zgbDbo5XkHqapM1DDWgHLOoIZfIY6WrBKxf000yse6vCuxFRNN
         jHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183871; x=1762788671;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQursU3vQn5dcAzH80PaV+pMX8Ep5Hc5g1Bu5Rspys4=;
        b=XAZ6Gtue/Og5s7OyZwZy7JssNtP5DBkxIB4Ra33715YkgyrCCfvnTRPHEp/tvttG8b
         NmdQ0IS00wPCjcMeQqKBwXIt+wXKC8H/vO78MPgJ5KZZb4QDOAtULNS8HlYob8c7n2e4
         HQZjy5Ju+AgB4wbr6uGbphwcriaFfeZz/ImE3IVVyTb4YrmisuDtOjzZ2n1LwSK9f+jV
         TxYoX1Jj/JHN5TL2DxdUJtmhWxPi1ZFWKR6RtdQjDCEIMlrH7HBkhCcRd0WXUhUvv5AY
         ZbXjJjNYkRYBDiV/Yg/S4vGfDmjFrkHCXVGxC0PAF31ZVNb/6SxQQxtN2Kt++0e88LBB
         EeJw==
X-Forwarded-Encrypted: i=1; AJvYcCVPBIIOjdN3eyvoNWsXoIrpWpjmNZRgBSClD+NlFJGaS/wX90JaDhsaXmJ+hJJ63+mFQXkfb3OBRg7V0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO4dayuwPd7YHciCRXA27TL5zwJLdK8/tQwhZfZm7oDPbH/86e
	EaftrFx/TB45FvuSIE8hZRY+x2AsoriKaXOl9dG2lh989bVfXBaT3tJO60G3RgV3vVX68m2k/Et
	hJSKL
X-Gm-Gg: ASbGncvoWemw6c4oDHj5Ln96Uc+W4CQdrdl/bRwVpiCOOeMHonhWd5TgQkDcN59hfE3
	uxoXcCTJP0ikEP6alEuveSAkrBkxEKzND5RM3jv7K/lh/jU+gxnW3ZNyoHFYaGc5C04pmRfPVEJ
	dIxPjZCFJ3Re7+a0vhfQwbT1wiHZ4oT2IkKltuGNNtfgJBwCacemOGVrCeVWzQJiVsTcES6yS+c
	OP7U4kmJ2or06+u2GoHGPr7RPq7TCvQDbLsufOJDX1Dd5Wdav7gX6EbqDMuBE/TkXREzdufXVnA
	ooIGvhjupcH0r8fyc2HsmVrH6+hjnlN8lVLP91+ETjhU03vQWguzcJsgcJ66C3G7CRQ8q4o2p7r
	zodaZ8myZBqhcN0IlkO51ocrS02UC46z+C9voo/wbqGr/puXfkAtZAlzvsaTG2zaNggwBcoNkOG
	tjvg==
X-Google-Smtp-Source: AGHT+IF9uCw+Dm4cAoPCKQ1Nmzm4tgHllBHAPxJuIpHuhQW4LAzI5jodlVMbim8JF8xCf9Hlx/UJIw==
X-Received: by 2002:a05:6e02:10:b0:433:3505:51c2 with SMTP id e9e14a558f8ab-433350553a8mr18998285ab.9.1762183870566;
        Mon, 03 Nov 2025 07:31:10 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-9485517b875sm22472039f.20.2025.11.03.07.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:31:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: johannes.thumshirn@wdc.com, 
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, 
 mathieu.desnoyers@efficios.com, martin.petersen@oracle.com, 
 dlemoal@kernel.org, john.g.garry@oracle.com, linux-block@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20251029033423.7656-1-ckulkarnilinux@gmail.com>
References: <20251029033423.7656-1-ckulkarnilinux@gmail.com>
Subject: Re: [PATCH 1/1] blktrace: add support for REQ_OP_WRITE_ZEROES
 tracing
Message-Id: <176218386919.6125.17209556415217535516.b4-ty@kernel.dk>
Date: Mon, 03 Nov 2025 08:31:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 28 Oct 2025 20:34:23 -0700, Chaitanya Kulkarni wrote:
> Currently, REQ_OP_WRITE_ZEROES operations are not handled in the
> blktrace infrastructure, resulting in incorrect or missing operation
> labels in ftrace blktrace output. This manifests as write-zeroes
> operations appearing with incorrect labels like "N" instead of a
> proper "WZ" designation.
> 
> This patch adds complete support for REQ_OP_WRITE_ZEROES across the
> blktrace infrastructure:
> 
> [...]

Applied, thanks!

[1/1] blktrace: add support for REQ_OP_WRITE_ZEROES tracing
      commit: bc49af56eea866c34d21bf582f65b02fc8c06ec3

Best regards,
-- 
Jens Axboe



