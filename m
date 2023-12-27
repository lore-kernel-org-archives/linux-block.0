Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F764652F
	for <linux-block@vger.kernel.org>; Wed, 27 Dec 2023 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YCZRxbd8"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so13838639f.0
        for <linux-block@vger.kernel.org>; Wed, 27 Dec 2023 09:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703699209; x=1704304009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G44FG++ekV5iX1pSW4POvtFdtozNN1kjQKw9JfkA4ZQ=;
        b=YCZRxbd8J+iH7faUY3m7FmwaauFPuk5ViMkGTK3Mvwwj57ugq5N/1IB+3rrGJVHMVT
         Ni0vsDmvSrXs0LxQ7E3d80BMDs48IUdaZI3quFFWuWW6Mm3m+B85/GZfFLoEDbdEX0RW
         gZtzDeZBUTNcKoZyaSSeD0itrQ9EzDnobGdG8pF197CsxbKKDPgxF1VPUJ2V8YDuBYmC
         jAnX5duXr81q0kas9zB9whgVvQCpD3hOvFlHMEgMqKxFRWI2KpTBDISOo8fm5CXH5Zze
         bzLmxR4aljnkLL59yjCWySdlMQUW9SDsPG1hxV9U9huaA7pZWo9yZmdhSE1L7M6+aCyh
         qiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703699210; x=1704304010;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G44FG++ekV5iX1pSW4POvtFdtozNN1kjQKw9JfkA4ZQ=;
        b=bxuk6NPO3c7CTWtb5iLTAPDLq+uSCYjbZScOuKn9NnYkui82jwyHrTyESmhiJ3bfQb
         1TKeaEGqKE1Ce0jtZ72dqK9r5rmXD03IHWoRTCAWXxF66CDngqOHqwu+gWTzbe5HwnYp
         shADArVvJVAG2Hs1anb6YcCP6vm6vNZsb0b2dENNzNDvaxx/eRMVyn0lrFg7opu3GCcK
         UzcIKiKYK7lsWa48MoFwAxhcrmy90VIGDYJ9iA7zXxUXdOkDUb3Ph8HOAw9Pr0PYB47T
         KM3sll5WiZJXlQJ0u7EuSQfAGMowmDHm+7xseRPGg8llo7xNfxI+nhK4xDnqT+2Fbs5s
         mbKw==
X-Gm-Message-State: AOJu0YytaxzT+cYAaZ9GEPxKeEalifTb1DB/gISXTymfz5jKQnc5PfIL
	RBJDNCoqLXfOdgfzWAaYAjyDK7lXpgavFTsprX0JxP62uJWvAg==
X-Google-Smtp-Source: AGHT+IFT86Dsful/cV6hJ6TIbCCJQ82u2NaW6V0q12ZfPQ/UumpkOsttKbozybjOnJOuaVqv2+cbaQ==
X-Received: by 2002:a6b:6a04:0:b0:7ba:ccbb:7515 with SMTP id x4-20020a6b6a04000000b007baccbb7515mr7799724iog.2.1703699209752;
        Wed, 27 Dec 2023 09:46:49 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bb34-20020a0566383b2200b0046b4e38a630sm3829433jab.109.2023.12.27.09.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 09:46:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20231227082020.249427-1-hch@lst.de>
References: <20231227082020.249427-1-hch@lst.de>
Subject: Re: [PATCH, resend] loop: don't update discard limits from
 loop_set_status
Message-Id: <170369920866.1390332.7216026835799570205.b4-ty@kernel.dk>
Date: Wed, 27 Dec 2023 10:46:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Wed, 27 Dec 2023 08:20:20 +0000, Christoph Hellwig wrote:
> loop_set_status doesn't change anything relevant to the discard and
> write_zeroes setting, so don't bother calling loop_config_discard.
> 
> 

Applied, thanks!

[1/1] loop: don't update discard limits from loop_set_status
      commit: 34c7db44b4edccda315edcf02b9669aa173e090b

Best regards,
-- 
Jens Axboe



