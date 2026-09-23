Received: from mail-dy2-f34.google.com (mail-dy2-f34.google.com [74.125.229.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA6749A3CD
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162156; cv=none; b=tZ3SO8Kb0wdEUZDH+thESRHL0S+5ftgmb4oEvXf+YaZdcPQlgDoCpmRIeXVmwvtnygpygZIQRmiUm2ZGXF45p/KNdrtu0zc+i3BiXBv71W7cWAzV8z50WZiGYD32DV4RU6j8HwEDEdLqeBhLsw9je3imTFaUjtnCnb7oAcPB3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162156; c=relaxed/simple;
	bh=fpTgXc3xoF7NXSdZg3Az2P+X8RDV8yueEizFc2Q7iAQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YtDfXpSMlRi6LkAdRBJDRP4YcUohpIZF/IrK0EBsHJoEhsOqqZX9ZyA45ieXF/BRhitD1H8NY/WmR86YOTch8DZll8TTrLJ9pWA18hmg2u2WlF0TGtacL8+cu5bbvH8v6HBvxsQ8y3w6VXJVnbuuDiE6ymFm2mStPuhAOS27Ybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=0pKDkXuj; arc=none smtp.client-ip=74.125.229.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="0pKDkXuj"
Received: by mail-dy2-f34.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so861991eec.1
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 04:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790162153; x=1790766953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k2RZKlHWzdwe4Eljq1oFXDUhjI0hVFgJE+l4Mm5J2Qk=;
        b=0pKDkXujqFnA1BhW/4458P3odCo86TBmBmkrRPrkQO/Jnkf1HySDq6hegTnfFaxnC1
         2x74A+eznnQ3JUMaYiUBgeRRDfDL/OLDxJigE0vIbBsUZBa9wk4lLquG37LE//Ap0u+u
         Rz5cubhELIbSMxv8uEMmbzTBGkhOqELODinTNMqwDESs40BeE4ocWiw8fNEZ5Iabodg9
         Z7moVH5/mNuSBDynjhfrBreZo+3igH8MnFyhcKFcyqPSZJlOU4PGhOyYr8et1Jx5FfQ8
         BqDHoYbLDAheSngD6ep8bLrC6O8GUBP6YhuWG7FlO+tmYCptb/yg6B0n1WsYNZT20Mqj
         /wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790162153; x=1790766953;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k2RZKlHWzdwe4Eljq1oFXDUhjI0hVFgJE+l4Mm5J2Qk=;
        b=E69m5+aOGdpFPasYY2qNbUQ/3VG07Nj8ik6TyLsYuE4zspal17tCuug8o6mUpPlmHn
         O9s6xX20Y/hyKhC9yf2KtkO2Wk/Gq9M7mWhbiDg5/wzoI89N7tww20D4YGPLmZ6fqas0
         CUk7EYxO0vXfA9KynnXUPNhTlK50MVkpSxfe5EGicRPtFeLUUAE0OrMBseW03aOzERPf
         gMRFMIuzaz18/p1+dMEFJ80yQc2lNQdYVPV9gDjpQqQPpjoJ2B6o7gL0TPF+KNDFT+kq
         5P0B5MSjLRS3ltJEv4EvybFvFQ0hbJVSeesoYpzf/Iqc+OFk+u6ZiH3QOrpCJ7uzilYO
         j35Q==
X-Forwarded-Encrypted: i=1; AKwUvBwLNQrdMmHxwc7EkGsCFnjfg2MXZBBNB/jmbJyU3pLU6cht6BK4olb+CZV8V+mLXqfxKqw1/hql9GpVCA==@vger.kernel.org
X-Gm-Message-State: AFuF++kB5MFpH76pmzMxJFlGJYj9I27y0e10OVjpMwawdNQKm8MrlRDg
	cCUjyUSEdgbBabJPL3JStkHk1TRwPfNd+RmRmolcDgfXs4ZG1Eh8Pk2sxaatIqrkd6I=
X-Gm-Gg: AYBFou0ArkO4JeVsXM99eOv+df+XMnubYvKeTB0/btanWR7jsV8j5xumnXAPjaziKyc
	6YDa88T2BB2hkwt6BX1W75Ac7D1RFzDpDJDP6ME297g8ef81oU6BYXSY7l2182IYnwyLcpa4+Sc
	nsqJXGl9j5vkAwgnuyhTfk139LX4NJ6trWDXFDpPyvGE8fzHRSIe3GEV2dSnjA7oQKqvO3m7F7H
	b7pM4ieqsGXEVPmyUuOsOVjiJnzW2APQVeDO+mAgpIp0nY9yhb990Z8GVdX9tzFERtvLGQaOrt8
	tsmCskbZLhndvjw041QwR1p23rvmyrPqeDX9wRcrxLp5sX/R2oUhuLtVPIVRPJtnogEzjNAZ8Xi
	SMyCfFFxFkQm35xPWojdWN35EiCx5hA+P/wg3ni1BDlZgbcNcnrhmmvNs2PKAHgX1Vzn88hKPCD
	yZHZsKJYUa5XFRc8qu+ek4repsOp7+Qfsogsp7DyYF7I8u0NpJ+9s+zjn3zRWEzEyxQacvPDWYj
	mLeipartJ+kksxmpXHWn5Lqz4kGRXsi9Ama1MqkPxWQiuH5Epvx6wg7igu8k+KujObaBdqB7Q==
X-Received: by 2002:a05:7301:4e04:b0:33b:faec:b01e with SMTP id 5a478bee46e88-33e8c442e2amr3586526eec.17.1790162152023;
        Wed, 23 Sep 2026 04:15:52 -0700 (PDT)
Received: from xps16.local ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdd91sm6383650eec.4.2026.09.23.04.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:15:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Laurent Vivier <laurent@vivier.eu>, Finn Thain <fthain@linux-m68k.org>
Cc: Joshua Thompson <funaho@jurai.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 Omar Sandoval <osandov@fb.com>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
Subject: Re: [PATCH v3 00/33] block/swim: Fixes and improvements
Message-Id: <179016215097.13005.11311816512162043252.b4-ty@b4>
Date: Wed, 23 Sep 2026 05:15:50 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 04 Sep 2026 19:26:36 +1000, Finn Thain wrote:
> I recently had a need for the 'swim' driver but found that it was too buggy
> to be useful for my purposes. I had two aims in mind--
> 
> Firstly, I needed this driver to help me test my new BMoW Floppy Emu for
> emulation correctness. Being that Linux is open source and MacOS is not,
> this driver should be ideal for that.
> 
> [...]

Applied, thanks!

[01/33] swim: Assert strobe with stable outputs
        commit: adcc410bfb41715fef198a0975db4ed594a49bb7
[02/33] swim: Select appropriate drive once only
        commit: a2d22b3f25c388f9fbce7bf36a45a8900dce4aa3
[03/33] swim: Enable the drive when probing
        commit: 57d88c8f4ea34a4dd7c5351bd026e225c7283f3f
[04/33] swim: Don't disable drive after every sector
        commit: 05a7c4b197279cfb3ec3df26146ce085a2438aec
[05/33] swim: Perform ISM/IWM mode switching according to specs
        commit: 52981bb358d1b5c38040b00f81e2cf973f9148ad
[06/33] swim: Configure parameter memory
        commit: 994a778d966592d0e211deaf6e436fcb21413935
[07/33] swim: Refactor SWIM setup
        commit: 62977e8ea98e99dbf86609e65930e6607398e1c5
[08/33] swim: Enable clock divider only where appropriate
        commit: 3c02a14c89962c88ed0abb3cce4101021c63149c
[09/33] swim: Don't start motor until medium is present
        commit: dbbaaae83cb277d76e70426c0f0ce289e867ed77
[10/33] swim: Recalibrate when drive is probed
        commit: ba087774a1493ade524f8a783461fa8be9c75039
[11/33] swim: Add track zero recalibration delay
        commit: b9c1095048537cc9563f12d0a24f2f0df129e4d5
[12/33] swim: Handle FIFO timeout error
        commit: 2e9bcbecee68431b689d16b23bc5529db686f8d4
[13/33] swim: Simplify return value initialization
        commit: 385a44e78702762e2fce796cf37b6f465d86a87f
[14/33] swim: Check for CRC errors
        commit: 01bff87152e6748fbac9ccd645d3d5f490d75ddc
[15/33] swim: Check error register during sector read
        commit: d66bdef0a3083fed1a0fc4f0ee1c85b26476b21c
[16/33] swim: Don't use the mark register to read data
        commit: cb7923133ec18e67e2d6718e29426a4423af6b73
[17/33] swim: Fix buffer overflow
        commit: a54870a4ae4962acf341eb6ca010cae02af1a6ea
[18/33] swim: Convert to blocking queue
        commit: 92353a04763726f70fea6be90957c50fc18215e0
[19/33] swim: Remove redundant RELAX actions
        commit: 04cb277e6841b55b950b42063fe11501b5d1676a
[20/33] swim: Deduplicate polling loops
        commit: b736189c93c9ad1056521a4229ec2f252b714b5a
[21/33] swim: Check drive ready bit
        commit: abae04f5bed924590e98fe1519566a6e0144e6b5
[22/33] swim: Revisit delays
        commit: bbcd3e38a4f355d6b0320f3f6916df96c109f2ad
[23/33] swim: Remove pointless mode0 register write
        commit: 151848934fa4696067a8ca861cef5efe7aa1e046
[24/33] swim: Don't needlessly re-read sectors
        commit: 22fbea97bc18fd099730572bf9aeba9879d62b02
[25/33] swim: Don't search beyond the first data mark
        commit: 79eafa4ccb74be023fd2cae87d75425d6eb903bb
[26/33] swim: Remove pointless specifiers
        commit: c516ded6f6da38b64ce9f69c88e65a65927296bb
[27/33] swim: Move swd initialization
        commit: c0862cf48fae35571489b79b1c84db16691f2ad8
[28/33] swim: Add some helpful references
        commit: bd4a21b8452d48be48cbc66693d27ff3c1f88d9b
[29/33] swim: Remove unused macro definitions
        commit: 7d7c6d91f5657b2979cae7c7dcb49d2523efd894
[30/33] swim: Clean up whitespace
        commit: e97cbb470cf94ce018558c899bcad387f69c99f5
[31/33] swim: Define macros for constants
        commit: d4b2519065d6db2eb7cd36d178591058452da3e0
[32/33] swim: Define symbols for constants
        commit: 75f47f0910f4f4289c11409398c05999aec19f37
[33/33] swim: Unexport global symbols
        commit: e7a6727deab0d300171ee059b7dbcdbdb3c46797

Best regards,
-- 
Jens Axboe



