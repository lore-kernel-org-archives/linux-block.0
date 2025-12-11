Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62CB19C546
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765443559; cv=none; b=b+9YUNRnbRIXiN7UUoroU7MriI3fPdRVizT3RiWlVT+QapADwNmS6VcGFYKvO1amQOjMd1ifhTuHR7QKrDa0qCsP3V8PBvFBV7GAJT+N+IIzSSyjn5fhTMA80skCNfcfzg00k86Qqhbs+37rZ3i4rnuIPyRyMpi8GkA/drI5rF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765443559; c=relaxed/simple;
	bh=MaO96beCTmaZPPeRZKxi8qaBVoB23RxfCIkZ5W4kcFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWQaJtWoDN5BySTk6U0BfoDmUV2YvTQO0xR61OPnUjiY5DWb3gQ29KW1qMDTWbAbQiWVL1u1SvVSCsQkVJZOzumu0AmjSTtbqoRAuvMRHGRYM+cK3PiBIbcCQvowzB8Qk9qKevarY6tZEzhtG3h6ZkONUbxAsnT43f/ujkI6iEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIIoGrM8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIIoGrM8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765443555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F2LQsFB3zw5vhuPzwxcrrOJgGt/OwAD2FBJ32W8RgcI=;
	b=FIIoGrM8nRW9vMATy4sA2cXv9TXAOdWjMJ9aQhdCAI7gVHJ6CAd+IQ/emHIywXcbO1RTLX
	mqo0pq9C2yV4XMXg7eFiLclglagNPiWl1X8P/iCLQSs5VMNHKtzIM7Hzv0Ock3OTlVDlE+
	xPfiMUAvuV0Q62XwsfnTjuAyB9L5YvA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-RlFsVLWnPlimQ2R69huZug-1; Thu,
 11 Dec 2025 03:59:12 -0500
X-MC-Unique: RlFsVLWnPlimQ2R69huZug-1
X-Mimecast-MFC-AGG-ID: RlFsVLWnPlimQ2R69huZug_1765443551
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1ED561800451;
	Thu, 11 Dec 2025 08:59:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B89F91800451;
	Thu, 11 Dec 2025 08:59:07 +0000 (UTC)
Date: Thu, 11 Dec 2025 16:58:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] selftests: ublk: remove unused ios map in seq_io.bt
Message-ID: <aTqH0See4rFDwMga@fedora>
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211051603.1154841-3-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Dec 10, 2025 at 10:15:57PM -0700, Caleb Sander Mateos wrote:
> The ios map populated by seq_io.bt is never read, so remove it.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  tools/testing/selftests/ublk/trace/seq_io.bt | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
> index 507a3ca05abf..b2f60a92b118 100644
> --- a/tools/testing/selftests/ublk/trace/seq_io.bt
> +++ b/tools/testing/selftests/ublk/trace/seq_io.bt
> @@ -15,11 +15,10 @@ tracepoint:block:block_rq_complete
>  			printf("io_out_of_order: exp %llu actual %llu\n",
>  				args.sector, $last);
>  		}
>  		@last_rw[$dev, str($2)] = (args.sector + args.nr_sector);
>  	}
> -	@ios = count();

BTW, it was for debug purpose, but now it isn't needed.

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming
~

