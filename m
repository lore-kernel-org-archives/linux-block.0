Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744121EB5A
	for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430860; cv=none; b=UfOxgoRb/ukoXR2KcaRFyVNmNGzzeAeIbo4w8s2wrpYvlOWx/aZwnH2fbe2kGQFYDp23y11ct9nlz8HYjalFT7Evxl+SxQ8e0Ni6+ewEhtWGH9nm+MFQiglIJac0+qnbs7qmAfQAU2AdOP9VuHMM9z4Eg76mZvjN2f/rGw9jVng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430860; c=relaxed/simple;
	bh=/5uCrSMDBFyGla1m9uaT0nTzpm5OUlZpQX6m2xgE05s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J34gvU8raSlSQNmo1unBxUBVHOnYVdhAs2zgmgH3faWwJhb+xDDedHn4c/IV/jOio5BKxan5lwj+5vs/pRBUjQl5c66TTI+JW0dfxziNH4V0HUeHP2xlIcLoLTewPGy7Tb2OTh5VsCOz+ga8dGMQWRStgIwbxhXUwKy7PIOn76w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=emwi8bEM; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="emwi8bEM"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-365c0dfc769so1329365ab.1
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710430857; x=1711035657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cN3wJipUzIRqQXP/cAUfx2YIxzvE49bUSL1Bir0Ob8k=;
        b=emwi8bEM0nmb1pNy2anF+B82GznZzs6UgnsXkT1ClkcFkN5bMc8uQ5gvn3MSHxafVp
         WJeIDmfvWSsVt6JF2MJbgfWTR/GiqtVmzvskceJrKLNAQng+e8n6c/HhZQrluZnCegKV
         yH2eGhXIoRRYEI6KcUXBqlzHUuFRsbtkVG7mRqiI/LDOdSzXGWDZEN27ZuRy2TCjJBWN
         VSr4aFnTLiHWE32LgUqdcnKlXOUYxJ2P4xhoiZLZooaL5G7y4Yz/WWh3EnM+FJ+Ao/h+
         xUREhPN+IoO0+xG9Jg5R4HfZ+QQk2/EeCqIU88ubC+gkY+l93FaNnofOGxvRFx0jRwd7
         1Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710430857; x=1711035657;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cN3wJipUzIRqQXP/cAUfx2YIxzvE49bUSL1Bir0Ob8k=;
        b=XpIK+S+jn4vrnsmy2geMU+SFKa2aHAq7tuEE1ZHD8kNhY6EDIqMMpnW0pXSHLLOkvY
         8ntyHh2paM9ohg/Q5ZtWZ93J95ulFDk0g6TwkWPMIdnIbCmyL6B3Lq4scwfot+r8FxX3
         6zKWWe+rk42XoAkDFSu2qFB1+ooV/XOb3jbI8p/TC313MT0ie/h0Jp3pBqFjKaRSla2h
         218c4oU/FOUOjw552SVOBucvCwfMHrmnNZzkD1nOdjqrpW3Kp4E1LiDBW0w0mYvba8N1
         TD3prtFFSTo5iIj7kw7vuhBVkRfmFHmXXj2tat/NvOLCkYGpm/9tOtvDoQdMeL0ToKUy
         I6mg==
X-Gm-Message-State: AOJu0Yzpm3sNqtereHDXmH08vCNKzlqKzBEgG8V+pOL5322NYD6cnjJG
	jkvVAppQjUSFtMmOvFWnxWERGYP0m2j0h5vjct/kWlCPZ2ADt2sQP+dmR6FxiGZkNZHqOnzMleW
	c
X-Google-Smtp-Source: AGHT+IFJ6pYR9vLOwDNozHOTxDbPfRax0OlGL69G4vVjlV2U9T0TDI2POP4vUTk66XeFhVtY86swtA==
X-Received: by 2002:a5d:9253:0:b0:7c8:bd77:b321 with SMTP id e19-20020a5d9253000000b007c8bd77b321mr2404861iol.2.1710430857576;
        Thu, 14 Mar 2024 08:40:57 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x12-20020a02970c000000b0047469899515sm216690jai.154.2024.03.14.08.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:40:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20240314025615.71269-1-jiapeng.chong@linux.alibaba.com>
References: <20240314025615.71269-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] block: Modify mismatched function name
Message-Id: <171043085688.105465.17983722271829476482.b4-ty@kernel.dk>
Date: Thu, 14 Mar 2024 09:40:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 14 Mar 2024 10:56:15 +0800, Jiapeng Chong wrote:
> No functional modification involved.
> 
> block/blk-settings.c:281: warning: expecting prototype for queue_limits_commit_set(). Prototype was for queue_limits_set() instead.
> 
> 

Applied, thanks!

[1/1] block: Modify mismatched function name
      commit: 4c4ab8ae416350ce817339f239bdaaf351212f15

Best regards,
-- 
Jens Axboe



