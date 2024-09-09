Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6411CD0C
	for <linux-block@vger.kernel.org>; Mon,  9 Sep 2024 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894578; cv=none; b=aKhhfkBGyow2c9/7FVu21uvYQ1pcZLPfMEhqYBrbmZP64Ike0gkgdb/6u2WqupTHbfFTFQ2Jw8cmxJmHdrg5y/KivJoPyTbEd3GuwJz8FqWsu+uulYki1siZaQqB7k5JbpqKo9VUWn5elS6A7pUOTv1yjifo+3+zkCuMsU8Cf6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894578; c=relaxed/simple;
	bh=KrCuM112xvksWAEhVjhwKSWtIGAgg/emdYOf6L8k8tQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XqA5vECvKWsykomjW4d/0LlHJjFgGL/fC7cSrAED8Wf79eAu2dYF7WAjklV//OtCFQsI6wm/X6oEYE1XA/tD77DoyY9ymnLWeb6YDSllWfIgvpkJPm/0AVd+4eRjHcC/m5fAc6fDU/OsymXS2DDpovS9ZRr6FQcYZEfupNPVDZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uqGfKSCZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uqGfKSCZ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7184a7c8a45so2591550b3a.0
        for <linux-block@vger.kernel.org>; Mon, 09 Sep 2024 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725894575; x=1726499375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZD0LM8B0SLCDFsrFpilRozE4KulMUqwHZ2jEOs5nf0=;
        b=uqGfKSCZ78R4uf+geLebFEy+dsojQ834HrsPv/tpr4A7Z50QZHPT+yUjJQl/piJCJs
         eFb90DpIPF/PTL+AFjlJc1nLEG/ELbWdxU/griJT9KjApJoQvEVlgey9dIvxVjUa6QrL
         SRdbK/A3lNsbCIiwa5V0P9kwPiINlf5rg+pxfBBDsrSSdb1peU8fxFmTe+WCqj36/ptZ
         2+ykBCW/t42/yB7ZPc1NPBh1tAkVf9kBYRlzi+pE8825EJndDzy4YF5PnyQljRzBNoVJ
         xz3p3ao5HmsS2qaCPDYmK0ZFraeUb7wp+Ipimt6gMIjjIFTxqveN/IYEljlMxbkE7VHo
         K+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725894575; x=1726499375;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZD0LM8B0SLCDFsrFpilRozE4KulMUqwHZ2jEOs5nf0=;
        b=q61VR7DX52j98sk3NfQtx1aStVJrC0qNzVYo4tAISbHFMW+iDQHkbsoW9MlBSDtf/g
         +HlfpQNyRGQG5RKIOzG1C+O8uYtSV1dtxuZ32smyXjrt4jnTbVp+XOKTHQAEPLFpGExN
         G28j2V8ZO/BMvPLqeXvT87ZqdapiLneraVg4XIjVg4cRxWExD3vfF4q4aXpG157wvjTe
         6EJ3r1uL0/FgSM8+gU7nvqsfTQQIhidqJnj4zCSvGWuYfXvoFrNsw62bb/JeHh/mgFq7
         t0DZ3ZDvTS/QKelbZMO7WF/8YRk1Cjvfv4NpuooWPPW5yHzGggIBz1ULs2+97Ho8irhS
         G9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX3QfXZUmboVwIeWX8SdyzmaCv0MOt50cjRCjNdF76q4x/8vQK8VKCu4ZhaXNBzLKAAkjVYITtzTHb9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyT+eqBkfm2tTZHyOMMXmJTkyKmrumgHQ4AN05uD9eT7XAclE0b
	xNomE/1IuETAspAnhbICuGZUtqcEaVEToqJwG+LBeIuedVBrlG74amkG3uCsGPGeoXu477RBzdB
	q
X-Google-Smtp-Source: AGHT+IGMnrlvMfMiebqng8NbwSxr6iDv+FCr1bhfnL2Hi0eMUOZmYfxKU7s51gi//tAzm2Ppg6U7sA==
X-Received: by 2002:a05:6a00:845:b0:710:9d5e:555c with SMTP id d2e1a72fcca58-718d5f141f4mr18435523b3a.23.1725894575372;
        Mon, 09 Sep 2024 08:09:35 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5990bfdsm3618706b3a.212.2024.09.09.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 08:09:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: Conrad Meyer <conradmeyer@meta.com>, linux-block@vger.kernel.org, 
 linux-mm@kvack.org, Christoph Hellwig <hch@infradead.org>
In-Reply-To: <cover.1725621577.git.asml.silence@gmail.com>
References: <cover.1725621577.git.asml.silence@gmail.com>
Subject: Re: [PATCH v4 0/8] implement async block discards and other ops
 via io_uring
Message-Id: <172589457427.297553.5122724634440899238.b4-ty@kernel.dk>
Date: Mon, 09 Sep 2024 09:09:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 06 Sep 2024 23:57:17 +0100, Pavel Begunkov wrote:
> There is an interest in having asynchronous block operations like
> discard and write zeroes. The series implements that as io_uring commands,
> which is an io_uring request type allowing to implement custom file
> specific operations.
> 
> First 4 are preparation patches. Patch 5 introduces the main chunk of
> cmd infrastructure and discard commands. Patches 6-8 implement
> write zeroes variants.
> 
> [...]

Applied, thanks!

[1/8] io_uring/cmd: expose iowq to cmds
      commit: c6472f5f9a0806b0598ba513344b5a30cfa53b97
[2/8] io_uring/cmd: give inline space in request to cmds
      commit: 1a7628d034f8328813163d07ce112e1198289aeb
[3/8] filemap: introduce filemap_invalidate_pages
      commit: 1f027ae3136dfb4bfe40d83f3e0f5019e63db883
[4/8] block: introduce blk_validate_byte_range()
      commit: da22f537db72c2520c48445840b7e371c58762a7
[5/8] block: implement async discard as io_uring cmd
      commit: 0d266c981982f0f54165f05dbcdf449bb87f5184
[6/8] block: implement async write zeroes command
      commit: b56d5132a78db21ca3b386056af38802aea0a274
[7/8] block: add nowait flag for __blkdev_issue_zero_pages
      commit: 4f8e422a0744f1294c784109cfbedafd97263c2f
[8/8] block: implement async write zero pages command
      commit: 4811c90cbf179b4c58fdbad54c5b05efc0d59159

Best regards,
-- 
Jens Axboe



