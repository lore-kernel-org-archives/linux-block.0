Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77883226D00
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969839; cv=none; b=K6nU08u3o4cUpNAFjG0yqHUO2OzDENckf05JPMDAXKTHnXuuonvNpp6HXx1heqQ2gsTYxnRaE2BTYnG8S0K2qvaIUsXS37MsBuT2JtQeQeH6HQwiM6XywnPHsl77xmbqzOGgtzMUYLn3O8ffRItKJ4kRNHwp8OKu/u3GzfQbqpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969839; c=relaxed/simple;
	bh=1hONDc9dMeTNKFggLaMXcuk+kphay8IJR3RTXsjX7JA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LCkHKhet5ALhSqW1mZu4Z1AGhCdn1pat0Gamx+/ckIUTGzKVoxxUOb7BDHwqZiYfROPeaLk41qZJxQXi86nlSGl4OiE/AJMRyBQhBEn1pIBp8usy47fAsQ6+CbFrE+vYJUriG3OdN82MU/VNuPWtHj7QGqAHNFMO1CehK6sIJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YPMkEXE4; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YPMkEXE4"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d4c7d04890so5636518a34.3
        for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 13:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771969835; x=1772574635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfslJ6h35RImFS2uqqcrmQcB3PuJmFh7HqLJjQ1RQUo=;
        b=YPMkEXE4b2VJv9XCd2bFS7Y7caUuYbux6XGdl7w8rtV6P9tdVaoIPTLT7/4l84DBn9
         +yGrt07f2e1R1t9mQSwFsCG8oCFB50r6TVIBlRP99SdTsQIRYmKhBBQ5kOHQG4Y9ifJa
         kYF4loRwESXe131oeOqtpwi8sBszZd90YFXMdnpPn0/P/RRDdZg/X7scsKmxM1p5SxER
         uCYUtPti9W1WClRYYtSEoanJSfV5Exvs6vv3kaPHcsaYSDOlbUQM4b+Mn9adY7vx+0Rg
         qtelv3tjEZyFiEpw53+mrlErX0WlQoTz/ex3AGNQx3o5w+HaTV9IO+OfZOv0zh8iInqW
         yrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771969835; x=1772574635;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CfslJ6h35RImFS2uqqcrmQcB3PuJmFh7HqLJjQ1RQUo=;
        b=HGnCVHHKEgbJg+/NHCAtw9PXk9MJDUk/QFGFnHBmIId6DVnDpLHEXijPywlb1p2rVx
         We5OAn4s7uZ+0oeWeyiOQm6sRYnxiuWxx6vhgoE7W2V6+/fBAPAsEP90LFfKCvRZJ6Ps
         27DxEFnOJZJMV+1LHw3sCZ/4WW25anjunL6z+ho6Fv7wd3tqJ/DYoIKqNN6EaTFVjc65
         UOeOuiy89jzfSGkFLpbjDvoqS0LQre44crUBjh5Gz9ATjpP56OMZcVnSu7MZx7LqBPK3
         tIm/T0qBSvfJ3NyLccCFdpYUyKLv7v4p2w6F53uvGGUirXkWcp1nagnnsog0QhcC3dPM
         0iJQ==
X-Gm-Message-State: AOJu0Ywlp03Bl6Rhue6FsgZzUGrs3ObLXhxc6CfEQQBLkXp2Z079/Gno
	2odenJPLURky14EFkB63aSGJ1dXiWWf8rAIJk63Ht3v9mC+A1l6z3gQkYN4idG47cQo=
X-Gm-Gg: AZuq6aL+lFz716pf+qgiRCgMotSkg9nH883Qfvp2VRERjHL4ZjtCJ8/Tx2Ctgevl8aW
	HVEFse56jYBQLRq0eIQJ5KdQ8iCZrhDYRlDAA2BKqGcVknUnbNRX3DNrMQKzNeQZrYGvJxpC5dg
	L2lCPy2Spx3Z6b25MGyE9cu31+KkfEmGOO26A1wUVcZ7jONCroSpkScLf9GNPxLMSs4qatNmhp6
	N7qYuJaVvC4C/FfkhyTi5GPuCq8qEQtx8+b19uYxqlm6iaHoGkU3+fCDGurKUCbMQzenB6x361i
	407ru7BUzm5tsIyL2c9L5gnjE4QdcK3Fwn+EboSnCCfg1Cy5ZWNA8xKWP5iR74v4SQ5dTLWD9gL
	2erLnjXmRJKP2/sRBklR9bj4fbOkTUsTmmC61oIut237c2382S4YX6bbTp+2TYaeUbRXMMcHLJj
	d7aAdQdZpqzLokMSEhDUr7ytYgAVJDEDiQtefC+qbV2dfHm5hXFzbf3WlcJIIDFu75KT3XHUBmi
	Y92
X-Received: by 2002:a05:6830:2aab:b0:7cb:125d:2a47 with SMTP id 46e09a7af769-7d52beb1751mr8143478a34.1.1771969835459;
        Tue, 24 Feb 2026 13:50:35 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d04dbf1sm10657155a34.22.2026.02.24.13.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 13:50:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260224142153.368472-2-hch@lst.de>
References: <20260224142153.368472-1-hch@lst.de>
 <20260224142153.368472-2-hch@lst.de>
Subject: Re: [PATCH 1/2] zloop: advertise a volatile write cache
Message-Id: <177196983467.781492.2326872834879958553.b4-ty@kernel.dk>
Date: Tue, 24 Feb 2026 14:50:34 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 24 Feb 2026 06:21:44 -0800, Christoph Hellwig wrote:
> Zloop is file system backed and thus needs to sync the underlying file
> system to persist data.  Set BLK_FEAT_WRITE_CACHE so that the block
> layer actually send flush commands, and fix the flush implementation
> as sync_filesystem requires s_umount to be held and the code currently
> misses that.
> 
> 
> [...]

Applied, thanks!

[1/2] zloop: advertise a volatile write cache
      commit: 6acf7860dcc79ed045cc9e6a79c8a8bb6959dba7
[2/2] zloop: check for spurious options passed to remove
      commit: 3c4617117a2b7682cf037be5e5533e379707f050

Best regards,
-- 
Jens Axboe



