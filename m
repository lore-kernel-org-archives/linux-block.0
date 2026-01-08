Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518144CACD4
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875009; cv=none; b=kytFV38Sj+Og9L7Pb7ypa61ytuv5+kzjdhGxMNyWyzdfvuA84mUsvmxBqmRfSzadPv3PcjGoxB+BqZyBnRl/x4Uf0VL7lMYszkcUoT7u+X1NBj78zhc24nqz2wzFdMH1QiwwuMd0wXsBBSQDlecEJjxlzE6JkKyKqAnDmZCAReY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875009; c=relaxed/simple;
	bh=Y7F7dO9vXncbKwJe4dfOeTCypPlmEBPkp2u4qLOK8Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRW3rCv2TdSwEPHfDKNFbIWhJbaQgh6XvlGRSTqDzWD+FSoTnAAkLf/oT40MXecX1+h8ux9YZZmEyaGp9hSdylvf+A38gmXophR1pW2W2CJe2v3yCP6xZ2W7rv0+EeNxVCAja/XqLiKeQdcFL0koldHmoYgAjS8ti91NsOPPBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jAhoOvJQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAhoOvJQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767875007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a0IWOqf9OhY4QzQttGV9NqWyiXgzm15K4lKyCnI9p3Y=;
	b=jAhoOvJQxczXpbRl45hnF4u46kyZALqgBCTbrAYLEKVMakI551bD1PfwU460mD7u0A9hIe
	+8j0+FBTw+USUKAxWfFf9Ec0gfgHSIyOi/dWBpVJuOGVUt6eU9ywF6Z7HJA32u4km+YErs
	TIQF7762qafAzqIqL/CDKcu6L0d/Yp0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636--2yEEi46OK6JieRLBnXv8A-1; Thu,
 08 Jan 2026 07:23:23 -0500
X-MC-Unique: -2yEEi46OK6JieRLBnXv8A-1
X-Mimecast-MFC-AGG-ID: -2yEEi46OK6JieRLBnXv8A_1767875002
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 102CD1800473;
	Thu,  8 Jan 2026 12:23:22 +0000 (UTC)
Received: from fedora (unknown [10.72.116.180])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 632AE1800285;
	Thu,  8 Jan 2026 12:23:14 +0000 (UTC)
Date: Thu, 8 Jan 2026 20:23:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 14/19] selftests: ublk: add kublk support for
 integrity params
Message-ID: <aV-hrsl3CVg_pc5y@fedora>
References: <20260108091948.1099139-1-csander@purestorage.com>
 <20260108091948.1099139-15-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108091948.1099139-15-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Jan 08, 2026 at 02:19:42AM -0700, Caleb Sander Mateos wrote:
> Add integrity param command line arguments to kublk. Plumb these to
> struct ublk_params for the null and fault_inject targets, as they don't
> need to actually read or write the integrity data. Forbid the integrity
> params for loop or stripe until the integrity data copy is implemented.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

