Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EDC14C582
	for <linux-block@vger.kernel.org>; Wed, 25 Sep 2024 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235821; cv=none; b=BCaHNH5Bjt/FoDHoZ4qIDesxjv22ZHLr+AKkX+7qv9u35vue404RV++1e8gbP3tr/4+1kGf2cI4nwaj0+MzYPTTfIqJKFMcCgee3IlFh49kMxRhYRo9I/oQs0jMXVOCAOTwHgcf8VmBKNxpqUtLnPhqr95UC2Fhalw9eIdY8oD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235821; c=relaxed/simple;
	bh=mWNKGq/Rb9mpPQiJY3D4D6VJQUItpSt89LjABgJwTa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRbSnjuFcVIbjddA+Tf7IvfgJHIIAAPzYi8U4C1Z/oEAogTSmgqDdAKV8h4VsX7gktne2O6KxI8fLGZFzPmmmTvNOSK/T6AY1pxqs7VM8Klk2CjWY5xOEigpkVGClCDaPH3jkF6JXSwGuNwyePWsLJgaRISxy8OMe2PFSwtz0lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUqBp5dr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUqBp5dr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727235819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NHb8dV8z/j5b9HDlBSuonk8HoQBx+V68SDEn9Igkrg8=;
	b=QUqBp5drJtSbrXNIiGXvwcwsOs9I3T2ng7JMwaAXSVW+oykYebpSzzE9bcgrNoGY9Cp074
	zYq7Y2LirRH5CNd23doxiDuT9gKS00YxaqTqR3HxbfbPFQNqN3xfxyYaWvBmLqu5SkVCaW
	Z/D8wMicZ51ZmECLlHPxv4ytb6ov8t0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-V5dKm6VcMl2hwVTERNqZlQ-1; Tue,
 24 Sep 2024 23:43:37 -0400
X-MC-Unique: V5dKm6VcMl2hwVTERNqZlQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95BC1197702B;
	Wed, 25 Sep 2024 03:43:36 +0000 (UTC)
Received: from fedora (unknown [10.72.116.51])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1284C19560AA;
	Wed, 25 Sep 2024 03:43:32 +0000 (UTC)
Date: Wed, 25 Sep 2024 11:43:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ublk: check recovery flags for validity
Message-ID: <ZvOG37CBbqitwZ5H@fedora>
References: <20240917002155.2044225-1-ushankar@purestorage.com>
 <20240917002155.2044225-2-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917002155.2044225-2-ushankar@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Sep 16, 2024 at 06:21:52PM -0600, Uday Shankar wrote:
> Setting UBLK_F_USER_RECOVERY_REISSUE without also setting
> UBLK_F_USER_RECOVERY is currently silently equivalent to not setting any
> recovery flags at all, even though that's obviously not intended. Check
> for this case and fail add_dev (with a paranoid warning to aid debugging
> any program which might rely on the old behavior) with EINVAL if it is
> detected.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

