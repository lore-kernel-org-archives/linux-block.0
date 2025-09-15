Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DC62820B9
	for <linux-block@vger.kernel.org>; Mon, 15 Sep 2025 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963178; cv=none; b=EHgccRkaLOGhxJUAI4umnUCAJTT6B1dB4zxe9hzXOUYKAUJN9h98cqAJI+FjXIppRrHTOwGtTUw2waS8oC8NDZVSLGyhXIlqCEcjsyFOYiprA94vAeEOI+j7vD8P3kmR0ZL6cTm8AaX+eOKS0IBws+CQLcv69g2euiJBRTP+SGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963178; c=relaxed/simple;
	bh=VEorQhrKiSh+kOoEYP8er8ieBm4fIAor4IioJ8q+Xmk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PBAcUCDTEeHKPeYSK8fs03we94/smrAwT8fsjBWJ1UPT7kFbCnbEX37pjs1jTABwZ0ksYCSfHgATXJd4VcHcjF6Z5HGktEGRmKzjAhQS+pEbreQidNwgm6lRvxi9jZgyK7+PjYDTYFyKWdaN8/Eghv9PmxgfPXJOrLe9/7ekOao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HH+hwJQ5; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HH+hwJQ5"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-88d17e287e3so189982339f.3
        for <linux-block@vger.kernel.org>; Mon, 15 Sep 2025 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757963174; x=1758567974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+A+shV6w4y/gajfJDsqhbYczD+1TT6ZMp9tK/fnk8wU=;
        b=HH+hwJQ5vkPy2m2qMzSW0mvGr8AGCJAZqMXhtlUF50v/PVT5Ow+l2Vs+0Zi/5tkx4S
         cB4O1hFGCctpmmu98/u8Pd9FXvrLtETSSJw8zvtAxM5+qK7MBLs/KloUOTfmZIfQCQLM
         nt7P2xNugo5+XOtv3YVH44z9imJzOBVtsie2tPdSTm5cLa78rDEVfwBuA7nAJlUQz1Gy
         L1yffM7k0aakkvwAnXnQMhLMENlwFhCABZ/z79weGkaoLdIjw9EQ3W7ZQvU7zT4vFtGH
         A/uoUguCJrnuiPVKSF8b7xEOvp96b4JZ837X0p6JfJpLT1cDV+5KvckHppu+HChuvfIY
         g4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757963174; x=1758567974;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+A+shV6w4y/gajfJDsqhbYczD+1TT6ZMp9tK/fnk8wU=;
        b=auxOoCoBC2alBBRnNpo3FUvSV4yJnueNMIevroyjeAFVeL4tWriL9yxtnad7lx9+sv
         y3XTYJCqxBXSHL0nc8M4D7omQb8cIhA22PDA7Kr2ZKf45pyRo5c5kBnhEPbBphNAvcX+
         cTBI8goK6HZ7CMEL/IfGdbP4BYBOzNto0XFrTDyp3aviwa2dd2hr6hxxfIExOARhNhZ4
         CY8VQflqNDm8meuuqKjCbBsHWh5tINKEDwyiPZGGqdYw93CaP1Pf2xwNM0/mVX/BVLZ5
         ESMAbjBYfCmRgbCafd/boPdO+apKZY3svEKrJRw7GTMOTi9axOP1iD45Wfx/TaUcM6AX
         m+Ig==
X-Gm-Message-State: AOJu0YyhLwuSY0/c5E4djlOAVMsAoDhhbcjMZ2ilCcZQPG43oNHTqNgQ
	uZxHOCGj8cVyeZq/zsFcUOXtisx2DYXZUkcL0poE/Q8Od8PsK+HjFC0EL6AwIDiW0z+uNRaCl8o
	39/rN
X-Gm-Gg: ASbGncvFOam1gNLYbCz4vKqHJJD33hFoia66F/5sRpxGOU8ZBlp4IF14+KjR+1EAun9
	AQCxHYzZ1fB2nNt3QGUJxwuDnU5j34bmb62iCXvrCRwYdZG9wsyhzrO3+UoxInW/h/80/b2x0SN
	8gUGEvVVPL+LKqIUoqTI4LBg/IF9ubB6rF5UXJLOw91x2MdDFfCPT8lq5ZI0c1X16YGxa9Xh9JB
	gbcmKTUPeKzEHcljfNL72F+GxR6nd22jek4/1PktQc7EGB1pD/0Flqy/MF2GcsLYvvXWlbRRl67
	HzUY1PohgcH1gSLXcUTNEd3mUgZzvZ2bd8APSDDcvzZDNdC7u4LJUPlBQfNz4llAJrbXcn+YS1o
	ea5rNVaiURLurPBoaKBEYZm4s
X-Google-Smtp-Source: AGHT+IGzEthkOI8DB+wDuSGUC9lcKPWdUobt+aBza3swXw/F5Ejv6HGcW1TFQSA+ywhVJYj2IhpzpA==
X-Received: by 2002:a05:6602:6b0e:b0:887:30f5:c96c with SMTP id ca18e2360f4ac-890330c10a3mr1565163339f.6.1757963173755;
        Mon, 15 Sep 2025 12:06:13 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f3067a5asm5064945173.48.2025.09.15.12.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 12:06:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: chengkaitao <pilgrimtao@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chengkaitao <chengkaitao@kylinos.cn>, Bart Van Assche <bvanassche@acm.org>, 
 Li Nan <linan122@huawei.com>
In-Reply-To: <20250915123307.96964-1-pilgrimtao@gmail.com>
References: <20250915123307.96964-1-pilgrimtao@gmail.com>
Subject: Re: [PATCH RESEND v2] block/mq-deadline: Remove the redundant
 rb_entry_rq in the deadline_from_pos().
Message-Id: <175796317303.265523.9738573935015342018.b4-ty@kernel.dk>
Date: Mon, 15 Sep 2025 13:06:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 15 Sep 2025 20:33:07 +0800, chengkaitao wrote:
> In commit(fde02699c242), the "if (blk_rq_is_seq_zoned_write(rq))"
> was removed, but the "rb_entry_rq(node)" and some other code were
> inadvertently left behind. This patch fixed it.
> 
> 

Applied, thanks!

[1/1] block/mq-deadline: Remove the redundant rb_entry_rq in the deadline_from_pos().
      commit: 74b1db86847cce1c0fb54d362f8f5fde3adfd41b

Best regards,
-- 
Jens Axboe



