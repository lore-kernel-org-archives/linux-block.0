Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8A33F8EA7
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420777; cv=none; b=WxJF1omdhbCViThiQ42cQvv1Xi7B5VAZa7PN/7mVqhdmbFMUGnylVMzlQKA09/3LniPad1f9YE1ppHis6PvlQTPN8zIMz+TgfYMbakMwnRsypAoPLTHQvxnxITVZdzqBb6ezfEI7gl1MyuV2xmzpaER4YoK/d4vk4+HX2P7eRHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420777; c=relaxed/simple;
	bh=J6TbArqEieGYxXff7djq4W3pT9sWbdagtpgszPKUGs8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t0i60b6Ids9eks4IemvluZ3cdTYP8JIa+kGuVw1MLidJOAa+DnfHzdtZIHqKAFQfcvbzOj1GnzgIXQfUj/d12LkZSsz3umg7AaALQDYXrD660V4fRAoXqvibwzLUTo+5J9VNv1iMm+yEbyuBFyknfWoTGiofNKo66btFGd3PdRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=jKA41w5G; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="jKA41w5G"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-43d2ff651f2so854499fac.2
        for <linux-block@vger.kernel.org>; Tue, 02 Jun 2026 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780420773; x=1781025573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w22XETF1XI3MhIWY2ZCBASwJWSIv4gb6nes3rZAHzmM=;
        b=jKA41w5GyNIVtf/y9eduUriCRVjnblzPxbifUpqBLE/8kjHMsgI+Ifkyp702VRkIs1
         DGlvFkIsu6WUyEEMtayij6n8pH1p1cl5bLmWTiPbyXLy26KQTPfY0N1oDVBjoylADaZ8
         ImmYIdb2PTn6Dd21W/uB6iGp2YlWIJRoP3RbbuKQLBXGfjNu7cuyN7eS6C1aoBI+i1b0
         HLw9XArH5an3XzIKDiZPhRRA/JMF6hkgDtL09yi7qOGV/Q26ufP2XosFqKdv9hF1vI15
         RfBowArI55ncwBhqFJ/N8PTrG7ed8pPs6dFHrLgijmq6YoWoG4bGvRgh+yf9sB68uRAp
         HPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420773; x=1781025573;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w22XETF1XI3MhIWY2ZCBASwJWSIv4gb6nes3rZAHzmM=;
        b=es0mSDI4dkCmh8bk5XN/L1xqmUoyNCZUlDWI63Dts4ABpa5LNfDQUQf4JgZhu/Ft4K
         oTIaUpfwswNQVgeNf7kSDHVcyqmw7hXqADfR77emdVBzQfVnmJ57wVGn9JtxrAa/n/76
         F0E1B5Jk/12V1QPPk0XHikAavGEZKjvef793karXj7Vu/jact+zeLRCZM3vS+FzSucsd
         k9sxqlsWBDMDjXETE2nwBcWTuItLXA0LObLfU6oII2H36HQzPpPGd6RHc3+90MCL+S8o
         WNfp1LBDTBDTxZ8NY+cifociMDQ8JBrsfAVIWOcdFREDgSGhh1I1DBeJup7j8V89+wEf
         ALbw==
X-Gm-Message-State: AOJu0YxfrJxZJQsqbkU1MCNPlFD/54aZhEZNZ95feW+wBAvOB7cm3XH+
	OBSbeUU5TUd0CzLuuOl6h3O3wNWRsVtBPx5zmvb4n4Fsq3T8g0iRDzdezIY8eEQGNuk=
X-Gm-Gg: Acq92OG9GahD8L+CPa5dqv+poZ6Y/YSXSKn8H6T5jZo9F1MAwZmzh/doJoUTcSLQJaR
	tSBLTsH9RwFVxtXwGreAftgpfL8nS32ZDwmL9+u05UMJvf1xSw99EYWH7sMdxOciAJ6RnV56MFD
	sBZrcJYqrDjCQhUe6YYI7jSXMB0eONuLcp5mDCiC0rs3QYi5z50l9Ld/onPmBCcOnC2zMu3NLQd
	ptK7K1iiZXFwxh/IsWQkxfW0VZlR1wkjFy3s2/5+/O0gNTOozzO6XAen45MKSoQR73avixwhGVE
	9ZRibtfhWALqpSzlcxV1K/xpCUkTPLQtUNCnOz+Yx9IkP83i6p4oNvvOE3WYiPfOYdx1mMiugv6
	06LDR9NlGQ/mwBM+VsVM+2TmkUdgvdXNPdABA07UJOeDmOgz9eSZ3rLGsFxKdvz9UcVlGojHmD7
	KRoZUrIjXtfD2/kQ4QeSeQ59Avf9g4nqUI7NVvLRQb4Q12sOoc8G0AMLru9rkfKVJtOLZsmxB3M
	ipG6D9/ApVYcg==
X-Received: by 2002:a05:6808:2225:b0:485:4441:721a with SMTP id 5614622812f47-486578a21e9mr333978b6e.36.1780420773498;
        Tue, 02 Jun 2026 10:19:33 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4863f0c9848sm2378107b6e.14.2026.06.02.10.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:19:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Kees Cook <kees@kernel.org>, Josh Law <objecting@objecting.org>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260602160757.973736-3-thorsten.blum@linux.dev>
References: <20260602160757.973736-3-thorsten.blum@linux.dev>
Subject: Re: [PATCH] block/partitions/acorn: use min in
 {riscix,linux}_partition
Message-Id: <178042077264.560183.2736435889845625330.b4-ty@b4>
Date: Tue, 02 Jun 2026 11:19:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 02 Jun 2026 18:07:57 +0200, Thorsten Blum wrote:
> Use min() to replace the open-coded implementations and to simplify
> riscix_partition() and linux_partition().

Applied, thanks!

[1/1] block/partitions/acorn: use min in {riscix,linux}_partition
      commit: aa528cd12ca6e7fda15f855b6d2095fd34d167e0

Best regards,
-- 
Jens Axboe



