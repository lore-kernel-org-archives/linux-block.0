Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461B5331205
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769825363; cv=none; b=Jps7LC+hDK39vDYgU0QMW/fvL5fJA4VKSWk76cVDkZo2QvmZFwVZhaAokODKrE0eOUaxV4prw+EEkPiOFDgfPtVc+uV2Kd92w27drnQ2hT5CVTIzAxqs3ulhgdFqwmMCT6FbZGVgdWWHYQV5KA10Y3uoVFR8zr9VFZh/BKRIE60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769825363; c=relaxed/simple;
	bh=msHqcg1vRtPmOTZbt+fJHRXiDHuEb5KKDVIiNqfe7WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgzXqkQl5wPxdpC01vxsu9Y8IQ5dHvAp5RQyAohbB9sNmve9s3r2B+E0798FTapQkdTvKXbQtuRBl3yhVx34hTRRDsZ0IuRP6akvtzepuLIFZ/K+VTxgZE59M+j51uQWjLUX6bNMjoIkuchyJQremekI6vuLnpLLqv8ETKCOU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVbYUifV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVbYUifV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769825361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wMMN/4mGp9CSYZgX6Y/B60oGiGM/a8bSA3U/a+ACEN0=;
	b=AVbYUifVz+KraVUhGJI+sfP3Z2n52ZJ4WQu1Preakq5G1C86WODByFlhnKJ+tKlWw5pjl7
	ldU6gt6c52GP9Miuo23VDRQofLUdJcyuJUEX1U6Mozk0A40AkItAdwVavvqYjsU415S4Wy
	4vS8JAQM3LT/Gdjka3yAFyOkuNEWDWc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-nsk2ouhUMPy2uQIQvuExNA-1; Fri,
 30 Jan 2026 21:09:15 -0500
X-MC-Unique: nsk2ouhUMPy2uQIQvuExNA-1
X-Mimecast-MFC-AGG-ID: nsk2ouhUMPy2uQIQvuExNA_1769825354
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5313119560B7;
	Sat, 31 Jan 2026 02:09:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.21])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DB031956056;
	Sat, 31 Jan 2026 02:09:09 +0000 (UTC)
Date: Sat, 31 Jan 2026 10:09:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Govindarajulu Varadarajan <govind.varadar@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ublk: drop ublk_ctrl_start_recovery() header
 argument
Message-ID: <aX1kQQ2xwuP0j12i@fedora>
References: <20260130171414.1376543-1-csander@purestorage.com>
 <20260130171414.1376543-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130171414.1376543-4-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Jan 30, 2026 at 10:14:14AM -0700, Caleb Sander Mateos wrote:
> ublk_ctrl_start_recovery() only uses its const struct ublksrv_ctrl_cmd *
> header argument to log the dev_id. But this value is already available
> in struct ublk_device's ub_number field. So log ub_number instead and
> drop the unused header argument.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

