Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA7E39E17E
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476839; cv=none; b=LMjEqgmXb9lJnVzmJOpgD2lKcfzko4TMjtSHJ+xwgmyZe+mmIIXUWdEg9lu8JfJhxRL5K5fBCQ0tU0sL1vDxvshd+jklPz9ZBClKH6ijFm3JdYOXZVlg/FCBP6YhOXxujU4bFH6GGbHTWAkYcwVUYy/SZupqrmSTTiskaZ5B+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476839; c=relaxed/simple;
	bh=e6w9+qMo3PMNQNfp9di26W28Drrv9B0AbEt6Wnc3Sio=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mNMJW2MRtlAm2k64Rg+NnwtvtmyYalW+uXv33jz/1K9w5ZGldhPK7rj94bhaLY6hcg9sJbmxqv46bDrS18iK2DTtFKnjlGtHgXpw3PRsSQ0b2XR7hA3p1/RlAbMOvRjeMLXaUkUi/bKet5kohmRmOVpfXmUEerzDDZWdXcjtKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=HgmV0BqU; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="HgmV0BqU"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so1862175e9.3
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 05:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789476835; x=1790081635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWHRuvOAbmWsxt2kIgU8wtQ7/NW/VEdSJYXzmDRyABw=;
        b=HgmV0BqUpxp5dIqaXqUyEpHa8lx/bbmD+ckXt+ZaoRMUFMo6qYeqiBjN56sYA/5nu1
         zl9aAsfE+P8DG5aw72s5LQXkvHcp54DiGn2ynnCaRda4fA7xAXVLkzfOPQ9gezJmyZdx
         tSGDi1eAh6a8fQxwEur9VXyjh02rLRKuAUeqZINnsGosTef0f6/yDUIta3szk6HqhuvB
         t57Ufx9HvFv7b/YnsBp8T7ccKH52ZXhF6qSjR6JFLml57Z/AKUa67cGQ2a60zGAemb9i
         kMODhLhzw5VuZUf3I+cdYIRQmSPSlUZEP+FjMTPhsW8trenUhb/dUXivlfYYVyUQKfz4
         D51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476835; x=1790081635;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eWHRuvOAbmWsxt2kIgU8wtQ7/NW/VEdSJYXzmDRyABw=;
        b=UhlsSVKKkFVhhmXPl2ZZv2gKvJCp8/jMszDto2jswYg7E/w9voCIUEzvUxh5nqOP9v
         Zxf2XkJt/Yr59vDW9w9t5hbpzFISLdBZ/6OmB+1k9y8ZGiMO7mlZBHp0Tv54nMhY3U4d
         WO9natcmNUNQVESjQuTXEOzRAZjpyRQNQqNxQsamGPsm1jjx91YMP3G044XK42VwxI2Y
         v4aw8JSNv3Y2mWKhH2L1f70n3g909euFwZUsfVv00C7IcLzmtd1Ir7jGQdscKriAcyBE
         /BRR3uakhnqsRYQyOAFZvYYSLo+rR9KqapKhPTcwsXDtXH0FUM+mbMlfPZFHurpSxQTH
         YOnw==
X-Forwarded-Encrypted: i=1; AKwUvBy1KaG8KjNgdQL/BARx2zH3sh7z6xt1CBVkjgLvJQ0dgqGUVEK4iej7GAVJQEWnNE0Euld2K0bjsspXPA==@vger.kernel.org
X-Gm-Message-State: AFuF++lKF+kCrMXN0rNasX6X9e7nFOP20kBBkfDvkcvCs0wCkCE5nXi1
	fMDR31Zd87f14CqK/bH7Z11jaqSC3Z+of43yRKOqjy+54SbSpO8mBrbodERxMSszVKHIEeCbdem
	UUsU79CRCNQ==
X-Gm-Gg: AYBFou0EcAbTt+byTeehc/PVKpY1v4ITpgdwAulBZrZCHHQce3t2ELoGcyNEW35Thy7
	nhGX8sd5Bj9s26/jELeJ/a1Hy0sdm7tgSPjhizLqm2RQ0SKnIj7nO+WRrJMnwmvMzsN/l6vIg3Q
	pHnh5Bocouir3fT3fuJTaEudyVymH0xVMZicdnPGBk7J25EhSG72eLjwgfaW0QjmLFS4yWemMeS
	ASM5JWMjL8ZTAnB4wi+hzm7azrAjXAWeGQsE2P87SNT8H0KKYLxRf4D74d/M/8DsNTHQmTU//XY
	dw2KnvWSBGNr8AtSdHo8nKLnagT8+a9r/DBsHlnfPNgeLZNbQL3T4btI8P5n8qR/LnqSDqQ+zl8
	mHfD1iL6duovsnplDqliHyp91kBEi3oOAg0pj/v2RaZ1GDUhvqwks95opoTRY9bMYZ5gZ2ImAiF
	xs8SvnPqkXBbrAiMB9Knuf9m6NYI1XktnBKG5NvCnGNVU6No45nchfAhKuMIIbDpmxla97TvRRr
	c++zQQSIU2gMONmS7n2L2neUUcts2POWqxnO65sjFnvFjj1JzsetXv/1oLvvziRxEzVL0xYADmp
	W69WRLW+VC/iW9pYWpW1
X-Received: by 2002:a05:600c:b85:b0:49e:6bce:b0f9 with SMTP id 5b1f17b1804b1-49e8228f49fmr13107275e9.16.1789476835329;
        Tue, 15 Sep 2026 05:53:55 -0700 (PDT)
Received: from [127.0.0.1] (150.red-80-32-100.staticip.rima-tde.net. [80.32.100.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d28c734sm57627925e9.1.2026.09.15.05.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:53:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, John Garry <john.garry@linux.dev>
Cc: mkp@kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20260914132323.208321-1-john.garry@linux.dev>
References: <20260914132323.208321-1-john.garry@linux.dev>
Subject: Re: [PATCH] block: cap atomic write size by PI buffer size
 constraints take #2
Message-Id: <178947683418.1379494.14484478143133588908.b4-ty@b4>
Date: Tue, 15 Sep 2026 06:53:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 14 Sep 2026 14:23:23 +0100, John Garry wrote:
> Commit 1418b5633ca9 ("block: cap atomic write size by PI buffer size
> constraints") attempted to fix atomic writes limits according to integrity
> limits. However, it just reduced the atomic_write_max_sectors. The other
> atomic write limits - unit min and unit max - are not derived directly
> from this value.
> 
> Update blk_atomic_writes_update_limits() to properly set the atomic write
> limits according to integrity limits.
> 
> [...]

Applied, thanks!

[1/1] block: cap atomic write size by PI buffer size constraints take #2
      commit: 657fe9c4f08355da51dc035547f221be3e79454f

Best regards,
-- 
Jens Axboe



