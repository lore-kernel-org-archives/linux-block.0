Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4CA2472AF
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 00:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965406; cv=none; b=V95BVWFFyKkTrjb28QxQU49mcNq0dfwe+9nsRm6tiYy0/+4bU+BwFrc9VM0oJdMxsqftSTiVBf3JMYaC34cSBF6ZNBEh9+FZNLmlmXSct5dk8Qw4VhOWz7HpV9cmuq8pMzbuVjotZDoUw1pmFAcBKOtcXHlK94HbOYZjpadEW2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965406; c=relaxed/simple;
	bh=jhMGWb5wU0e//pOq91Ni4U70PjkpDW3s25lSZUhAuhc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Ofy1hPSQMAVNynnKJ8/yTJ3cl2dihVDvQdg64ejm7xMwoY9760osy7TaHGvYUOCyFSWF3h9yDsD+WFSM3Z5PuyUdQME32R27iLHd66b0gcNco43QHDKNR8RkxqhGFvxmsQB++dUqSyTnWKnSkFUv34Hao/NQxWHghms5HX6sHbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fUwNQXh1; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fUwNQXh1"
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780965400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NCGhRG1CImeJMpSnliLnjJkZGyrhgZ+lru5auGG2Gio=;
	b=fUwNQXh1lEooBGZvJLZNoxiuDwcNOOml0nwHWou3dnA0p85p1xJVID3+wiq/X7XEWESCIT
	eHyyVEDLJJhX0GvVJf+0RYj3j9I5kqD+ZyNSML+aJf3GSGT88N0VNozTBPcMklIR/18Jvd
	zPey73k1RoTqgxhyL/ZoGa8wExLhA68=
Date: Tue, 09 Jun 2026 00:36:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jackie Liu" <liu.yun@linux.dev>
Message-ID: <d99eb11c43be22184bd044a16c5968f93b082d3e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] block: clear zone write plugging flag before failing
 rejected BIOs
To: "Damien Le Moal" <dlemoal@kernel.org>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
In-Reply-To: <33035623-1f1b-4391-9212-e2af5fd9457f@kernel.org>
References: <20260607031814.19188-1-liu.yun@linux.dev>
 <33035623-1f1b-4391-9212-e2af5fd9457f@kernel.org>
X-Migadu-Flow: FLOW_OUT

2026=E5=B9=B46=E6=9C=888=E6=97=A5 19:42, "Damien Le Moal" <dlemoal@kernel=
.org mailto:dlemoal@kernel.org?to=3D%22Damien%20Le%20Moal%22%20%3Cdlemoal=
%40kernel.org%3E > =E5=86=99=E5=88=B0:


>=20
>=20On 2026/06/07 11:18, Jackie Liu wrote:
>=20
>=20>=20
>=20> From: Jackie Liu <liuyun01@kylinos.cn>
> >=20=20
>=20>  Commit fe0418eb9bd6 ("block: Prevent potential deadlocks in zone w=
rite plug
> >  error recovery") changed blk_zone_wplug_handle_write() to fail BIOs
> >  directly when blk_zone_wplug_prepare_bio() rejects them, for example
> >  because the write is not aligned to the cached write pointer or the =
plug
> >  needs a write pointer update. However, the BIO is already marked wit=
h
> >  BIO_ZONE_WRITE_PLUGGING at that point even though it is not issued.
> >=20=20
>=20>  Completing such a BIO with bio_io_error() makes bio_endio() call
> >  blk_zone_write_plug_bio_endio(), which treats the completion as a fa=
iled
> >  device write and may poison the cached zone write pointer state by s=
etting
> >  BLK_ZONE_WPLUG_NEED_WP_UPDATE.
> >=20
>=20Yes, true. But you did not explain clearly why that is a problem. Aft=
er all, if
> we hit this case, the user issued an unaligned BIO, and so forcing it t=
o do a
> report zones to get everything in sync and the correct write pointer is=
 not a
> bad thing.
>=20
>=20If fe0418eb9bd6 change is actually causing you problems, please descr=
ibe that
> problem clearly. But ideally, I do not want to special case some error
> completions over others and prefer to have a single error path that res=
ult in
> the same state for the zone write plugs, regardless of a write error ro=
ot cause.

Thanks for the review. I agree that the changelog did not describe a
concrete user-visible problem clearly enough.

I was treating NEED_WP_UPDATE on a BIO rejected before submission as stal=
e
state poisoning, because no device write was actually issued. But as you
pointed out, for an invalid/non-sequential write, forcing the user to
resynchronize the write pointer through report zones is consistent with t=
he
current conservative recovery model.

I do not have a concrete regression from fe0418eb9bd6 beyond that extra
recovery requirement, so please drop this patch for now.

Thanks.

Jackie

>=20
>=20>=20
>=20> Clear BIO_ZONE_WRITE_PLUGGING and drop the zone write plug referenc=
e before
> >  failing the rejected BIO.
> >=20=20
>=20>  Fixes: fe0418eb9bd6 ("block: Prevent potential deadlocks in zone w=
rite plug error recovery")
> >  Cc: stable@vger.kernel.org # 6.13+
> >  Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> >  ---
> >  block/blk-zoned.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20=20
>=20>  diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> >  index 6a221c180889..855767d8bfc1 100644
> >  --- a/block/blk-zoned.c
> >  +++ b/block/blk-zoned.c
> >  @@ -1502,7 +1502,9 @@ static bool blk_zone_wplug_handle_write(struct=
 bio *bio, unsigned int nr_segs)
> >  goto queue_bio;
> >=20=20
>=20>  if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
> >  + bio_clear_flag(bio, BIO_ZONE_WRITE_PLUGGING);
> >  spin_unlock_irqrestore(&zwplug->lock, flags);
> >  + disk_put_zone_wplug(zwplug);
> >  bio_io_error(bio);
> >  return true;
> >  }
> >=20
>=20--=20
>=20Damien Le Moal
> Western Digital Research
>
