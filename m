Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663E93A381D
	for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030436; cv=none; b=AfvR0J4w963aAN0ZuS2UH7tkSw37vgWjiToFKowsYwR8ylBEMUgEbj6FMk/xxVv1ZpLGjYyiI6I3PTERPswO1sgO0lQk3ego+VJ8mzMwzGQ3qAlYKJhexOJMOn3Qa+ic6kMWBOIdm9TZ3I/y/JnduEV2qkoojlJPwV2zQw5wlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030436; c=relaxed/simple;
	bh=96sbAZPafOa+Bj6MD3f5YLxc3QBZXNK7l8NPedI4rRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFj8XDDJB2YEKVi2mHLU5Qy+H3/i96P1KNq4ddMf7scxlRWXCm95365uJ96WMtrJj9zEhuE+3+EP9R9FrvPxWYGhNrTtV8ua78HutBdWJexLfp23Pr0mPB6gAIIKY+FxxZ1sValcRts4eikFDfppNgHBIW36F4mttNkUeUstI28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FF9pm+za; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FF9pm+za"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-c79506f3c40so2823607a12.1
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 04:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777030435; x=1777635235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5klHZw6KHbrjuBGP42J9YX0tNBmMkSZu7UbE2WbLVA=;
        b=Qz2ByZHuezTQkqJsPpqWlDWXixcRaod+0i/ITHeZ6J4LvxiEz1IDxnshgtGAgfXZE6
         m2sGtv3LrHPN/eA9z9Q2yh3eqjNqQaJ8duZPlTnxZGhAhbKb3ynJfKQylk9ShzJP2exK
         u7WueKnmvxSslXisp/7dAqs+AkmDCDndBWUlt6q1tB3sFaWUGpduVVmb+qCIxAeaGGsb
         70/oKG64iVN69RWxVy9jLILpstfo33ROUIW73BAB9UPydYdT2WbPhtb1yuGnZ15qpMn5
         sGV1gJPpDMVgaAJSJsiX7cE4SHn6UEzzKntDpV2E628RxHqzuqoG54DBTJz8lKTGbMWm
         EMMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CKFuq4/TLlFNQ6836IiWRqqWuxgTRdmh95hSqZ9fqpssQ/nFN6qyhaGlPI8ekeX0AK5K63SaEv+5b9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqS079zWNQ7tVBB94kWSSys9up9mGKdDGWL4vWomH1iM/T0fWN
	9XuROt9VKZEUj4BUpwOFXPmaOdb5ayd/t6xm45aAP3wAhFm47D7hOzEkpuhBEtgGJdXTv4iEvPj
	0DQO7rpdysC4KZ9qUe6IHpgGX7+zoqTG65u7FF1xatETcKUMi2TkrN5FXfqQdOx242Ag/glwwlz
	qZMWOcxmbaUTVfbKycgPmSGsgQtTX31XjlkbblmmyTchY9iESZlYWyQg9yV6G6grbuFR/Rg+Dwd
	bYKpri+opww1/92aA==
X-Gm-Gg: AeBDievES264JoTqFlDJp2bfsw29yN4vrOaWrrKMYPZ7VMjQLW7lO4bZNKrnilakWxs
	HBil0HljuXaU/31pQpvIcNdX17jrGZGsXDs79YKRxcve2U1g53G3MVyTIceruSSX648c/Pz+hPX
	G/EDNXuVdoe+s7foV/0lBox4acC43WF+mVINo0aTO45k4GJBlQJoGX2YBT3mQE24Gt3/i8+XLUq
	qAsbCNnd8n9W8/cXpLZTwbX1HU19rXPgHmXjCxLUuYtJEIzAzakHCD3msdyBhHUrkedydF47www
	2m18Axp/GNqYnQ4/XL+r6FBNuXDBYP5NWaMnMTjZ/jAh6hxvvkK7I+lvhgemrnHslwundmf7osA
	0Yt8/ltmZLQGmcLrVo8qMrv6FvntaD0afIpOGg+AG0iEUARY7CAK5LuTte394pRJDmJN751L1WJ
	eesrDtRLWuhe3+Tv0KA1twsx7K/g6rgKDwYAQyDGAQ5fHJS+lXAfDdhtyKtr3T00jE56o=
X-Received: by 2002:a05:6a20:914b:b0:3a2:d79c:415c with SMTP id adf61e73a8af0-3a2d79c43a0mr24278051637.47.1777030434451;
        Fri, 24 Apr 2026 04:33:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c79770aa764sm959750a12.11.2026.04.24.04.33.53
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2026 04:33:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5a406666270so6012226e87.0
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 04:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777030432; x=1777635232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p5klHZw6KHbrjuBGP42J9YX0tNBmMkSZu7UbE2WbLVA=;
        b=FF9pm+zaQ7fp/O5reRBlxkREkoCx3j/tu5MBTqt5QLAu774fxhIeK1Dsv6DeQJXxPm
         z0VOPNp5gfJHGCbisY6HKt6HA4IMsXY3WvmRaCSVxQ2v0FrBAN9gCE+QNQFgJY0y7utJ
         Qo5nb6gwunr78zBWaBT8cu/WmgAGN7LXnvCiY=
X-Forwarded-Encrypted: i=1; AFNElJ9kl/ZF5G+T8JncW9//xH4+qHll+fTrf/kdjtR+/sGVXVHdHl3jVdsoEqDUZpqQibNbohD8wG6iaifyeA==@vger.kernel.org
X-Received: by 2002:a05:6512:36c1:b0:5a4:19df:48d4 with SMTP id 2adb3069b0e04-5a419df49bfmr7069057e87.18.1777030431976;
        Fri, 24 Apr 2026 04:33:51 -0700 (PDT)
X-Received: by 2002:a05:6512:36c1:b0:5a4:19df:48d4 with SMTP id
 2adb3069b0e04-5a419df49bfmr7069036e87.18.1777030431402; Fri, 24 Apr 2026
 04:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420113846.1401374-1-sumit.saxena@broadcom.com>
 <20260420113846.1401374-2-sumit.saxena@broadcom.com> <a27a04be-6c41-4d7f-b697-b04c4fe9dc8c@oracle.com>
In-Reply-To: <a27a04be-6c41-4d7f-b697-b04c4fe9dc8c@oracle.com>
From: Sumit Saxena <sumit.saxena@broadcom.com>
Date: Fri, 24 Apr 2026 17:03:52 +0530
X-Gm-Features: AQROBzCT5Q_jm9UCw6s7ffiH7xMv26ULaNYD59NPvuZP9VGpfR1Rlq3cw7VNW9M
Message-ID: <CAL2rwxr+7tD1BfxKJCn70wyPT34=sfFMfUNAV63SAW0BxQ-0Ug@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] scsi: scan: allocate sdev and starget on the NUMA
 node of the host adapter
To: John Garry <john.g.garry@oracle.com>
Cc: martin.petersen@oracle.com, axboe@kernel.dk, linux-scsi@vger.kernel.org, 
	linux-block@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com, 
	James Rizzo <james.rizzo@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ade1510650332363"

--000000000000ade1510650332363
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 5:40=E2=80=AFPM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 20/04/2026 12:38, Sumit Saxena wrote:
> > From: James Rizzo <james.rizzo@broadcom.com>
> >
> > When a host adapter is attached to a specific NUMA node, allocating
> > scsi_device and scsi_target via kzalloc() may place them on a remote
> > node.  All hot-path I/O accesses to these structures then cross the NUM=
A
> > interconnect, adding latency and consuming inter-node bandwidth.
> >
> > Use kzalloc_node() with dev_to_node(shost->dma_dev) so allocations land
> > on the same node as the HBA, reducing cross-node traffic and improving
> > I/O performance on NUMA systems.
>
> I suppose that this makes sense. We already do this sort of thing in
> scsi_mq_setup_tags() (in setting numa node) and
> scsi_realloc_sdev_budget_map() ->
> sbitmap_init_node(sdev->request_queue->numa_node)
>
> For the actual shost allocation, we still use kzalloc() in
> scsi_host_alloc(). However, shost associated device is often a pci
> device, and we probe pci devices in the same NUMA node it exists, and we
> try NUMA local allocations by default, so nothing is needed to change
> for the shost allocation - is this right?
shost allocation is not an issue, I will drop changes related to it.
The tests indicate that at times sdev and starget are allocated to
remote NUMA node.
So, I will limit these changes to sdev and starget only.
>
> >
> > Signed-off-by: James Rizzo <james.rizzo@broadcom.com>
> > Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
> > ---
> >   drivers/scsi/scsi_scan.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> > index ef22a4228b85..9749a8dbe964 100644
> > --- a/drivers/scsi/scsi_scan.c
> > +++ b/drivers/scsi/scsi_scan.c
> > @@ -34,6 +34,7 @@
> >   #include <linux/kthread.h>
> >   #include <linux/spinlock.h>
> >   #include <linux/async.h>
> > +#include <linux/topology.h>f
> >   #include <linux/slab.h>
> >   #include <linux/unaligned.h>
> >
> > @@ -286,9 +287,10 @@ static struct scsi_device *scsi_alloc_sdev(struct =
scsi_target *starget,
> >       int display_failure_msg =3D 1, ret;
> >       struct Scsi_Host *shost =3D dev_to_shost(starget->dev.parent);
> >       struct queue_limits lim;
> > +     int node =3D dev_to_node(shost->dma_dev);
>
> this variable is only used once, so we can use
> dev_to_node(shost->dma_dev) directly
Ack
>
> >
> > -     sdev =3D kzalloc(sizeof(*sdev) + shost->transportt->device_size,
> > -                    GFP_KERNEL);
> > +     sdev =3D kzalloc_node(sizeof(*sdev) + shost->transportt->device_s=
ize,
> > +                    GFP_KERNEL, node);
> >       if (!sdev)
> >               goto out;
> >
> > @@ -501,8 +503,9 @@ static struct scsi_target *scsi_alloc_target(struct=
 device *parent,
> >       struct scsi_target *starget;
> >       struct scsi_target *found_target;
> >       int error, ref_got;
> > +     int node =3D dev_to_node(shost->dma_dev);
>
> same as above
Ack
>
> >
> > -     starget =3D kzalloc(size, GFP_KERNEL);
> > +     starget =3D kzalloc_node(size, GFP_KERNEL, node);
> >       if (!starget) {
> >               printk(KERN_ERR "%s: allocation failure\n", __func__);
> >               return NULL;
>

--000000000000ade1510650332363
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ifscJ8gSasrjdgcsGC9lCyPXLwfNEU5C3Mbnua8OK6sTBpf6mvY88HW/6AoKiSpfo5jxCZQOm4Zz
oJWD5ea7ThJ2XdDk1rRtGUkwFgN9GRNfOoiIwkkA7EdEfV0eQkVqNgkqUyBSABXcduul2sd4/JQO
SsVmTdSKid7L6yZsqk5b3Xj+GMJwPdRfeKP2SRoys0SVnajc9Di+9Jy7uGKxxtb562egZauDFX/0
o0UgYfZrbwWfzJDYMLKzlrOD0M8yGkD8BnyIiVECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZc3VtaXQuc2F4ZW5hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQURSmmYGaiq6dg3CEvXQGHEXJF
8xwwDQYJKoZIhvcNAQELBQADggIBAAl0pcCjujKdwmgtiGl2naEY5wB4G601Kuu3032tR7wmgZLg
k+lg9fhAA0boPsi1FE1Pwb93YDBGr/naS/oQ9JglSMeEVzeRvCqjFS4FpouBAFHB77c8w3ZwJ3+t
FSRJW9SbW0DADBn5t8GAjv2aSm5vDorqFe9MKOYEe50yYDQEUAsEt5QkrLTcEx9ntvVb25MxI8vM
bdfqna+/TyCmFmnGAz58jiw5DxLn++6wMmAk0SeUEuMrAlRIyhte6BBSBQ5cL1P+DWSqQbm/pwCq
NhySSLNtTi2dKJvvg6Ax9au913KiJj6uZfPlh6/0kaVKM5GhIABUcm3c6g2qD7ITJxB/p1kjYKLa
hVrtrjK7000lHKTPFr6MWB4Ggx7yKQ9yIlPMKKF/Lj8FabYCqeM5ovG7kaK8FYXug5vjNjN0nedR
X3P8o+8aL6WFIAAAKm2DqZh3252Gcken8v5c+f0SXWSJFvemfFNgrJiQFnFVrOE5v7qwvM/KvVCA
dYm4Ph9QYI0sm+Xitx8MkdOJtq5mcPWowGi8UiCgkOidv4ki1SA0wptfquUhbfS9b2M3XUHCEIUX
4ECvIjR3f+E0NbBIfPccWfYUaDLvo2qhLYS3KQbhKdXcJ83ha17mbVNZbDDo9upNcLO/oPyDbCNF
J6UpXZmis1wnCynhK4kQfwFhW7H+MYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMdI2Nfq/Vk8dzZMUnMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDQP+2m
9x9KRrwIuow9BAUCi0SzsPbFR6Qnu6EoHyvJ/jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA0MjQxMTMzNTJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBT2d2/m0b7+nvMUo7QmtbouYQFfwRorBwp/atKN0hN
LD8WTdVClFQ9Xi862pD4MnSBI4f9ht+kls/of3ZdnIBq3zGmik9qHn0Kw34hyyf8G7OJUL0Utdgm
TGdHXzaM8cc4MMRWc1RHR5FS/DmWMfCxSxGZOehWDqHuMknm9rzWqe5e3hFVBCFJJl6IbNljSWqU
2Bx1YVMWY9eLEdUpgxvvykIH6kBS44qrEzy4TJLvagjwhc58GbhFr4JZ7mVWWSThsugy5PR3Q4vW
QXJYRzZtjdAw1Ym0+r1ltCC6LJbfDC94h3UrgUUzZQePffgWMrps7zgVB46jksCqmeOXHhAY
--000000000000ade1510650332363--
