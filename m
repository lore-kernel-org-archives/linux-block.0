Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890BD80058
	for <linux-block@vger.kernel.org>; Thu,  8 Feb 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412371; cv=none; b=K8J2ao9i+RUOzqbkgHuDFS4iTdSIk1XCT8bB+sdo0t+g9H7FbicqR4DL63O2vpQ94jEAL+b65pxUkSN3MZUmSDhquB3tXX8tI3Oulihjg9vqFifvJjEtY4OEpmh+APpwLPv3KhswgzzBZMD/n57khMyhBR8IHwoZMvOesjBPViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412371; c=relaxed/simple;
	bh=GGnpdvKFnsrJRcVaLIVdd4QMhMW4+moxJRBEa+tk0p8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DFpsPGJil8BHglOGaWlDrdoutdW6Q0ra5NVBJMJWocn5X6TXyjiSg+b1YBaAp/nJOLL5egSPB5/oryXAUMXLKOMW3U7vLTSF8VdkOtd36VRV8YamQ+phP6RFJ3k4LF/QngkEIVRRplsAcPL9IqDyfTv0DhndMPKS2pw63WDUd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VfuZErpL; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VfuZErpL"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-363acc3bbd8so546735ab.1
        for <linux-block@vger.kernel.org>; Thu, 08 Feb 2024 09:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707412368; x=1708017168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjRxbDcqKY++6B9sBRg0ywAO6+22ec0EvOww7ZTGUEU=;
        b=VfuZErpLSX8qfuecrXGgZexlxvSIyiYKTFvYUaGrIS4ZnYXArpTbeZmDcxdyBeCUaf
         Mfqp5GlLUq26IWFlmHXuz5dI6HSuaec0aLS8JRwayY2u7wlfS9P7ltdM84nLEQt/Fut4
         Fl/Devd+rNUIikkdXafDyqrrrCat1eGi8kO9Xk9wkU7fwOrYJnYVyTjAV5asaVOWwu6a
         0pxI/mk5x6ypUsVM1B/vY2EYwUk7Jt/Xowi7BVFM0lJHV0RNfQLO1CI8cTZDzEhE76n6
         U+IulNkkRcAtfD6vHrIwIGCso/zEDt7CRF2e8mInYxQdiTZa+1rWxHEvYLY5PvuNu3kf
         e8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707412368; x=1708017168;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjRxbDcqKY++6B9sBRg0ywAO6+22ec0EvOww7ZTGUEU=;
        b=uQRBP2Pe+iL6KSKQdf1YUpt5N7rMtgJkZdcfMsD5EpKSVbdj91J9wISZ71REpGcJ2+
         r61bN65Nh15q73/pZRF8A32s4UzGK2YLY6qU9le/RyhR8VRO5othr1z1MHqGT82NUKe7
         HSg+JDXqyW2cumD49XakhlUx0iAqIZ2M7w+rG1NyPI/+0Fc/42WMZomV4UuW4DApjyS5
         rGTcRzf8QZOF8X93+7ujysNUeSNtgum1sNlHPMIX9W7QPV8lLncbcn/Wt2p4hqHGI8So
         VLVwPK9iLEnNCVIsZkpaCA8ud3TOKUjuFhfHz3xHKEHd0PWwPOoWMoGYYZ/hdLmHSrU2
         Byzw==
X-Gm-Message-State: AOJu0YxUMMOT1Eu3N/Nh/4zY11iZTM1Vh9rJ13zPTF2K7R2Nh5Gawg2L
	PoaGiymYq9422No/eO2Fu5sXEJv9MUD1FidOHpYuOxTsP7Ip9+YcxOLdE7d+4jUV73pEIMSN+DB
	MQC8=
X-Google-Smtp-Source: AGHT+IELBZX3WwQ7vkAiN26yd2iLHBjLAq3uYSOHWbHc7iD32gst2rPRTha59n5UBHRLNiyaeWiWiA==
X-Received: by 2002:a5e:9204:0:b0:7c4:2a52:c2a6 with SMTP id y4-20020a5e9204000000b007c42a52c2a6mr192704iop.2.1707412368205;
        Thu, 08 Feb 2024 09:12:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVd9KHTSAz4BmHnhPJwTgIrcKgGJ1xgvtnJUNN4ncO7GWmToqIjTFb1v3BO8jmWQ/DPXp9/C+FkA3vAWyi/6YQ3e+Y8J455dvNs2qB41RRf+uGF6HR/+j7DT0ztFePoy4o0t6Qee0SC/k9O4QutJyT3VlCOoei1n9BK6tNI8p/RLMWRcpZIgh7kTQgWLFWnR3/CxpQBIGAS7/C3vDqzXzj5nn9RFVSyIpnGcm8hgTaSPFHtrQ==
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b23-20020a05663801b700b004713f3c2831sm993173jaq.61.2024.02.08.09.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:12:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Miroslav Franc <mfranc@suse.cz>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20240208164248.540985-1-sth@linux.ibm.com>
References: <20240208164248.540985-1-sth@linux.ibm.com>
Subject: Re: [PATCH RESEND 00/11] s390/dasd: string handling cleanups
Message-Id: <170741236688.1366825.9301760269550901204.b4-ty@kernel.dk>
Date: Thu, 08 Feb 2024 10:12:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 08 Feb 2024 17:42:39 +0100, Stefan Haberland wrote:
> looks like the patchset was not applied for the last merge window.
> So I am resending it rebased to the current for-next branch.
> Please apply the patches for the upcomming merge window.
> They clean up the string handling in the DASD driver.
> 
> In addition there is a patch that fixes double module refcount decrement.
> 
> [...]

Applied, thanks!

[01/11] s390/dasd: Simplify uid string generation
        commit: e5de34db1e95ef549236f9a2630d396a41c208a2
[02/11] s390/dasd: Use sysfs_emit() over sprintf()
        commit: 9c386d0f6e04fee1b4161e49f8e9f5756bcab04c
[03/11] s390/dasd: Remove unnecessary errorstring generation
        commit: 8d7ac904c90be7a1ed1aafa34953c40270c30bd0
[04/11] s390/dasd: Move allocation error message to DBF
        commit: 4849494f05994f411c9cc0504843c6adefd1f2de
[05/11] s390/dasd: Remove unused message logging macros
        commit: 32312cf229117b781bd02d93b0b11c8b47dfcc0a
[06/11] s390/dasd: Use dev_err() over printk()
        commit: 0b3644b475e2564abe26a916af8447beb7c4966b
[07/11] s390/dasd: Remove %p format specifier from error messages
        commit: 4ba6366dbb03c2a58d0e7cbe140942bcf715006c
[08/11] s390/dasd: Remove PRINTK_HEADER and KMSG_COMPONENT definitions
        commit: c6c6c69df6598aacf3921f26f89b12d5e321ea83
[09/11] s390/dasd: Use dev_*() for device log messages
        commit: 79ae56fc475869d636071f66d9e4ef2a3819eee6

Best regards,
-- 
Jens Axboe



