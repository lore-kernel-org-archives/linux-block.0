Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4816920326
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 02:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728355701; cv=none; b=heeIRLW2tMiAcvcDeA7w5ulEtOLZFrGXWeAwbZuE1rt4RFIQSscSX8R8Nx7SEqDb9BfBPG1v0gLurW12S1a2kUz0qZckBiYCNQ95lZm8ky0m5DfIQ65LxGoEAQ8sp0lWxp/uPpD0W/5uwMQxk/qkxStLTXPZkC9jQjGWXcWUm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728355701; c=relaxed/simple;
	bh=00l3ew/+mUdwOjmX4YW9hrWtqAXJr9UModlO93k7rBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0dqxrOjAbzejApib3d+LXNI/PwhMLm4TXSPVYc2K+BAbvYGSlwbmsniD8xCVZJGPnUKvu+Zg/76CkmWbc6DXA9DAF54YmaVPpvEpg9xJuIYYBLJqXzSftIh6CsvmECKxkMU9jU7YFl2XYmevzXG9uyTsbdgIxGEImic8BvmfNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqWeD9gK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqWeD9gK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728355698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=72e4QnH4D6K+NkUJS7yS03i2OR/C2I3oUkzItklfg0k=;
	b=SqWeD9gKBAR8euuF/GdrG1EQ+7WI1z1YhMBTGh+kRhq5Lig9R3OKNTYT4UyKdx9Vnuyet+
	lDDixCg6LvOKnZ5Uvoi9FxEZWwdnXobezW47r91D++jPD8aLKJn8MPXoS745ICfosTDV/E
	MyW1lXGmtsgaF9xnw6XIylcZEpyhN2k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-Pb3mLiR8M_qUIZ8bAPL7CA-1; Mon,
 07 Oct 2024 22:48:14 -0400
X-MC-Unique: Pb3mLiR8M_qUIZ8bAPL7CA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8624A19560B2;
	Tue,  8 Oct 2024 02:48:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.102])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2F74300018D;
	Tue,  8 Oct 2024 02:48:08 +0000 (UTC)
Date: Tue, 8 Oct 2024 10:48:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 4/5] ublk: support device recovery without I/O queueing
Message-ID: <ZwSdYnVpceFGtb8O@fedora>
References: <20241007182419.3263186-1-ushankar@purestorage.com>
 <20241007182419.3263186-5-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007182419.3263186-5-ushankar@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Oct 07, 2024 at 12:24:17PM -0600, Uday Shankar wrote:
> ublk currently supports the following behaviors on ublk server exit:
> 
> A: outstanding I/Os get errors, subsequently issued I/Os get errors
> B: outstanding I/Os get errors, subsequently issued I/Os queue
> C: outstanding I/Os get reissued, subsequently issued I/Os queue
> 
> and the following behaviors for recovery of preexisting block devices by
> a future incarnation of the ublk server:
> 
> 1: ublk devices stopped on ublk server exit (no recovery possible)
> 2: ublk devices are recoverable using start/end_recovery commands
> 
> The userspace interface allows selection of combinations of these
> behaviors using flags specified at device creation time, namely:
> 
> default behavior: A + 1
> UBLK_F_USER_RECOVERY: B + 2
> UBLK_F_USER_RECOVERY|UBLK_F_USER_RECOVERY_REISSUE: C + 2
> 
> The behavior A + 2 is currently unsupported. Add support for this
> behavior under the new flag combination
> UBLK_F_USER_RECOVERY|UBLK_F_USER_RECOVERY_FAIL_IO.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

