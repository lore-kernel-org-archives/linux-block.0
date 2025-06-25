Received: from out28-41.mail.aliyun.com (out28-41.mail.aliyun.com [115.124.28.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE7E19F419
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 02:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750817783; cv=none; b=DPxIIxXL+iDbzkqETvluob71c9Ja7rxAxQ1Cf1Cvy6LWpp6d82Vi/tHXYD0SRoPUe2XHKrC69Cvv+dR+jMjebOmccQgSdOBKRTUiS1yO8NoC+aS8KjPFWDYa8goqYc5E58o4ZlSZaiZbqhOMtG7PIXmsVryNFznlaRBrO8m/oz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750817783; c=relaxed/simple;
	bh=g9FfGtVXRsK8G5UxO8PVS1vY0Hjz4S/vdBlMnvrJ8ko=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=Ae7qOj4cD0YmzXknuvAK1AWcI5ziTbPxprEqk630SgvitR7ytmyQ6fJ/cu+RZ/9ZitHnjr0huiDAqxw78HRPCgxtdgJ0xpV7ZEmAQG75BwjAVKEF1qn4XRMro671buAcoGX+Z9tPt6bK9aX0EoMtSB32p+zVr0B40TFMa52ETXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.dVyS1C9_1750817456 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 25 Jun 2025 10:10:57 +0800
Date: Wed, 25 Jun 2025 10:10:57 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: scsi optimal_io_size changed from 0 on kernel 6.6, to 16773120(32760*512, 4095*4096) on kernel 6.12/6.16
Cc: linux-block@vger.kernel.org,
 wangyugui@e16-tech.com
In-Reply-To: <yq15xgkoayn.fsf@ca-mkp.ca.oracle.com>
References: <20250624091020.071E.409509F4@e16-tech.com> <yq15xgkoayn.fsf@ca-mkp.ca.oracle.com>
Message-Id: <20250625101056.DA49.409509F4@e16-tech.com>
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

> 
> Wang,
> 
> > scsi optimal_io_size changed from 0 on kernel 6.6, to
> > 16773120(32760*512, 4095*4096) on kernel 6.12/6.16
> 
> Peculiar value. Please share the output of:

It seems the valule of 
	'shost->opt_sectors'
	'dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT'
that means the optimal_io_size of scsi host(hba).

> 
> # sg_readcap -l /dev/sdN
> 
> and
> 
> # sg_vpd -p bl /dev/sdN
> 

# lsscsi
[0:0:0:0]    disk    HITACHI  HUSMH842 CLAR100 C292  /dev/sda
[0:0:1:0]    disk    ATA      INTEL SSDSC2BB48 0121  /dev/sdb
[5:0:0:0]    cd/dvd  PLDS     DVD-ROM DS-8D9SH UD11  /dev/sr0
# sg_readcap -l /dev/sda
Read Capacity results:
   Protection: prot_en=1, p_type=1, p_i_exponent=0 [type 2 protection]
   Logical block provisioning: lbpme=1, lbprz=1
   Last LBA=195371567 (0xba5222f), Number of logical blocks=195371568
   Logical block length=512 bytes
   Logical blocks per physical block exponent=3 [so physical block length=4096 bytes]
   Lowest aligned LBA=0
Hence:
   Device size: 100030242816 bytes, 95396.3 MiB, 100.03 GB
# sg_readcap -l /dev/sda
Read Capacity results:
   Protection: prot_en=1, p_type=1, p_i_exponent=0 [type 2 protection]
   Logical block provisioning: lbpme=1, lbprz=1
   Last LBA=195371567 (0xba5222f), Number of logical blocks=195371568
   Logical block length=512 bytes
   Logical blocks per physical block exponent=3 [so physical block length=4096 bytes]
   Lowest aligned LBA=0
Hence:
   Device size: 100030242816 bytes, 95396.3 MiB, 100.03 GB
#


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/06/25

