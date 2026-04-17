Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBC11A682C
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776386984; cv=pass; b=eQ5a2FdF/noQ9v0aysuKl/wBOu2EdIqbVQcnzgaZcTrK3kBRirqHOOKLPLVTq2SOFHt6ZFK2UEzIUjCyiiznWt6obDKYuZv8T5SVMZbNJEIvqiYegzTD8+eZknDNdcAf+0NAbs0Z6ADndOKnzDQ3vpk0V5mEMiL2zKnEt2XO4nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776386984; c=relaxed/simple;
	bh=AYksPbQRYfZpXRNRV7qgR+unadfC6gESTfhe3x8HxEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9my7hNG1tfhMwgBiwq78eek96dUSOIL1rVdmZB0KKUNsqaph8CUYhAQnNHuk7F4lU16AtSphHXRYTPJ4aBPg4BNgQjT3s0RIAOeIITqa7lKthPj1QnyY6vCNuSpS7m9wWts9SEtFEbdZwp8OfsaEH1/R7LwOj1WTlyir4zNuyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewWPWeMx; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewWPWeMx"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9c755b2cdeso24804366b.2
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 17:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776386980; cv=none;
        d=google.com; s=arc-20240605;
        b=WR/pkI0i0QYXzar5pk99+WjwQ5wPa5tJBVvFEOmAdtiTCCmEePqzEMmWkE+WyFGiOp
         PH2tZigtItSQ39fDPJWTy43qBw/m8doURG4XezX77L8xSjbjdFUiIOwarc4mdvod2uzP
         867VEjuzBhbWfZjvgkhnl5ToLGL8vbOErCDUBWuAOEXvHHIj0MUq9S6X9HTY3EPhgcgP
         r4trBuXcgwAk5epbVdGjT72ZjGsDr8z8ZIT8PKeFYnqdcm9rxFt/WMZJRiSq/kb73U0r
         mDRTgLifaX0KmfYd6afN8Yz0mRsl+Mekv0GvuCU3GepBIGBq3dGjpaIz8d5uv51ZxNQl
         z8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LhTXHu2o/0hRksqRr1kKj2ceP06H4JzmPwK3UEzxxqQ=;
        fh=OMxC0oQ//UvjsuAz8phfbeAkLJ5mBwmiQ2Oi0irpHLI=;
        b=CxKlghm6Hakt/VkpSrIItzKbSktIOvfBG1vP2MD2p8VjMFbRsiv079zoTeUW4dMZI9
         3oEHaLQP+TRiveJd8tU/IWb2UqQrIMw7atCcFgYTcDFaHyR4tDRX+B0Ar1pd+aTp5m0R
         pTT968q00dT9U+uNa1O23B67uGmpBDb7jr9yefUrHkER9JGTSlLUAXt+vxiupIAYnN0x
         ObjcXAZVrlF4z/u8+pGa/NZRH0cih6BNfFSxLIhgRVrBq8R7uj570zBEjUh7677KcIfo
         kr09dSxF/nv6yn51WmFiq+TvmVdfHqUXWjVx5e2vljw2b0eym6MYeuDjIKa///dfdQd8
         S2EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776386980; x=1776991780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhTXHu2o/0hRksqRr1kKj2ceP06H4JzmPwK3UEzxxqQ=;
        b=ewWPWeMxsT9w7uVqjgeMl5YAMeSvP853Z0CcpbRFT5P50nOlLUVD3qoYIAv+VIEN+z
         B04/wHzn2qWBaNNfJ9FVzZaMp3Jd9QC0F2RRvE5nclvaklmfFi3w3eTBMZVYwSk9e0af
         +e8QUW6NDCsszDWR/bFoYMTxIRf/pU1bjx0VtghUOqTP8M3a7b2MZj0gV0+Ikma1EmTQ
         Mdoierwce6mzpocBE0WNG3Cqec7ZmovG01p1tMfZYbLr2cxWzPS/KIYTj2BIgn9tldew
         CzzAUJ5MZ2aIsnlSYUHfbWU7UaQtCI83O/89vebllYfpNrP/P6UXSlY+jn1a51gZoPIl
         B2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776386980; x=1776991780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LhTXHu2o/0hRksqRr1kKj2ceP06H4JzmPwK3UEzxxqQ=;
        b=cGp/n5l647Tk8iB3Eu8W3wOdwHsdLJZ+OypRa105P6TiZ++eWcsVCTlQNmi3sETUtU
         H3snmw2qHX0buxRAsSBbQGOYjx6bQoZ+NN/oP7Rfwdz2/F2D7Vtc4CNdnSp88agmX8NS
         6dNS0dI7OrZBudBOxopRnzYkSvIyWAax2/LY+ZtuJ0RDfmW5emLbW8kA0FNIc9PXZRQ8
         nAiWSp3jAEN9ri0ViXzdKcJ/CH2AOC2W3AEZ9grKozLdR4Y4D19h2umOIgPFbNsOBE1X
         2h4rti9osXDciEdnJOEXd4JMz0DHH2jgRQfGVjGu3JZs8e/6OUbaRy5FJf+gqcbhB+7E
         itSw==
X-Forwarded-Encrypted: i=1; AFNElJ8lTao+Wd85kbd9gHt2o1nFpLAY77IehZBQl7SLBDkR54u3PgSNPXZPqGac9cRKQo0+ZAsd4Buo/m8oag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQjr3fAjqbwPgXJ24hLsKqtQh04wBJiFcrysW46z1SIaZXLPNa
	GLrNNQAabbjePy29uLTv5JKa2BkKZG4G9cA70hTN9Ax9d/P3+jB9i76xTxUK6K1TzSUvdxhQnm3
	6x+ACuiCEFCB12XlYqxJF1IOnOEZwtO0=
X-Gm-Gg: AeBDiesJvUkXgffoUEeWWTl2JxtLvO8s6n1fBKMCNzje8v/AcKJTuBRapFzluuBKW1z
	x73S5sNmD/yvEgfMQ/30qwefj+gJlxst7tqJmbfDSpM+BkO/1Ke4w++MBmvFGUEWd0v750l4+fO
	PmoT8N+odb/1KewxN8KcmraGmr6HtFl+X7WToXxiTxaZSVszG7jTLpDSaRbcj66pMZW8qnBuwX8
	nnCRqyuA3iWQGlDH7ffndZ6yrvHQQoH2JmGy4GYmCBqgOUE90RH0XKoklI+iJWQL91gxTeeOwNL
	++FX0CRfYkSCWmlzTKhLbRGVzpMUtQRqSXcvgf7CtdYq6bNR
X-Received: by 2002:a17:907:3f83:b0:b97:e4a9:baa4 with SMTP id
 a640c23a62f3a-ba415ea4a0amr37642766b.0.1776386980272; Thu, 16 Apr 2026
 17:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415230250.2783414-1-alistair.francis@wdc.com>
 <959f800d-b92e-406e-a174-680fb09c884e@suse.de> <20260416-landlord-encounter-c93f2733de5f@redhat.com>
In-Reply-To: <20260416-landlord-encounter-c93f2733de5f@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2026 10:49:13 +1000
X-Gm-Features: AQROBzDD04mch1uvuQU7s4MjBPfv5sS88qUmjrUElNAPcPcUhgN4y8FZ2cgvOD4
Message-ID: <CAKmqyKOdcv7ojr2WdbNSdkaXQaSuwqmD3daE8yP3JckDpOKdpQ@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: Ensure old keys are freed before replacing new ones
To: Chris Leech <cleech@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	kbusch@kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, yi.zhang@redhat.com, mlombard@arkamax.eu, 
	linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 1:27=E2=80=AFAM Chris Leech <cleech@redhat.com> wro=
te:
>
> On Thu, Apr 16, 2026 at 08:16:14AM +0200, Hannes Reinecke wrote:
> > On 4/16/26 01:02, alistair23@gmail.com wrote:
> > > From: Alistair Francis <alistair.francis@wdc.com>
> > >
> > > Previously after the host sends a REPLACETLSPSK we freed the TLS keys=
 as
> > > part of calling nvmet_auth_sq_free() on success. A recent change ensu=
red
> > > we don't free the keys, allowing REPLACETLSPSK to work.
> > >
> > > But that fix results in a kernel memory leak when running
> > >
> > > ```
> > > nvme_trtype=3Dloop ./check nvme/041 nvme/042 nvme/043 nvme/044 nvme/0=
45 nvme/051 nvme/052
> > > echo scan > /sys/kernel/debug/kmemleak
> > > cat /sys/kernel/debug/kmemleak
> > > ```
> > >
> > > We can't free the keys on a successful DHCHAP operation, otherwise th=
e
> > > next REPLACETLSPSK will fail, so instead let's free them before we
> > > replace them as part of nvmet_auth_challenge().
> > >
> > > This ensures that REPLACETLSPSK works, while also avoiding any memory
> > > leaks.
> > >
> > > Fixes: 2e6eb6b277f59 ("nvmet-tcp: Don't free SQ on authentication suc=
cess")
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >   drivers/nvme/target/fabrics-cmd-auth.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/ta=
rget/fabrics-cmd-auth.c
> > > index b9ab80c7a6941..58185184478a4 100644
> > > --- a/drivers/nvme/target/fabrics-cmd-auth.c
> > > +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> > > @@ -412,6 +412,13 @@ static int nvmet_auth_challenge(struct nvmet_req=
 *req, void *d, int al)
> > >     int hash_len =3D nvme_auth_hmac_hash_len(ctrl->shash_id);
> > >     int data_size =3D sizeof(*d) + hash_len;
> > > +   /*
> > > +    * If replacing the keys then we have previous successful keys
> > > +    * that might be leaked, so we need to free them here.
> > > +    */
> > > +   if (req->sq->dhchap_c1)
> > > +           nvmet_auth_sq_free(req->sq);
> > > +
> > >     if (ctrl->dh_tfm)
> > >             data_size +=3D ctrl->dh_keysize;
> > >     if (al < data_size) {
> > I am not sure.
> > The authentication variables should be freed as soon as the authenticat=
ion
> > completes; the session key is ephemeral and
> > should not be stored longer than necessary and will _never_
> > be used again once authentication completes.
> > The TLS key, OTOH, is used throughout the session and needs
> > to be present while the session is active
> > As such, both sets have vastly different lifetimes, and
> > I would argue that this
> >
> > void nvmet_auth_sq_free(struct nvmet_sq *sq)
> > {
> >       cancel_delayed_work(&sq->auth_expired_work);
> > #ifdef CONFIG_NVME_TARGET_TCP_TLS
> >       sq->tls_key =3D NULL;
> > #endif
> >       kfree(sq->dhchap_c1);
> >       sq->dhchap_c1 =3D NULL;
> >
> > is actually wrong as we should not modify 'tls_key' here.
>
> I agree with Hannes, and was just about to respond with the same
> feedback.  I think the freeing of the auth temporaries needs to be
> returned to fix the memleak, and the real problem is the setting of
> tls_key to NULL.  That doesn't seem like the right lifetime for tls_key,
> and it looks to be a reference count leak as well.

Yep, agreed. Patches sent to revert the free and remove the
`sq->tls_key =3D NULL;`

>
> Is the presence of sq->tls_key the best check to see if the socket is
> currently in a kTLS mode?  (it might be, I'm not as up on the target
> code)

I think it is correct, the issue is just that we are setting sq->tls_key to=
 NULL

Alistair
