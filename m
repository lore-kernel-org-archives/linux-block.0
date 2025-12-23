Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528522D5C91
	for <linux-block@vger.kernel.org>; Tue, 23 Dec 2025 05:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766467810; cv=none; b=RkYlMTKEqkYMGiETyKOZ7G0++SmchDNyA/OmclqHeHa4sOtOawyKqArT26e4azZlLzouCLFcNxvRqcj0ENChuMhZdyTvMCEbItj/F3bHlk83aaJBov9ZaOC7Gx/I6ltep8f8ah3EWrFWgZkQu6PnxWeop8Ya9JZbXU4126mE30A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766467810; c=relaxed/simple;
	bh=LeHgaTCg3sZgaNtwPEbjvh+7JlJOUXsNXjaOCgEgLN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEkk8vH/vdllGJAWe1p13I4ZbXYnZyoPUxs+MSoKjQjB2Vs86rupaEjltRNqTHbSBKeTuhuVnMZNdJgm6GxC14/8pmbAtsHsX9wdYvT53BNRDXbn25zbsiJp5CnqPChjI4rwxpgAlCQId2XzzULzpsFsIvzVy7BWgg3O6vlsPu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOxfjcd3; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOxfjcd3"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5942b58ac81so4051390e87.2
        for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 21:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766467804; x=1767072604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjrVs5qAijx5UEiplGDR4bSOktnBgAEK/U0XoVs0/GM=;
        b=UOxfjcd3KLs0/zOnrEFXM55BIWgg4SWi7QASfMBxTSTBULhPeHWEyu9QQ41IsMHxJv
         Vp4J37vnn0MbCyyHvtoKWrrB5NPN16zaVrihzDqnjfnlEOIzQDiHn/X+3VkweluQlVpb
         b33rHk/R0YoujjZ2Dpv0aI1Upgc7yZ4hOw6Cmv/tLdRxRvhKexEtFEhctSH60l90r/Zd
         xlN0HuUDA8htT+yqvZR6jTx5OHYZZeMVU89zHBe7m9K23LD9P14tIhWQdD0HfBvxOzCG
         taDipDYZVRZsaI4qpACS606KN+Rw6yCh/03YJoxxr656Fng2iSGKjgipon8b0miprEbc
         BsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766467804; x=1767072604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CjrVs5qAijx5UEiplGDR4bSOktnBgAEK/U0XoVs0/GM=;
        b=dFvdvQPWO9CvRTeIk5SQHPnzPOz8gfkKugOKWCegUILtZGrosdND3k7hbqRA+LR9p4
         RkcCCtk5jzQjHIoi2l2zcYd0N4mCviJtvKgDFfOUh2nWkVnjHep+jc/e0Wtxce1TA2TJ
         GDVUTuQRbFwtbaCYbggoj3bK59gWVKWHUNDpjnueHKAyrXLVEglAaG9m1x7jOEyrZ9z5
         Bs67i/UNZDGF6SZkQKL+Iir/FTux9kWaJeI0zWayoMq/67mAHQiSt84KvY+0VI+rnHER
         +dV3XcXPmsic7RGqc5DHso6W5s8YqYqHpuqpUW96yM6aEPs9tQH5qONFg1752DXwi23M
         jrIw==
X-Forwarded-Encrypted: i=1; AJvYcCXGF4kfnq29Myqooa0JcEmeId6TXvapvJrkqadqJ3uCQspSc2H+YF8imyJXriUXUlX5GoxovV06VOURaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/42kDdOb9HF5TkRG+girGOQhAIWUmyAM5INoYPidHVzr7ctN
	tmvOW1AibAbCAPrszvm6FtuCDBxN1biN7llCKMd+R5G9YVKsEgU7AHw1
X-Gm-Gg: AY/fxX4pE1SiPTA31MtG6eRgBI7wVzdL2xfZPNQCvxJ1anyoKe7+ll7s7xFb+CMV9Qa
	egWLxcWz8j3ndYBJeFwkDHQ+nW7GcKEB2I8TACcjDkuAOEEra8Gb55AuU8nQnP+saEdd+VAi12F
	MY5deg7VdPZEIUI7ZcJjxeHS1i84DzME6cxHAv5dFPMRejeIvc+MmCqDPFS5HZ6U6ZUD7OXeHLK
	f7VskP8x7sRLrahxVBcRTm7zgft8gmGbakHduCWRTSIOtot2KbTPtnlJnOA5wjm//Eut+SWsbGU
	6FsOmOZFS7s1rMJXG+17zeZBoih9OPT1lcoQr4FywO/+/MH8jkclATruabeBl+myHFOjNirstQX
	R14VM341fk9BPWvCnkyu0qTwNOy8kpQKM/nQeeJt2/FrfcyI5FLf9bXaHUSNBv2d7KPKe8gfmQi
	ILsEIOtPiF
X-Google-Smtp-Source: AGHT+IFBJ4czf5dy7NoHG6Z5fLR0sF8QwzLoI7Shb3fIF5XKnuFbQtFm8MSKsqZe2birAQ3bGk4BUg==
X-Received: by 2002:a05:6512:3a85:b0:598:8f90:eff5 with SMTP id 2adb3069b0e04-59a17df6969mr4474213e87.53.1766467803957;
        Mon, 22 Dec 2025 21:30:03 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-59a18618ce8sm3818747e87.54.2025.12.22.21.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:30:02 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: gmazyland@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	mpatocka@redhat.com,
	pavel@ucw.cz,
	rafael@kernel.org
Subject: Re: [RFC PATCH 2/2] swsusp: make it possible to hibernate to device mapper devices
Date: Tue, 23 Dec 2025 08:29:52 +0300
Message-ID: <20251223052952.2623971-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <86300955-72e4-42d5-892d-f49bdf14441e@gmail.com>
References: <86300955-72e4-42d5-892d-f49bdf14441e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milan Broz <gmazyland@gmail.com>:
> Anyway, my understanding is that all device-mapper targets use mempools,
> which should ensure that they can process even under memory pressure.

I used journal mode so far, but, as well as I understand, direct mode is
okay for my use case.

Okay, I spent some time carefully reading dm-integrity source code.

I have read v6.12.48, because this is kernel I use.

And I conclude that dm-integrity code never allocate (not even from mempool)...
...in main code paths (as opposed to initialization code paths)...
...in direct ('D') mode...
...if I/O doesn't fail and checksums match.

(As I said in previous letter, mempools are bad, too, as well as I understand.)

I found exactly one place, where we seem to allocate in main code path:
https://elixir.bootlin.com/linux/v6.12.48/source/drivers/md/dm-integrity.c#L1789
(i. e. these two kmalloc's).

But I think this okay, because:
- we pass GFP_NOIO, so, as well as I understand, this should not lead to
recursion
- we pass __GFP_NORETRY, so, as well as I understand, we will not block in
this kmalloc for too much time
- we gracefully handle possible failure

Other strange place I found is this:
https://elixir.bootlin.com/linux/v6.12.48/source/drivers/md/dm-integrity.c#L1704 .

But I think this is okay, because:
- integrity_recheck is only ever called from here:
https://elixir.bootlin.com/linux/v6.12.48/source/drivers/md/dm-integrity.c#L1857
- that integrity_recheck call is only ever happens if dm_integrity_rw_tag failed
- as well as I understand, dm_integrity_rw_tag can only fail if we got actual
I/O error or checksum mismatch

So, this mempool_alloc call is okay for my use case.

So: in 'D' mode everything should be okay for my use case.

Another note: I used very stupid way to search functions, which allocate:
if function has "alloc" in its name, then I consider it allocating. :)

And final note: there is an elephant in a room: bufio.

As well as I understand, when pages are swapped in my use case, they first
will get to dm-integrity bufio cache, and only after that, they will
actually hit disk.

This, of course, defeats whole purpose of swap.

And possibly can lead to deadlocks.

Is there a way to disable bufio?

Or maybe bufio is used for checksums and metadata only?

-- 
Askar Safin
