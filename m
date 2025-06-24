Received: from out28-84.mail.aliyun.com (out28-84.mail.aliyun.com [115.124.28.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD7C79D0
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750727433; cv=none; b=a4j+Vj0h8J6JtSulAGRhe4DcLrICHnx/XwUJgvhQq44mAgHjaEM4TzMASCfLNXL+kGc8wxYsXDiQ18GuFb/8GVVzO7ZvNj6kNA9BxM79JawkwyZig8T/5D/DFvFdrxzGhKIBLdJFchef/CH9WxsDDcy4L2INu7OReS7VpP6u9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750727433; c=relaxed/simple;
	bh=vbze/WviVnobLVutE1oTI+a74X4YkHBJ2jX7He20Das=;
	h=Date:From:To:Subject:Cc:Message-Id:MIME-Version:Content-Type; b=XnNi7LNhK4mlu55SvpjAo9t63kQ7D4Y1gvnjPGSSlzH6X0g+PGAVTaIVjCK5BEpipP/TyHcSb6RxWV7CsaxLAZfmYihwdflaZPxuojp/SR/4bCH853LB4STYhwLXM0q6+QUJ46E3qxU+Py4zSVkmejLUFyYv2OzC/ocGGTjHPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.dV7qcIs_1750727420 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 24 Jun 2025 09:10:20 +0800
Date: Tue, 24 Jun 2025 09:10:21 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: linux-block@vger.kernel.org
Subject: scsi optimal_io_size changed from 0 on kernel 6.6, to 16773120(32760*512, 4095*4096) on kernel 6.12/6.16
Cc: wangyugui@e16-tech.com
Message-Id: <20250624091020.071E.409509F4@e16-tech.com>
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

scsi optimal_io_size changed
from 0 on kernel 6.6, 
to 16773120(32760*512, 4095*4096) on kernel 6.12/6.16

I tested in on same device and same os dist, but different kernel version.
both ssd/sas and ssd/sata connected to same hba(mpi3sas driver).

Is there some feature that changed the default value?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/06/24


