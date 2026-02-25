Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B367E318131
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055827; cv=pass; b=pVgrBV9iJHsgnnMOHftYeplG5MoShdqvBr1fd2VNthhfkC03mJFH7p56PbG85hrNHLq7v5NPhKmDS8kEiAcdoj4W1T2Hotew4bNrrKT87o/Rg2Vu2BAGKb3zs+WYhCPSZv2uxljbiVVInwKQqT4gfS8rHbGzGvYl5e38c4g23o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055827; c=relaxed/simple;
	bh=hoZBQczrzcuyVPOXD+tTAmFlTYabJ94zI9Irylb/EVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzYEoO44ES5QHptp3n1+RiPkPS7wibScBeo6QHC6iZkKMDbiW9+UADHQFCq7wuuBjtWMMMmaxuY9Aqi6H0y0aHN3HsbXVi3owCA2ulZSPncdyR5xA4Jia/PdMA7TK9pErWNwJ6anCUG/Tri49n12ehW6ZNeQRDEw0ApTlUDJWCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DcXnIIPe; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DcXnIIPe"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65f93fff5c5so1087a12.1
        for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 13:43:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772055824; cv=none;
        d=google.com; s=arc-20240605;
        b=RAtJV427rxdfAWl5AIFBTtZyBOPvfIoAZxelc3Zq+4xDrDy6+MajfWUK6ethYBClUE
         gti3Px18XzFhJA3ZkVyJrxPbRe94mMsTTiH2B1AqG3u9k4O4iPDUUqAuxK3PrhBx85u/
         40piIuA81kENg54kMpMIqlygkzfAJgpwH8B3PosXyfOoq1xAQo+GBJEjE6QuFTHRVvVq
         vDPyFzj/rWmkYA/2VisOnliXrG6Kpf8czFTX2CHCzw9edJYklbV3op0Q3NL+aOuLwhf/
         VbQE9GuZ9sIao+RYCTMLmNgwHKoTFAQFb1kflUpTgf8yaFr54Oa/ztmXGZpqA2uTPP9a
         4Olw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vB9FeLIHdzkOeJQl8sZ1jnIIU5NTPuPRUQDCv7qOk1c=;
        fh=qtU/+qtqLkhNaPjbjA56LXb+ZByqqlE/jWaE7fwVI2M=;
        b=B4E+Dsl0NW/VSfbyZSMFPQYn5y2FXVFuYc5tjS/mRTtjX8XjefJclTiBuV7XpHlQFF
         Fqp9iyoiaPLElGM8S5Z5F1Dpu4uvFBTaTuxuERd2YyS7zKAYjbZf0ybog66ckLfvj+kP
         MZOoKqCeSG4GEZYI4L9Mo/rRkjzEMeM6KhziINXn9PCXnsyVygRo7El1Ruu9g0/61nDv
         V90oxRCAVB3/jZ++0onn4SqdWmr9bsh452rPGIVdk5IZk+uDcBTAy8jbj52uXpc3Dhot
         fe89exwpFLMnxXPdzGvivVqrTOL71zH/OcGj+979yXlakWFxF91bBNQ2wDO1wJ5vr2AF
         NSzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772055824; x=1772660624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB9FeLIHdzkOeJQl8sZ1jnIIU5NTPuPRUQDCv7qOk1c=;
        b=DcXnIIPehOR7Zcc84tU5ax/4/X+fJQQXdh6G/qeIGgAwD6QNLuPBvyozFNu04p1olg
         g2ioHyEBoajIsPgNamu8pOCASAUioThGOznYmtfFxA2PNCUI/goNDca2bs4YaC57UiMX
         hrNrJLYnxtIrwCeUCMpB65/mfvXVpuwHhNmB8r2rpeEZVUk9JmP1VTBaWsG8jXrjKXwl
         UiqonoSGe9mduDMaJoz8Kgszdb+iCjKBceJQZRl2elaXYdryJsUcOdQPBv+X7m1a9tcz
         uA3wykguwgIff37UR05C2cadCAQdbVnrzA/akWYG16NJ0Q72rMQDl7LjJp/0lKeJMubA
         Zb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772055824; x=1772660624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vB9FeLIHdzkOeJQl8sZ1jnIIU5NTPuPRUQDCv7qOk1c=;
        b=k64AJqzHT//7MwMStfC2WBslI3WDq58dSdw5GGL39bw/ly5DnSZUnV0HVEcDBWc0xN
         PqXhV0jsU2UOguQ3sNBWo6HXkFAAq2bSv+uPOktyN3YcyY9srgODz0Zuw2gxrzB57MSQ
         EplqeJznTMrAA8RFormPmjh3FvB2JIypzo+m67dXDaeNuXzEd8k4QDBAoS1cHVdTiXFa
         mqfT1QNSxP/Po7VZ6gM6HEx+pGjJxolCxeFER4kk8xJWkb+iDOfVtz5B3y/QJ5BXxSTs
         OQhgUZBlRQGbX+uKPtN72FywBtG5Otsx1Dj3UEvElL9zZWg1DkiO22xRQB4iMZHCPEp5
         NNqA==
X-Forwarded-Encrypted: i=1; AJvYcCXsliXHCHYc+9v1Q1e2AGdc/xSh8rx2ehkV5fg8Sq5jhpX0GXD5nWIL0X3TiBOZ4acnzyZvwb6k6WgUAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyATuVBgHR3XEv31Rkzk+fdrW0DpnAUL+YCx8Lcx69CVCzUiKSh
	yHtoMfH0he5m94pQhQGWiMpMBrr5EDKb70mwNZbH+CSDEg0yHH60OQEoTh0VrggsuQxnANu6HKZ
	N4CPOx/oS4b/Qw4epqGXmJ84Nbrk00ZWF/rijMAQ4
X-Gm-Gg: ATEYQzyRFNExzHuVu7dxE+GSFDF6bVoBwtBs9nHRmExm8geSVEHqk+JNkpNVO1p2uti
	9Xx9JKUYq4nlMClO3T8xGEwC2m6yUA9EGUXwBOyKzVa81yoa4QZjCxBHubZsbFo9mIeoYbq2UTV
	2e9Xv4mnM9uF5202KsikVMmzvoVATb9CCrDDyw8eG2a1AovVYiwKEsJ+VhUpAN4g8IH5CCvxiyH
	TcutygzjjIAEwjdNRrIKOTwEe6g2YmzeNvqLvjQRTkly6jEvAftkuc32QKcSDtOsgyah/uWiAvL
	lstTF5xQrKBCH2ccYrygvgTNoWtjrSQ+Z/pkxQ==
X-Received: by 2002:aa7:c7cf:0:b0:658:e7a:6fa7 with SMTP id
 4fb4d7f45d1cf-65fab61a7b0mr11377a12.4.1772055823405; Wed, 25 Feb 2026
 13:43:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619111806.3546162-3-yi.zhang@huaweicloud.com>
 <20260225000531.3658802-1-robertpang@google.com> <7d2a3f65-4272-46c1-991a-356f0d2323cb@huaweicloud.com>
In-Reply-To: <7d2a3f65-4272-46c1-991a-356f0d2323cb@huaweicloud.com>
From: Robert Pang <robertpang@google.com>
Date: Wed, 25 Feb 2026 13:43:31 -0800
X-Gm-Features: AaiRm53fO14_kYBnlB-QimzynwfGzteAR7wRZiT1Sf0awQgFveGcUyR_Z7IWsCY
Message-ID: <CAJhEC05L7QEc9iY7gFZVK3SPYvFhtFyURss6xQgZ-qWwZZkFjA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] nvme: set max_hw_wzeroes_unmap_sectors if device
 supports DEAC bit
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Zhang Yi <yi.zhang@huawei.com>, bmarzins@redhat.com, brauner@kernel.org, 
	chaitanyak@nvidia.com, chengzhihao1@huawei.com, djwong@kernel.org, 
	dm-devel@lists.linux.dev, hch@lst.de, john.g.garry@oracle.com, 
	linux-block@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	linux-xfs@vger.kernel.org, martin.petersen@oracle.com, 
	shinichiro.kawasaki@wdc.com, tytso@mit.edu, yangerkun@huawei.com, 
	yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Zhang Yi

Thank you for your quick response. Please see my comments below:

On Tue, Feb 24, 2026 at 6:32=E2=80=AFPM Zhang Yi <yi.zhang@huaweicloud.com>=
 wrote:
>
> Hi Robert!
>
> On 2/25/2026 8:05 AM, Robert Pang wrote:
> > Dear Zhang Yi,
> >
> > In reviewing your patch series implementing support for the
> > FALLOC_FL_WRITE_ZEROES flag, I noted the logic propagating
> > max_write_zeroes_sectors to max_hw_wzeroes_unmap_sectors in commit 545f=
b46e5bc6
> > "nvme: set max_hw_wzeroes_unmap_sectors if device supports DEAC bit" [1=
]. This
> > appears to be intended for devices that support the Write Zeroes comman=
d
> > alongside the DEAC bit to indicate unmap capability.
> >
> > Furthermore, within core.c, the NVME_QUIRK_DEALLOCATE_ZEROES quirk alre=
ady
> > identifies devices that deterministically return zeroes after a dealloc=
ate
> > command [2]. This quirk currently enables Write Zeroes support via disc=
ard in
> > existing implementations [3, 4].
> >
> > Given this, would it be appropriate to respect NVME_QUIRK_DEALLOCATE_ZE=
ROES also
> > to enable unmap Write Zeroes for these devices, following the prior com=
mit
> > 6e02318eaea5 "nvme: add support for the Write Zeroes command" [5]? I ha=
ve
> > included a proposed change to nvme_update_ns_info_block() below for you=
r
> > consideration.
> >
>
> Thank you for your point. Overall, this makes sense to me, but I have one
> question below.
>
> > Best regards
> > Robert Pang
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index f5ebcaa2f859..9c7e2cabfab3 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2422,7 +2422,9 @@ static int nvme_update_ns_info_block(struct nvme_=
ns *ns,
> >          * require that, it must be a no-op if reads from deallocated d=
ata
> >          * do not return zeroes.
> >          */
> > -       if ((id->dlfeat & 0x7) =3D=3D 0x1 && (id->dlfeat & (1 << 3))) {
> > +       if ((id->dlfeat & 0x7) =3D=3D 0x1 && (id->dlfeat & (1 << 3)) ||
> > +           (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
> > +           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
>                                 ^^^^^^^^^^^^^^^^^^
> Why do you want to add a check for NVME_CTRL_ONCS_DSM? In nvme_config_dis=
card(),
> it appears that we prioritize ctrl->dmrsl, allowing discard to still be
> supported even on some non-standard devices where NVME_CTRL_ONCS_DSM is n=
ot set.
> In nvme_update_disk_info(), if the device only has NVME_QUIRK_DEALLOCATE_=
ZEROES,
> we still populate lim->max_write_zeroes_sectors (which might be non-zero =
on
> devices that support NVME_CTRL_ONCS_WRITE_ZEROES). Right? So I'm not sure=
 if we
> only need to check for NVME_QUIRK_DEALLOCATE_ZEROES here.
>
The check for NVME_CTRL_ONCS_DSM is to follow the same check in [3]. There,=
 the
check was added by 58a0c875ce02 "nvme: don't apply NVME_QUIRK_DEALLOCATE_ZE=
ROES
when DSM is not supported" [6]. The idea is to limit
NVME_QUIRK_DEALLOCATE_ZEROES
to those devices that support DSM.

> >                 ns->head->features |=3D NVME_NS_DEAC;
>
> I think we should not set NVME_NS_DEAC for the quirks case.
>
Make sense. In that case, will it be more appropriate to set
max_hw_wzeroes_unmap_sectors in nvme_update_disk_info() where
NVME_QUIRK_DEALLOCATE_ZEROES is checked? I.e.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5ebcaa2f859..3f5dd3f867e9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2120,9 +2120,10 @@ static bool nvme_update_disk_info(struct
nvme_ns *ns, struct nvme_id_ns *id,
        lim->io_min =3D phys_bs;
        lim->io_opt =3D io_opt;
        if ((ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
-           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM))
+           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
                lim->max_write_zeroes_sectors =3D UINT_MAX;
-       else
+               lim->max_hw_wzeroes_unmap_sectors =3D UINT_MAX;
+       } else
                lim->max_write_zeroes_sectors =3D ns->ctrl->max_zeroes_sect=
ors;
        return valid;
 }

Best regards
Robert

> Cheers,
> Yi.
>
> >                 lim.max_hw_wzeroes_unmap_sectors =3D lim.max_write_zero=
es_sectors;
> >         }
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D545fb46e5bc6
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/nvme/host/nvme.h#n72
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/nvme/host/core.c#n938
> > [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/nvme/host/core.c#n2122
> > [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D6e02318eaea5
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D58a0c875ce02
