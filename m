Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE6CA2D
	for <linux-block@vger.kernel.org>; Sat, 21 Dec 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734799679; cv=none; b=V5deBUnN9w1tRlB9gb6qVRtctIV6UElqkpd8JoT6gnky1z5khwgwjzu+n7GSmW67cO6DkbQZu5r3IZFcpR7fnFidVhO8b9hewjUQCP14FKCwRz+ShMKaPk+o+YLgR7wlsyU0uJAFJ01JZX9p/r/1s0HD3RovOC8neGeINLA6XvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734799679; c=relaxed/simple;
	bh=AkieSUP3+EFb1pCOyMWX1amBQSnlURELAh/8dtuRq+4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GBm8pWqq1PlCNbNthYietLNmJv5B/FRw7/RZjg6lI0w9LCRA93P05uqOeyi3aBDrgO+icz07jfFaAlkoO5CLXtkDvIMFp5JYt3EVEgI4X8d4gTFf+jOupruhPvRkYs48/Fpr9x+wYpVxrlbBgtLud7ct6erZt4LsiVDMbD79QXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LbGkl9vn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LbGkl9vn"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-72739105e02so3098396b3a.0
        for <linux-block@vger.kernel.org>; Sat, 21 Dec 2024 08:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734799675; x=1735404475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqC1trSxvTADIeV6lGNwosOExYpHPDcBhyvo3U+HCkg=;
        b=LbGkl9vn/Og5oKCB2ZgSFjuaRmoHE1+r7tN5dlPFrI5aAqaOPpg21WJGBaZLOx/lNT
         mAmH+r/+e26wDrybpDPqDOqYHrW7B7OmFLhesFwaiyYYhRFkiC4hOjlv1MqW0Ip7fH3G
         rifIcL03Mf9Oasp1mt8qz+lo1DfWnbIbOm+KhmpE1U14zvT6PJAKUF2tefN+JEkNsueV
         Whv9CMZCbb+SKJ1dSv8Aww5loo6AYlm7uWw9LNf2NQlPZ1MhUo43n9ZadjzbM5blB1XJ
         7LlAt02LbD3lGTl1O9BqG3B+EMil7rv14eR7Sf4zUnI4DPStz+kCQ8+VX5jTZ4N0NdpX
         pMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734799675; x=1735404475;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqC1trSxvTADIeV6lGNwosOExYpHPDcBhyvo3U+HCkg=;
        b=Q04WsMJFgdkNOVPZk3TPFoX7WJGm9ETl1Vz2REr1KyhBSZT13IKXTu0aXbBmU/wjJH
         Kbk9FEUzLZaJDSMmoPbFpRt7fY63vnGiJAMO4hAEz2AmXzZ3bmcwLcw6Q5fAMk998SVE
         /nk/4Uqs7a5lFQ1RNdAi6qOUhxx2sxohszx0+pt9Jt7XKuGlpQWNdKguQCSrmNpWMMPO
         MQSAh69kLAVfwRMB1cVlVO6p34zAsItm+y8M2KmBFkin6+oBwQlQtu7kJQ+HZ5c8Sbp6
         MXtaPLX7cJgllKzcOIEmLG2Ri1lkdKKB7q6P7zSCS4vxkXO6Cpl9aUPXtVeoTyGY1I6K
         Qt/w==
X-Gm-Message-State: AOJu0YzyS2DRhLvxfVJHmEZ9487OoH5F7iMgJAeg0sz/GPAf9HZKkJFV
	67ZSKsMp5FFVop5hPwc9Xlgw5TlgJeseSdyMnoRTn8pVO6+IAvGCBtnqldh/hxk=
X-Gm-Gg: ASbGncvOaGWNzKXca+udkzZLt02jH8fuoUm/m6TgzdH+8lHpVz1lTG3KJL+OS+iS6zS
	JwhEmsWWB3Rjxj7p7iOEmOUxrozhU0TSyrVi8BzHQ99pAEHaAqBn+boAROGngASICIYSpbO8tdn
	uwkRXmlV9DdaQFMIWRoqXFMmCZOtmv0tjgx8cBJaMxb9d73KbNzGfGaJpJrvw8yhr47ECx+RZUk
	ez/spfPhIxyFX3Ig0j+nF1DZInH8ZlecxDVl8Vf3OEk0eup
X-Google-Smtp-Source: AGHT+IFSJeFHa6b97DG9xUBC+3b4tqpgc+k1OOeVNvBN536IR+cpkGiy0i8pxEHG5Rx/mN0ariBalg==
X-Received: by 2002:a05:6a20:7487:b0:1e1:b023:6c98 with SMTP id adf61e73a8af0-1e5e0482bd2mr12326220637.26.1734799675240;
        Sat, 21 Dec 2024 08:47:55 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c2bfsm5113438b3a.188.2024.12.21.08.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 08:47:54 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20241217210310.645966-1-bvanassche@acm.org>
References: <20241217210310.645966-1-bvanassche@acm.org>
Subject: Re: [PATCH v2 0/4] Minor improvements for the zoned block storage
 code
Message-Id: <173479967405.1178834.15586356455960558944.b4-ty@kernel.dk>
Date: Sat, 21 Dec 2024 09:47:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Tue, 17 Dec 2024 13:03:06 -0800, Bart Van Assche wrote:
> This patch series includes several minor improvements for the zoned block
> storage code. None of these patches changes the behavior of that code.
> 
> Please consider these patches for the next merge window.
> 
> Thanks,
> 
> [...]

Applied, thanks!

[1/4] blk-zoned: Minimize #include directives
      commit: 812047bc7e7754dc9d9a9f42685a006f064cd16a
[2/4] blk-zoned: Document locking assumptions
      commit: 27eb21b36c60a3986cfc7d374f066fbdebb8b3ed
[3/4] blk-zoned: Improve the queue reference count strategy documentation
      commit: e3d334adc3aea20e3caf16d408c1f5b04a59eed0
[4/4] blk-zoned: Split queue_zone_wplugs_show()
      commit: 736a8772092fa8e3a87bf8768e47d6bc1fcbc149

Best regards,
-- 
Jens Axboe



