Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875D4315D53
	for <linux-block@vger.kernel.org>; Fri,  3 Apr 2026 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775214706; cv=none; b=YBBSeLECDtJJNUpqlUB4+N9Y6N2p9TRFxrFxVItPKZXMgftwdAhgEaQ6Yaj/+LF+uEzmQBXzTxRMzyP1wGbGcc5IZI1tksumfN7kKh1yetUXuAFQPTFqW0vPqXxweXJOOthJ00C+QqpyR64k9Itr8/S8iur3+wazIE7kqmZmsoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775214706; c=relaxed/simple;
	bh=G4q9ytr89+oXUGexoVndJFmle1kbwPhQOoCijTkgCkk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WWW0ktA/yeicBv5Xoassqne5GEOlv3NAYkehZWeVgz+8iOnbPC/4cBAO5R/j1lCOHWylU5TGwy+KHSDvr+0KIUEzFswRZuxlqKgdbK6t2WL++6gFYECiaOLZ1vE5Jnp2EGMKdi7+REwkrC45X0kSOjaQwbhcy/meEP15sgdiMJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=s/IC2oQb; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="s/IC2oQb"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40ede943bf0so1060281fac.2
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2026 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775214703; x=1775819503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+JSpJKmntFQiCLi1vmyrSGOFgxbMGTn21g2RZIXNcs=;
        b=s/IC2oQbJ1bhmRWG/8E+eQcmQXMAAGqdWxY/tNxU2ZOa4twR8whRVH6+spmMM6vRyp
         BpzuZp6DjyW9QHG5Gd1geUicee7J8TfcsF/lE89hb2zsJ1YVOvxvGLNiRRkeyc8kX46L
         vVC85bNuEVOslvYMLKe5NGmzW8Yh9QNkjYFpqUWfXS3T47Ns78ZiJyiot5Nd47EXXE6E
         Ji5j6gLpNsNa7LKDtSO4BOuw2QhrC7nwlLYE3QWrJhpWE8JNhlYEaVU7xyZNEZo+rt50
         HSB2Wvzh8Kq8/2G3R0UeOwXgNBbLyn92dVoiVMWvQMcnZafX2nkGkjDNk/TQSjxOjhtc
         53dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775214703; x=1775819503;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M+JSpJKmntFQiCLi1vmyrSGOFgxbMGTn21g2RZIXNcs=;
        b=Xeyf4BWCWhjzIq5CrdPYHgdGkOfE8SuNuHI3udmwTi9TMJv/jFONsI0z+ml8/VYHcr
         /UYec4hdbzcyAKe4CcxjQxhLxc3jeo8A4EBsRH5gEa7bpRMPSLEaukng+EeygcrhN2GP
         kC+LwpEYDbi4ewfKdiFQRFmmr+WpKVmkyrPWqyPoDuE7W1mBfvGVIknS7CPmhQ73NMY8
         GQ0MovOMRbqbCPI0vXC7f29UAJ59BckGk1nuYg4zb3x0xJsmxZZQUrKmMV3vsst9LaHh
         QmMxtmR248Cj1ozrjjOUGEVM016TGO7IQ75/4n3Cuc03fyNw+86vPNuHZm4o7K9yQfzR
         Vlvg==
X-Gm-Message-State: AOJu0Yz4KYUNEJnHY5jBXxUlExHPT9TqXsj9ciJEXOkdPjaGrCnC0P7y
	8/PY42snj5MbB5ZMdCKds7wpTlZu/LnsuK6TzhDSN69E5gg24/YO4FtiVV0qQb5arWI=
X-Gm-Gg: AeBDiesdgsimqx2DXY+GN/uil+5j093YgX0OU8LeBetRfNnK26TdICw4cVfWhc+Zvc+
	8FTjZm6ONhX/WaYkSuWU8nX+5DsfwSgcQnSSEb9AnuCxIi/PggGffUqlzY9GafMJhjZ3RqTAfk5
	1t+25b71klejOaseemfwV7Ed1yp45UJphkE4onDLgshgTSTScmhP6KpDdVtAHN+GNF9xkRwFQ7n
	U5nTBGVzP/iW30PlK5xUxqEhhjEYfrsfp887Cc6lyjl9VgDNS64qdKVjEw5ZPHK18JzTyj1/X6d
	bb3whCd+62fZuHm9w5pPRqgvHf1bbdCEdh2GPk2eoGKjokHXG5RTPqD1jDxeqvXcPGViQdG31iS
	oShbbLIKmzFQs7+lMWQTLj+0F/q1cTQAVInQroixj0H5ldBtLnRjb3PGHzPk1e9ERVNAlzowwmw
	Wl+8rn6u73Fy09Y6aPDNUJ97u3mTmcsexAv7MnScpooQbPcEcQXhQzk2UGBXJ0MvxSNzSud3a81
	vqxYSIkz05uBqI=
X-Received: by 2002:a05:6871:d0:b0:3e8:92a5:3287 with SMTP id 586e51a60fabf-4230fc0bd11mr1273866fac.1.1775214703414;
        Fri, 03 Apr 2026 04:11:43 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaf2c7c3sm4487097fac.5.2026.04.03.04.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 04:11:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Kees Cook <kees@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260402164958.894879-4-thorsten.blum@linux.dev>
References: <20260402164958.894879-4-thorsten.blum@linux.dev>
Subject: Re: [PATCH RESEND] block: use sysfs_emit in sysfs show functions
Message-Id: <177521470205.492849.18182684068159783392.b4-ty@b4>
Date: Fri, 03 Apr 2026 05:11:42 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1


On Thu, 02 Apr 2026 18:50:00 +0200, Thorsten Blum wrote:
> Replace sprintf() with sysfs_emit() in sysfs show functions.
> sysfs_emit() is preferred for formatting sysfs output because it
> provides safer bounds checking.

Applied, thanks!

[1/1] block: use sysfs_emit in sysfs show functions
      commit: a175ee8273319547a4be7584da03831a2fb2f835

Best regards,
-- 
Jens Axboe



