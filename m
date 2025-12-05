Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3896218AB9
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764969484; cv=none; b=GeqXRS0y+HdNZ2mSuzh0v5GSqqi4NEuAm8wb/FEwEAkwJTqpYjyN3oFSVrIKXOpxTkTtioSSRnkiPGsuwi61q9IjwYzxxdtN9e9I3bkilzDakPMEv7bHR89q4wNqHiB3tcdnB5clkEmXg2ue+ojMjH3HOUafn1y/el9p5DHAJW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764969484; c=relaxed/simple;
	bh=fRZOm+nn81nPeAI8N3yxexSk41jbLfzqyhBcC20QVPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ccl/NKUBQE8hxXHMv5NNmZzW3lR1jxeYUuyEII9nA+ZvTvcjuxlOScDxJkLRWn+JNOAaoeTw9YoiT/7n08upamoj8h+BhtYrS7rL+5PpXW1ax9TubGC798ZWxzLwlFhB2BhXpY2LZ3ASklse3MBxaz7tRq2sdimQlw+ROlZn2FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cnU16/Yn; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cnU16/Yn"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso1590725a12.2
        for <linux-block@vger.kernel.org>; Fri, 05 Dec 2025 13:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764969482; x=1765574282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qLr78IWpZsH9cRJ6KPlqEXZYrcnfDvKEUz40bjS2UZY=;
        b=cnU16/YnSDlkXnh0czFQHfkLupbMh2xbI2z2n59po4uD8yIqwrlJmzFKAol1Npw5/i
         eubkw4A9d4+XRvNPNxWYUekh9oE/k5Ci+wh7FhkMng1nt3baCfBrvEkyk73ys1ozHFoK
         PZB3hfAVk77nepubtwOSf2FxkBYGNpY2krVIPuZeOkijCP2KQRBCfMPX6Dec6PTLref7
         Y4hLe8HyLXMC5smFsFi5rD9bxwkm2rnGgW/hbcdtSQJTG98wRaiH9ioj8sIL9YfPI4kT
         wYU/tWY7WIYtFRWqbLFScP/NcWYyZUcBnHetrM67jP5L6O6jRpPx2xiJ5KjLOH1nlGvw
         +3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764969482; x=1765574282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLr78IWpZsH9cRJ6KPlqEXZYrcnfDvKEUz40bjS2UZY=;
        b=J7zDTiGD2HE2yo3zaQ+PIMiQk0hVeZb51ohgDXIKtBL3/d0HdtVw1XDF1lDpA6dPaz
         T0uXbmdABnqV1XSxxGYDa0CplBL1XX+N7HLIhLXWr4nt8+9DAKpdKmDAGH8Fu2QTNGUe
         LDGKZN92/1x3IBPtUQcFn7Hw9+XAPsGoPpDdYEVl1DvDtZ6liYERYRZNR3DkvhM7B2ab
         wQno+vaA6i0+WpdzCcmO74fU8quWpLaCAjDK/WKAtCSf+wZMRkB4kJfcO5/V40MkwHPl
         aPnF08o2pb8Km9QpJKbmawijZXrnXZYM1hFxHUsWGvLglhZN4NaqnP1l8pKLB394vEiw
         3EDA==
X-Forwarded-Encrypted: i=1; AJvYcCVgKWMWM9ovJeZTgQUEvoi19Wb3wvGGdnes1IBcB/8oqo5PakbOEHuBkTrsv6kSOJjQSzu2yNrPzzXtbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YziZyv+IuR3NMOETjzB89SBM+uQK7nEejTHe6MLUnm3Uiei6E+m
	hsmUojHFVoffrShqocqHVYnUCzFHeOUF35JTrGWTQ94k5c73Rbh38JhMFrnXQ7DhX0A=
X-Gm-Gg: ASbGnctFhY7NV/TUqvnILK/mSs8qGjy2BQGEv1bx9RXSVUkZ/off4sOmAhxoR3z0jSN
	YgYWph7lCr4ArGURDhcmNYBN7KVXG2rIEMxuELbIL9MdFzZjKQgeR+5dNFANt+atku94Sn1Wouj
	9dOVKZb6JuP81GUSv+j2LsRXlM+06ZTk9ok7G42Xc2UoFxkfMsaJlPjIEBtkbnf7W9yQnlMHGGY
	IcIfcFSuylqnKRcqQjjy/y+jSpbosYisDvZOfMqswbvEVyuWuvRfirnibvWMfyGNbMuRqKle8Gh
	dl8Zn+jLZIkTsI+eDG0bxLTL81wkrMxHCh+sIkvAb27fK2QYUS/z2F++xsSfXewOzWkOVbVPaUk
	Dfeqqx8gVC+eWNGOVgPQBp/I7wAzJfFKJrpCNd2kOv0K2heBAkN5XQyXMFme6+3fxTbaKfHaqr9
	kDZPwqIK3gaScFDvPn5pkBHxL00zN8CYq9QA==
X-Google-Smtp-Source: AGHT+IHgbtRzljq2X9udI6Q97+gwmHZiZ3ufXgUMLj3UuDiJA4sZb94uuPtC80v9mSCYDgdTAcYmcg==
X-Received: by 2002:a05:7300:d0a1:b0:2a7:83e:7b17 with SMTP id 5a478bee46e88-2abc712d0a3mr394259eec.12.1764969481828;
        Fri, 05 Dec 2025 13:18:01 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm25546318eec.1.2025.12.05.13.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 13:18:01 -0800 (PST)
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
Subject: [PATCH v4 0/1] block: Use RCU in blk_mq_[un]quiesce_tagset() instead of set->tag_list_lock
Date: Fri,  5 Dec 2025 13:17:01 -0800
Message-ID: <20251205211738.1872244-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v3:
- Fixed typos in commit message.
- Updated stacktrace in commit message with one taken from recent kernel.
- Added Fixes: tag to commit message.
- Deleted synchronize_rcu() (added in v3) and pre-existing
  INIT_LIST_HEAD(&q->tag_set_list) call in blk_mq_del_queue_tag_set().
- Updated the commit message to mention why it is safe to delete
  INIT_LIST_HEAD(&q->tag_set_list) in blk_mq_del_queue_tag_set().

v3 - https://lore.kernel.org/all/20251204181212.1484066-1-mkhalfella@purestorage.com/

Mohamed Khalfella (1):
  block: Use RCU in blk_mq_[un]quiesce_tagset() instead of
    set->tag_list_lock

 block/blk-mq.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.51.2

