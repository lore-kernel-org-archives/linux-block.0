Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DE622D784
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758306; cv=none; b=RozVUMExE9qSICGCFZqQbbRxYuVCSOVsC73r3H7RQ78rRLnrMtk4Xr5kE6GeWVBGu6DpyEmI5N4EUL7Bbv0jCc++p26DbdlBz6BWXEsB/1k4ygLRMDrLN/8/uLhXz0joJGbAodG9yvDAQ89A1rJkA4qt6YkSkWx332Ak7rqS/jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758306; c=relaxed/simple;
	bh=52gdfV2lf3R3eQZIep9Nn0vgtttLjQtR3cQL8aToaTM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tfBY6Jq/DagyXDHCqug51T2pc+NRjap+HI12xefzmcsbcY/Z2cYiq2sBpMH1A6h6Z6BuJDGneu8FIYi/R9xPmSxvlmz4Wcv+u57U61q+3d2Lu2gE29APHdNRF4NLH8UQ7Kb/ZfxSqaSYpqW7mlzB+9mNEjYs1S1npkwLoDkQzn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XgPZBDUo; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XgPZBDUo"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-861b1f04b99so181401139f.0
        for <linux-block@vger.kernel.org>; Tue, 20 May 2025 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747758303; x=1748363103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+RkIP/QIBRyqjYoT2iLudVQSRRGsLE1SJ4sP38mSAE=;
        b=XgPZBDUohxr7EushGaSKsM6q33Iy2YcQpjWQU9ns3ZpJdujOFq6YupnnzoUruF8Pxe
         w9xRcZh9DQq1sajGml0z7RZVIoC2ys0x9TYwWHwYtGEx7E3ka8i10jSqQjcc+1ahB0Wy
         99w6YJQjcAlAtOPtxqz72ZCZvyy78TCInnSeClypndGwkPyuaUqi02fYiEGkEY/6z7DK
         KhajuwHpu3Mt2mkhTApzGtVPE5bw2ZbqUwPicnFkc5Jdc4szAgN2x99/6I0Hc0D1CWcF
         PetbfOuFaiavvc4uJDPqY28sbpcN/X7MVTt8zbgZe3v7db6d8Ll5pU+s0keYEmSH3lWs
         ThlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747758303; x=1748363103;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+RkIP/QIBRyqjYoT2iLudVQSRRGsLE1SJ4sP38mSAE=;
        b=Ds6WjaeL8luy6k5bBHg1zk5LJsUz4Y+cj3uhS2wxCpwVNbpUhC5pzB11e1qZAgxP67
         bEHcFpIua2vm/rvx289qwcLNhjVzwGKmcQzudP9uvXRXTF8QOBgEe+ScKeGPtm4RCUdG
         uq9saCoSvhe++rzUSOoLnxFcYVKPgaQNy/JXfYvOAUTlLrKHqQ8x8oGvbzhBtTIkaSo3
         WZvEe6Y3SkJFxjIt/R3icAfnoEp1x1FhC4Sgsx+ZT4DqnXMP4Wk3EABsDE82PX1RIn10
         GmlcHOnqE5m3GcH8ICVcm0OUYX5BgdLIVGsCJKysrmfy0lmQXrvj728OJQJyKwbSLc+F
         hCxQ==
X-Gm-Message-State: AOJu0YxxG5/gt2C08D12KscC1Kr/EbIX8Jx2QfyEQLICxr/xNqpCjQuv
	PxLkCMzdcmSf4LuiOdaTlFSA6O2X5LJIBFPzCIOQrsjCqJayRCptVf9wNHx/z9qe8b0=
X-Gm-Gg: ASbGncujThVjaCV21PkbN0sGp7w0ajkrGv/pNqz5GyNLvE4kFOAA4uMRr2Gx+ZBfyO9
	/7jB9FA7M2iEjYOv+lxlIAoBA02WeuADpoe/J6YkaumP9M6QqRC0Q485ZER+X9rtXgZjSZOMRa5
	yVgAPzkhkkNtgE686Hf7YGv4RKnxVV1AupSW0lhlCaep1SUHm45VECx69z2XJW4PuyudzePQ6Wm
	YB/EkGj/pG6eExbhACp+chgAzaDIwWo0Yy0iD5+VTtJvdwj8eS6Z4gdq0etu4Yoq1TSSEAfWPQi
	4jL9C/E2ixnOKpINiv4OJzOwUifASEFj2eUThesDxK37lQoOoqPO
X-Google-Smtp-Source: AGHT+IHjaMGsRuyBOiVLqRm69RnkcYn8IFl+9obgwpyUfnU9nzaGh/BNoxyIUdo7KWA+Du3kqMdpYg==
X-Received: by 2002:a05:6602:394e:b0:864:627a:3d85 with SMTP id ca18e2360f4ac-86a2322a4a9mr2367744539f.11.1747758302870;
        Tue, 20 May 2025 09:25:02 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc3dec82sm2205762173.68.2025.05.20.09.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:25:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Jared Holzman <jholzman@nvidia.com>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250519031620.245749-1-ming.lei@redhat.com>
References: <20250519031620.245749-1-ming.lei@redhat.com>
Subject: Re: [PATCH] selftests: ublk: make IO & device removal test more
 stressful
Message-Id: <174775830202.740786.366567782519822651.b4-ty@kernel.dk>
Date: Tue, 20 May 2025 10:25:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 19 May 2025 11:16:20 +0800, Ming Lei wrote:
> __run_io_and_remove() is used in several stress tests for running heavy
> IO vs. removing device meantime.
> 
> However, sequential `readwrite` is taken in the fio script, which isn't
> correct, we should take random IO for saturating ublk device.
> 
> Also turns out '--num_jobs=4' isn't stressful enough, so change it to
> '--num_jobs=$(nproc)'.
> 
> [...]

Applied, thanks!

[1/1] selftests: ublk: make IO & device removal test more stressful
      commit: 3fee1257ab6be5b52c9f002f27d5620583a8dc40

Best regards,
-- 
Jens Axboe



