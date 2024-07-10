Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E176257D
	for <linux-block@vger.kernel.org>; Wed, 10 Jul 2024 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626395; cv=none; b=jDh9oe200AVwxjWHFR/OBjsCEzyHQm7SOWFh9yK+/nJNNnEQy2oJWTlnWCql98cJ/yA7VYRCue2EKXZECJrgLYYIziqG9YsASINcpI/nvb6SwWGQT9SAinsXVtJIQ/DjsVnHDcmL8huN6hiF9MKh8OeqYFCsVV0KcbzI4ogyNiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626395; c=relaxed/simple;
	bh=YLZkxBGjqD2NAo+Iq2HBUifNeuVDJddhpSDR7uVvQuI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YHbk3olWSL5z9KVfOtCCpHK84DeNm9RcE+k2TzkWzFMWMi2fYXoPkqAGa8ptBrroh/yo1wfxvt0oOXG7kjFIKuWoodi8mLO+4hYRBjmckYk0BWI4IaKPitVFEnp57J5++j+HIygBCthynb593Av2X8pzHkrF7bysiRmWIV27a0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/HclOn/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/HclOn/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720626390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fb3PcI/pBVUB0MBEt97v8xh97i2M6YPEg2sdiVOw+Ig=;
	b=I/HclOn/ZgIhWAHErGqv32lvRC0lM6pSNj6LgAEvXjAWVZaoUijXsWGDrniZm252HJVKgx
	l1GgDw64yTbjkPaywFs6QO+SR0y1iiQoRFGlyzAm/xpB3O5izO4pqV9b38A/ZZ8ShLbwNQ
	bmis8fJSYtKi05ldCOYmaHONwTCe1io=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-wqRP_APKN8SfGYrsZCiLJQ-1; Wed,
 10 Jul 2024 11:46:26 -0400
X-MC-Unique: wqRP_APKN8SfGYrsZCiLJQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7A201977000;
	Wed, 10 Jul 2024 15:46:25 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5146C1955F3B;
	Wed, 10 Jul 2024 15:46:25 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id BB19D30C1C1C; Wed, 10 Jul 2024 15:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id B7BD041970;
	Wed, 10 Jul 2024 17:46:23 +0200 (CEST)
Date: Wed, 10 Jul 2024 17:46:23 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Bryan Gurney <bgurney@redhat.com>
cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
    linux-block@vger.kernel.org, dm-devel@lists.linux.dev, snitzer@kernel.org
Subject: Re: [PATCH blktests] dm/002: repeat dmsetup remove command on failure
 with EBUSY
In-Reply-To: <CAHhmqcT6F_b8ZJMbm9jbL0Zg-vv6zq9oxfMttzf1K4GH-zz=NQ@mail.gmail.com>
Message-ID: <e767864a-7ecf-8459-30d5-daa654b4c0d2@redhat.com>
References: <20240709124441.139769-1-shinichiro.kawasaki@wdc.com> <CAHhmqcT6F_b8ZJMbm9jbL0Zg-vv6zq9oxfMttzf1K4GH-zz=NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="185210117-164662512-1720626383=:1964515"
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185210117-164662512-1720626383=:1964515
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 10 Jul 2024, Bryan Gurney wrote:

> On Tue, Jul 9, 2024 at 8:44 AM Shin'ichiro Kawasaki
> <shinichiro.kawasaki@wdc.com> wrote:
> >
> > The test case dm/002 rarely fails with the message below:
> >
> > dm/002 => nvme0n1 (dm-dust general functionality test)       [failed]
> >     runtime  0.204s  ...  0.174s
> >     --- tests/dm/002.out        2024-06-14 14:37:40.480794693 +0900
> >     +++ /home/shin/Blktests/blktests/results/nvme0n1/dm/002.out.bad     2024-06-14 21:38:18.588976499 +0900
> >     @@ -7,4 +7,6 @@
> >      countbadblocks: 0 badblock(s) found
> >      countbadblocks: 3 badblock(s) found
> >      countbadblocks: 0 badblock(s) found
> >     +device-mapper: remove ioctl on dust1  failed: Device or resource busy
> >     +Command failed.
> >      Test complete
> > modprobe: FATAL: Module dm_dust is in use.
> >
> > This failure happens at "dmsetup remove" command, when the previous
> > operation on the dm device is still ongoing. In this case,
> > dm_open_count() is non-zero, then IOCTL for device remove fails and
> > EBUSY is returned.
> >
> > To avoid the failure, retry the "dmsetup remove" command when it fails
> > with EBUSY. Introduce the helper function _dm_remove for this purpose.
> >
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> I think this looks good, and I tested it on my system:
> 
> Reviewed-by: Bryan Gurney <bgurney@redhat.com>
> 
> 
> I want to cc dm-devel and the device-mapper maintainers, in case there
> are any questions on this test.  (It's probably a good idea to cc
> dm-devel for any "dm" blktests.)

I think it would be better to find out which code keeps the DM device open 
and fix that.

It is generally assumed that a DM device can be removed when you close it. 
If not, there's a bug somewhere else (and this patch is just papering over 
the bug).

Mikulas
--185210117-164662512-1720626383=:1964515--

