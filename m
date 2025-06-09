Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34CE2571C9
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749452267; cv=none; b=cP0WIwUEs+Jv+fWWkYjcfU6s95IGYq/ewwgLQ/wXXFyyoUTM/cpgVDbklkJ5EjvrAwI1cNRhpGoG4N/q3UrHZGpkgg4KDQ8Xd6kkkf9wQfHdCfZKBUNdBjdr6FlBJCbRtPfXgAYPrzSTL5KbgPRK6BbTI3mKL0D7s2en8qMG9sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749452267; c=relaxed/simple;
	bh=ARoCqWcofYkGjc10zDqILXHGTaJkQxNAqse3MTdzQ8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlTkjPxgIkaJaZKnDWK5/Ga1COkjVJUeGHqUlVH38O3EkQU9byDoaU3mVwnEGipAr3GDhx6ulZuFp0visCD5ytXOjybRFcOP/Nz0edMyjwAbRimJ+Wcnc2mv1AC8H5gWNo/xzlOkpFYVtSWdQVToMaXX0IP41x/LX6aN/yxupuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hT0CEuNn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hT0CEuNn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749452263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E0MHN7ZtMYMO/keG5XCU1az3m6IvXqs5wUg7/ChdN1Q=;
	b=hT0CEuNnKhut2itgO8gNTfLsZoJ366dpfGdvqUroGxleR6/Ut6biHrscrOVnIiXeze806K
	Jx2jWfZ8LeFt+2ZNzrs1RPM6bzNnD0l2E+URLjqy0fwWZhcucS7xz+m5l7E5UVmWibXgkG
	dnmMDrkADzQeKioMd6H3qkhzStNHdGk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-KJUQ7uJdOyaTct1XZQodyA-1; Mon,
 09 Jun 2025 02:57:38 -0400
X-MC-Unique: KJUQ7uJdOyaTct1XZQodyA-1
X-Mimecast-MFC-AGG-ID: KJUQ7uJdOyaTct1XZQodyA_1749452257
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2ACAC1800283;
	Mon,  9 Jun 2025 06:57:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.58])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C85018003FC;
	Mon,  9 Jun 2025 06:57:34 +0000 (UTC)
Date: Mon, 9 Jun 2025 14:57:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/8] ublk: check cmd_op first
Message-ID: <aEaF2BI289mawdsu@fedora>
References: <20250606214011.2576398-1-csander@purestorage.com>
 <20250606214011.2576398-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606214011.2576398-2-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Jun 06, 2025 at 03:40:04PM -0600, Caleb Sander Mateos wrote:
> In preparation for skipping some of the other checks for certain IO
> opcodes, move the cmd_op check earlier.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

