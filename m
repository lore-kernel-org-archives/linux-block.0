Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E61285C88
	for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763795358; cv=none; b=CytZ/nqawaHW/uVM6FubFYi8YBuB/uxUAvTGP21n2zJI/dmuDg1XWo0/5IJzoQ42Nrr24jaik84O10drrtMhM8vIjMwOnVPW0/wbqxBz/ESqG5Ra3Ou9r4eOKAIVRsY57XuTY8HOoUzlmfWX02pxXfRNwisGpk7Pvd/XYtpFRQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763795358; c=relaxed/simple;
	bh=7Yd8nloP8m0dR422jBlUsUdryD11f8cV04WwFlwTHDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFmriRbW7nz1KlZqDgxbuaPPJTLqrJxmbprWxep8EyjON38CKRoY6aR5iIazimh2ksg1o/QESfSMbLN5Tlu7MwHQoWXyVgSawFJx2nRFnp4CLctqWA2rkfBOGPyXJQaB4UI/vhWJMqNo5bMp05BqVSDMSWg9ssFM+DbgMUe4m/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+SOyhwH; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+SOyhwH"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8843ebf2facso36339446d6.1
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 23:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763795355; x=1764400155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOU5zUa9ExH2UPIf77XppaYiXONJBt1V6maHsn7ikzg=;
        b=g+SOyhwHAKHXQcllkd5+4zdvPOLjeKqLL7A8kncx5suqPmNxkpgtjCRlgHgrZFKLh9
         9R3K7DEZhBJM23wVVGnnfJE6zWwULKGvNuhW82icfF64D8E9VPazIALxzvl9EKLTmiys
         HDwQVq7pKoP2awPscUxS1pYioZAdLsd5fPdqe9B881LJst8+58SQl8yMJARlkG3jmp7I
         qaIQCyCDgIyxTN2H/YymyCU33ukx3P7wFtw9nzWNLE28+oLNZOZLGHwDYdgupWrQPTdg
         Vp59TpmHidS3mzbCRC3oAsoYEwIWT/VW70Iy7yGhCiNjKxR/AgdPvXWQUVCu/XRJsITQ
         PIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763795355; x=1764400155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOU5zUa9ExH2UPIf77XppaYiXONJBt1V6maHsn7ikzg=;
        b=lXCw9gYVIVwdkYm71YcUR8ZASBTX9IsZvd8w3RmPZxncMzvoMOFf2SDu2br4Z7gvGK
         jwUlXVqf6yeFD602TjFIowqDKnS78+y+Vh9V5FkqOV8ia50iPsRobPtsV/1vA58PJ9C/
         WZFlW1DUY7DjLj2VTipZPJ6qlQkEukirnD/IukFWRDCpcjyBDkF2QwEpwgO7Lfw8FkHn
         tR1C6xF5uQ1d2jtvf2zfLNDEM9iCoZrt+kVnzEldEgJBeqcGcFomtkHcBGiuu2m3SI47
         hO5rNvuGf0hohBYGGBtQ0mWE+gnhU2DJFuBejRTQCD6o5shIlJDB/2GmNXIoLdrGV38j
         gMvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvzE0qySmUPYIPfUMG10Tx+hDe17ADlkVPVOCp2nNWHPk52WZlFOzneE3UpYsgAwP4JxEHjeQXIhkL1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh78Y9/cbSTsWWKJUOKAxRAEjbFpvXlQbZWhQlR+SSCjKsDI0V
	rH+0S59557BLIKexv0ycaKU09aMgbPH7NvRjo3DVa1O6zL3j7IjjWzL1k/iItsPum7wz0z98R3P
	PbLYUH5unuc/Hv9lG1xjiqmokmbr4MJM=
X-Gm-Gg: ASbGncuxzTre+DnKecHFaNMxm6xTJgwxflni+p2uqbsXN6yaaLTETKq6CT9CvdYtIuf
	6PY4N7A13r8kNnn2WthWvkvRy/oKgCKrh+xH34VYQMMc5+NyQchy6TFZ9EIK5EHigwg1+iZniie
	pt7oSDLTeRLNmpUN7iItPELCkb1x+EWSnKc7K8RNY9gxqPBuFgHchd0/IrP/jHUJ3hlUdOHOrrY
	1jaMhblef/IEChjFMW3WAmfd/BT+2yTyE6ohBvQMV+ZxyOOlW9odhKtMce/qH5AHA3udg8=
X-Google-Smtp-Source: AGHT+IH732VY2HEOL1GTjGnjiDpMpgHpw4qhxelOjeL0bgVDWuC8OicLazoWJuAvAFEObeAlgbjBNJsbaZaVBgshjVg=
X-Received: by 2002:a05:622a:1207:b0:4ee:1563:2829 with SMTP id
 d75a77b69052e-4ee58b04a99mr71664381cf.72.1763795354707; Fri, 21 Nov 2025
 23:09:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <20251121081748.1443507-2-zhangshida@kylinos.cn> <72fb4c90-0a75-43df-8f5a-154d9e050c09@wdc.com>
In-Reply-To: <72fb4c90-0a75-43df-8f5a-154d9e050c09@wdc.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 22 Nov 2025 15:08:38 +0800
X-Gm-Features: AWmQ_bkaHk0wh-SvlSCw46Rlr82grFve_Y0_m2bfS2qbhv3bWWgwLzC0W1VLkPA
Message-ID: <CANubcdVx3MkWwncj1S0cS4FN+Stt8FpHD89dCFeStsd2QE=2sg@mail.gmail.com>
Subject: Re: [PATCH 1/9] block: fix data loss and stale date exposure problems
 during append write
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>, "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "zhangshida@kylinos.cn" <zhangshida@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Johannes Thumshirn <Johannes.Thumshirn@wdc.com> =E4=BA=8E2025=E5=B9=B411=E6=
=9C=8821=E6=97=A5=E5=91=A8=E4=BA=94 17:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On 11/21/25 9:19 AM, zhangshida wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
>
>
> Regardless of the code change, this needs documentation what you are
> doing and why it is correct
>

Okay, will do that if I can get the chance to make a v2 version.

Thanks,
Shida

> > ---
> >   block/bio.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index b3a79285c27..55c2c1a0020 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -322,7 +322,7 @@ static struct bio *__bio_chain_endio(struct bio *bi=
o)
> >
> >   static void bio_chain_endio(struct bio *bio)
> >   {
> > -     bio_endio(__bio_chain_endio(bio));
> > +     bio_endio(bio);
> >   }
> >
> >   /**
>
>
