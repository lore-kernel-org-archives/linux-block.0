Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0E935A751
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485713; cv=none; b=He1i/90zXthev1GWfEYb34o6RMYJpgmnSO0YnAHYBE+JDSBit1LzEBibgtb330QKPz5UM9Ws+gEgZXxm9x97cwsK++6k80U9rRLlfWY6KucC8335L8rEsUSA3BwACaczCCmGbbuhxCfhYGRxXzbelv1kbcHcxid2aGDKY72k3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485713; c=relaxed/simple;
	bh=o4dmr7QeNk6BMAJDX5IeyPT/JPkokyGq6C8SqU2UR/M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XCjsqCXRRv9KpvWKKTpdpiGeB6utM9KRBooumhU6hTz8ImSwh2m+CzqEn3iWO+LFBNRQtjnzjKBCqp+Q6qd2JL3I69JIkqsZMEg8mngAMvSXUW+vIinwp01x5ieow7T09cXSydFDVb57C7loTGbmR+l8j911MGEhINohT0I4CkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wv9Dbus7; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wv9Dbus7"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d817bc6eb0so15895525ab.1
        for <linux-block@vger.kernel.org>; Mon, 05 May 2025 15:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746485710; x=1747090510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9IWRogWT+IHbngw4rVJPf1yqVTJMP/POXHV9mjNlM8=;
        b=wv9Dbus73jy6Mm6xL20KyvmYpfzIX6HJsbfIBUFeLlsJpFnBc1LuN44v/oomA5FiR2
         hrTIR+hsTIC/fcDcOzHUTgPJ3csw/VXKz2pjj6vBhINPmSz58JXvnQ+kSG+ABruoVh2o
         D08giiS2eiYqPSDNAjf0B++kBzB70e7g5k6APYCVjcrX/DIgNCE/+FlTGTJb7RegqJ5u
         nPLHJUix55gJQiOxb6hYyz1ljpPgRi0fGjdhyTZxBNuS+zJ0wiDm5zNt/ZQMi+znEdPt
         aooaSY6e4xkm6+ZHGGUtTIPT3qmR8HU/SXe31XrsI9QjRquX2OClByMyMnR3Qt8B/BP6
         hufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746485710; x=1747090510;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9IWRogWT+IHbngw4rVJPf1yqVTJMP/POXHV9mjNlM8=;
        b=EeR6EZkuWcwkAUG1Yrejwa95+1DlrkefCegI+1+qtXEzJfOqt/+Tp2RjK7/CZaHr03
         aRC+vl6OJedBqgMYX2cS8LEvwjrKy6MaByCsAo3tY0AA53XsZ9D5+RJqFXWufu9KC/rV
         i4FOqUTLrtaq2Da98L1/iktImSIEj91XeH8uDMIz6NLsCRMyOBD1ReznAN+mkuPZPhT3
         JRKBmls3kJASx6WlZjJzNr7fXdeB++LT3Y4nKMQBbIo1/OXGnt+vJ/sHjJPnlXmg85dc
         mERCSqHHcdoarKHS9x5uFcfzbcAMEy20SOqW0e4mT1TOVsqxhsUDtalESV8Ct/TPAJCz
         cxMg==
X-Gm-Message-State: AOJu0YyJVohrRuRfftQvhE0K4EfYQyFXND94JUIUmftZjV9ZtaTyi1nm
	qV9ERML+t2GQo1DmyaOrdpRvcvyzJpH/PK6+vWBJxQ08Xiagw9OsNmHmZfwYvfY=
X-Gm-Gg: ASbGncvTkTplpgdbWmluFF3ZQl1qiIjxqCszhaL5TU+vc2Fr+qUvMadxT28c9seIYAX
	6n2UyNbpwOl05W6uZz4a60cbr4mZcsycxIK9/UTao8huWYVgRSx8sgTRvHpZnI487872/I0EQn6
	LXujt5+wiZfYesauHtIn9XtSuEIqzupCRvVUdhltT6yIm8b3RTLGRMpfPEYYAKhQ7/pOQJRxx+q
	zbcuHL+7aoCk6JqPGqiGWPD2E1CAwgSoDDs941poz6imksanDRiYCyI9Md6Ndsb6rcsb/Y9KCZy
	BxWaTXawEUK193sf97Phztaq9esDd5yx
X-Google-Smtp-Source: AGHT+IFpcNPaFzZ/vhh/4FSViYGaK4KRsBfwCvdYltBjqw6DGBuUksSFjecGP6VWziUl79QtWsppOA==
X-Received: by 2002:a05:6e02:1f81:b0:3d9:36bd:8c5f with SMTP id e9e14a558f8ab-3da5b2a02dcmr79548175ab.11.1746485710125;
        Mon, 05 May 2025 15:55:10 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88aac8004sm1921031173.145.2025.05.05.15.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 15:55:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Caleb Sander Mateos <csander@purestorage.com>
In-Reply-To: <20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com>
References: <20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com>
Subject: Re: [PATCH v2 0/3] selftests: ublk: more misc fixes
Message-Id: <174648570900.1422154.9689058645460558381.b4-ty@kernel.dk>
Date: Mon, 05 May 2025 16:55:09 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 29 Apr 2025 16:41:02 -0600, Uday Shankar wrote:
> Fix some more minor issues in ublk selftests.
> 
> The first patch is from
> https://lore.kernel.org/linux-block/20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com/
> with a modification requested by Jens. The others are new.
> 
> 
> [...]

Applied, thanks!

[1/3] selftests: ublk: kublk: build with -Werror iff WERROR!=0
      commit: 3d6ee575d0d49be35dbb787db4d05bdf94e2cdbb
[2/3] selftests: ublk: make test_generic_06 silent on success
      commit: 254827a32118ddb171680dc2143c777cc68f2cbc
[3/3] selftests: ublk: kublk: fix include path
      commit: e371b9d3368ccb6b55fe9747be12c3107b2817b3

Best regards,
-- 
Jens Axboe



