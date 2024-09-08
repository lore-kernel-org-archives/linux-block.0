Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B0A171E4F
	for <linux-block@vger.kernel.org>; Sun,  8 Sep 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725807412; cv=none; b=I2OVAkxzbJgpyouxW1OfUH01xBt+kTkG8hd71IrGYLFUs+yTLoaAsio9Bosqg89kN0BNGDoiTf6ZxIrnYLpMV8lZMuGR2mT+SaCBsoZTj5Byfd+NEIrWZreHX2wzHGxEBVqZ0pa9c37LpBTIzMOw8tTFTEcS3pKT1MNYPRJl7vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725807412; c=relaxed/simple;
	bh=GuOFUIUxIVsBZquM0yJY39VnaN21FhKOUMf1KDcwxi0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SeozR9qY2hj8XemAxsiZxByeehBlyKR8JztbVnZxC9K4hj4vddKUbVafZqnxvpbpZUrhjpI3y78SXqbvQyd6DjEixNJBr6mvCocV9QunvD/QN3d45YbtiA5rcIdPGW64yDrZ91vRhd4lImS3qU59YHU4/bawiclsXPKPdChIQbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fOffD5UZ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fOffD5UZ"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so3001596a12.3
        for <linux-block@vger.kernel.org>; Sun, 08 Sep 2024 07:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725807410; x=1726412210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J34rS7e5bbxObx2vMisny7xK0MvUIBdu8vnPBGO1Xj0=;
        b=fOffD5UZggyR5oPdJxdcUe2Wxu81f1VzsIcLtZOzaTchQeueM6bfzwvb6NZa1W3v9G
         D28JlGhmwILV0wLIyFhB//VbRM+pEGz3HMxtWKMV3/SrQMf7oYhChaVhvZuaByzYmEuL
         oJvTLhx3lQzsiINZ0Id60T75SYtP2aVtSvpLglSQB5ouPsEve+dI1Lxgb9qIaVlKMXIE
         VKglmd+Y24aDPDWdao1GoH8Bx/7LRqsgRVqSO7W2DEnR/cj1mkdSbFhJFGRB1azu5syh
         EKX2S8ckkJb3YqqH3uKlBDOb1baVLceDyTdLcwE0v3c6vl7QS2WdH65qbXoZAoYqb7EJ
         DypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725807410; x=1726412210;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J34rS7e5bbxObx2vMisny7xK0MvUIBdu8vnPBGO1Xj0=;
        b=xMt1MJQUFRGJF+66o8Pj08pWURNQb47vjCr7ggEtUT0VJBGuUpi1emqK+wm0K3VD7A
         V81C00s1vAkSpj5i9bCdLLpoFkE6pjNcitsLXPsQBnBkiPqh6I/DQK5bq+dpK5cWs9KK
         MyPafjQHK/qxota1K5wniTp+0ZpqvyfXiIdjWWHIHc5O/SxMwIkwa3JV6n9HNImmFcWv
         +KgFi3UpvEq9dT386Bs9AgjzHQeLgrWbXI1eOjtyyY9NrCBMC9m/cIag/xxX/ruX9yWp
         vuhdi2ElXV4d4lZPbAoXZ6gKwqToazlyhtZnR/oklL7xaJouV/ta6i4d6FVtZvbMuXbh
         64dQ==
X-Gm-Message-State: AOJu0YxWiFJ80srVTs+XrC2QZBN+TCD8E491bX/55AeU+w8IXWyxUi7s
	H7AMdmRkU/C8VLS+X2sYfxIghD2v/7UdNMohmyqEh0tFnkUwiGKg9kK0yZR1AeoNGxj8/Rcc7P4
	t
X-Google-Smtp-Source: AGHT+IGJha8j9cAZKXhvB1LlYpa9/ruXnw9dOUaanEgUw4NivvzMUPafOhhFAaA3p1MMjLnuqFfSyA==
X-Received: by 2002:a17:903:22c4:b0:206:adc8:2dcb with SMTP id d9443c01a7336-2070a537840mr66447745ad.25.1725807409844;
        Sun, 08 Sep 2024 07:56:49 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e0f6f5sm20951925ad.11.2024.09.08.07.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 07:56:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: "Richard W . M . Jones" <rjones@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Jeff Moyer <jmoyer@redhat.com>, 
 Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>, 
 Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, 
 Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <20240908000704.414538-1-dlemoal@kernel.org>
References: <20240908000704.414538-1-dlemoal@kernel.org>
Subject: Re: [PATCH] block: Prevent deadlocks when switching elevators
Message-Id: <172580740775.254205.14911870002112819350.b4-ty@kernel.dk>
Date: Sun, 08 Sep 2024 08:56:47 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Sun, 08 Sep 2024 09:07:04 +0900, Damien Le Moal wrote:
> Commit af2814149883 ("block: freeze the queue in queue_attr_store")
> changed queue_attr_store() to always freeze a sysfs attribute queue
> before calling the attribute store() method, to ensure that no IOs are
> in-flight when an attribute value is being updated.
> 
> However, this change created a potential deadlock situation for the
> scheduler queue attribute as changing the queue elevator with
> elv_iosched_store() can result in a call to request_module() if the user
> requested module is not already registered. If the file of the requested
> module is stored on the block device of the frozen queue, a deadlock
> will happen as the read operations triggered by request_module() will
> wait for the queue freeze to end.
> 
> [...]

Applied, thanks!

[1/1] block: Prevent deadlocks when switching elevators
      commit: 3c031b721c0ee1d6237719a6a9d7487ef757487b

Best regards,
-- 
Jens Axboe



