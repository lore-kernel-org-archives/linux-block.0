Received: from out28-41.mail.aliyun.com (out28-41.mail.aliyun.com [115.124.28.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB31DFCB
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806967; cv=none; b=VL2hQdzm7c5x0ouRfIPL8FpmMawHU2mXklxk2XaousNCW149XvTwrQkAGFA5ICB5Mo/9lGK3V8+H47qGneOgs73lDXDErxQQWSwdkzN8MfkBFM9N8djGrwcDqnSkaekRn5+PkW+nWUXvHH4PdkqwSAI1KMhav2n7jtYXjuHkaiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806967; c=relaxed/simple;
	bh=iCpNUjgcwl1ZgsT7QxJiXk2twdhG5M3M1n5R1BELBKA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=EW8maif185YxLtpl1e7dbH72Ln3Mflvd9sNhSd3MV2LAiKbZFhWQ2qOexgOvXyLYsPfoEdIbtgs1IK8WOn/bV1RntMwr5rzBbS6Lk38Dj0xLQ4MgirEuwq7YZp5aaif6jwwvPfRO2MHt0ls0yYLIMY5WrQg5SJPiBnDiplLgAd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.dVxA7VS_1750806019 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 25 Jun 2025 07:00:20 +0800
Date: Wed, 25 Jun 2025 07:00:20 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: scsi optimal_io_size changed from 0 on kernel 6.6, to 16773120(32760*512, 4095*4096) on kernel 6.12/6.16
Cc: linux-block@vger.kernel.org
In-Reply-To: <20250624091020.071E.409509F4@e16-tech.com>
References: <20250624091020.071E.409509F4@e16-tech.com>
Message-Id: <20250625070020.B0D8.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.08 [en]

Hi,

> scsi optimal_io_size changed
> from 0 on kernel 6.6, 
> to 16773120(32760*512, 4095*4096) on kernel 6.12/6.16
> 
> I tested in on same device and same os dist, but different kernel version.
> both ssd/sas and ssd/sata connected to same hba(mpi3sas driver).
> 
> Is there some feature that changed the default value?

we walked around this problem with a local dirty fix.

diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index 351b028ef893..638dbafd695d 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -240,6 +240,9 @@ static int sas_host_setup(struct transport_container *tc, struct device *dev,
 	if (dma_dev->dma_mask) {
 		shost->opt_sectors = min_t(unsigned int, shost->max_sectors,
 				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
+		/* /sys/block/sda/queue/optimal_io_size 16773120(32760*512, 4095*4096) @T7610 @kernel 6.12+ */
+		shost->opt_sectors = min_t(unsigned int, shost->opt_sectors,
+				SZ_1M >> SECTOR_SHIFT);
 	}
 
 	return 0;

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/06/25

