Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5441C6B2
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424317; cv=none; b=SsT0G+pUWbil2cMkdI2bMQC1gW4jFFmTLb6NJYsVESY4KFGlgp/HNF0hObBk8bWrSv+dzd2RLvgssS5Zsv+sUhYfllJVyaLyxJeyn8ZlL50qM3Suq6Qk6MxkOc0F8WIEsIMV6k1UyhNiUzCcH+xppdYjSSioNmWqBD8kvdXxzKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424317; c=relaxed/simple;
	bh=KHvhReCv44/55dj9+ibrQQb071tGsg2pSA/QTfOa46g=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer; b=l4N3hphwLyHX94LgIYZkMm+xvIEa27fimwbUQ8k5nD0qznEY4di4qJdikesZqQCQU+PjH4knaG61dQSzx2X0tKZ3lnp63dOM0wSELkNMbabk86JG+YBWx/Ej2FULfTs7A2qszJWMZ/n0Z/h6Du3kyD3KK5xs3f2lK8TcyRhUYAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JFUy9jg5
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JFUy9jg5"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bee01886baso44470539f.1
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 08:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705424315; x=1706029115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQVl3obLJONQe1N1K6IxWcX7SZKeA8D3RD0YmlI67xE=;
        b=JFUy9jg5mhChRk6jZve+ubpLiu7BHtWk1FmFQjN5qj4TDMHw7YVMNYMJa4iINX+pTS
         imJcNekaqBoNyWihRNVMaZq7ocBxHtal+eNityOcYYiG3Y//KGHLCXMeJuN2O5Vv7XoI
         UA0TXL7JM+8oMZLBBhx3gNI1b4LtcDo0TlEYBqMB2omurWnR6efAeNS5wAxpKX8zP9PI
         CBkuo1JmbutfYYHqr+yZWTLOoDZo5sG18DearxJLKyoEhu/Es0nPE5eBbGtByxhXtYIf
         wydk3Y4zqICBTIhU1bXPtBSxj5A+QLFXl7OldV29ZFVzkanf1fA42XyaU+u8crVgl7MM
         9Jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705424315; x=1706029115;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQVl3obLJONQe1N1K6IxWcX7SZKeA8D3RD0YmlI67xE=;
        b=nCTLqTCgtHRAxV3iNV11Io5MngyVnukDrrNweDoXy3UOdYlPUh9k+gyal289EEim5i
         xyw/DKbkzQMMXD6b5022RIzt87/DMdnZTwz2D6iRcCLqtICTaz+OnB68pPVZos85rY9I
         zGpWX7UZWZHvsDElV0MuxNLihPr8vxwl5t7jpKVIyTgD9OOmyVwjbfyGyQHbX0nPsKtn
         6RHI5TgJ1NfWBU5H/LM+lDUAtoU21OsHA+sXyzoXO6QREiPK0rYnTZ4Wu9pY/3/hKXLr
         IFJp90TliLSV7qgE9FWHWnwfNCZWRZCG6U1r1w3YFOGN252gk1Tfl7pqFK9iQMbiHBmP
         ZG+w==
X-Gm-Message-State: AOJu0Yy+qYD40m2uvdZu6RtDp8dh8sAJZqxcriQHZg4vOtOR7b7fPddw
	d3/lR87q55XfrK2bJ/PHGHIXY+YhGx37BA==
X-Google-Smtp-Source: AGHT+IGSZL8yXjuYGteHQpIDJn2UMOHG9K0CIfXrzBTxca1is1XIeGlgLQILBL2LFe5HC3qbBvUQ9g==
X-Received: by 2002:a6b:7e01:0:b0:7be:e328:5e3a with SMTP id i1-20020a6b7e01000000b007bee3285e3amr11401615iom.0.1705424315562;
        Tue, 16 Jan 2024 08:58:35 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r8-20020a056638100800b0046dfd35b042sm2995191jab.73.2024.01.16.08.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:58:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, linux-block@vger.kernel.org, 
 Nicky Chorley <ndchorley@gmail.com>
In-Reply-To: <20240114191056.6992-1-ndchorley@gmail.com>
References: <20240114191056.6992-1-ndchorley@gmail.com>
Subject: Re: [PATCH] block: Correct a documentation comment in blk-cgroup.c
Message-Id: <170542431492.238046.7293062052485358461.b4-ty@kernel.dk>
Date: Tue, 16 Jan 2024 09:58:34 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Sun, 14 Jan 2024 19:10:56 +0000, Nicky Chorley wrote:
> Commit 99e603874366
> ("blk-cgroup: pass a gendisk to the blkg allocation helpers") changed
> blkg_alloc() to take a struct gendisk instead of a struct request_queue,
> but the documentation comment still referred to q.
> 
> So, update that comment to refer to disk instead and fix a typo.
> 
> [...]

Applied, thanks!

[1/1] block: Correct a documentation comment in blk-cgroup.c
      commit: 521277d12b5a75982d4f642d2ee22db8d7f986dd

Best regards,
-- 
Jens Axboe



