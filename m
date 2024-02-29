Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7253B2D602
	for <linux-block@vger.kernel.org>; Thu, 29 Feb 2024 01:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170052; cv=none; b=SyoaY2xebboSyAdgMmoGwt1CwHkN3fFhEnPrRUk4Hkp6R+vLUZjmh2LOjBz+eHOucTre3tbZ5i5YCShCrybJPX+p91W/eUTFbKbhn/I5wCOYAONsFbnqT3Dgo5K8pONgr5HiK7s+AfDFLbPvjd68oOrldhPWbyvAHWHseGb9J6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170052; c=relaxed/simple;
	bh=vrrYuPLX0BtyJO0ZknngptbEWmn4WXbIvb/6n1X5UTw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvhbIIZOogNHLC5yrnHWaemnWVTYFI9bf5TguqTsIdtL1Zrt8MfxLBzgrNOQ43+tsin8PjDhSkq7FE/HuVTY8keUIa7uYK4Go7ubFGhOByxBzeWqvPY01Azxc0oDIknRETBhWImoIeh92368AtnHZavucA5+/y+r37Vt3VGkkLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4Zbv4+K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4Zbv4+K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709170049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k+ZgSZgOlq1/Acfrl7l8H88V5AJIHT9dDULJVkcILW0=;
	b=i4Zbv4+K07tndag+aolTU4v/zLJdkYQ6dO3+xR+m5E/zUO4fNRXcumgdZcRPX6chJX16av
	bCi2xKb+7cBhUVAwYwkHHfIoW8gQyEwu1ytoRBUuLMVYJ0y+ggRjbgmBjbNaStvZtA0TM6
	cGxh5GAWSYRkGd5Sy4nCI8nOYSnDDEY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-as8R_2LJPUKg4n5o7MMSGg-1; Wed, 28 Feb 2024 20:27:27 -0500
X-MC-Unique: as8R_2LJPUKg4n5o7MMSGg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D040C869EC1;
	Thu, 29 Feb 2024 01:27:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D19791C060AF;
	Thu, 29 Feb 2024 01:27:24 +0000 (UTC)
Date: Thu, 29 Feb 2024 09:27:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] ublk: improve ublk device deletion
Message-ID: <Zd/deJWmSDs8dxWF@fedora>
References: <20240223075539.89945-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223075539.89945-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Fri, Feb 23, 2024 at 03:55:37PM +0800, Ming Lei wrote:
> Hello,
> 
> The 1st patch cleans up get/put device, and annotate them
> via noline for trace purpose.
> 
> The 2nd patch adds UBLK_U_CMD_DEL_DEV_ASYNC so userspace device
> deletion can be implemented easier.

Hello Jens,


All APIs in lib/ are built as notrace, so the 1st patch adds
noline for ublk get/put device(slow path), and it is helpful for
investigating reference issue by existed trace utilities.

The 2nd one makes userspace happy to not consider complicated dependency
issue in removing code path.

Can you queue the two patches for 6.9 if you are fine?

Thanks,
Ming

