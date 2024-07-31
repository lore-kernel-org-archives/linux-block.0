Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0E81AED59
	for <linux-block@vger.kernel.org>; Wed, 31 Jul 2024 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430154; cv=none; b=YMVhrFtvEcG5TzqjS2BVCYM9LP7CFmrWTEz4UhQxWd/H1GiarjHbHPlst/2LihyGapDCHkH3Xc5X/pb51fmk0ezTs7sbMQgYyfSNm/diUGUcsnzVizXihJnxGjBCOZjtpH5vmN8MUnbR8aUvD6HEuoiP/oFlzaY4OE+wiH28wyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430154; c=relaxed/simple;
	bh=Ub7XQET/ZaZOsO+6E2FjhoWf/3Q9YRVW70nRZcFBXbY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X5c567dJlM6nhgOMk2tUkRLey/KKRcAgnBeElwFy3oILRCfLV6JbQ/oM+4k/4MtRKSA8CZEe3kMQOa0I5F8ncCTLKRXG56v9iDovCsm4gHU5vPIrDpqhvZFfMvgnkY/lWNn+qDZ/+7t3QXv+QSlbhNjeSWHPUDXxV12ySqrWBi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RovzCPiV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RovzCPiV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722430151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfOezK4NgajJSnaHDL5lqgNB6v9S8prMoA4fLWqKK1A=;
	b=RovzCPiV80yIvsZF8I+Du9kfjQKYg5SuPlhQIv8HyoL6aYpIs+Lx/KJ1ogeKYB79uPmVaV
	GOrDsJGdvCDpJuLnbpvmHeOGLoke3PKa8nvONlAxHghvyCbqM67f6ZTQE0UmOWXWyYtyzL
	+k9vNN/f79o0PIR8djsWaaLJKIFkMXI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318--h9lzUaiO9-fcU-cgd55pQ-1; Wed,
 31 Jul 2024 08:49:06 -0400
X-MC-Unique: -h9lzUaiO9-fcU-cgd55pQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3813F1955D5A;
	Wed, 31 Jul 2024 12:49:02 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F237119560AE;
	Wed, 31 Jul 2024 12:49:00 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id DE5CF30C0519; Wed, 31 Jul 2024 12:48:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id D9B983CED5;
	Wed, 31 Jul 2024 14:48:59 +0200 (CEST)
Date: Wed, 31 Jul 2024 14:48:59 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
cc: axboe@kernel.dk, gmazyland@gmail.com, agk@redhat.com, snitzer@kernel.org, 
    adrian.hunter@intel.com, quic_asutoshd@quicinc.com, ritesh.list@gmail.com, 
    ulf.hansson@linaro.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
    dm-devel@lists.linux.dev, linux-mmc@vger.kernel.org, 
    linux-arm-msm@vger.kernel.org, quic_viswanat@quicinc.com, 
    quic_srichara@quicinc.com, quic_varada@quicinc.com
Subject: Re: [PATCH 0/6] Add Additional algo mode for inline encryption
In-Reply-To: <20240730115838.3507302-1-quic_mdalam@quicinc.com>
Message-ID: <cbf18ce7-f9bd-c05d-d22-f56ca4ae3240@redhat.com>
References: <20240730115838.3507302-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On Tue, 30 Jul 2024, Md Sadre Alam wrote:

> This series of patches add additional modes for inline encryption
> 
> This series of patches depends on [1] Add inline encryption support for dm-crypt
> 
> [1]: https://lore.kernel.org/all/b45d3b40-2587-04dc-9601-a9251dacf806@opensource.wdc.com/T/#ma01f08a941107217c93680fa25e96e8d406df790
> 
> These patches tested on IPQ9574 with eMMC ICE for raw partition
> encryption/decryption.

Hi

I discussed it with Milan Broz <gmazyland@gmail.com> and we concluded that 
there is no need to bloat dm-crypt with this logic.

We believe that you should create your own target (like 
"dm-inline-crypt"), it would work like a linear target and it will attach 
encryption requests to the bios that it processes.

Mikulas

