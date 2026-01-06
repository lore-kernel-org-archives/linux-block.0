Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820B91EA7DF
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706611; cv=none; b=gw/uq1/U4vuhmTDCP2MBPkrBrO28EfCF+LU4It8+ZfafyI3WSXE+DOooKTiFqlqpZJjQTsMboqGJFvUgsm3B6Ji2UVuWATCqZoLxU6XwI9knmqD9DZcMQtEgR4vGZrRDUlbn9QDXWZ5Cgpg0FNVD9UvLLIYrz7Hh4w5lgXUiVsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706611; c=relaxed/simple;
	bh=SFx2b2O5Xai/31PBK1ljJU5OeDhmpnKFS85HBJDBJrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNZApG5I67xyHRT1m93q3uhkAttRrSCAc9vFNG0jtoetqKYPTrr06+am81rsSdxEco88eplB/wwLBZS1dP15ikjIa9i0ls4ib+YqovaW9c0D1e9tCdfd2Z357bFN/D9jm8rkE0AMSgczEg1phkyop8piR6ka5O9uvBjKB2hbGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WRzIEboG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRzIEboG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767706608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kQH2tS6p8C6ddM5URhXlqhqtGE7QDS7qlRZ/W9IQQrE=;
	b=WRzIEboGaV8CKlJi8OU6XN4lCh8RKX/2F2GlD0rWSvyMlSExFD+t0K711YQuJgkSr/nwUA
	7CHfob/KVwr62gAdEQYrepyn3UhV0TXNPj2Z+zWudW8k0RwJOAdYVkCdoiNQrIyCFqbdR1
	5vwOoUzbREdEBA0dpL4v+r0d9hozqsA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-gs9YGgADNteo5E4VG9F1XA-1; Tue,
 06 Jan 2026 08:36:43 -0500
X-MC-Unique: gs9YGgADNteo5E4VG9F1XA-1
X-Mimecast-MFC-AGG-ID: gs9YGgADNteo5E4VG9F1XA_1767706601
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67E6D195DE48;
	Tue,  6 Jan 2026 13:36:41 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 565D819560AB;
	Tue,  6 Jan 2026 13:36:22 +0000 (UTC)
Date: Tue, 6 Jan 2026 21:36:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3 10/19] ublk: support UBLK_F_INTEGRITY
Message-ID: <aV0P0DCt4Jprm-Wy@fedora>
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-11-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106005752.3784925-11-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jan 05, 2026 at 05:57:42PM -0700, Caleb Sander Mateos wrote:
> From: Stanley Zhang <stazhang@purestorage.com>
> 
> Now that all the components of the ublk integrity feature have been
> implemented, add UBLK_F_INTEGRITY to UBLK_F_ALL, conditional on block
> layer integrity support (CONFIG_BLK_DEV_INTEGRITY). This allows ublk
> servers to create ublk devices with UBLK_F_INTEGRITY set and
> UBLK_U_CMD_GET_FEATURES to report the feature as supported.
> 
> Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> [csander: make feature conditional on CONFIG_BLK_DEV_INTEGRITY]
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 9694a4c1caa7..4ffafbfcde3c 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -73,11 +73,12 @@
>  		| UBLK_F_USER_RECOVERY_FAIL_IO \
>  		| UBLK_F_UPDATE_SIZE \
>  		| UBLK_F_AUTO_BUF_REG \
>  		| UBLK_F_QUIESCE \
>  		| UBLK_F_PER_IO_DAEMON \
> -		| UBLK_F_BUF_REG_OFF_DAEMON)
> +		| UBLK_F_BUF_REG_OFF_DAEMON \
> +		| (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0))

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

