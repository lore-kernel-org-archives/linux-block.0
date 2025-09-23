Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DF15789D
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 07:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613000; cv=none; b=n4VpWQz6T1bEBuTA/GOe+xMP+y7aSG5X0SLkDre0vnwn+1lets3TnMHmMDdzN5x4qgONWBHcw4adF8/bRrJcl6A1tng2bH0shpr8+OSEmakxgj8sVENOB7vzIns1yzi/Zdc+S4AOeQrHyTeNIxpy212hY/L4S95glBEzMK1xo4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613000; c=relaxed/simple;
	bh=Doy12JHJ1QdbigZcVC8weYmIDB/n15heyBBBZQGSXi8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OV8ohRqK3goWqiyULcg17NZ7CoRdlQ2GE9CJKuhwn3Dmwmy+iiisOXL7CtykPP16Nu2Q6+inpJo9YcINbG+bSzHHzRTXFir5INWdtz8z+X5WfTU3LgOqjfs19JrRUJz57CU4SQd229jBO+R5p2+tEhUEDBJKLBk+irwCUCf5wh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oWhlp44n; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oWhlp44n"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6219257cb0fso689514eaf.2
        for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 00:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758612997; x=1759217797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZTXYGDWrb7C8J087XBul2Wu+MAhbxhji+L53zCPt8c=;
        b=oWhlp44nWbXE2cJXE6nEObBKhC2kAzzpixfn/POM0yTXsgkVnkj5eQiJBMz1fW62D2
         zWz1nhZNrERMUwSgCt/6x0wGRSFlPMpz/BFeIsvHMp+hRjkzFIYttfnRiIzL2RxqZTZf
         A/MiqyWNkQDC8IH0ZIDC9BeVJs2RLOca4cxSCmIQghE1B30vrk5r19CC11U+3WCgVcvX
         F1VJvkv/lZkAcBnUFaU3Rg93J212sCCwTeZnj+47HD4JNyxrDxFgibOdnbrVgM2p8wKD
         GfinpsGMwQuaKCXtYB4utBkNjA237HU4uHpQoPfUiYo6n6MruUBi6sRlLvkDGRsjV5tm
         HiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758612997; x=1759217797;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZTXYGDWrb7C8J087XBul2Wu+MAhbxhji+L53zCPt8c=;
        b=my+2DmRckVDEJJPS8elwPQuQHTC1IgGUsjG58VU7HvQTutTBDu5eXQJ4TxTd8mlx51
         J1sbFFk/WrOVGSXFV5mSbx3p8Tmzg0SYS1KqjdDvUdQx4tZIv/J7EH76OcWQll399A0N
         0YoXgUu65hJAI3ElyfHbhRAKR9LuEIHTkrCYmOcbIGp81ml3bcU2MQ6Ar1j35FESlkhp
         oSFQR7AuUf+1Up8vOFQjJ1NA+YuNFZmVETd3XyXPFHpAaDLn8qpWCbOCCbEHYjjHiAPn
         fDx7irxEtHDCwHIC9t/xaI/vWwFdmuumwilznpaIm7RL8x+o1uSSq4CR4mdrJcnEGuI+
         wviQ==
X-Gm-Message-State: AOJu0Yyx3NEOiepFzXSKXziyfL+wJhOX/Ewu4uVyTYwGpE1iqF3ZgVt2
	57VGJNa4k2uqtHE2+594gq8CIEMq0yK475zz3z94LcYaibUDRUt4wkrocLe20rUo8L7QL8AwFT7
	hc3yexoNl1w==
X-Gm-Gg: ASbGncsHUgCaZiqXDjfrCl0istj8cMcdG9V6u2fjSXUtHCYYmT5Ql+rAV25UibRLGEW
	yIdu3f/9TknDGI7f9zQgfl4SoHKkvLzTZbiqkBrpa1ewaw5NH+o2D9c3H86XX0+rgXAZqt09LUN
	LtKBUcJ8GsAaQCxLOFO7HlvxFCAwYroFpdDorc+PDSM8A/TEEKAwH1xIkzkgJzejHJjcTsbSLG/
	F2ZanWlWB3ux5KxxqlXoit+p4KdmuK/KEWXD6Zy/DYjjbpNStZAxsDEXDXLg71YzyhKcVY+YT3T
	odG60ua/jQYLtpM2Dy4V26HfLtNQg+CtsDeJ9CaPsaTfhiyebJPc2oZuYVzpbOqITJ1HgZ97CUa
	qc3BqiIk87EDyakCuYxdV
X-Google-Smtp-Source: AGHT+IGEnfNa5jqUIAzVSLji+rj40a8Wk8m3DmSZpsHkwIloLFM6TqzxMWEp36PzqFprqp3s5irrnA==
X-Received: by 2002:a05:6820:1c98:b0:621:9802:d183 with SMTP id 006d021491bc7-6330f72837cmr899233eaf.6.1758612997270;
        Tue, 23 Sep 2025 00:36:37 -0700 (PDT)
Received: from [127.0.0.1] ([2600:381:1d02:9377:13f5:b434:ef16:6886])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7691ac53551sm6971622a34.11.2025.09.23.00.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 00:36:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: martin.petersen@oracle.com, hare@suse.de, ming.lei@redhat.com, 
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20250923070101.3507251-1-yukuai1@huaweicloud.com>
References: <20250923070101.3507251-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] blk-mq: fix null-ptr-deref in blk_mq_free_tags() from
 error path
Message-Id: <175861299450.153465.2022974135907413149.b4-ty@kernel.dk>
Date: Tue, 23 Sep 2025 01:36:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 23 Sep 2025 15:01:01 +0800, Yu Kuai wrote:
> blk_mq_free_tags() can be called after blk_mq_init_tags(), while
> tags->page_list is still not initialized, causing null-ptr-deref.
> 
> Fix this problem by initializing tags->page_list at blk_mq_init_tags(),
> meanwhile, also free tags directly from error path because there is no
> srcu barrier.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix null-ptr-deref in blk_mq_free_tags() from error path
      commit: 670bfe683850cb29957a9d71f997e9774eb24de6

Best regards,
-- 
Jens Axboe



