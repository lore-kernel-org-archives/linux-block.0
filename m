Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E2A15B118
	for <linux-block@vger.kernel.org>; Wed, 24 Jul 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836351; cv=none; b=Oyq6B2L0M2PoQMHYCrLr3HhbSNKVR3hN5HOjA3f6BwPvk3KKAaeGYQrXST1gLaR9UOb07rLBrmSu7jmYownDuzmYjBbx43/N/GxTBGOknjJlbMIefq1NCktPzskuqA2EC7BRtrqtAevnjPd53bEJiH9yYX5rBUiexiaIp5PZKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836351; c=relaxed/simple;
	bh=pgROB0Pgz8YIYh+9w0h8H4O5rCQTkdjlPAE38hAfJ6E=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CAfHDEZAIl91xor8TfQUggXohbFJBEY+93EsmY+r59UG9tKTHxZI522wXetiMxGyF4hpDL21WOVIAKuoxq5Nasj1qmcLA5x+xGXvgz6a86ETxmFEzAhoZN14zKNwQuHBRAC5vkhHA34RBk2GGhjueugGCydEN9aZ/HGsZve3Izk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=X43a80L4; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="X43a80L4"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7036c788e2aso627429a34.3
        for <linux-block@vger.kernel.org>; Wed, 24 Jul 2024 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721836349; x=1722441149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcmTzEJe8AgPtLmTAm9/LnL3ub8/zZPUfi0JWx0JEQU=;
        b=X43a80L4b+8AE2xiQGj5S+u6p/Ovy3H1gVVTXUPb65jhkTUHlRVni+kXeByoQZWnRI
         L/QQ/gsu2wiYsSfaaKsb8G+I+yJYNd6xdd64mZwuGhEbUdJTBoOUuvzlwpJVSR/hMDn+
         1SyuHwm/IN9P6XOrx48D8CRQtztkC9sJ0YZHOFCi+S+1688giSt8eFT+DmOPrnhCz6+5
         OoDp1J6IUZhl1qtNcubQTvLrLxlBAyS64M/iuliD9G+fMWRyesYzj0zJd05eO/VVXoDl
         9QaizN3W2544Q8wQ6wFGoiF2/snDbFMGf+eGntEuSc6uA5CGHWY+GZhwuf/379d/eXQg
         9deA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721836349; x=1722441149;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcmTzEJe8AgPtLmTAm9/LnL3ub8/zZPUfi0JWx0JEQU=;
        b=nrBRvjQH0K5P2EOJBpHnMFTQ2Hmtx7jfbFvDwSs0SxCDHQbnNiOz4sQeH5Xlncy17e
         VF0yLdliWHKpP9yRB4FVeE36Pg0lhI+G9DWcOpopqeJE3w6FcEd0fIp9P4SOS9/RcZL6
         H7/8gbB96I0M6+7df4SzLqrSXTCEUJfP2mI+L1ujQCAI1HXL4UDXmljA4ip14XmZWu+R
         zxzO8Sqi8K2Zim5JWfflz9sBaJR7yINPkX2Vo27m09r3DGknT4kH7ROzAIv9/GbzMZrw
         WMd2GHDs0U5wM6coAVcfZjWuOBeyg+s0C75OnV1V8M2a9unq757b3yS2EtbIDtypKDFK
         pi0g==
X-Gm-Message-State: AOJu0Yx8vsX2/IxyCPl5xGMtzlu+A9hw4J/t9UV3fej/pts8r4Dq45kR
	MtKeQePyaeHeAmC2emcfrMY1tFoJX1xTTO6amc2cviaIdq4FwrCov6Puws9eWuezxpEj4pbmO80
	JJXc=
X-Google-Smtp-Source: AGHT+IGyVsZH5/HH/nZJvEU+FXNzNuuSUpom8Vti5FFYKl90ynInGCuuQXjyNQzWXMCHyKz5B+Sy/g==
X-Received: by 2002:a9d:67ca:0:b0:703:5ddc:d774 with SMTP id 46e09a7af769-7092e5a2c25mr132130a34.0.1721836348894;
        Wed, 24 Jul 2024 08:52:28 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60bf24csm2463281a34.18.2024.07.24.08.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 08:52:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20240724143311.2646330-1-ming.lei@redhat.com>
References: <20240724143311.2646330-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: fix UBLK_CMD_DEL_DEV_ASYNC handling
Message-Id: <172183634757.7375.2514321447591169303.b4-ty@kernel.dk>
Date: Wed, 24 Jul 2024 09:52:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Wed, 24 Jul 2024 22:33:11 +0800, Ming Lei wrote:
> In ublk_ctrl_uring_cmd(), ioctl command NR should be used for
> matching _IOC_NR(cmd_op).
> 
> Fix it by adding one private macro, and this way is clean.
> 
> 

Applied, thanks!

[1/1] ublk: fix UBLK_CMD_DEL_DEV_ASYNC handling
      commit: 55fbb9a5d64e0e590cad5eacc16c99f2482a008f

Best regards,
-- 
Jens Axboe



