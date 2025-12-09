Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1539032ABD6
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765300897; cv=none; b=jQ8QwLY+ityDPgKb+RlYaROe705GPtT3Os2u4QfnNMTrIJxk+8H1eu28LUQw9pLc3GIw2DkGUfYAmJmeXGhpCWfNLlIyqxKDx68yycB77790EmUajgEA7ea/GxJJwAIXv5duwVTTplHtIRYvreCAl0LzQKWvl+aF6AqXRMah+Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765300897; c=relaxed/simple;
	bh=HR70R7VpRgxSmhJlE8cF060Mm3GQkrZMFB4wCLn61Ek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dikddxI0+rmP2lBIC2iLF0PQq6gUv06dG+Q18ZFAcpvTG3PnLp6534ulOMmY23C7hyMYsBq+SMYrxJfWh20fD/DUcVHiyyi067135bgHxaqmEeNRFVliNoVdEeGjm1grDkjNRIkdVDTtc6PKjRFfVbSyO0n3uw4lpwvB+v9biNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yoW9zB+d; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yoW9zB+d"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso4928353b3a.0
        for <linux-block@vger.kernel.org>; Tue, 09 Dec 2025 09:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765300895; x=1765905695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwietJa4Xt1cJ02ixB/T2eOTxw2s3Amg4IrtG+LaYI8=;
        b=yoW9zB+dHzpVQ0kB76mSCvrsQBeI6pxPDRCGwOM2GibZk/EcYnsYTTYMxvBTjzgd3T
         5FYkRUSEwHWutuvbv2/lbfdrTXk8s+0U0SQF3ibtT6wty52BtoWvtRtEzLEsgQvlujQ5
         yR3UjNNHvXx7rw9HK0CWYh6Vsgy2lXnBpXj/TXmJ6gP1ijEWCVO92SIQGcv2NNO4O5nm
         eoRDpjuHBjXBTLnpXxh+f9flQ8kSNMHxL2vi63lxHkfDoUPR8I0n1IYTWd+r54NE5p8N
         dWTV1iuA9s6NBG+Dx1R5U2B7kJIVJ0u183zSMC+xnsj1EWpMk9Du2hUPLOLG1TENCQgm
         qyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765300895; x=1765905695;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cwietJa4Xt1cJ02ixB/T2eOTxw2s3Amg4IrtG+LaYI8=;
        b=ctmUNOhqNXPm45DamLMG8BonmzQ+5KvxRnpnge2Z2VlJEnDx6tJCOObS9Tv8W0keh+
         8sJnSNKAT7DjO7PD4BfXZA1czgi79w9OnXZOjCTK1/fsJ/jCnTMRKKguvtJRaAYExMSI
         6uVw9du320t4/46KnqqBMkX4xaKvg2dzEZiIbCtC3a7TSeZJo3uszZGTVM9Wc4p3taCQ
         QPM46/2bmmw1jVfDbPT49mCvJMpRe2i6/7KnYKdbK511In0Z0XozD98oMYSDGbRAoUt3
         rkFPY+RI8LyDJBIo1XDLOBgLOYLYsULxtAdjl+1iff740RolikuJsBE62zeiV2D13T8M
         eTuA==
X-Gm-Message-State: AOJu0YxXe/sLfkFOZFgi8WCkU4dXrVd44AyIyXtYVDaraUn5ggRD9AVh
	CKyq8CaMYXwbiy1Fw2vRJKAVjINm9liRwQiVUJWYQUt9t1eLKizfxfqbBCODysJeMAsETJseT/J
	9in/u0oItPA==
X-Gm-Gg: ASbGnctv2c6Zhnf3t5hVhWCmzmMJyyo4IE0BlU7u35fBRXUizgEuL9zqUOn71hkLa95
	xfVIaImQ9HkpsxyDRF495tLsYeD2sSKUrWqxx2+qFVmTW1HYAO+SNu9qh2RND94d3arvJmAwc51
	97+pd9soTahzF7qYq6psMIywKBwHf1sy9FyB6Xgh+hi34Wzc3QguWwP9wJEy8RxOTPBQwwOURnj
	kdCX5xO/mbt40QikS8R1gQhGpOJDVuowBEWBWAuxSO2U7KDl+3E3ghVU86JKjznKAI70qgyWT90
	zFX/Kv2A8BoRlDDYexJT7fO4bL8nOkVjjO9XJI1murCQYBCi0FxKEuQcdZsW9B+qsDlrujwHCVP
	HsB7HKf+qIV2Lr/PNR+G/JZSXFMJQBFO80VMiabhck6vx2DsUQWeQDCiTdZZmyjH7s+patKOyva
	+oQ+mrO0WjPsUbzrgkG0QYZpvUb2F2OZS6sXM8hTAcs6DWTQ==
X-Google-Smtp-Source: AGHT+IESJG2Io3EM0m8tS3YIfJuCtzYaGUA6zm6VEFJbV0wTLw7bRCLX9AMXOXA6EVFBVeD1Trp3fg==
X-Received: by 2002:a05:7022:418b:b0:11b:923d:7735 with SMTP id a92af1059eb24-11e03165bf6mr7770950c88.1.1765300895349;
        Tue, 09 Dec 2025 09:21:35 -0800 (PST)
Received: from [127.0.0.1] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f283d4733sm994549c88.17.2025.12.09.09.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 09:21:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251209031424.3412070-1-csander@purestorage.com>
References: <20251209031424.3412070-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: don't mutate struct bio_vec in iteration
Message-Id: <176530089382.83150.18335871238893970747.b4-ty@kernel.dk>
Date: Tue, 09 Dec 2025 10:21:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 08 Dec 2025 20:14:23 -0700, Caleb Sander Mateos wrote:
> __bio_for_each_segment() uses the returned struct bio_vec's bv_len field
> to advance the struct bvec_iter at the end of each loop iteration. So
> it's incorrect to modify it during the loop. Don't assign to bv_len (or
> bv_offset, for that matter) in ublk_copy_user_pages().
> 
> 

Applied, thanks!

[1/1] ublk: don't mutate struct bio_vec in iteration
      commit: db339b4067eccb7fa3d9787d5d3ab5d466fd9efa

Best regards,
-- 
Jens Axboe



