Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7418BC3D
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210763; cv=none; b=JCv9ei3ZQkIuBn6iO5alXf1cEqDZs+nF1vY95Z5PH49NaMSVWzLWzM8mB+BEWgRF6k+pOs/aFJWNhwho6C+UV9zUbSzmYGe3gXzEwxk5vzNfNAUprK609BmRQ6FeYxHSFWzPYrRPGMByToM48EfZgYNiXMAtAEfdLDjAj3ft0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210763; c=relaxed/simple;
	bh=YraavJsaLN9URd3LPj6XhlPbEyOprjT9eDPAN83WTvs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CrhTOMp5OJ4v2D7V0zcyl4wrstWIABO5dPLLp1NL65fCkLAdWVcTqpieMzj05ccB++u9c2B4+fMHGksHcL1unkwdjqTiGnbth2qAVZRmV6EaVyKT0SQW9eFnh4pBn+PuA+Vq+V2BEnd8qq9jYZf3sP9irjGSAk0WDWvysI1pYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xmIebQH3; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xmIebQH3"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-899b676b5d2so29014026d6.1
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 08:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772210760; x=1772815560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Qf40BBS3ytKOtSwy2EBWxHko406dzIUXFnhbArPU0s=;
        b=xmIebQH3qVZ3n1QZCVN6Q4WyPPXFcierZujxObPfyeBtLGb+Z37yNgaIP3i+6qLM3J
         Odm0hD2q22hCMFWUU0gGULGULoNU5Tewlj/YNT02GFLludAGrOtl9bMHWs25Sy48FcQO
         d5EaeRdGByaHPWHCJzBzWKUFhDub+cszLGjEZebV5XNyY6ThQVdwKRfVu5iUZp/pY2ug
         lA1jLRZiwVBArcupQJlXl4oIXd/nyZ0neGlA7LxZmoxCpXjGWXCh7silcQD6ftiw2KhC
         kfvO4dKu5U1lWe7TaxIlhhvtKNHjI6npi8KKSA4+His/uUBrPh5JKyohiz+0Mx1mYQjg
         De3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772210760; x=1772815560;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Qf40BBS3ytKOtSwy2EBWxHko406dzIUXFnhbArPU0s=;
        b=ScKr0az/etQPi3K9EE1LqSETyC2kpoOrR3QFJ0fYCHpbHYoy+rq/mNRxxaEyOZOfIU
         2XJ7xciJTOzeVkDFkk29aHwnbfwqDjrTtBb/lcy6fcjqlv9JZAgtwbhTZtdhgIFamvD9
         U/7Zx0qC6RK5wS6qZ4FeqkcVXmvqWl9Wu9EDAfb3r0TIoiWd3NhWMnQ7i5CJDVkz99bl
         aNgWxrZxjn8pdr3HdObQScAdeOR+YRLOv58vDK2lktIMFCkuqWfKCgYwipPOl0ptkcRB
         CA8C+5a4/uG+qgKXnAtQgoCd8m6Hyw12UklKk/W4sD9cprnUj719Rchc/j+lx7hEShYP
         UKdQ==
X-Gm-Message-State: AOJu0Yz/bG2SJJBML2sVO/L+W0/luWezN0LuDDllCbQpkXTLZyofsoH6
	trP5DHHOnjvfXfYm4dDdd3zzNGRso9w/DaxOFqfu91ujm5o0cM5pbANcV51GOAobXSNcaU2E17W
	6JfnA
X-Gm-Gg: ATEYQzxk/RzbZrS+Uu2e3Rcon+4AL8hqDDgoShooj3sAVuyc+b2GO/O9emRzGFvBcQK
	bOToxO6hLMoTuvpyLqjduh9iMX9qNp1ZWY3800pjVnVq1j6ikGyFy4aeStytWjg9pxbnj3R34BP
	R4fmEXg3ras1jilhYvykM0zs5Gn/h7k7OtX0Exm72VmxT1chOIntajvaFqoG8A8KItkZHSHjfvj
	PM4dDpbzL4rQeBC99aHkDxvmyuxMp5dnOFWwliCYDKkV49C3bXEmLpRyJkIAQlJMUcFdsMmdfmK
	o96brOVFzSaB2Ty6J83rd9RptWpTYrLn4jANehQxbR9rs9WB2PN90iVN0eJLbQF9LEkrZaFfDGI
	IUBKl2W6D8G/MZBfu/Fy6XRt8DaM6cMG0UK1ZA8PiI/4+tOq5+e5pqseHU1doc3EHQ/ufcPL3AH
	cLoUVU8n83FY4GLbpJn5Zy1nBkskyHm//urTv4w4q62ed+Pevr+/e5YLteOxx58lahmFCRrSE10
	l4=
X-Received: by 2002:ac8:5f4a:0:b0:507:3d1:e4fe with SMTP id d75a77b69052e-507527142b7mr44420791cf.9.1772210760357;
        Fri, 27 Feb 2026 08:46:00 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449a66f1sm53611171cf.12.2026.02.27.08.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:45:59 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20260227131951.2464150-1-dlemoal@kernel.org>
References: <20260227131951.2464150-1-dlemoal@kernel.org>
Subject: Re: [PATCH v4 0/8] Improve zoned (SMR) HDD write throughput
Message-Id: <177221075911.1149491.4524149342491662979.b4-ty@kernel.dk>
Date: Fri, 27 Feb 2026 09:45:59 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 27 Feb 2026 22:19:43 +0900, Damien Le Moal wrote:
> Jens,
> 
> This patch series cleans up the zone write plugging code and introduces
> the ability to issue all write BIOs from a single context (a kthread)
> instead of allowing multiple zones to be written at the same time using
> a per zone work. As shown in patch 6, raw block device tests and XFS
> tests with an SMR HDD show that this can significantly increase write
> throughput (up to 40% over the current zone write plugging).
> 
> [...]

Applied, thanks!

[1/8] block: fix zone write plug removal
      commit: 6ff36afa5eaf22db6c7a8b43d7bc7fb55efb8822
[2/8] block: fix zone write plugs refcount handling in disk_zone_wplug_schedule_bio_work()
      commit: fe2696d207b4d8da382fa6239a4689b68fcc0cc7
[3/8] block: rename and simplify disk_get_and_lock_zone_wplug()
      commit: 9fe9d5db6e28211eb1e93be584ee538cef8ad242
[4/8] block: remove disk_zone_is_full()
      commit: 56d54df82aaef511d7f6d716f761202f67e3dd05
[5/8] block: rename struct gendisk zone_wplugs_lock field
      commit: e05624be8150a73a25cf8612013b2847c0a38459
[6/8] block: allow submitting all zone writes from a single context
      commit: 2f0d2401a412ce84929c369240c1f900262bc96d
[7/8] block: default to QD=1 writes for blk-mq rotational zoned devices
      commit: 904100e435d1eb71dfb3d9ee5ac6ed8c0b7791af
[8/8] Documentation: ABI: stable: document the zoned_qd1_writes attribute
      commit: b154532ca0f25ba89bb3494dc0ae1a8f17bd83cc

Best regards,
-- 
Jens Axboe



