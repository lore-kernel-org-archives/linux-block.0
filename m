Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D85D280CE5
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774960233; cv=none; b=A4h521dAlWMCucI3xepx3mgCoeQwCencvkbNY3Qx9uuETKswoH5wB8UToPUAOfR/wleMbzgF45ZOuI242Vmg/nDgrM19c8YP6SHSGZ+tu33ZVs48SfBY94EZxod7B+jb+z5iLgu53/H69EKC9Kjz4xKtcflwXOMuKrdQ6zcKaE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774960233; c=relaxed/simple;
	bh=zYa4n8qzWSecdu2d4k0BP73D9jsD/lRVfyLGa60q+Ik=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ssd/mM+4XiJfu6/wokUf3E+9555ghfx5x8gPeEbvokH5MdtpgDyerW+MupStsrRJq90vHn4bga2wMlNRRRjl+z7mWhPeEClNkjpeJ6KQ/kZmz408GtYg9ws4j8WATqLzfhL65O1XaJQ7LICqpos2k1oH65MkRK7giYyY6v3hssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 42380814A8;
	Tue, 31 Mar 2026 14:30:29 +0200 (CEST)
Message-ID: <2ca9bab2-30d2-47d9-bc40-d6c8fd806f37@proxmox.com>
Date: Tue, 31 Mar 2026 14:30:28 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: m.limbeck@proxmox.com
Cc: axboe@kernel.dk, dlemoal@kernel.org, f.weber@proxmox.com, hch@lst.de,
 linux-block@vger.kernel.org, martin.petersen@oracle.com
References: <291f78bf-4b4a-40dd-867d-053b36c564b3@proxmox.com>
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
Content-Language: en-US
From: Mira Limbeck <m.limbeck@proxmox.com>
In-Reply-To: <291f78bf-4b4a-40dd-867d-053b36c564b3@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1774960173043

> Since we saw the quirks added for certain devices [0][1], we also tried
> changing the sector size on an unaffected kernel to 8191, 8192 and
> 16384, but could not trigger the issue.

Small correction here, we just tried it again on the other disk that is
encrypted and the issue was triggered with 16384.
Testing different values, the maximum seems to be somewhere between 1281
(works) and 2560 (crashes).

We are happy to gather the maximum value that still works if needed.


Thanks,
Mira

