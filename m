Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3441DF25F;
	Sat, 15 Nov 2025 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763223775; cv=none; b=d+GJZMmmw4d4Kn8mV8Zo2aByLTlDzVvyOCjfBrtXhSdyhR+Raff7DWiWsmnGLxSf/SWcD1sNawHrYYn3t21r6pvUPH8xmP+VRkeeyp2BJ7zqaMdiop5ITjgPTf1xR//NSFYEbivystWNwXf7pXmWY49zjxdK1TayPO4yevVY6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763223775; c=relaxed/simple;
	bh=dkf+PPZ9lvXL5kEc6dGDQYL+MKICC5QBe4nJe2bEqDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d2w868/sYwjzuTQREtvZETI6U957tLqTo+dHryzHIdqpsjcCbpbD6g6+NPtYPFov/SInb/pdXYnNvQ0hRzYE/Bh0ZkYUQp4OiwjGU3S0AiO7Fdq1wx/lsI8o8XxaI0VMpnWes4t3EyX+NMpIoYLejhRhRv9QVHwwwcUbhfUwhJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5wG0rSW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5wG0rSW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA96C116D0;
	Sat, 15 Nov 2025 16:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763223775;
	bh=dkf+PPZ9lvXL5kEc6dGDQYL+MKICC5QBe4nJe2bEqDk=;
	h=From:To:Cc:Subject:Date:From;
	b=O5wG0rSWt91XzQaEbMhM/t8nd9pBoUJ+ph6daIuK7cmHYOux8HGw+taxO5cQgVbAo
	 iHMe7Ggi1y5j0xG6X8GLskNweg4z0Kq45Mrahj7NDJQ3N2whucLl7/sydbazesGhB9
	 6TVI/hR6nichbr7lCc3uLqS7uFQPRC2rP3vaJGnovUQL08v6ZdC5GccobsliM/io2G
	 xoMMl1RfdrktcSfPI8WL6MmkmVlMAg8Lv6+Vb3Uwyd2Y88t3ggGlzB8/+MlsvtSwFj
	 4f8sTMf8TYf0jzEG+auT9xK0yzxX9sSu/moi9vRx6kqOt0+W/oRu/k6lw+UnppaNh7
	 jXNScmpIhIYpQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] block: Generalize physical entry definition
Date: Sat, 15 Nov 2025 18:22:44 +0200
Message-ID: <20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251030-nvme-phys-types-988893249454
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: quoted-printable

The block layer code is declared "struct phys_vec" entry which describes=0D
contiguous chunk of physical memory. That definition is useful for all=0D
possible users of DMA physical address-based API.=0D
=0D
This series changes NVMe code to support larger chunks of memory by changin=
g=0D
length field from u32 to be size_t, which will be u64 on 64-bits platforms,=
=0D
and promotes "struct phys_vec" to general place.=0D
=0D
---=0D
Leon Romanovsky (2):=0D
      nvme-pci: Use size_t for length fields to handle larger sizes=0D
      types: move phys_vec definition to common header=0D
=0D
 block/blk-mq-dma.c      | 17 ++++++++---------=0D
 drivers/nvme/host/pci.c |  4 ++--=0D
 include/linux/types.h   |  5 +++++=0D
 3 files changed, 15 insertions(+), 11 deletions(-)=0D
---=0D
base-commit: 79bd8c9814a273fa7ba43399e1c07adec3fc95db=0D
change-id: 20251030-nvme-phys-types-988893249454=0D
