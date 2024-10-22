Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35841CCEE7
	for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 22:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635911; cv=none; b=CZHuNc0Vr6jUH5594ztMJlZR+P4I7OleritUwX0ps+pK11mOAf9HgtKr/mdBuU3kgXTO8J/pmH2wnBCon5ixi9aNqwU4UpIz091CWaOV0nyYd/MDu176RYN1T3I6XiQLKZCpksn1J7ddKBIOJEH6CT327Y8U4x42vsgWsGNRUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635911; c=relaxed/simple;
	bh=Z1cZjeKf/jozcwiyWOWX+ZIBI+FWOzyh7DvqYvmsWkY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OxzlkL36ORjB3iYOz88mgwJj9C1kG2ETPj0sPWFkmPX3QwyeJhfCENaZhORUN1ntJPHV2esNAyUxJjHCmO+Y3LYbh2o/B6fNuI4vpnpD6ZsCh2yDKH7MmRMxfE3tFeXW4Y1Mr9BokdAol6w26XmimUIPquQ0pkIIjgckDzyzSqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DrudqmM1; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DrudqmM1"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3b7d95a11so21293235ab.2
        for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 15:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729635909; x=1730240709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Wdl0kwphF2c8vv3SMO2fVvGpDrIoce+OneiyQG9nXE=;
        b=DrudqmM1sd5Mwww1nFxn8VCx7r6c+yPditOJ9DxYQP6N/f/4JTdymvUraWixrYwEDd
         Ml2DqF/DFKwnFg2w5TZ1G0oeBWVxBKh2a1aBnubeAFI2gN75gMgpTW02XMcrVo7IOOr5
         2DuADxGeaJJGq3G/nBq/EuKbkKZrtWT68ZMJKXyA6CWuHRaenBX51dhYXuvoECFFbzh0
         TyK86fM7fBKhAXxbvTBu5XkeG3RCPLh83e59qXPVpcz5IE/YXYuWB3124R4K+bzqTtXI
         pX7NP/DRl9S5zkbXrLVXya9ou2mLd3sn1TIYs/XdJ3T567z2Kl226EmEYfA+RMWvB3F7
         SCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729635909; x=1730240709;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Wdl0kwphF2c8vv3SMO2fVvGpDrIoce+OneiyQG9nXE=;
        b=o4lTq44fgC4B1Z1WMVsWU+UiNIsasgYoXU1zouMxD951oSIv0dtKVOg2SyXSEQS666
         koFmimmZ13g7KbmJcZhMC7IBkrmmGRX3faVY/4CWepZGRvUcA99Duh1ZHEjDybnfyXEb
         /VR5+vYqKrB3p1l9J9qA+4yEOB11Q/iOqgpGs9Copr5lxWTo6lRqyh3wKOn+K8QFmxAt
         lBgoEqU4XzrVzj+NBZfPO3jWKoK8hBnP6yQvtUlixFp0eHnJzxm3mJ5JqcvDjre44Yc5
         vCeEv4G/Z1mCIQAXcICH8rOJDIRFjB+pZ0BiB2gjz8ZUcTU1YX78Dh8uTQiT10N4mUmq
         1/og==
X-Gm-Message-State: AOJu0Yw1dFIyAiSLcdSThI1saCZAQJ8gMcptH9AdTIKiY4pcFobu5Rs0
	OvLGqTUPT4DW6QmBcsScYqcHOOtgz1hfOQvalrXF6lKWCmeLhqV4xmCSvQpNEk8=
X-Google-Smtp-Source: AGHT+IFCHP8jHtw9I0EW/rBRRR87HKzXzIXgYn6ehqFfzqLjMc7iRS7Pvz2diCbQT9CFggYFStQ+0Q==
X-Received: by 2002:a05:6e02:13a6:b0:3a3:b1c4:8197 with SMTP id e9e14a558f8ab-3a4d5a00b6cmr7283545ab.23.1729635908957;
        Tue, 22 Oct 2024 15:25:08 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a65f952sm1767297173.176.2024.10.22.15.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 15:25:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Peter Wang <peter.wang@mediatek.com>, Chao Leng <lengchao@huawei.com>, 
 Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org
In-Reply-To: <20241022181617.2716173-1-bvanassche@acm.org>
References: <20241022181617.2716173-1-bvanassche@acm.org>
Subject: Re: [PATCH] blk-mq: Make blk_mq_quiesce_tagset() hold the tag list
 mutex less long
Message-Id: <172963590776.1032314.13124670972320527966.b4-ty@kernel.dk>
Date: Tue, 22 Oct 2024 16:25:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 22 Oct 2024 11:16:17 -0700, Bart Van Assche wrote:
> Make sure that the tag_list_lock mutex is no longer held than necessary.
> This change reduces latency if e.g. blk_mq_quiesce_tagset() is called
> concurrently from more than one thread. This function is used by the
> NVMe core and also by the UFS driver.
> 
> 

Applied, thanks!

[1/1] blk-mq: Make blk_mq_quiesce_tagset() hold the tag list mutex less long
      commit: 6fbd7e0472b73bc21b19d56d3f95c2a1a5456607

Best regards,
-- 
Jens Axboe



