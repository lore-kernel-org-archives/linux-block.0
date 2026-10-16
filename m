Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FF237F334
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160920; cv=none; b=s51d5uV4Xv8x7DXmoWh7apG5zUgGqnbjsvp2fM5B72bMhVgrIl1CBi5sIGhpfwKellqrfc/WdkemnyRUwnQULltDqyZ4XU0oGcqaP5gdagQkJQqEV+vdSMm6U7yJCa0F5XYyPo9fETzbVp530rAC7sR7uaOtevnGQzfDm0AQAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160920; c=relaxed/simple;
	bh=tCiJvvmVqkDn9bBZcYj3gCwhrS0H3F9Qtdp20m+sp5Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f0NHdrlMpbQdk6idHNQZTVtsUZqkrWrRYEo6/BbZx1HhnV4tjXPwbQqQLex0/aBFmiVswpTqM4g/1yvT6kmI1qfasZ9QuOHOZCpHdmt1s3Opxc0C1JLOrWoV5U9HO0PgEeeUDF0e8WMJmn1rGdlr+zKNo2AWtQ1RG8ZhkzLOzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=FHqdv+3V; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="FHqdv+3V"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-354ba08cfd1so10597165eec.1
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792160918; x=1792765718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lZNDAA0XdcAcUqgBVAh4lShInRCyhCpm07d2o6YZC/E=;
        b=FHqdv+3VwCIo2+J09xi+YGOLak1/q7OXSZbyRS8Vl5Oi1QMPJQiA04n3Pj6hT22CDc
         7t3ymWfa8wbsAep8/pc2X5m7e+UwGg/xRAsOYoPhBSNwwy/QPLKf610iOHnwxfV/wc6I
         FajLQalN0zpeqlpItO3ZtQU87+MIhplG39URNEn7F6OfSc1Z//kAthnm25gy1MGUP97+
         MTJw6vR5eSiXGiAguaO8/wkqA3uCziRO6z9iwuhKnM/T9fpdkCTzKJT5U137bgYWc/xJ
         vdTYVcxRhucjvsDaEnLFbiY6qIbaqkstPRk2buvy7GUosej7lIiE9hcMeVhe9gIS69LO
         goRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792160918; x=1792765718;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lZNDAA0XdcAcUqgBVAh4lShInRCyhCpm07d2o6YZC/E=;
        b=ooPR7NgXLv8KmNi7/bj+qfGwTVVqzOruB8IQAvjnLB9xgke0x5O+QSB1zqVh4zf1aw
         hAtoIvKCRxjAZMGv6nAkxpL412m1FhD4wqDF+IgN8vlMcuWfy15QKpv+2+4FApvLM7kf
         vyeUXUZdzaaLBh5Of/YbtBoSl2XnJ660J9uCmucFr5od7bAEH1UUquiG8SrMTSBLX8N6
         4G50E5/WSgj9JJMxPlzd5I+ClJI9KOpRt/gPEFFDHBKDu8vZ2xHbSee/6eE+u9/aSFIv
         zzlSa5d51kaVdElNtY+MbZxm4b+dPdJ63+P/HlZ8p59TvZ7ajst1VBNz6SU/BUyBBLoM
         6SSA==
X-Gm-Message-State: AFq9FYKWizqAxvtRJyLJSB9F4hYpRLUXAVc1aPQ1mXnYK1dR80Qh/TpF
	gSKAPD5l3cOVuC/NnkYEed5jLG3fh9hw7MvEMnYj8kSGQQX+KfgY8BnX4vPhNMNp3ow=
X-Gm-Gg: AYBFou2UMG3f/rnjjtGB65Jg4IBkGDbisTnrgci+3WdKFtNP3U1zQwbzRE+zHsZGyWb
	3BAvZmjKmzzu8lpkqRCcpQGRNNgnpe+BD4VI1Ft1XhdpTTwe9pzE5oRqSkQwTM+lN7wFWQsJuaV
	qUGDCwnJkX7xsG9txbObbwL+WA9Nv+Knc41O6sskJy3MnuGXjdZ5BpgTZrf5za/8Jq7vnwQVYdE
	F1kMpgaBGOiHg+H0VQ1qUlEoI9VLtVcuW0o0PxftRWWP8uC5q61HOitypnTObuJBEaHl35FV7Az
	ecH4zf2/UVTdECGHp4z4mxNxBOA/+pFwBfnf3kgt1LyDcVMpEDyawtq0d9GLC0+bNoZcyEVLpqX
	tZgfnTbIygMMV8PasNGPC8T5ni4+KKcv8Cs9PcPEsxNuhRTDkXxrP3R+//oxilC1fdgpE8mUaIH
	Dj0yxWL361kuesbpJ+ma4U7djhdfSosavTaHvq/ybI0QW8AvyISGdYDZMfA+tWz+H0yoYpjWbeA
	Ut1edj0hC6tF8GWWDZzFMbsTtfP47sFD1AxkmBt16QOqpQO8AOQc/MDhs1KKq1VYZ3s
X-Received: by 2002:a05:7301:1706:b0:35e:6816:fa72 with SMTP id 5a478bee46e88-35e6816febdmr8708847eec.18.1792160916751;
        Fri, 16 Oct 2026 07:28:36 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081bafa7asm7150945eec.14.2026.10.16.07.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:28:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, sonotri <sono7ri@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261015120654.241354-1-sono7ri@gmail.com>
References: <20261015120654.241354-1-sono7ri@gmail.com>
Subject: Re: [PATCH] ublk: pin module while release work is pending
Message-Id: <179216091563.2070939.8848021281402109877.b4-ty@b4>
Date: Fri, 16 Oct 2026 08:28:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 15 Oct 2026 21:06:54 +0900, sonotri wrote:
> ublk_ch_release() takes a device reference and queues exit_work.  The VFS
> module reference held through the file operations is dropped after
> ->release() returns.  A queued work item does not acquire its own module
> reference for the callback.
> 
> Consequently, normal module removal can start while exit_work is pending or
> executing.  In addition to the worker callback itself, the final device put
> can invoke ublk_cdev_rel(), which is also module code.
> 
> [...]

Applied, thanks!

[1/1] ublk: pin module while release work is pending
      commit: afc9cde716b29ce814798d649a95f9128ba42b43

Best regards,
-- 
Jens Axboe



