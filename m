Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F834D4CE
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764871961; cv=none; b=F3duBuzkLyjKwRFLWmMcfFAUfJpu5MsVNLz63Zx97iJQl0eNpYHUzqsm9CXVVm1UUyitEeLwoiP3r57RzxRoYFERTGDssR1WcV3Bv4hRSeGdhxu0r5VCKoJ5xSJZA9oPngY7uapx7qhPhN/IQlb5QfhnNbYTRL5spgMfkXBi6mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764871961; c=relaxed/simple;
	bh=2B5netBi0FKDbBrKYajIzUqf9ji3yrX5LtpEQRqxhX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1c+Bw7kGwCh9yl0kQBLR2YWFmcF8QSstO+f+KkvMGG+m2CBDxwxgWZjL4WNs8MumxhuYC0KU2EGMC1IL7RsUymACYxUxkwx0BhDhm/jz+UXFLwRiYnONv/y5SuSpmVQMxsGK9JqdhADVJFwA4lwsegI06yka81d4kR3pIoP8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=G4aaKUnc; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="G4aaKUnc"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b9a5b5b47bfso999447a12.1
        for <linux-block@vger.kernel.org>; Thu, 04 Dec 2025 10:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764871959; x=1765476759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RILiBFUrCEeMeEKSv6N5kdn++qwTP3SRlW2lK7kc7WA=;
        b=G4aaKUnc+Ior5IAGtlsN+8Vpo4QbG4JjEVTEK8LA1q6cEzrifda/nU52OyZZm7THi8
         tAuxxy2CjsJ0M5T75DzMzv4gI7VoF8tm4mP7jQ57N7W2U14X057KvnukmQWpdxBdhCbo
         omQUzYUGstLYjJYKhKXGeazGpKyuXAYzfa40KpeNkWejZVSe5YdLbl/g4Hrgc0xCUIjV
         +p4u9l7hDDStvR3WnfHyiU4YahQrIc3CoMibRlZ13gnuojOhLmCESJQaEERR94V21VWM
         2yelKOm/okHHUaA9NlRxYOLwQ4UeeRHmda6OZ1ggNJ+XRK+9uAKuAXj9SR6rgFM4+gsc
         rusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764871959; x=1765476759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RILiBFUrCEeMeEKSv6N5kdn++qwTP3SRlW2lK7kc7WA=;
        b=B3RsYmShj/egfVA83xvnwfCQdYlObEi3QT7nsNjCt2+LAWVXiLDNhsmHL2Y+DnG0JL
         n+E75piSFS4qZN0dm4MW4WHBDOgSnJEkmBBphhY9PdilWwJc26d9MAv7qmdNqKVLQuFT
         o1L7fx97EUju3QxgfBZkuLQP2GjM6R+yObhysnSpQE5sUr8DyfNUCwM3alhfrh9txlFr
         PkhXI3jaPJUi+lQ+2kcWkrlFcWzIByoWvlYY3oPVTcOP4kOT30pYejPGOWaE+swv93Cq
         NhFLBCx7rS2NiUkbI3L84T4wcSMs2RNy0QWRXS4oCq5YSf5UD7+AWuwpEyamlhSQySM4
         iupQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmCepDZjr2x5gbSOufkqxTHKzF68TFL4CgvJ/xLKgL6b6AaMhqJ9LV4rDdfMequOpUAxVeWaFkp5HQyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv+sK5y3b4KPPAN4e8KNE/M58sneh2BByuVgL6gmr3YyQdeJUJ
	tUl3kDrfm6jKgCNTEIoBK3GOwXvGiTSxBKIMFHZHmMII9D4dm6i8BAGe1bta1BJFD5Y=
X-Gm-Gg: ASbGncuthwqmU5yfRxrfCcC1CNPQyLJhAlixb5wSjdTABflhuGshVGriDnaTw9OomEw
	/cCVwh2StdAQBlSSJH9u3qXc/3iejkVaHNWf3bg+0lBoHQvcD2KdGROrAz0F2um1HtXWGOW+hpJ
	nlQjd4H2gHTduM/usTs0mo87cpAYxfgrwhoJ+GMDuBUgSoT/sdNnC/A4W9Jen56y97C2dXbLFFj
	s91tWllqmw7Q6wi24g+iGTMLR2FFqXnN6QSxwShte5g0p14m7Dfto+VQcwSEpph69QqmaNrL5FN
	YTdD1UQR2ktQZLmK6Vu8lrbsS+9SW7CK2QOzlsPE8a/0R1u/vuIs/v1jb75w8Xs3jYtd9KKeYnM
	j7QcGXYFobr8QJVlzcgp3DSiu0rjekA/zVf8+EeDbx5+n2w2fwMcRvtEtvl6jjezNrbxRW/sB6W
	9p6Fh+L4DyeywgAFTt5bRB1Z5xzT4iZudutA==
X-Google-Smtp-Source: AGHT+IEgEDoTOTXQKy2j948cOKAQ7GqxE72wljdD/dWwVb6TtYiLJMON+G8ZC/6ycK5Ggb6q5/+34w==
X-Received: by 2002:a05:7301:da8b:b0:2a4:3594:d548 with SMTP id 5a478bee46e88-2ab92e3b053mr3781119eec.21.1764871959232;
        Thu, 04 Dec 2025 10:12:39 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2aba8816ae9sm6998935eec.5.2025.12.04.10.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:12:38 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Hillf Danton <hdanton@sina.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH 0/1] Use RCU in blk_mq_[un]quiesce_tagset() instead of set->tag_list_lock
Date: Thu,  4 Dec 2025 10:11:52 -0800
Message-ID: <20251204181212.1484066-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch in v2 converted set->tag_list_lock to a rwsemaphore. It was
pointed out this could result in a different kind of deadlock. This
patch uses RCU to protect set->tag_list when accessed from [un]quiesce
code.

v2 - https://lore.kernel.org/all/20251117202414.4071380-1-mkhalfella@purestorage.com/

Mohamed Khalfella (1):
  block: Use RCU in blk_mq_[un]quiesce_tagset() instead of
    set->tag_list_lock

 block/blk-mq.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.51.2

