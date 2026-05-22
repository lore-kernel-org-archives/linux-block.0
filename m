Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3AF41C2F2
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458770; cv=none; b=cd24xaKsiNmMHftG74BVFiAbUF0IDlSHel7LJZgl3YLsWOics37TbaFtMjbe+lAJBH9l4BiZlAwFiyHHhBIJuAgiqoOv6FRC9SLWXD1coIrYRsUHvcgFH16yEeEOS5Zx178pIXOWT6HbtKVCBWenzAPA4GDeAcVSNVJzQ0tVeAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458770; c=relaxed/simple;
	bh=RKf4SJP//pUgs2fFYiO7wQADQ7h3MuKCkA4umIzoOV8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SjYvaQVDA+CLlLVCRmdz772Be/hNAOtXOGzoZJH5gCVFvG0cIoq41FkODzJU7ERGY7PaRRHAablEB1WAcPHhmcKO85hOf3H7KksffjZVFa5XU+inMVeBGhTjxqBHyryh2dKltIEgroeK3QbATqKnUg5+DxOlLIGVHqaPVhBT5G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=N6Fuim3M; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="N6Fuim3M"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-408778a8ec4so4509127fac.0
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 07:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779458765; x=1780063565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsAhZciPltskpB+CH+Xn7+a5Hugw+ATxejWcisf+UfI=;
        b=N6Fuim3M7WpKq1ac4h8aGvtDGr5SwUULxeyOmAsYwk2QawUm2HdKo7UqjW2Y5lUoSb
         uNo0NRqXCZo+7LbVJW1NfzmVVOmaL7E1FRiT5tyiiDRqlHPR85PCeRp/XwzSbgLIwMpc
         IgciMG23yzxRX6zPR1DvG2+jyOTzzU2+KYAHxZuHvcG7eIRzGTf2IKVnb4tT+uI1r830
         yIFqVVto63eNsVby4KatHlDNDanX7hSVqzRDpDoNjAsmTdQFf1ENLysrwBFtd+8s3d1C
         E23/COzs/cpLGXABAiYAbDNOh9e+6rsQMRfMTfvyomGtiThuXTkSYrYxUY0mA/iSRg3P
         xO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779458765; x=1780063565;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IsAhZciPltskpB+CH+Xn7+a5Hugw+ATxejWcisf+UfI=;
        b=H3hCL/dEmcdlU4OMkOEB5HYWvLtD0cxDjHwtbFtwbX4w0j5en8Bs7FVkikykll8oA7
         UYyB9m+kYYiE/2rQx8+ONMBC/KOxzUY9jir/bv9LVvdkJU6XculdYeFtwbP2fpNBKgAy
         WNmGtM7CyObsbdEmRoRaqd/2m4UqZKNTtY85uJl3q4HTFQJj9EWMcip7YxJschJzkx1S
         HT4Cz8d/s39lMrATLfRueZ/wA8sXwknp1ReNjWHqmnXUpSN2ySnoGUMzhbuwc7QT4zRw
         I+euZPsudrXQ4pH8jR/TiqjOXhrjXKhl7cE5ww+Ot9mNogvZ74xCIpq7ECvv/FjWi/SK
         fajQ==
X-Gm-Message-State: AOJu0Yy6vv63xHK/gijURWMWjuU6VBoWHZSJKSCr62EpzjDvDhuuXVhE
	W67CocAl4XBfu0bg2vlokT2PAY0FUNXoJI+gifY67fsI8V0abRQP9U1aVOqZoBUKpIw+nW3QwOx
	w43Kp
X-Gm-Gg: Acq92OGneIBEHGAg/LPNq7la7He0lfK4gWdjR7Q3uuQlTM1HzFcFssoIco9O+SD8sCs
	3phQt4a/CAFT9Wg3eRkK9oYmrzwIHEIvJ5SUMzkpuy99toQwY2RPgfFcjM1gI6BUMpb6onobcXZ
	XhLFF5uuiuGKuKiHSeHoOqWa4zu2ntVON/P6QatFzKccspSl37CXtTmfjCF5Bh1T1ePuD0jm1v/
	rBSagOcJLrSUpM5gE3Yi9WEKqfLTHXEEQ4uwx0JMEMk0OoRFysDW31mhz9MXLIdM10NhcdWnvXR
	/96ixVnfkMbc6CT9NBL0LXuE685luR6Uu+HCBfiD8sFPDEilxJ1hH1ueWDqzr/vF+bDMcHn7fre
	dO2+KHQGsMHWkRQXy98bIGZT+l/oP7m5sG4b9syZNmLhMudc/JgmS5+hUvA0fJYG/Zm3BugPLyt
	ICeVBBKxtveS+gVo6OzxHdLzW8wgUC5a7MJtOrk53ZtWkBOFl9JI619t/L4zO3wyCSSf0alFRCo
	fc=
X-Received: by 2002:a05:6808:1719:b0:482:c65c:457e with SMTP id 5614622812f47-4854a0ead12mr2075770b6e.11.1779458764983;
        Fri, 22 May 2026 07:06:04 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4855476ab77sm554972b6e.17.2026.05.22.07.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:06:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20260522115622.588535-1-dlemoal@kernel.org>
References: <20260522115622.588535-1-dlemoal@kernel.org>
Subject: Re: [PATCH] block: avoid use-after-free in
 disk_free_zone_resources()
Message-Id: <177945876373.102352.8012707488920137128.b4-ty@b4>
Date: Fri, 22 May 2026 08:06:03 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 22 May 2026 20:56:22 +0900, Damien Le Moal wrote:
> The function disk_update_zone_resources() may call
> disk_free_zone_resources() in case of error, and following this,
> blk_revalidate_disk_zones() will again calls disk_free_zone_resources() if
> disk_update_zone_resources() failed. If a zone worker thread is being used
> (which is the default for a rotational media zoned device),
> disk_free_zone_resources() will try to stop the zone worker thread twice
> because disk->zone_wplugs_worker is not reset to NULL when the worker
> thread is stopped the first time.
> 
> [...]

Applied, thanks!

[1/1] block: avoid use-after-free in disk_free_zone_resources()
      commit: f6982769910ecddabdb5b8b9afdab0bb8b6668ac

Best regards,
-- 
Jens Axboe



