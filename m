Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625B9362129
	for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985609; cv=none; b=GZVLc8PSiassOBh2aUiPDYq6R827DyqnnZkSy5fwXfjFPVnDAUGa/gDr6zJQOhiBCDUrt5QZRgi+pqhFd22vZynfagIxIdlg6IPyof2dGWK+PiHt61rAethrkpq/DExR9SIS3/QRHjoS0oAcDH0PHr9ZfLPRlGOSncX5X0s8Rtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985609; c=relaxed/simple;
	bh=wNrfIHrc5Czz+jzZxfKu/ErFsallL7ACy54NLdpq9XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=difEzoqWeFtYNapkWrMtk2mjHyLLXNRmBCeGac6bIp4qzv8kJGXAbnf3w6bFp4qBoDK6Qa8n2ufo55UJqOmxvyRYVeCRGZn+3l+Eg/AhTQwHUIwPatu5jbro1DBXZ4D2GeiYLgro1tul6HHsfaYVmrY3PY0xeEVISlHI3h4VwIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAI2EYq2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAI2EYq2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768985606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tae9U7McvW0hfPoFDeOkrv1yDXDhuBS782pMRzhzkVk=;
	b=ZAI2EYq2u0Xyk3sN2TONRASny/OZJDzOQ2KrWGJTTW8uPSKWlMPUvqBKOjOSRxVbxFBrSX
	WasE/gBOG19EKfFZVmUXw/KuIgneW4tBJ7IE6hh2CWEczNZmrhaffXOBJLhVYiPmF0i88m
	xQiVVFhU7IXCYhMheGrjhQFtFm8aMHc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-z_KCQ28HOmKlPseQwUEmZg-1; Wed,
 21 Jan 2026 03:53:22 -0500
X-MC-Unique: z_KCQ28HOmKlPseQwUEmZg-1
X-Mimecast-MFC-AGG-ID: z_KCQ28HOmKlPseQwUEmZg_1768985601
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F17719560AE;
	Wed, 21 Jan 2026 08:53:21 +0000 (UTC)
Received: from fedora (unknown [10.72.116.62])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDF9219560B2;
	Wed, 21 Jan 2026 08:53:15 +0000 (UTC)
Date: Wed, 21 Jan 2026 16:53:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [bug report] nvme-tcp poll queue causes busy loop and 100% CPU
 in nvme_tcp_poll() on the latest linux-block/for-next
Message-ID: <aXCT9sFChMdhwNYw@fedora>
References: <CAHj4cs9JJu+dDZqAvCd1qPM1CZuV-_b-AHxXpU-vJrGHHO-ExA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs9JJu+dDZqAvCd1qPM1CZuV-_b-AHxXpU-vJrGHHO-ExA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Jan 21, 2026 at 10:50:00AM +0800, Yi Zhang wrote:
> Hi
> 
> This issue was observed on the latest linux-block/for-next during CKI
> test, where enabling the poll queues leads to a tight busy polling
> loop and 100% CPU usage during "nvme connect".
> It seems was introduced from v6.19-rc1 and cannot reproduced on v6.18.
> I will try to bisect it.

It may be related with f22ecf9c14c1 ("blk-mq: delete task running check
in blk_hctx_poll()").

I guess it only happens when `nvme connect` takes a bit long time, not sure if
it can be reproduced 100%.


Thanks,
Ming

