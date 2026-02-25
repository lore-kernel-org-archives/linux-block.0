Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD962BAF7
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978035; cv=none; b=C9/6e1MsNPWQ4d/cIc3YD/ZksWsDKiU67eXs/qh5yNRvMkvAeONCOmIq4MkZ5fRGx2BuYX4F12VoPvxSPzEMf7KtvwcMq+JIr6l0EfNjG95lFTCMYQHAKfHBKlG5o64lCkv4L5+aqS6yrO3VtGcfhVRDS77N184O0JjZXWAKFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978035; c=relaxed/simple;
	bh=TmVck+FldsP6JAM+f7tHdpVNV1AQOfdjvZD6NWwaNTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cct8TajuO2ThcEX+tw5nvdA99RLAIYO/XWqo7GqXYKLmSv1U1UH/voxa1btI1XW39VoGMq22WSY+sx4v6PutLWUtnnm1lK81PXtOsFJ3mKPzeL1zwYyPdAQKrlGjThUw2W8qDyZQcd3/dF5aYpI1RcUXf5NhPpazqv8DsQbxJME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--robertpang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jM+ywaAh; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--robertpang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jM+ywaAh"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba7e98178fso5641584eec.0
        for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 16:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771978034; x=1772582834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tYhhsa7kCZNvYr93t3sYKWAVnQ12TUikgigc7L/AwWs=;
        b=jM+ywaAhjWmDDU0Up0OPTru1cqJzUC/6zLzJvfNLmHaw4RokDSwGp4Q4tKdFaPj0bt
         VESKOiiXZZd7OD0c+ZkcjKobk5KbIBGV8E8YBj3iZ1WoWxLqotr48rd6W1snKvANlLN7
         iruCd3LnCwpQ0d35856mS1x4jzNI15pAkjC6R632OIZRrxAtj/1ekc9tTKhgfBrWuNzX
         s6hQPgfIJgkqAZxCTB25nQ+0H9qVwHhj5O5l9orI3Fd7DKTKdgXTPU93ibrWTzXjHYbC
         3c8tvvvpOMKB9sFnCTO8ni+ZKn/Z606NbiQkm1kDPrTyucweiC7pHZRen6E3zJz8O7OT
         7UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978034; x=1772582834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYhhsa7kCZNvYr93t3sYKWAVnQ12TUikgigc7L/AwWs=;
        b=dwVq5HBBwGMQwZh/IvMHz9jzP8MoghsdNCmVPRanuAsIF34L88+Mojxkv2cLyCeAvx
         oX7in39Ugw7naVz9lNulPpQwg7zzssKXH2jX2a3migqqGhHq5DiHBpAj8rKCstYxyq8C
         keFxeCgjMSRXbVBw8F1ncA6h25aUA6eLBsnmqS7EWKyMS6uXCfQEwAte8fhtN933eYmG
         md2g5elNjTi9zSFri9iJF0N6p+C4fVdF6Qgigl0RVmj5Zl5bUk9iuS4/6SWP1XDDjwrZ
         JWA5x8cTEYQHCdRyrLrYuQRtuyaR7epEL6dzmVxjCRVoRb62WYZi29eCkg95sQkgNodU
         8lTg==
X-Forwarded-Encrypted: i=1; AJvYcCUeFyEPjIQq1R2KA7BEsEMLSbnHsQxOMkrCdytUCwWgiHfXensnKDl9lwUK9H8CBD3vIZln8imjtWNqJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+crUiq4Lk10zbrC2o2UR3nNqk1OhRNZU/CQomRgFJnDOQ4Pjo
	3Db58xexk2aPIG6383vSa9NPPuL5KOURyBDbH4N8OQwyEI+yzP3wZPD1jZa3VEeBKv0DKdxhSaA
	OfelMEuL5QAprvkod5wTNoA==
X-Received: from dycqa7.prod.google.com ([2002:a05:7300:fe47:b0:2bd:b038:ae2f])
 (user=robertpang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:dc0d:b0:2b8:209d:5983 with SMTP id 5a478bee46e88-2bdc33aeb7dmr127538eec.29.1771978033558;
 Tue, 24 Feb 2026 16:07:13 -0800 (PST)
Date: Tue, 24 Feb 2026 16:05:31 -0800
In-Reply-To: <20250619111806.3546162-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250619111806.3546162-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225000531.3658802-1-robertpang@google.com>
Subject: Re: [PATCH v2 2/9] nvme: set max_hw_wzeroes_unmap_sectors if device
 supports DEAC bit
From: Robert Pang <robertpang@google.com>
To: yi.zhang@huaweicloud.com, Zhang Yi <yi.zhang@huawei.com>
Cc: bmarzins@redhat.com, brauner@kernel.org, chaitanyak@nvidia.com, 
	chengzhihao1@huawei.com, djwong@kernel.org, dm-devel@lists.linux.dev, 
	hch@lst.de, john.g.garry@oracle.com, linux-block@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org, 
	martin.petersen@oracle.com, shinichiro.kawasaki@wdc.com, tytso@mit.edu, 
	yangerkun@huawei.com, yukuai3@huawei.com, robertpang@google.com
Content-Type: text/plain; charset="UTF-8"

Dear Zhang Yi,

In reviewing your patch series implementing support for the
FALLOC_FL_WRITE_ZEROES flag, I noted the logic propagating
max_write_zeroes_sectors to max_hw_wzeroes_unmap_sectors in commit 545fb46e5bc6
"nvme: set max_hw_wzeroes_unmap_sectors if device supports DEAC bit" [1]. This
appears to be intended for devices that support the Write Zeroes command
alongside the DEAC bit to indicate unmap capability.

Furthermore, within core.c, the NVME_QUIRK_DEALLOCATE_ZEROES quirk already
identifies devices that deterministically return zeroes after a deallocate
command [2]. This quirk currently enables Write Zeroes support via discard in
existing implementations [3, 4].

Given this, would it be appropriate to respect NVME_QUIRK_DEALLOCATE_ZEROES also
to enable unmap Write Zeroes for these devices, following the prior commit
6e02318eaea5 "nvme: add support for the Write Zeroes command" [5]? I have
included a proposed change to nvme_update_ns_info_block() below for your
consideration.

Best regards
Robert Pang

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5ebcaa2f859..9c7e2cabfab3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2422,7 +2422,9 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
         * require that, it must be a no-op if reads from deallocated data
         * do not return zeroes.
         */
-       if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3))) {
+       if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3)) ||
+           (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
+           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
                ns->head->features |= NVME_NS_DEAC;
                lim.max_hw_wzeroes_unmap_sectors = lim.max_write_zeroes_sectors;
        }

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=545fb46e5bc6
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/nvme.h#n72
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/core.c#n938
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/core.c#n2122
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e02318eaea5
