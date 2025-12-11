Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85252E1C6F
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765443500; cv=none; b=SkrUczDBvISgm/yo6ohXLgEi3+zczuA1yWWoNHrlIhR0SycAfd1fPdKfB43H47quYdwbkSEXRGTJHbLGVtZADk0Q+ZAVMsXspy/pMIqqAs6nWB691iH9ziasBVIFK4CbibxhssVlq8CmHVsysNYDcdgjQaZo4ouLKwre3EtxdkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765443500; c=relaxed/simple;
	bh=ikTlwrQmci4X/uusets6DAXQBh3inbX9GdiNQBLv/+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AA+sE7w0d9FBMd3v/sd8oDX2ETacislmDo/NLk/86jZ4oTruF9tfpXuACKdBYrZ/8w0l6LQDbnyrhmVqsnFkp0Ovt02QSdN2jkl/J1MwxT0aGBKTEK+w9zW2kFyE33L8O/ENH4A0bDyXLY1kloiWEK0E8Kc6Q3uPQ4fWLvofR/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpMK/rRT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpMK/rRT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765443496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=65Y1627ZV2tbL0TMEgxGlq6K39Yb3mgwd2DIfysE9SI=;
	b=CpMK/rRTSn38LWXfE530qtrJggq7PJ91f7IUxdsBw00fvrXXN5Ro0t5tpHcD6Unn2c9Fza
	lc2VOGeEBSlaQYbGcetPImbXRs+H8wjKySjgzF+TXWA9g7tt/0Fj1HVNUJ03r08naxJ2f5
	3OtSKIbbAAqjH6zhIVSdkK1B8I6+6nc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-cvmRlKlMNaGtLd2Xlj5i1A-1; Thu,
 11 Dec 2025 03:58:14 -0500
X-MC-Unique: cvmRlKlMNaGtLd2Xlj5i1A-1
X-Mimecast-MFC-AGG-ID: cvmRlKlMNaGtLd2Xlj5i1A_1765443493
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64231180035A;
	Thu, 11 Dec 2025 08:58:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D08EA30001A2;
	Thu, 11 Dec 2025 08:58:09 +0000 (UTC)
Date: Thu, 11 Dec 2025 16:58:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] selftests: ublk: correct last_rw map type in
 seq_io.bt
Message-ID: <aTqHnCSZMiobMtXL@fedora>
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211051603.1154841-2-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Dec 10, 2025 at 10:15:56PM -0700, Caleb Sander Mateos wrote:
> The last_rw map is initialized with a value of 0 but later assigned the
> value args.sector + args.nr_sector, which has type sector_t = u64.
> bpftrace complains about the type mismatch between int64 and uint64:
> trace/seq_io.bt:18:3-59: ERROR: Type mismatch for @last_rw: trying to assign value of type 'uint64' when map already contains a value of type 'int64'
>         @last_rw[$dev, str($2)] = (args.sector + args.nr_sector);
> 
> Cast the initial value to uint64 so bpftrace will load the program.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  tools/testing/selftests/ublk/trace/seq_io.bt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
> index 272ac54c9d5f..507a3ca05abf 100644
> --- a/tools/testing/selftests/ublk/trace/seq_io.bt
> +++ b/tools/testing/selftests/ublk/trace/seq_io.bt
> @@ -2,11 +2,11 @@
>  	$1: 	dev_t
>  	$2: 	RWBS
>  	$3:     strlen($2)
>  */
>  BEGIN {
> -	@last_rw[$1, str($2)] = 0;
> +	@last_rw[$1, str($2)] = (uint64)0;

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

