Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0933122AE59
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614644; cv=none; b=lM4vaXfa3H8/MpFK1dGgNtSVCmQxvOZQxZwQ6z/ee8/maUBIdi0QLq5yacps/gLekxY7ev/c3mqVBg4shvc8gcoGztDOfIEopOuUQYtY/vwSMM+6EaNVAKBRTJxdUVIGJixDE8ZFUCp9xF/wh+z8Tz/rtN+KjfhUcSBjcacwfB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614644; c=relaxed/simple;
	bh=kRowGLaCnFK9DFM6f7uMT7JNCKLCEf2PT5kJGF3yYYc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IWOZIqmK+uhFBjD5t8ZvU8783dV6gfTEYOPGzQcygzdUnU//xvxMeG744HVw34RMyR/j9erBg+vlhYboVm4D3Jj8LcQGGB7ufof5ytQygpUKENQMGmN3+cuihq82E2DmeobH32BSe7vS9VF5IObmMA5VhKUBkj+GUoU652+cWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zleemMs6; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zleemMs6"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-85b42db7b69so13141539f.0
        for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 06:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741614642; x=1742219442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUspsaKaBehtCKwT16rXODc0xHUdVxEjdsqpOZ3zIYo=;
        b=zleemMs6gwSf9iH3d7QXA9Cm0D9zd/MVCE+3KpjYFO3zGibKLV0umPE6zqo7/fW001
         ojpnKELVjUVTaVjgjLWXFJt6ZrClCv/tdjm+MEBtgeu8dzMcwZqUttxyqgNjneoY3gGY
         JyBq4X9XdJfUMI91UFYafqAS4hmAQFj6a7EIm5on5i3OnhgAL+u80W9wJOxnATjGOyVv
         BUu2XJJtF7vpqmSBK9v8T2rtol685jbXq6EYRWGRcqtui5D3x+wH8+L3ZLwQIPr2IDso
         lX7fxfJE0uZCOeYx/54UG9Icfm5+yb+ZfcPZTPDDTOaOkvCfKrKY+R6GeANsOrnm/2zz
         3mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741614642; x=1742219442;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUspsaKaBehtCKwT16rXODc0xHUdVxEjdsqpOZ3zIYo=;
        b=TVKRrL+t0iSiBFoVa3k02Y1fCn1YPsz8/D9+WJae7CkaaCKa1JpQfNH38j3F+a6Ad9
         mk7IXLoJum787ZXYAFGihuS3me27n3U5xIcVPial8o5MmXjoh2tZk0msCXVLYvYRJGY9
         fouCkMhdmWQb+Zmgth2eygQqkKI5S4trCwUFPl8blMBiBz/eiSJ5VNjyfy439H9Kc/dh
         BfC929VmpWmsSPoRitcSiI62vqVNVTWovRohNKIz2G6dHn7rFF94E7uLmoF29Mi8N89B
         +rjipddzYmglTBg4azNRHN8rZmAYvw8Rs1YHmM07pvGzwVYGOF+s5UAWowKKuFwlOytS
         I4+Q==
X-Gm-Message-State: AOJu0YwszaCwfh4Een+I0hiZrzLnAqzY2AQIbcs2smM2KgK+exTGNJH3
	cykzAIhBOrBTSIw+gUo0+irzm8x5B69UXKcVMMWJ/8ggXACX4IvTBoPEMU5l0Jk=
X-Gm-Gg: ASbGncvgjb7t4ZSO8YiWfIUOPckdIX/kosYSRAxo9V/Rnwj85HpIrOodAz1duw2e6q/
	G8zrNI7vIAWhy1AxEkqrSmFpUEl2SsW35ztHPRSzT04gsyHNPPv9OtnRpHIhyz2cQqZHAVWNv5V
	cHG/CHjufomr1e1K2h4onirNpk4oMXKFPzmcBmuP6dCVg7Q3S8lG27HHQ3lJtk8QgIrVBBl3UlD
	ohpZpoIsbaIWCqQDW/pxPyu1kMeShXHWXAijesyUbmf4CFGAfvo7XSvOhbm87tRacBSObEMYKhs
	s9DeJ3Br4DrglXwJSDJyhh/0nCMGtR/LNX4=
X-Google-Smtp-Source: AGHT+IFNw1d4zMmcDFKbVYZybB1yEIUzV0WvPzCrDNX6b2PPX+F5muZn2JfFNZcEZIvopidgYOn7fw==
X-Received: by 2002:a05:6e02:144f:b0:3d4:36c3:7fe3 with SMTP id e9e14a558f8ab-3d441960b65mr144960085ab.9.1741614641970;
        Mon, 10 Mar 2025 06:50:41 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d43b511091sm21350915ab.42.2025.03.10.06.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:50:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: dm-devel@lists.linux.dev, stable@vger.kernel.org, 
 Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20250310115453.2271109-1-ming.lei@redhat.com>
References: <20250310115453.2271109-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] block: make sure ->nr_integrity_segments is cloned
 in blk_rq_prep_clone
Message-Id: <174161464074.178937.3099509536865247557.b4-ty@kernel.dk>
Date: Mon, 10 Mar 2025 07:50:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 10 Mar 2025 19:54:53 +0800, Ming Lei wrote:
> Make sure ->nr_integrity_segments is cloned in blk_rq_prep_clone(),
> otherwise requests cloned by device-mapper multipath will not have the
> proper nr_integrity_segments values set, then BUG() is hit from
> sg_alloc_table_chained().
> 
> 

Applied, thanks!

[1/1] block: make sure ->nr_integrity_segments is cloned in blk_rq_prep_clone
      commit: fc0e982b8a3a169b1c654d9a1aa45bf292943ef2

Best regards,
-- 
Jens Axboe



