Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF022FFFA5
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776445098; cv=none; b=FngXjwn0bTHvZCr4tPj3EA3wJlwNf+RdOfm6lrS89Kr4UYdtr284eVrciZohACsyDC6mXrdEf4DNpw17pJDwB/YuLOVMHq4GFumRC311OLAJDaRSNa3N/TpGh/grTxyw5MPB2oYKj0Mo7BM5oURy7cczOqrbM69PFE/mppjhOMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776445098; c=relaxed/simple;
	bh=bWW/GnGanoc2swdz1WuPRkprCjHBIK3TuTRWtfg7S0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/+8cntWTqqfIKtgPf81PnCUosJh5LGCj5qJZ3iYByhv9QTShURl9kj6bE4FQ+ev4wWCu5TbVowMoTBt/2eLXr/5LLdjNPJTwURv5D0F95IKfPKtpwLdTcHGvBeYdAHVBW04RLxhuTcGjM1M0DIXmlHD0M/i37AWduT6RRVz7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVFln2uE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVFln2uE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776445096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aLM10jOwdSOCKnbr47lCVYbynLEmuueYz8PH1kR1jlk=;
	b=NVFln2uEEl0A7UNq7stOqA1xuSHhVA/8Mc8VukQxt2svguQQ0CSj3prpok8spJ45Xi/8Ld
	DYiz6yZmz6DiBHXdlLc6utaqLJuv1UD0o4+kO56Mb7dnPh02jUHMm2ZuaJZE8VSChbRpLo
	A4NrOD41J2Cmy76HqtAtyI1XzM4M0iw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-3qTGo_kRMMyDgF51cl9okQ-1; Fri,
 17 Apr 2026 12:58:14 -0400
X-MC-Unique: 3qTGo_kRMMyDgF51cl9okQ-1
X-Mimecast-MFC-AGG-ID: 3qTGo_kRMMyDgF51cl9okQ_1776445093
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2037E1800282;
	Fri, 17 Apr 2026 16:58:12 +0000 (UTC)
Received: from cleech-thinkpadt14sgen2i.rmtusor.csb (unknown [10.2.16.224])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 106C51800660;
	Fri, 17 Apr 2026 16:58:08 +0000 (UTC)
Date: Fri, 17 Apr 2026 09:58:08 -0700
From: Chris Leech <cleech@redhat.com>
To: alistair23@gmail.com
Cc: hare@suse.de, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	kbusch@kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	yi.zhang@redhat.com, mlombard@arkamax.eu, linux-block@vger.kernel.org, 
	shinichiro.kawasaki@wdc.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 2/2] nvmet-tcp: Don't clear tls_key when freeing sq
Message-ID: <20260417-9fecb7f3795b98707372292b@redhat.com>
References: <20260417004809.2894745-1-alistair.francis@wdc.com>
 <20260417004809.2894745-2-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417004809.2894745-2-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Apr 17, 2026 at 10:48:09AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Curently after the host sends a REPLACETLSPSK we free the TLS keys as
> part of calling nvmet_auth_sq_free() on success. This means when the
> host sends a follow up REPLACETLSPSK we return CONCAT_MISMATCH as the
> check for !nvmet_queue_tls_keyid(req->sq) fails.
> 
> A previous attempt to fix this involed not calling nvmet_auth_sq_free()
> on successful connections, but that results in memory leaks. Instead we
> should not clear `tls_key` in nvmet_auth_sq_free(), as that was
> incorrectly wiping the tls keys which are used for the session.
> 
> This patch ensures we correctly free the ephemeral session key on
> connection, yet we don't free the TLS key unless closing the connection.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  drivers/nvme/target/auth.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Chris Leech <cleech@redhat.com>

