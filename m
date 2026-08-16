Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D04B049B
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838478; cv=none; b=DlRz4JJDb3jf3zRnJKQjoJyfads2roAsKEPOuiOponIaECfZue/T9BfHhcqqJ815XED4q/lBrlnMI1+Z3u2aMAB+qJxbWJ+MpKBHlXm8el7Z2Qp4cZh90AayDt7yhyheloL9ynIE5HhKZiLGd+sb5gaXbHTR4aS98k8dP/QAZQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838478; c=relaxed/simple;
	bh=fwiCeuBN6LsxzKm1ssAsRPzU7QhFFzrSvf6fjxV/x50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UcmL5wav0mFb0ykWMRM2NwO+OzYXnb82vM0Vlea/3PsAGHQjO0Di6MGWHtmgKWq9AzxaBN/gtGPayosB5GsDHENTHVVgpIkKg4zSStt2xKJ7Q0zd8Gj3i893tTyTtfUn9Pm9DCahoLVUVon/7jZj4yz+Iu9kb+cRImn+OKsj2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=RIF288Zc; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="RIF288Zc"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-451e1066971so726994fac.0
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 17:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786838475; x=1787443275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QmJoj/egTa/BBVvRaXniTUWBidYZo+XA4NIXd1JdCCg=;
        b=RIF288ZczK5pRvheu3nawVQkC/SuRrebR0je3gFsQ24tinq7qI/+LRxd5BgWqwA+73
         d/te4PO5doycCUEcnTTm4FeBfD8RWKJBlkDw+9IoWtJoO9OGEZHTyctF0HNbSz/3yny2
         p7fLhugN5mT35uXdh0+QAmdD6y4VCRKzc4EtJ3HwVDjyPPQgg9th+1N9BJSqK5DoW+AQ
         rmnUPf8gMcc5HcMd9s6gGc8XGDeGj47lc+R4fEUo9Km8XD7IKLFbtRjdEkGvJYsuWwZc
         6XMMipGU2jcY/GwJVeGVHPAUc/022zGglOiIPX6Y9Sn0qm2/mi8G2ffU+DEh3eNasG1d
         geZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786838475; x=1787443275;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QmJoj/egTa/BBVvRaXniTUWBidYZo+XA4NIXd1JdCCg=;
        b=m/QnfEZFc86WL6Us6baNQbfW9WME6L0rbpvRCdL5q77AH/D3uEmAo4Bp38QGsr7nQe
         5Azpx9UXZV6zm9RvuPna47yVGgJ93Zpp7XNPrGf/YIrKa1EYhaBC/GW/3kz0YmH9PyXq
         LpWOzY3ORkcmdU9QafVL/Dp4CT9lEdr/DUpXO0jyp2GQXykbYZQfAPCqTFH1w9+ad9X/
         CZ+c8u9gwHhCXETwNnjrCzT3JRg90HEIUiY6D/YDp3Cc89ZzsTQCsTXSvXB2VKTjjsAI
         goq3m9ZJKnRJNvl0JoYmQX7Wfpq+s2RZyGB/Jxa9Tl0E2eHRmGAhTcySUcwJi/0uH9XY
         9iYw==
X-Forwarded-Encrypted: i=1; AHgh+Roq9dgQ1b+45MM8T9B8MsZjbw6dINrzoNIcNMR9PycrijsMpMO+w6jFNnUREx0XI1+NscCvdeu1BlTGwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlPBOss+ybwd9oa+oQ7JvBOoAdtOoQggLMqBFmTbXw9/uAYaGv
	nvX+mJhuitJavRVo6a0XDYCYjhIDQiXdaLXWgT+uwQ067RceEiTZ8+JEa4xTzZujQzY=
X-Gm-Gg: AR+sD11emO1PWY9nLC3w/Q/QRG8c3crcvc5NRWHSOg4Xseu4HBkjCaeROq0Afhhlddg
	6bpD4PioNNVDb87m4Nv9xwK9YIXCi6lQf2Im7u72ZP4+k6WW2bb/IOcJg533gdzgSJh6EL1xirX
	h/R164uJffJZJj99r0TVPOhOhe75YeSJ6qAZFIbFmoIS80S77lDPAPWRnj8qv7sUb/knBfICAvT
	mK0wVb311gdSGlk5Z1KqCrdH6lRO90sW5B1lpqdbDSReBcUs+MwoIrtYv3b5BBZSblCipk5oQQV
	SXW+rt5o5JEqOEP5iuYyH4XW78BroFbTKDVBDfiWhuyL91zEpE1wBXBexrKWmc6lkSnRfYHcA1X
	IVtqNDDAzYrE7c2g7hJRaeYAUJXkepbUkcjTHgzknW4bBiy1a2NSWKJJVALtFV3BwzSWKk8YPU/
	RuI2wKr3hGQOVXKyUeZNiaIVResxWVioof/LkCdMyQUsqACZkhM0L3ZZykRBDJAtH5GBhwPHZ4T
	kbzcUFmKgHdgn1P7ptuf5zyZIenBr27Js2XRguFJw==
X-Received: by 2002:a05:6808:1a1b:b0:495:f519:70f0 with SMTP id 5614622812f47-4b241e2adecmr13500972b6e.19.1786838475613;
        Sat, 15 Aug 2026 17:01:15 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d92462dsm4347729b6e.5.2026.08.15.17.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 17:01:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: dlemoal@kernel.org, nilay@linux.ibm.com, bvanassche@acm.org, 
 yukuai@fygo.io, kch@nvidia.com, johannes.thumshirn@wdc.com, 
 kbusch@kernel.org, linux-block@vger.kernel.org, 
 Zizhi Wo <wozizhi@huaweicloud.com>
Cc: yangerkun@huawei.com, chengzhihao1@huawei.com, wozizhi@huawei.com
In-Reply-To: <20260725022509.714271-1-wozizhi@huaweicloud.com>
References: <20260725022509.714271-1-wozizhi@huaweicloud.com>
Subject: Re: [PATCH V6 00/10] null_blk: fix init/exit races and memleaks
Message-Id: <178683847329.1984298.4609905343090788312.b4-ty@b4>
Date: Sat, 15 Aug 2026 18:01:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 25 Jul 2026 10:24:59 +0800, Zizhi Wo wrote:
> This series fixes several issues in null_blk around lock initialization,
> memory leaks, concurrent configfs access, and module init/exit.
> 
> See the individual patch descriptions for details.
> 
> Changes since v5:
> - Add a new patch converting the file-scope mutex users to gaurd(mutex).
> - Simplify the last two patches accordingly.
> https://lore.kernel.org/all/20260714041805.1088702-1-wozizhi@huaweicloud.com/
> 
> [...]

Applied, thanks!

[01/10] null_blk: use DEFINE_MUTEX for the file-scope mutex
        commit: 017dac7670909eaea3eb36e6b3b5a8be9ce0a14d
[02/10] null_blk: register configfs subsystem after creating default devices
        commit: c9d293d6bb0575fcb1f3408129453187e2a28a4e
[03/10] null_blk: move unregister_blkdev() after destroying dev in null_exit()
        commit: 4ec26e8885161ce15b66957be638a08d786035cb
[04/10] null_blk: free global tag_set on init error path
        commit: 5a1c5ff3a49ba93a1fd0b70537e7a0164071760d
[05/10] null_blk: free zones array on device power-off
        commit: 2a6357a9b935a34f5508618fee8a7fffbf7722a8
[06/10] null_blk: clean up null_del_dev() to use cached dev pointer
        commit: 5bce98f9e76f62386a3264b9782afb4dac99f31f
[07/10] null_blk: reject per-device queue resize for shared tag set
        commit: 1cdfe2fa62b48728a9b436fbbd3dbe4c11593e24
[08/10] null_blk: convert file-scope mutex users to guard(mutex)
        commit: e3ef4b1b76d6721067259577ab5df54a173d9341
[09/10] null_blk: serialize configfs attribute stores with the lock
        commit: 7e7fff51808237703a3a1df6dd5cae1dfd1db86d
[10/10] null_blk: serialize configfs attribute shows with the lock
        commit: 2cd9e14abece86d790c2117276ff49173b735b61

Best regards,
-- 
Jens Axboe



