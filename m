Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83EB2DEA75
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696150; cv=none; b=fIBc2mkGHL7Xh7dq+vW5ZKxuFw0Hu9es+UaMaebwMPYuxavp0g0MQUmJ1x2Lxbb4sXJs3QrljLRLNaGZHANDYyiz7vZa5qI6eFQA42hDsx4BQG+JxS0Ex5sluDEJ64t0GvDDs0wFM/cCmkh0OaeMLb/8vKjOpCWWVSj7bMILjBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696150; c=relaxed/simple;
	bh=KZqtujcSYrjp1XKrHdU8txiKbJH+Es7z7r2jC7Zc6Sw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VZcaaMCs8ecOi5qnF9lqCoHO6sxIeGMJsmpWZHOz8hgTvZyq3Feh4AUkxXBnxAbxnqc+CcL1axeaupaCTWnAOzzwuSKXpJZVJoVAHpznc8O0FwOZclfaG1UcUAkw4iIKZjMvnoUhFC8+ad4wg972u0BTZXCtm9oS0mHnJyaHtpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=T6sIx243; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="T6sIx243"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso824900a34.1
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1783696148; x=1784300948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w3tK8TtDuHzKVLUaacAPkZ3tgZuo4O65PAWl05AIJ+4=;
        b=T6sIx243ummo2V782Lg4u+AGt+fWHSM+Uhg72U0JEX8f/NIt4663qJ/9HNa+GFmINu
         K1lnPZyRSzV9j113rccnciLgH7uWUcWtkfkWWC1a0mq75y/I7aD86NeIsFRzofkPDTPH
         Wz+7Cf2bbBd8kItdK26GuB123QIlKRFAdIfKnbhjZkOv67YIaNobJyr94/GhuqUfhwpo
         enLIU9kqQ8DN0jV59upgablVDx3ji8NUOgt55H7Q6WNqgw7SqujN6y4XdzgWgBno5kJ6
         1A1N6oZnYfN6ds1QGLGOIPPmq1qfaEnPKdJW2+IQjprVbzOQSiUtZZPVIiFbQpQ3ECWB
         /vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696148; x=1784300948;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w3tK8TtDuHzKVLUaacAPkZ3tgZuo4O65PAWl05AIJ+4=;
        b=SkkB2tPPvnGrxTFAwf6qFCSp6iJoG3SGAYESRtcu6Oznxg6udLYPy+yS7HX6ICjBNM
         PzJ/T/P1BwOddBpMjC75WSAic0TuGEiyBRpJS6X98k2g6eEwjaLt7yKkSB6NqRArGiq5
         PK+8so0MxcHRZFbDH034RUWvdwWm8zU84aFwqNVqMsfJ9b5jIrmKr4/rOPIPND4rChiM
         mHJLh73xhO5EqM7nq08vLpKSM6/UlM/8w7WXQjbs4gPeahCZjrZl+CoYRW9KhoGup2B+
         QrKriRThbCNuRSuqeg4zeSucjmPqZ2wt2bibFKhHY4SyZ3RW5/egp9WvE+QsDIT64CjY
         r5EQ==
X-Gm-Message-State: AOJu0YwVkN5jtVqkygS19HU7J4+rAKdWtESHdiUaD16uONkk2p1I0MPq
	A/PpHdjKrkeqLpm+gZo063P6pNicKgkMC4oQWX0JClnIw2qB+G3/WVZw1nel24qaRJA=
X-Gm-Gg: AfdE7clFwSV990Dfx+izrzMftaxOMvIgRgckDf3nCmr3QN5Lk7e4eRuRJAG/LWbAH2D
	v84n23qjTy/XjPJyggd/x2bqHeqkwraNnaeK1acZX7jAXDuoQrH/3cAn4hf/F3Hpnubzep52u1x
	N+zRU54R5jY9VUREZUV1OpiRa0dBlQzRPD0rA8WA34hncJhfA65Z6MmCbC6yv4fYqpUdtBZlPPa
	VdhYGIItMJ0lLakdo0CkS4xFK5t9rbNN/O/TV8tUFxMUSP20Aq+2p79KTl+ImWJFMCtt2aRrOWc
	EZjlYgO7NKq54wqOtI5F27pE50PeV1TsXAySrGEEQyvcXC0KXJK6H7TSIv6e8tTtw9aimIIeZ8n
	CSFd5/rckxZp2teKCZ9Pn/+8KP/pKbxYjsPE1k+mzTlShf2vULSMSAiP9VKt9Ytn4QpovZuI3Xs
	ChhonG+Hx4MVolJHktMgDzu9WQELRUWFLBj/LAeT5S44oaeYTMydGQ7vSStsld2k1z2w==
X-Received: by 2002:a05:6830:81f0:b0:7e9:b4cf:d8c7 with SMTP id 46e09a7af769-7ebcff9cc64mr8083563a34.27.1783696147861;
        Fri, 10 Jul 2026 08:09:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae177c5sm6709330a34.5.2026.07.10.08.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 08:09:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Connor Williamson <connordw@amazon.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, yukuai3@huawei.com, hch@lst.de, jack@suse.cz, 
 nh-open-source@amazon.com
In-Reply-To: <20260615130715.53693-1-connordw@amazon.com>
References: <20260615130715.53693-1-connordw@amazon.com>
Subject: Re: [PATCH] block: remove redundant GD_NEED_PART_SCAN in
 add_disk_final()
Message-Id: <178369614634.284240.18222044248749979725.b4-ty@b4>
Date: Fri, 10 Jul 2026 09:09:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 15 Jun 2026 13:07:15 +0000, Connor Williamson wrote:
> add_disk_final() sets GD_NEED_PART_SCAN before calling bdev_add(),
> then calls disk_scan_partitions() which sets the flag itself. The
> early set is redundant and introduces a race.
> 
> Between bdev_add() and disk_scan_partitions(), concurrent openers
> (multipathd, blkid, LVM) see the flag in blkdev_get_whole() and
> trigger bdev_disk_changed(). When disk_scan_partitions() then runs,
> it calls bdev_disk_changed() again, dropping the partitions the
> concurrent opener already created before re-adding them, which can
> result in transient partition disappearances.
> 
> [...]

Applied, thanks!

[1/1] block: remove redundant GD_NEED_PART_SCAN in add_disk_final()
      commit: 181bb9c9eae4f69fe510a62a42c2932d0314a800

Best regards,
-- 
Jens Axboe



