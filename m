Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692B122578D
	for <linux-block@vger.kernel.org>; Tue, 23 Dec 2025 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766457164; cv=none; b=OE8jz6RRJsY0ZBjLmE9e1Rm5arCnUwlfjKw8T/AkVH5IKva3ZltjtjCmjbvuEhog9GKYNJmdCOjccYcpKJVVYaCaUL0vIrEWououRyf1gYihhKSRf3IUwSIb9CJ8hvkOISqBSg4i/j22gDYo5XEZNOzX8d/7YgLQQNdOOJeXQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766457164; c=relaxed/simple;
	bh=pEl0r6tIMtt4EA48ZnFQISwRXFeyilrX1o5cZ4rg/pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDo5KLpYrW6zLk50kumxBI0I0P9vAgYsSEL8i+2Hz0AcUfQagTWuJwmUAkmLkUwSQPpXUvOEvSiKaTAXD2dOXr4KEbDnFQGFX6XIcGvSazfOma2qU7ZwKP1dvfng1hbZ4NADEvJE61KKUde63DX++m/2fMmOSBYVzJsrUsxWs38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pp6lnJUS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pp6lnJUS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766457161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oW1QGOLNSp02co7nCAtcdM24JErkYO2/wmSB0f1BR7o=;
	b=Pp6lnJUSrgX74WMb98ybNnTy5g7PGP5uukruB2G0xHcTP9xe5mHs7w9rFi2tS50WO04nMe
	rzzII3RDv83y3bPouvKEvEopHxsdQwSNjTjNYADEZuA23MZcbZJnPQr274vtjMhbcaONYa
	3VJGLOLyIPTrVztF/Ij85zr1Igjovlc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-dn3UrxMxOnSRW7QwxoXHFw-1; Mon,
 22 Dec 2025 21:32:39 -0500
X-MC-Unique: dn3UrxMxOnSRW7QwxoXHFw-1
X-Mimecast-MFC-AGG-ID: dn3UrxMxOnSRW7QwxoXHFw_1766457158
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7E171800633;
	Tue, 23 Dec 2025 02:32:38 +0000 (UTC)
Received: from fedora (unknown [10.72.116.97])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD412180045B;
	Tue, 23 Dec 2025 02:32:34 +0000 (UTC)
Date: Tue, 23 Dec 2025 10:32:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Yoav Cohen <yoav@nvidia.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag
Message-ID: <aUn_PVBQ7dtcV_-l@fedora>
References: <20251220095322.1527664-1-ming.lei@redhat.com>
 <20251220095322.1527664-2-ming.lei@redhat.com>
 <CADUfDZprek_M_vkru277HK+h7BuNNv1N+2tFX7zqvGj8chN36g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZprek_M_vkru277HK+h7BuNNv1N+2tFX7zqvGj8chN36g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Dec 22, 2025 at 12:11:03PM -0500, Caleb Sander Mateos wrote:
> On Sat, Dec 20, 2025 at 4:53 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add a new feature flag UBLK_F_NO_AUTO_PART_SCAN to allow users to suppress
> > automatic partition scanning when starting a ublk device.
> 
> Is this approach superseded by your patch series "ublk: scan partition
> in async way", or are you expecting both to coexist?

This one probably is useful too, but it should belong to v6.20 because
"ublk: scan partition in async way" can fix the issue now, and backport
to stable isn't needed any more.


Thanks,
Ming

