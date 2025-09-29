Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BB93002AD;
	Mon, 29 Sep 2025 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759150605; cv=pass; b=UfVaw7TPYMBDWeT9dCVcOA+1nIQ0ytC+QZH8VYDwUndECwQFAtXVeLSkr3kgZ1kpvflsQ+UPpfBJD1UfQxAgMkX73mCCSLUgFfFy43fS+NCDU45U50GByijQrTsrBrLQsh/KHEEfnBfiYiHoMWJqYnBzYlgyJD/SZmS+DIHFEmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759150605; c=relaxed/simple;
	bh=jlu1RPauD+35YtIPSJ4mapRaTRJ+pjwd5qmVEcTneiQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=d0LcrTjlO2IONZ+hY2bOUtCRitqGYiBBTUUKEHT6nniIfKgsycIFFh954XMLEjWNKEVpCETfgHw2IprZR3IX05PeZwrLp6lfnd6UnRzkRfSW+FqSyRGyxRVfU04fETffJuTgJPG2ewjOD+m17qCVg5/DPEYTyoA4cgSgcgeEjXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=Z5DHq5qK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="Z5DHq5qK"
ARC-Seal: i=1; a=rsa-sha256; t=1759150592; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=A2/6Upu8d5+35lAH4aXAPCNT7ffbly/9gxLn+md2mL/kYGOM2Ggrxo9IszT48+gsH3s3b1Ngg823aCWUZUGk1rag4oCxmd8fVDg/RyQACBTifozMMtVFLVXzWV38t6DgHWg4kbXy+1Q0yXYICRH9jOXdJhZhJIPmLg09VtguMyc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759150592; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CCMTLNWcX+amaMhpM9yRHYxq6idWilkG27Bb2c8YbEk=; 
	b=EqeOAiKy2wK0BTwv1LZ1A5i/JpvSHLOoz63uPRI/b3CYrXBIwLct8cK57qPjN16g4++PLGe9HgbhZ9qPiIRx12l08UZozxMzxRvy+tHYyL8MRcWzZyZEpw+SAwBSdlZihJwB9BFKb2x5ORpdwLU06AXofmpG2+WqhLWh2Ha7jHQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759150592;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CCMTLNWcX+amaMhpM9yRHYxq6idWilkG27Bb2c8YbEk=;
	b=Z5DHq5qKF9pOmurRz7WYUceD8uit3xMEi0YfL2Kei9o2ejzAHMCzQxpMQkSuvVY/
	ORzANSbdrveaua1EhiWRTkCZKCTqr/igdwZr6dOvD2Mxs8HOsWqpCjoDH0RyQBqPmij
	x/q/xjzxBLByl6jO1otKgQBJbjr6tHxmzNE8kr6M=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1759150590612210.47496336906693; Mon, 29 Sep 2025 05:56:30 -0700 (PDT)
Date: Mon, 29 Sep 2025 20:56:30 +0800
From: Li Chen <me@linux.beauty>
To: "Yu Kuai" <yukuai1@huaweicloud.com>
Cc: "Jens Axboe" <axboe@kernel.dk>,
	"linux-block" <linux-block@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"yukuai" <yukuai3@huawei.com>
Message-ID: <199958bca6a.7ea76c7c550787.2798726002425326647@linux.beauty>
In-Reply-To: <68aebe91-4dcd-925f-4232-1c432fe6899d@huaweicloud.com>
References: <20250926121231.32549-1-me@linux.beauty> <68aebe91-4dcd-925f-4232-1c432fe6899d@huaweicloud.com>
Subject: Re: [PATCH] loop: fix backing file reference leak on validation
 error
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Yu,

 ---- On Mon, 29 Sep 2025 09:11:04 +0800  Yu Kuai <yukuai1@huaweicloud.com>=
 wrote ---=20
 > Hi,
 >=20
 > =E5=9C=A8 2025/09/26 20:12, Li Chen =E5=86=99=E9=81=93:
 > > loop_change_fd() and loop_configure() call loop_check_backing_file()
 > > to validate the new backing file. If validation fails, the reference
 > > acquired by fget() was not dropped, leaking a file reference.
 > >=20
 > > Fix this by calling fput(file) before returning the error.
 > >=20
 > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
 > > ---
 > >   drivers/block/loop.c | 8 ++++++--
 > >   1 file changed, 6 insertions(+), 2 deletions(-)
 > >=20
 > > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
 > > index 053a086d547e..94ec7f747f36 100644
 > > --- a/drivers/block/loop.c
 > > +++ b/drivers/block/loop.c
 > > @@ -551,8 +551,10 @@ static int loop_change_fd(struct loop_device *lo,=
 struct block_device *bdev,
 > >           return -EBADF;
 > >  =20
 > >       error =3D loop_check_backing_file(file);
 > > -    if (error)
 > > +    if (error) {
 > > +        fput(file);
 > >           return error;
 > > +    }
 > >  =20
 > >       /* suppress uevents while reconfiguring the device */
 > >       dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
 > > @@ -993,8 +995,10 @@ static int loop_configure(struct loop_device *lo,=
 blk_mode_t mode,
 > >           return -EBADF;
 > >  =20
 > >       error =3D loop_check_backing_file(file);
 > > -    if (error)
 > > +    if (error) {
 > > +        fput(file);
 > >           return error;
 > > +    }
 > >  =20
 > >       is_loop =3D is_loop_device(file);
 > >  =20
 > >=20
 >=20
 > The changes look correct, however, I'll prefer to change the error path
 > to the reverse order and add a new error tag.

Thanks, but I will switch to scope-based resource management in v2, as sugg=
ested by Markus.

Regards,
Li
