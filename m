Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC91C168B06
	for <linux-block@vger.kernel.org>; Thu, 18 Apr 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454495; cv=none; b=iWhyepcFwFNbslH0i8JK5r3FHRG6wlahI5ovRi9L5WD6loZripSex+iZ7gNi/GvYvIhgLs7c2K9JU9yvA92coQo+MqNlFKuuX158O8UNx6VIzVtR3AULAwU8EB7bwHLRI5KMOvMpg6/VTD8uzXhpNd2/cp8ebZLppFcpdlgu4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454495; c=relaxed/simple;
	bh=RbKeH6m/60YxVDWb4xXr4DtSZxDRH9TvDchql+4hSX0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m/bAd81hgofGPXOZHuiDaUu7HQzcH01JkqdKeWGJg5tju39LkK6dBY1d6bpHJCd2HHVtg8qmoSW39FzG2B3XZt0ajq094kOPcEatrXYma0eCfSfEpvvDGGNSBP3N5SymOnMkNXesp7sUhEfjWX1Zy7UqLraygLx4z8TRnew5xwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dFI/2LXA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dFI/2LXA"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f055602a7bso204593b3a.3
        for <linux-block@vger.kernel.org>; Thu, 18 Apr 2024 08:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713454491; x=1714059291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtyMTrDAAeLUAVKK4p39pOuDxuloCsZgvVfvLhHVqFQ=;
        b=dFI/2LXAEIOTWr+rwt3QXcjZnzhjkKijdEMA2QTwddYC5VVuEY7v64jYi8Xa8P4yol
         hW8qmB6x8SAqrOM74QOUp2y6zOtO5eRmFcmZmF3zdmptULTty/0e2kDhLNwqx4T8PdRo
         P6mwA87zpUcOthL1nHYi6AVLdKQ57r0xtnNE2TtkBTU0LATCm7x3Pku8GKCscl0NLNUu
         KDYW53zlEtTFo8EQ/AgGQPA6Nuj4hug0zSlzOsXfPe54mdjA9RMzK6d1rff5zCu2QDwF
         AYm929UxToajOhUR9SnY51KOAmNsyWHaOtU0PYPe3ignV/PR8Sown3U5g35hHnRo2BDG
         rVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713454491; x=1714059291;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtyMTrDAAeLUAVKK4p39pOuDxuloCsZgvVfvLhHVqFQ=;
        b=rNRadQWnrnui9+yxUCgRUrbgVJlXzgJn7hfKkfuAc8KuMHX4ppbfRkigE0o2En+e+z
         83G+27sSqiPkv9lsFWFlyIpTW1LVkGIg4gThbgiWd8nRpoNmnVtnABBNhXerH2nPuvBK
         FcjFT6AXgr9+UCUfmOwUytWABqKxhjE5fZJMf6wLOTxqrzZUbDIDLLBnZiQcqzQCzhJj
         DysP68aQJfM9NTClFY1+CNTRFjH5X7kDZg4iBCaA0tKtsfc+dvzbzjVAo0z9OCDfxVvc
         /3TUuIuzlgGF9ie1SZSXYOUrrfYGrrpFoRabS4FOjB3Gfs3mKPWZ8ywC3I0zywZv/qDA
         eXMA==
X-Gm-Message-State: AOJu0YxHZ05K90S/ZYMyPFtDMF1K9L95kNUlSLBNs2D9bnyoxVuFAPfk
	/7ZcPUifP92wiHRVheuGSDIf9u8Zh1TxBTXuhuKZUX3bwVKbmOkKudO382iw4cGXw65hGNVghyx
	r
X-Google-Smtp-Source: AGHT+IHPAyQqOdq7gsbQjinvOYY9ex6ui3WquoEH41gImSXT65fYaLXbN3XZI7/0yfr2TOxlG+4sQA==
X-Received: by 2002:a05:6a20:1581:b0:1a7:94ba:7b03 with SMTP id h1-20020a056a20158100b001a794ba7b03mr4195480pzj.6.1713454491665;
        Thu, 18 Apr 2024 08:34:51 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id k73-20020a636f4c000000b005dc4fc80b21sm1559816pgc.70.2024.04.18.08.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 08:34:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, saranyamohan@google.com, 
 shinichiro.kawasaki@wdc.com
In-Reply-To: <20240417144743.2277601-1-hch@lst.de>
References: <20240417144743.2277601-1-hch@lst.de>
Subject: Re: [PATCH v2] block: propagate partition scanning errors to the
 BLKRRPART ioctl
Message-Id: <171345449077.438677.10984470002252005040.b4-ty@kernel.dk>
Date: Thu, 18 Apr 2024 09:34:50 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 17 Apr 2024 16:47:43 +0200, Christoph Hellwig wrote:
> Commit 4601b4b130de ("block: reopen the device in blkdev_reread_part")
> lost the propagation of I/O errors from the low-level read of the
> partition table to the user space caller of the BLKRRPART.
> 
> Apparently some user space relies on, so restore the propagation.  This
> isn't exactly pretty as other block device open calls explicitly do not
> are about these errors, so add a new BLK_OPEN_STRICT_SCAN to opt into
> the error propagation.
> 
> [...]

Applied, thanks!

[1/1] block: propagate partition scanning errors to the BLKRRPART ioctl
      commit: 752863bddacab6b5c5164b1df8c8b2e3a175ee28

Best regards,
-- 
Jens Axboe



