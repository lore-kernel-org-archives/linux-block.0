Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA0D26656F
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 03:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758080986; cv=none; b=Xc0BSGOTegCsaaX+I+a/bBGklfLF9WRi2DpbGu61yF6HZNl8TV9Ofb3vQt7zCj7qZ1XDMMgdjHlKRKuIVHkkRYDnlIYpt7MLWsClk/vlRm2aGrKHxg/0D2YBc3EKGvHxufkMXd8Rb8DJu4+EqbqvSy9uk/zp+H8cBXDAx0IsEbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758080986; c=relaxed/simple;
	bh=UaBjcrDAy8qe35zcK0EvPixIhqJUoVPcks/Cvf//7TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYsdw/5x6oXIo5IFZ9N1MOzOfxxcSg0tWTRCo/9H48nUOY1IHwRb4DgYI15EI4sX5Mg6/m2KGxap3rkqYbk8VQjfN8DRdqOnGARIIAf5opewBBWyaATJfhfI/lv7syjVIR+fjBSXuRIZAHD2gyxzPwSDuIIDJEP3kPVQXNtD6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdGKJsEs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdGKJsEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758080984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9qpmrXCKv/lBEPu/+D2jjLY1f+6nwSMqsX4httEPJc=;
	b=PdGKJsEs4FlVF8jAxGuX2eRnDWkjPYMseBUYSVUXvzjoQIN8FBiU4c+IymYjqqgPVG0GeU
	9nzp3csMM8c4JXhGsKrXT4MnlEMsJd4Xvh8DHQ1Y5zu4tLHeXG2B2X90u6WPuRO3SkjYD2
	ptoyBkuVy0mKkPfUfqMxaTOiQzWA/Rk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-XtgHUay3PuOsIqEaLT2_5Q-1; Tue,
 16 Sep 2025 23:49:40 -0400
X-MC-Unique: XtgHUay3PuOsIqEaLT2_5Q-1
X-Mimecast-MFC-AGG-ID: XtgHUay3PuOsIqEaLT2_5Q_1758080979
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86F251956050;
	Wed, 17 Sep 2025 03:49:39 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F03819560B8;
	Wed, 17 Sep 2025 03:49:35 +0000 (UTC)
Date: Wed, 17 Sep 2025 11:49:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests: ublk: kublk: simplify feat_map definition
Message-ID: <aMovycUcPR1mK1cg@fedora>
References: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
 <20250916-ublk_features-v1-1-52014be9cde5@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-ublk_features-v1-1-52014be9cde5@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Sep 16, 2025 at 04:05:55PM -0600, Uday Shankar wrote:
> Simplify the definition of feat_map by introducing a helper macro
> FEAT_NAME to avoid having to type the feature name twice. As a side
> effect, this changes the names in the feature list to be the full macro
> name instead of the abbreviated names that were used before, but this is
> a good change for clarity.
> 
> Using the full feature macro names ruins the alignment of the output, so
> change the output format to put each feature's hex value before its
> name, as this is easier to align nicely. The output now looks as
> follows:
> 
> # ./kublk features
> ublk_drv features: 0x7fff
> 0x1               : UBLK_F_SUPPORT_ZERO_COPY
> 0x2               : UBLK_F_URING_CMD_COMP_IN_TASK
> 0x4               : UBLK_F_NEED_GET_DATA
> 0x8               : UBLK_F_USER_RECOVERY
> 0x10              : UBLK_F_USER_RECOVERY_REISSUE
> 0x20              : UBLK_F_UNPRIVILEGED_DEV
> 0x40              : UBLK_F_CMD_IOCTL_ENCODE
> 0x80              : UBLK_F_USER_COPY
> 0x100             : UBLK_F_ZONED
> 0x200             : UBLK_F_USER_RECOVERY_FAIL_IO
> 0x400             : UBLK_F_UPDATE_SIZE
> 0x800             : UBLK_F_AUTO_BUF_REG
> 0x1000            : UBLK_F_QUIESCE
> 0x2000            : UBLK_F_PER_IO_DAEMON
> 0x4000            : unknown
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

