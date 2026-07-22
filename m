Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172503B19D9
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746757; cv=none; b=NJl+r+7dCsEtGe3aYE5jI7fkUbMDHt2/o1ou667AZeZgCeuKaHhw8Im704XMKVg5ADoiuQBFPl8AOD7PHG8kfTUEd/3efhinWAg86xRv7Yx5g22rXgxPpZSX69+dNOenqUvLxiN3T+LmknFYipoMi1Up9GysTh3th0DPoygF0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746757; c=relaxed/simple;
	bh=tb87IS5YwxWP0/pdiRmCvUCzVsNHu9wl18O2iixHy6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDQBN76U3tLV/SzyRPc3AbsShtUXYslKhwEHdsiMLINlY1brZFdEEbscsbp0bDN4wjampUCwlxtTvhOd9e0dPEP+nZm54l+AEgY8NzbzicsftsTvtvbynVcNdUgi6wwMSKf0O8ryBAlinRO9RJIrBiR3kxvu2E3MMJRM8atc668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=ke96zD1A; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="ke96zD1A"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so23309455e9.2
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746747; x=1785351547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvUC0Lia0it+LgLYsOXSPjeMnXEhLq3Hqn52LEDkVn4=;
        b=ke96zD1AV2KN7/+6dDmPKBnVJGHdbbiVVwXnekYtUt5RKh8NxsEXdLh4Uhrtj3OP+z
         Qa5Tjtwp+zgHtPjbmH3sLbPAuREYsRuyEi64W2NwBdnsmMmAk6WQ7+qwFI7D272BVQcX
         +4x7jTG20yYoO5cuGmCNe/+2tylFSiszgDYajx4OjtF9KyTRz0yLQqTUUYwHiHxpTAT4
         RWdrCIx2RSbWF6yp2I+Adi8w+y0/CWUUFbEkOqc4fXhCR1L3uydeMAZZiLN3IZS9fQv4
         qUxQzbQxifQSHcmfu3kGAYb1Sk1hGER4swGw2xx0wzQnRi+IYx0e3kS98iq0ytplswMF
         JBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746747; x=1785351547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvUC0Lia0it+LgLYsOXSPjeMnXEhLq3Hqn52LEDkVn4=;
        b=U7MbzvmH77RJdhDpjB5eA0WGnfgJgr/6phg44Q1aN4frCN0lYuEwbIoNnd4n9eIVO9
         sRVjMkIIKhwvxdpkp1mwGyi286AWA0+K0CaWcAbEzT+tKSzOfE04SRlqFbdcFSMZXQg+
         dCMtD1rz9w3j3yccTJiNSnrxJPqHph7Y9DLJJJEjR/IJ3R0bmadkyp7OkEJxOaVO887S
         eAhfgxBpJTJMhh312vJlW1utqWblUXC6WP1FsbtZ0So0bUjrtqdKcJsHurbIZmCG0ef0
         iWbX3I3ETOKYwWacGjLGbey+GH3rKqjC9ykTJKuOvlHd2/HhzFinpcjpdq6g55nbFbkL
         QSOA==
X-Forwarded-Encrypted: i=1; AHgh+Ron/z6G8JE51WkROWZTuujqkW1zAubMc5zfcKikSxrREs2iDBjYne3Q6t0Qiik3klkgX+fk0QmB85KFQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjPR3iL3K98M9LVgygnN3J5XUu+4BpuR1CGWgTGQFHoEcjumlA
	FNDnayAU4ULb200S/M3Rg6uN4wcL0fRjrc23OWEr8Jr7d4LIadcR0OgtqUzRVv8ahQ==
X-Gm-Gg: AR+sD12W/2iV5uAHjoDoU7n/NhPizCJ32zpqCbi8ponNhYrfDYckxbs8gjigDrEKR+8
	cdQU+pM7XHY7HKNKoti3QWi2wsFQXfJGOK1jfKAm+g3puwHDDmhLtNPDzPxXCz8qp+9/LCH4qQ3
	1PWbIr48O2RVxW++17dqAjlTNmLxj+OYsxrhPbhal7p0IOprAvfXu6V8YiCwfFVuw7CiTHN8k1A
	0ducOWs4HavQC3bWm9jaxICP6K/0zO699SVxp57HYWG6a0ZEh8UJM20ISl9I3Ctuq2xmKQ6Td2F
	zhiFeM2uegcZZ28v+bx/tNy7Ht51hCUBZbPXXbTGnwStdHDxidgHC7ZSnFoQgEg1rEyi15w+QH5
	uXUMSRZq0X+Nq+2CvB5bLHgTFomY87FzAT+v6qr3blTp+xeNTyuOlF6dWWJzaHPl6jOwkQUOTeD
	BJm9osD9xgzmkq6U4syWAwS2ZmKPiJ7mgOO5cCj14QdtS/BeU=
X-Received: by 2002:a05:600c:2049:b0:495:6397:14b1 with SMTP id 5b1f17b1804b1-495639714bfmr108525535e9.34.1784746746655;
        Wed, 22 Jul 2026 11:59:06 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495730353d9sm13740055e9.12.2026.07.22.11.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:59:06 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 4/9] md/raid1: don't use write-behind for P2PDMA bios
Date: Wed, 22 Jul 2026 20:58:36 +0200
Message-ID: <20260722185841.449934-5-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260722185841.449934-1-mykola@meshstor.io>
References: <20260722185841.449934-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_behind_master_bio() copies the bio's data with bio_copy_data(),
a CPU copy. P2PDMA pages are peer device (BAR) memory; generic code
must not assume CPU load/store access to them is safe or fast on
every architecture, and bouncing peer memory through the CPU defeats
the point of a peer-to-peer transfer.

Skip write-behind for P2PDMA bios: they are written directly to all
members, including write-mostly ones.  Ordering against write-behind
I/O in flight to overlapping sectors is preserved: the non-behind
clone path serializes on CollisionCheck rdevs (see the preceding
fix), which covers these bios like any other write that bypasses
write-behind.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid1.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 997f79c05db7..7d769b6460ca 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1523,6 +1523,7 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 	bool write_behind = false;
 	bool nowait = bio->bi_opf & REQ_NOWAIT;
 	bool is_discard = op_is_discard(bio->bi_opf);
+	bool is_p2pdma = md_bio_is_p2pdma(bio);
 	sector_t sector = bio->bi_iter.bi_sector;
 
 	if (mddev_is_clustered(mddev) &&
@@ -1575,9 +1576,12 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 		/*
 		 * The write-behind io is only attempted on drives marked as
 		 * write-mostly, which means we could allocate write behind
-		 * bio later.
+		 * bio later. P2PDMA bios are excluded: write-behind copies
+		 * the data with bio_copy_data(), a CPU copy that cannot be
+		 * assumed safe or fast on P2PDMA (device BAR) pages.
 		 */
-		if (!is_discard && rdev && test_bit(WriteMostly, &rdev->flags))
+		if (!is_discard && !is_p2pdma && rdev &&
+		    test_bit(WriteMostly, &rdev->flags))
 			write_behind = true;
 
 		r1_bio->bios[i] = NULL;
-- 
2.52.0

