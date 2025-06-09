Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342574C8E
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749453583; cv=none; b=CzVo5vNokRAY8notFugaXLnEdHsMl9NldCSAfczUErY4q+eztDuiuZhXv1w52AVU700nwoeW2MBWIOkqvxVxidIytXhzCt7LDXZceO4FEZfiheySKXg5RhwZYAdzCOjKD6pV4+wOfrgCkFxPTBxf803aCqPPRRpu6IZ5fg/osX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749453583; c=relaxed/simple;
	bh=BO5gs1JcvZPZnqUnvQDfGBOCvSTECklMeB31Yid0qzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y33e6irvnXE6mlHk2OLqTTMAH27pWGqr7feV7d+jllO1gEiE8EYXVdpJt+Jc1+Pp3XSqSIqCU12KqfTZZqzFFN9yNHAvzrKqpY1IGCzL8XnTgZmBm11x8kje8Pns7gxCCuw6XekC2sjT9mTnAeq+D3XSY/X5w17RuM86xFy73c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9ajKYMF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9ajKYMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749453580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVJyCKhiizWjCtBSO2ul6Ce0A0uM7D/dRSeA/2P7SqM=;
	b=g9ajKYMF0sG6hf1gLs6TtNHpAwNK93KQJMQ3Sl6yP8SuHHSTbuKqM48OC4KhJcpVx6RAnv
	YoaAbM5B0R2LMB5hldRLu0cbiOo91QvqAB6n0OglpM+vy0Jkm8hiYVad/4KTJWLTjftHvw
	n1Fn4+wLb4sFXjz/pRiHJZXmzE8UAbw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-4KEbccalOMGFfuBqXfqgKw-1; Mon,
 09 Jun 2025 03:19:36 -0400
X-MC-Unique: 4KEbccalOMGFfuBqXfqgKw-1
X-Mimecast-MFC-AGG-ID: 4KEbccalOMGFfuBqXfqgKw_1749453575
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 840C318002EC;
	Mon,  9 Jun 2025 07:19:35 +0000 (UTC)
Received: from fedora (unknown [10.72.116.58])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B2C019560A7;
	Mon,  9 Jun 2025 07:19:32 +0000 (UTC)
Date: Mon, 9 Jun 2025 15:19:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/8] ublk: consolidate UBLK_IO_FLAG_{ACTIVE,OWNED_BY_SRV}
 checks
Message-ID: <aEaK_9gB-0R1MQ-i@fedora>
References: <20250606214011.2576398-1-csander@purestorage.com>
 <20250606214011.2576398-5-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606214011.2576398-5-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Jun 06, 2025 at 03:40:07PM -0600, Caleb Sander Mateos wrote:
> UBLK_IO_FLAG_ACTIVE and UBLK_IO_FLAG_OWNED_BY_SRV are mutually
> exclusive. So just check that UBLK_IO_FLAG_OWNED_BY_SRV is set in
> __ublk_ch_uring_cmd(); that implies UBLK_IO_FLAG_ACTIVE is unset.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

