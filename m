Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07364DC529
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876388; cv=none; b=uE5xuUNmfzDeAGG3q61lIuRKHGYBOz48w14MIu2H3JrF6iHhXOjO5C2FZ9H14y/nxKYJy4VvffY98Pqa9wnM0K/w8vW7FXNHnZeVpgI3kYbjjNWx0yHIj3ruwFsbpvpGym0HQ6PzYxHvoFkEOuVmDNe2sv6LvvIwGREkOIEeLyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876388; c=relaxed/simple;
	bh=QL9YlTQaN2PY6NHDDn3eWnaSKYuYEK10I9sZaXTvqpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=karve/yknSAtwA7Y4+Lsl18AZV1/wMPvv2/eGNOrWdxEwNexX7WgzdMni+o5nHOYmDYQJrBctx2icY/L1C46VJO+4Hk2XuXvqG3s1XqAOzfQDR9s+D0EVtgVO6izLfkDYrgEbHEdtepZCnQNzDkjoAF6kN6IYmFogstqHrNBVe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LMv1tXWU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMv1tXWU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767876385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/qPu+3LCPnbGPgQeEn2OSt57+pLzCrb6Wk2W972BMI=;
	b=LMv1tXWUbXy5aJSC3VX8POlgMtwcZBj6BC/w+hMUH1HJJNzODLoByFNVN5rBdWtI9fbD4D
	xppr+zh5rG8W0OducCsteT4SqZyZTCsNr/KF2hrT4sldcpfPDXsFOZkQd5bu5VnddMBPsb
	seSFuStmyX5Q7of67KkyjHIdyc16HUU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-QGEVK5a-MIqs_0LFdJdNtw-1; Thu,
 08 Jan 2026 07:46:22 -0500
X-MC-Unique: QGEVK5a-MIqs_0LFdJdNtw-1
X-Mimecast-MFC-AGG-ID: QGEVK5a-MIqs_0LFdJdNtw_1767876381
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9EDD1955DC3;
	Thu,  8 Jan 2026 12:46:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.180])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DAE230002D1;
	Thu,  8 Jan 2026 12:46:14 +0000 (UTC)
Date: Thu, 8 Jan 2026 20:46:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 19/19] selftests: ublk: add end-to-end integrity test
Message-ID: <aV-nEZ_HBanIH6cH@fedora>
References: <20260108091948.1099139-1-csander@purestorage.com>
 <20260108091948.1099139-20-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108091948.1099139-20-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Jan 08, 2026 at 02:19:47AM -0700, Caleb Sander Mateos wrote:
> Add test case loop_08 to verify the ublk integrity data flow. It uses
> the kublk loop target to create a ublk device with integrity on top of
> backing data and integrity files. It then writes to the whole device
> with fio configured to generate integrity data. Then it reads back the
> whole device with fio configured to verify the integrity data.
> It also verifies that injected guard, reftag, and apptag corruptions are
> correctly detected.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

