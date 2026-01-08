Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99D84F59B7
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875736; cv=none; b=ejtnjkiD1U0vm3y316suK9Xbn24vul1ZC4fUqqSZ5MOFrGfTLbwjV+WCdiLEk27tvlGE5fpzKL5UE6eTKpDx8bBB128yD+m/20i7X1aNUnkstTv6QFYJHJHdILP10+xnjZCXGy4U9XuQlOkc4sOhSXjFOzRWI5uOlOi7wPbzg90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875736; c=relaxed/simple;
	bh=7W5IbUQig48mmUun66kOBBefkisQQnzRZrgjkYz+eTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHEXCystI9MC+4Ofdea4IEoZjhLCdsGcRpYgPWkp1kLO/reuPJTvNUwfRlFQ39jWIqGMm7p/6j30VSwNgR457Eq3mbnSq7Vzaj9aUg5X9JWk1afhnvvO19Ug2A0MSXG/F523ftEEjGujC2cNCgg6/+CUDqFmNusNKVrWXZh99O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUVsTr0h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUVsTr0h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767875733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QGIZxA5+0nMI2UGYg26r4G9izdzM1b9mlt5Z8K1XQNg=;
	b=aUVsTr0hPvXXqpTDASLVHpFVAGvycxkYFkErJYdxtcB1LLbUSnX1tY5k6l0eQWjSBoXk8i
	7cGNknAubnBPSWvn8phMbWuJyuaAacPt1fO27oUVN725fWd/Ql1yhU8mn1BOFKB3iCijQ7
	AV5EYbs293f+CMjMsld67YOpiX9WIw4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-5pMAXFOXO4K1pz8Gkfbc1A-1; Thu,
 08 Jan 2026 07:35:30 -0500
X-MC-Unique: 5pMAXFOXO4K1pz8Gkfbc1A-1
X-Mimecast-MFC-AGG-ID: 5pMAXFOXO4K1pz8Gkfbc1A_1767875728
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A05C818005AD;
	Thu,  8 Jan 2026 12:35:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.180])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E9D619560A2;
	Thu,  8 Jan 2026 12:35:22 +0000 (UTC)
Date: Thu, 8 Jan 2026 20:35:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 16/19] selftests: ublk: support non-O_DIRECT backing
 files
Message-ID: <aV-kgiZlP7DBz0bx@fedora>
References: <20260108091948.1099139-1-csander@purestorage.com>
 <20260108091948.1099139-17-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108091948.1099139-17-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Jan 08, 2026 at 02:19:44AM -0700, Caleb Sander Mateos wrote:
> A subsequent commit will add support for using a backing file to store
> integrity data. Since integrity data is accessed in intervals of
> metadata_size, which may be much smaller than a logical block on the
> backing device, direct I/O cannot be used. Add an argument to
> backing_file_tgt_init() to specify the number of files to open for
> direct I/O. The remaining files will use buffered I/O. For now, continue
> to request direct I/O for all the files.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>
 
Thanks,
Ming

