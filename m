Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13492DB78A
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770894331; cv=none; b=b3BOmEC5m0J56x+cLc52T5WdzGYDfl5fqpTVEgx/UIz2HP46yt84qohiuUTbCSN6V7pANjfAj63lVr/VgMLKoi5a6VD4gvt4m37GQ9yWHpSP7A0H6XmnJUcaGPdWCn3SP6HQqK25YAUZWB97puIKiix1nNO754/aTPjzveMgbWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770894331; c=relaxed/simple;
	bh=cTyadoJRVfMfmXBNQrJrUbQR1ZtoThlCTFLO00VnVio=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=f/QyBUt2nGQm4/fsmb7H22f9uqwWLfeRNekFq+ZdqhPiESmPuPZV+/a9IhuImq3UhCg+RGfaL59iKBE/DN9MiBN+p2YOeeFwSLkE78LJIf6nJMBs5c9+jI42c3DgilGZ8O1bQxbww6XFu8FhPR6DECpvzIiOtzDJLk9pMn6I1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ySQ/uybb; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ySQ/uybb"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7cfccba483eso2709245a34.0
        for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 03:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770894328; x=1771499128; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMo7UYfozPkFUrgCebyxKuU+IeMfOcuvKg/mZ+fIKUQ=;
        b=ySQ/uybbTMuToX1gn4aXHs2CSajv9x1W5q+6VBGhoViUOLrUKGZGnXeftpyCHNqoUF
         l3taAAT63nBiMCKBT+Oj6RWeX/M0eiDBh8fVy2F7wfWzsWVeNXwW29IuTeeSiq11y/Px
         mjSCUaVagcPVdjocv8eqXmr6ZxQPryt6DC+IwUocNifMnrH/0ebAXhgYKe2lPdmYraQN
         qIhiTjaSPdipBt/ZCbbTRyAw8pmp1hXfXXZj6LUUgWhaS2WLpeMggUUodlEbFibrH5LF
         VUYDy7n4Lhb0lumQBjnzfUOTXMBhAUxojeIat0l0YgEOaP0gaWsg4Xf6oS6uEl0mn43g
         iDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770894328; x=1771499128;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nMo7UYfozPkFUrgCebyxKuU+IeMfOcuvKg/mZ+fIKUQ=;
        b=rSUs6GRTGFWeQbZADw6aRAJyCNaR0XeIMKFuCJ8SrTH6tIh4QOSUkydeAaxt/l+U5C
         ZUX39+9Wn+C9BmYHrBhG5yAuhA85CCO/n0fNhKKQFE/qDeZSKP/ZIkreCoMjXxeirZND
         HGXzZPjUqzpQCXaNzgurrxqaAfJo4Jxgkc68PUHzDVphVZ8xzDzzTCibUA09botzKzhc
         fp69MkqfYddMT/ZIe2knbTxkTZY7NMFJ0Gn3l7ztw5E6Y7vPx8LCTdbOOuETxymneRLw
         Sm6w810kP51MNDrcG+IIyDBhL81Rq+rY3UPgpbkQ2WX2OQVVQot68W9et9dtgNpJFVqZ
         cAxw==
X-Forwarded-Encrypted: i=1; AJvYcCWKZHF99sNy1oleBNpYHmvZe1BFfDfcVnJKw/kqZB6XIJONtkpQLE5QdFrAPNohaMfMWeRDUJpCzI9MBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyRHWYv3jh5FSVl/o8czGhGI6Brn9lbLkkl33wv/L4XEyXd4sf
	f+Xac9dI3fLfobddtcOwsoaXc/k9Pwkkj/w5YBmfO6T0U2Me8n4Tcp7cLwLaTv+IYdY=
X-Gm-Gg: AZuq6aJnxAzf/5BhJK//klI8E7vtJsALHD9/cVp7brSOWxDHdjiYAFGPuldoY/6EM29
	H7N5FKgD1VD6x3PZhBa//TIs4lylU/7ZcTpaHsoumorysYI/slLDIqNEIL3juk/7yZ5cljqFZJ8
	uov1rG5xbkzULtNRUCLT713eWqUZ3y3kpcbg9LCzP3k7SGmdGCC7bC5WA1dw1hP+VHB1hKnCakS
	HHAlFw4ZbfA/l+uOKPRasJi1BU0A+2IXMGD07HL62khQ0sNOkeiPtglZkYizQZJGPt06cElXEaC
	aP7dNY4CGp4Zqf6F2RQjVc3609NGuw4G/uIJVKV8QiIU1Wa465V9XAddxZg12Nfy62M7fu3Lsko
	Pe9Kcv9x39dZ/oOp8ctxZG+h02KtBYRl8h9Yhfc2YKoYL/0WcE9yVZT9n71LxCDKU2994DMv4Pp
	5t1PSPbfaQd1xb62CdYPhl1lMHAD7Bq7ma19ZMewem8KoDyy9hQjKK3+kjC9jhIuIfztmgVJOk7
	yLLopDaMs72v/jYDtPY
X-Received: by 2002:a05:6830:6b09:b0:7c7:58e9:8e16 with SMTP id 46e09a7af769-7d4b2a0f50bmr1157120a34.14.1770894328557;
        Thu, 12 Feb 2026 03:05:28 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a7530a8bsm3666324a34.4.2026.02.12.03.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 03:05:28 -0800 (PST)
Message-ID: <0535f4dd-ada3-414a-84c6-7abc232aa670@kernel.dk>
Date: Thu, 12 Feb 2026 04:05:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: ublk invert part scan bit logic
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

For ublk, there's this logic in in ublk_ctrl_start_dev():

/* Skip partition scan if disabled by user */
if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
	clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
} else {
	/* Schedule async partition scan for trusted daemons */
	if (!ub->unprivileged_daemons)
		schedule_work(&ub->partition_scan_work);
}

where the

clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);

seems reversed? Why is GD_SUPPRESS_PART_SCAN being cleared if
UBLK_F_NO_AUTO_PART_SCAN is set? Added in:

8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")

-- 
Jens Axboe

