Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AA93B7757
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476838; cv=none; b=oS+MZlgMuCuWIhjA7rddTEpEUH/4xT2o+cuIdxeCgI5isCPXTl2nm1jbYYRv85+1lC0BNAntLmALk+UQHwZbUk2j9KtwJ9eUt0FicW51zYc7fNGyNvOM75OrySlEZC3pwes0cCng9ELCNaYRX2Fi0w78TF9RFC/UyHtuwdzYjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476838; c=relaxed/simple;
	bh=sme8Hz713zrcPTrgqanyMIM8rXOqa7srde27rwSKSW8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lX7I+epytcVSjrQOPGvyLvMw67H1i6I1EZJBmTB2XO7UPSDRaLp7vOUdCm9qEUsVCO+orgfKXBy6EbIVQfMSp16LY3WT49UjymQlSTqAXugYyeX9oLFshnrazUAeGS5FnlolvmP4HAoUdsewyPTkPk4caRRVNifVJ01WrtdmvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=BP9ZPLUI; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="BP9ZPLUI"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7355e411so24130385e9.1
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789476834; x=1790081634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oft/uvvpYXI8HIkiOt6GboGKEaPXhfLuDuk5H2E2Wxo=;
        b=BP9ZPLUI0O4CTR41DJMuH2nKM5IXI8gv5iPS2m5pOnQ0aV/hLhKfacY2owdEOwAzUV
         UN3RjwWEOx3KlpDglBJsOuek6flvTVdqEO1MRLpgeWX3JV1e1YFUzooIbbxc/9qUhkOE
         iTC0t09wr7OwaAE59TfFxP4o3I4vMShtRMQ2E7I1MFIGkaH4VCMCICXuppOdFxb9IQ6q
         sCFKrtQ1E0h1Wzlzwo9RRN3lDncA5dQqGwyomfBs8xnm+6McmhZrO5UqN3dwnCz3tmkQ
         6PCHbk0wCvOIefzy9NmZFKHihh5vIAFN5yTWo0r9PodLAPE1eYJp/C3YzdaiCmccE3YS
         4KjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476834; x=1790081634;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oft/uvvpYXI8HIkiOt6GboGKEaPXhfLuDuk5H2E2Wxo=;
        b=S6ruZ/2HvoOxmTgwydkHcjPV/huVOdYcYAPhYAWEgA8CWqjP2SFzqAPxGdylTZRlLw
         wvdbTKCAN6XlCUeJQszNeW6OcJBNJMk8/Yq77jg6px9+LkJh0n+ofWYfc3E62N8dRTWo
         5ocWzjDPb1sPOBjS3Kzm52AaXob0NO5+iQiKEG6pkeH9eYdHa2yJnHdHmOKiBuJetD3u
         jCtTV7fKL8YGvYZj4287vTKNmp65mLPxPi5VTYVtsqHqTgY5vmAmZGp+1ZWP0IzcEFAi
         E8ILN8egeYo02KcqkklW5bgrvVMulZJUmqyTaM+oeiK/6AIPhahAMH1U3E8A3z9d31AX
         y74A==
X-Forwarded-Encrypted: i=1; AKwUvBz5xnskx67J+KDwxYflB3Dcp8iy+4F9qGGNupuW6xHHnoBlmLJ1I6CUva9fd+o0BEOfsSywrxjs7CVw8g==@vger.kernel.org
X-Gm-Message-State: AFuF++m41ojUln68gR87n364Ah+HJo0lspeW4Bd1OXTd6a533HoShCG5
	Vps9DUIYRzyujfJGu77vdaT51dtc7VnD2lFZBWZEH6JAazRF3xkPF3fP0PFqLQ2hI4k=
X-Gm-Gg: AYBFou1z0ft/oEae3SIzlzAKoXKfPUF/wikUpcb+2Qf3VemGd82eI/7r2bof5Ri6BoO
	1jyuKFKg86kxxyeaD0MdL5QxZtwtErWwC2vbbE45LDGzI4/LyZXWhssLxb1rcFZmnlo8CysGo8D
	CiUVR4hjB91h+NnB9hFJX7bq9tHHbefOh50hQzAmzM8WOlcK7lfDD6cNZVf9oXZ9cy6deYgRh4M
	3jKY2zPi8wlgLYhp7Nam972VAPDgnfJmyH741blWA2GKm8aILK4bRAoQOxnFCmAcNPcClOM+qRl
	ELfki0VoLL83kBo0Z772BxpjQFhYAPRjMnJ5wBMe7fSdOc4Tn0LDh7RrAW7Atrt2l7nKA6u+Zd+
	DYkm4TYQJXGoGvJes5ZaYm54NqfC3rQlg66nVfKBqfQ2pfHR5uaefnHmdPfij1iO72b1Q5WnE+m
	z+rRd9ewNi4/eu53w7SADMCNSwQ18AAWZ0GALzUuUL9WmCWt4PuxK/QOXWB1nxeXplDu85dvAwH
	YKg5fkdSUgXlj7T5UN+9H/t9+xwP9aSGenxzrYOeNjcWwQZSNXD7d/SHptJ4DGj58stbSccNiDw
	rTLlZmmwhIiV4474CXQT
X-Received: by 2002:a05:600c:3b08:b0:49d:1e09:694a with SMTP id 5b1f17b1804b1-49e7a66af45mr163880085e9.11.1789476834097;
        Tue, 15 Sep 2026 05:53:54 -0700 (PDT)
Received: from [127.0.0.1] (150.red-80-32-100.staticip.rima-tde.net. [80.32.100.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d28c734sm57627925e9.1.2026.09.15.05.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:53:53 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260911233415.31271-1-kmehltretter@gmail.com>
References: <20260911233415.31271-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] block: Fix the thaw_bdev reference in bdev_freeze()
 kernel-doc
Message-Id: <178947683123.1379494.5325444794589226009.b4-ty@b4>
Date: Tue, 15 Sep 2026 06:53:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 12 Sep 2026 01:34:14 +0200, Karl Mehltretter wrote:
> The kernel-doc comment of bdev_freeze() refers to thaw_bdev, which was
> renamed to bdev_thaw by commit 982c3b305843 ("bdev: rename freeze and
> thaw helpers"). Say bdev_thaw.

Applied, thanks!

[1/1] block: Fix the thaw_bdev reference in bdev_freeze() kernel-doc
      commit: e14c3379be86854c203de1e0fdfdeaa0b45509df

Best regards,
-- 
Jens Axboe



