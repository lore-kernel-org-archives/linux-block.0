Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC12FFF94
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765301650; cv=none; b=P+OxFFBDZ8v4kTn3Yvezez2WXyk4XtSkqLHOg8qEZARB+SSkRPTgQ/nkVlXqoDpBcVTp9EbGzh2Vl9PvaNpDKIzqOZg4ErW3CW+ySdX/K1vq4l0Tj9vLcDq4ychJb/Q2gv5rc7V/5MmAw65n70gLVy+7f0LhP3g2509TmXfR5FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765301650; c=relaxed/simple;
	bh=B0bQCB2y5W+qmyLc2/z1up9scJRY3swOuD/APX89Y98=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Jxn93kvPo+H8CtEHURk92FLQa+98xpZUrByXZ1Ag+dNZBK5v0UY6QchdJ96q08W4st/cZHhDRWLOHUOAdMtFhSMwmC4KFKBU2uHKP+nmcOyDPhN0e67bFIHm45D0APCONWmdh6Tc440EkiGFUoZJg7jzPp2BPDRj53F1xDgV3ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fBdMA0O6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fBdMA0O6"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso7492076b3a.1
        for <linux-block@vger.kernel.org>; Tue, 09 Dec 2025 09:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765301646; x=1765906446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzfwZgr4h4BhPNLh3j52xxFZfkoKPkXdetQmkUZ/psI=;
        b=fBdMA0O6f91iQMew1zuueQC8jS2V5QUn4ZDo98ACsl3RxW2IEnJaEBp4ftuSwFfOGn
         DMJTyqRLa6w8wQWisCvc1HMfqX/JUN+RcLPxFUu/Dq64/v6XcHLV94m1PwdmmQpw1HzA
         zcmrcqekOo0q5ILErZz1r+6G2jbSdWw8HP0Bp3ZSWZa/wYnSrow3BAqcrNR3jI6TLpcC
         dEVcE2jAsdIoaGY+I92BynMkkJibMtlN3bEb3O2ZiEqP392yVkVxSamEaIolVBuzK5IT
         Fn8wJMacFGsniAiuGnI4Jxjzff8X+9EC1sOX24Qs6hrK/GVayZ7EHATGakyjCw6L04J9
         zh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765301646; x=1765906446;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BzfwZgr4h4BhPNLh3j52xxFZfkoKPkXdetQmkUZ/psI=;
        b=H62dZr4btd6en+fIr4f3l4Jr/bq3hDsLZMd4BEeKB+RagA5dE4skNZg+LVMSRu+gRa
         UquXW0sYFvEJWks/hECxUtby0E323mgFVFv2luroDhIH6VlGnSrSBgMzRmmgp2QJuTWM
         0qtDQLQXka55me3RXO/6zS+NK0RntlNkNbwO6lz5DL9GkGzg+C2Gww2aLEragNF56Pif
         e+hVZtiPlV4w8ktYW36hUyRlPtiTTrWrmzofyG/OIujNPzTm1OGiKSUjUmPRfnYTgQvK
         FZqOimGg0nUAIgVoIHAmmzMnAwj2xIz5IvZ0fSbjf0syyRXAkCGvI1h7f6JyOxMRU5Ys
         AdBg==
X-Forwarded-Encrypted: i=1; AJvYcCURK/vvm+mh3wdBZsiTyvkQo7S7R7mYUVyDYseN/Yip7zrXLd5phXavWGAjZ39y5U3ztz48V/hMxvJjnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdNKy4K1xt2fas/RSryQfgel3jRfjgQX5qUVNeslj+4KXUoL1V
	NXA81++pL49NoMb0AHUDmN4XBfXUmpauG6kezdZKJWIbtHU7CPhgA8yG+6f0kxcbHLg=
X-Gm-Gg: ASbGncvqjhaNaR47qoD9JKWLuEgZzHY9EwbtIVFhHHDWvdrSPGrZExbJ/2PdEPcDBgV
	MrYxK16+rg1H/5feTZINSjlFNf5CxDRseeH3glghxXKX/+fPZFlS7+vglOWsdD/50zvLKaL6zNR
	+b0FjHKWdl4gF1TMvaU70KiO9xf3e/kB6AnqMuHJrMCGDE0maKEmJf7D+NN425Jh/zpNhuqKfFp
	nRMlz2IVppPinMqYtAHRWb8Sj1H/mIKEy4tsm3NI/qCu2Uku3BOWGDnRh6UYzrL8KC74ljGEylU
	7cqAI4Zehvq/pfMf/2RqwaF3zDiZOAtGQwUxkfKUiUQOApmOymsri8PRARdc2d/9DMDHzuxGuFd
	ATLYIqtU3sQ9mif+yE564qvJCXySDbfi1Kuk7FI9PyAKhBpF3Yh0+RW9hQIHmw/sIvVC9+j9Z5Y
	idLMSQ+ChOARkBXfj4FKAmg/vakcUuIoOt5O11XoBNeqt1jQ==
X-Google-Smtp-Source: AGHT+IFfoIXes1iCAjV5UsXYGWZhHXTyswShTgrkG5vdMBtSxznkyo+2Kn1L/PUWRLbkrpFV5M35sg==
X-Received: by 2002:a05:6a20:258d:b0:366:14ac:e1f6 with SMTP id adf61e73a8af0-3661815910cmr13717265637.72.1765301646601;
        Tue, 09 Dec 2025 09:34:06 -0800 (PST)
Received: from [127.0.0.1] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6a274af53sm15484593a12.28.2025.12.09.09.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 09:34:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Casey Chen <cachen@purestorage.com>, 
 Yuanyuan Zhong <yzhong@purestorage.com>, Hannes Reinecke <hare@suse.de>, 
 Ming Lei <ming.lei@redhat.com>, Waiman Long <llong@redhat.com>, 
 Hillf Danton <hdanton@sina.com>, linux-nvme@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251205211738.1872244-1-mkhalfella@purestorage.com>
References: <20251205211738.1872244-1-mkhalfella@purestorage.com>
Subject: Re: [PATCH v4 0/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
Message-Id: <176530164449.86086.1886657108099467825.b4-ty@kernel.dk>
Date: Tue, 09 Dec 2025 10:34:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 05 Dec 2025 13:17:01 -0800, Mohamed Khalfella wrote:
> Changes from v3:
> - Fixed typos in commit message.
> - Updated stacktrace in commit message with one taken from recent kernel.
> - Added Fixes: tag to commit message.
> - Deleted synchronize_rcu() (added in v3) and pre-existing
>   INIT_LIST_HEAD(&q->tag_set_list) call in blk_mq_del_queue_tag_set().
> - Updated the commit message to mention why it is safe to delete
>   INIT_LIST_HEAD(&q->tag_set_list) in blk_mq_del_queue_tag_set().
> 
> [...]

Applied, thanks!

[1/1] block: Use RCU in blk_mq_[un]quiesce_tagset() instead of set->tag_list_lock
      commit: 59e25ef2b413c72da6686d431e7759302cfccafa

Best regards,
-- 
Jens Axboe



