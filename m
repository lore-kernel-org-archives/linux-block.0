Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66048165E
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106396; cv=none; b=orgfgAiJirE+xKqHV88uECbGPq53cG+HkXmE0O75BOzBqh8SwrzLFXFOXRJbXanJT39rOASL4f6Jj54Ho/VFHA+OW8llvgoTP6GCDyZtuooHD4HYd4XollBSW+MztSrT6gaNRBV8/v6Xqw3rRKv98dWJTlyrWRnsycvvKtOJDmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106396; c=relaxed/simple;
	bh=lYAdUUP+j0yiX5IukF1sZj4xyeGVz3upxelmkrS2Eec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P53Cn4FFheHYWhjR8W3mfT90De1CR0r6DWc8cgX4Z1FnVfNBfhQJh8uBbXOUvW1IpuLQYMehHhhAr1skXqdFVK0BYAqHWXHomQaliCA1i+kOKzn20dxlr5T4epyC4dMscYfq8Cez+vmqHSkAtHjtMRvgADSlDNRSfFnRbJC9nWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MeweUUK7; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MeweUUK7"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-36b903567fdso6990810a91.1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 08:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781106390; x=1781711190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjXQRwILCRJMnAYdZuSm5LSZZiZbPZ5xq9CU2aMCxQw=;
        b=TC6vVXaT6h8FK3vR3RDOdXshafsQeDXCitsHkYV1DV/IKwheeYqxeP7G/BoCLtR1Zp
         DWo0zcK2LuG+vu33w6z599peKVh8zwowhPcPVXUzYmbmUplcxb07CW0dUT9XtN+GUjh0
         dig/W7uug6oKbXPerVv097lBNpldDMX/X4uxiV7v+DNCg6xY3cNR1Wdkc+2zZqh9Syii
         q4QucRgg01JfgwC7rn403yAic+lQmUEWfz9XaBvSoGrwng8AxMGWvl6mXqSf+5aQnKQU
         Dmqt9S792z486GYdbF9Wh9fGY1npPT2YxnVRque8eV9dC82boy3K8yQs0YDnNa7hM3qo
         hc2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/APg+MrfZpXZh+KpHVySZMJp6DURaTdi01RZo3lYdyaDt1zoKKtj6pL+WdQxHxpVVNRFaTrzAbYz44Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp398Rq4ATATwvxP90UqDQniUFdOHBXzohRwTII+Q6tkABxCn+
	PP+LsMsW6FHOLQXB/iqSWz4SXURDJa+/CdxQfigWbcjBUYuOVorHWB2mCRzLpL6Kqyq0DGkmHzO
	d1pPTSVxc3e+7hflsvcCwProCCI/kCyKcK24o23prDNP2B64RMQaFQ7BkG+fbLY77QmTBuy79qw
	8o6FIs+z4oK3ZhXrSrkeR0QjNZEaWOvZMGYbdUXi/OkDIQZUQRP5pL7Pep3yZS44esu9zg0xI8T
	xyD/a9GI5UND++a8g==
X-Gm-Gg: Acq92OEDk8MZznVIJrLSVraFShlTMHhJrt4uNbl5M2wGC64YqGGLadro46DoXpqyjHg
	3ryRVYf7mvX/9+WvcOvKIZcS9EBPX5S1xSmlx8zqRclsxM56KBUJIbvueeggYRXkEhbzrpF8wja
	RKpRDVNvONzGCt/Xrhq4hRAaUE6Cw3P6Y3Pum1d8PhdMS27vmiMyRsXM8GsHScpRk0DBjc6ZHAk
	xb5L6eO3EK+KDzw9b/YULfuH8fyw20V7Zig4yegUbBkavDIumHMrjXdLRLZ0uZicuPCKAL9v0tC
	6cLVvPt+YbKOT2j7dQ5rPRR3VVQ050eht/Wj4iliGWXOOcZ6lW39mAulY5FZEUtZIQahUVU03t+
	Bt2V4o4PcBjncaxCSdbf2AujFrGk3whI7kForcjU/zzk1O4ZnrjQwmXyM69O7NBl+FxPGBrqd+y
	bZbFL1skPzxVi5cKZAqPawNC27va79sLOkUiaVTALOgDLsh26Rfw3FeKiwjoKl1iygf47XRg==
X-Received: by 2002:a17:90a:d884:b0:36d:b680:3041 with SMTP id 98e67ed59e1d1-370ee82fb58mr24601409a91.4.1781106389605;
        Wed, 10 Jun 2026 08:46:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3772cb2cfefsm14012a91.6.2026.06.10.08.46.28
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2026 08:46:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3969ddebd36so28060421fa.1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781106387; x=1781711187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gjXQRwILCRJMnAYdZuSm5LSZZiZbPZ5xq9CU2aMCxQw=;
        b=MeweUUK7I6cqmpNgNSkSJwY1NECe6kmqTEdTKgvfJVQwsiLM8RstkA0VJPE9zgzdhk
         uHPPI0nJPKTiW4kPkAIb48FvKYy0UgzgMp/HQ52QSF7ZkvTu/Hhmt+JdvHICWl4Hl0/h
         2C5bCNLbplyD/IPXSK+SEsZQ5T5Z23NsEKo8Q=
X-Forwarded-Encrypted: i=1; AFNElJ9qijW/ynF4WNXc9I5kUBuvjdS437s/BdYqUkgrOXiSN9GhMYnvIFAeU/sHr+ArweSTuSi6xep7O8Z3bA==@vger.kernel.org
X-Received: by 2002:a2e:2a45:0:b0:396:6842:b604 with SMTP id 38308e7fff4ca-396d08bd989mr56541191fa.6.1781106386508;
        Wed, 10 Jun 2026 08:46:26 -0700 (PDT)
X-Received: by 2002:a2e:2a45:0:b0:396:6842:b604 with SMTP id
 38308e7fff4ca-396d08bd989mr56540501fa.6.1781106385873; Wed, 10 Jun 2026
 08:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
 <20260609121806.2121755-4-sumit.saxena@broadcom.com> <aikAs4X-2NWTuwCc@infradead.org>
In-Reply-To: <aikAs4X-2NWTuwCc@infradead.org>
From: Sumit Saxena <sumit.saxena@broadcom.com>
Date: Wed, 10 Jun 2026 21:16:11 +0530
X-Gm-Features: AVVi8CczcMQl6yLccvF8BXqLxlWeOM_I7Uvs7Y8aVoY_zDLtG6L1R0wGVRxim8s
Message-ID: <CAL2rwxr1uGshb1o=jvP2OnBffNz2cKXj8tHuAUCN5HFuy2vB_g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] block: drop shared-tag fairness throttling
To: Christoph Hellwig <hch@infradead.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Jens Axboe <axboe@kernel.dk>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, linux-scsi@vger.kernel.org, 
	linux-block@vger.kernel.org, Adam Radford <aradford@gmail.com>, 
	Khalid Aziz <khalid@gonehiking.org>, Adaptec OEM Raid Solutions <aacraid@microsemi.com>, 
	Matthew Wilcox <willy@infradead.org>, Hannes Reinecke <hare@suse.com>, 
	"Juergen E . Fischer" <fischer@norbit.de>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, Finn Thain <fthain@linux-m68k.org>, 
	Michael Schmitz <schmitzmic@gmail.com>, Anil Gurumurthy <anil.gurumurthy@qlogic.com>, 
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>, Oliver Neukum <oliver@neukum.org>, 
	Ali Akcaagac <aliakc@web.de>, Jamie Lenehan <lenehan@twibble.org>, 
	Ram Vegesna <ram.vegesna@broadcom.com>, target-devel@vger.kernel.org, 
	Bradley Grove <linuxdrivers@attotech.com>, Satish Kharat <satishkh@cisco.com>, 
	Sesidhar Baddela <sebaddel@cisco.com>, Karan Tilak Kumar <kartilak@cisco.com>, 
	Yihang Li <liyihang9@h-partners.com>, Don Brace <don.brace@microchip.com>, 
	storagedev@microchip.com, HighPoint Linux Team <linux@highpoint-tech.com>, 
	Tyrel Datwyler <tyreld@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	Brian King <brking@us.ibm.com>, Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>, 
	Mike Christie <michael.christie@oracle.com>, open-iscsi@googlegroups.com, 
	Justin Tee <justin.tee@broadcom.com>, Paul Ely <paul.ely@broadcom.com>, 
	Kashyap Desai <kashyap.desai@broadcom.com>, 
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, 
	Chandrakanth Patil <chandrakanth.patil@broadcom.com>, megaraidlinux.pdl@broadcom.com, 
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, 
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>, mpi3mr-linuxdrv.pdl@broadcom.com, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, 
	Ranjan Kumar <ranjan.kumar@broadcom.com>, MPT-FusionLinux.pdl@broadcom.com, 
	Daniel Palmer <daniel@thingy.jp>, GOTO Masanori <gotom@debian.or.jp>, 
	YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>, Jack Wang <jinpu.wang@cloud.ionos.com>, 
	Geoff Levand <geoff@infradead.org>, Michael Reed <mdr@sgi.com>, Nilesh Javali <njavali@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Narsimhulu Musini <nmusini@cisco.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio Perez <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	Vishal Bhakta <vishal.bhakta@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, xen-devel@lists.xenproject.org, 
	Bart Van Assche <bvanassche@acm.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008948c70653e825be"

--0000000000008948c70653e825be
Content-Type: multipart/alternative; boundary="000000000000700d920653e8250c"

--000000000000700d920653e8250c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:44=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg>
wrote:
>
> Just dropping the fairness was rejected before and there is no
> explanation here on why any of that has changed.

I missed the fact that this patch had been previously rejected.

The motivation for this change stems from performance issue we
encountered due to false sharing of the 'nr_active_requests_shared_tags'
counter
on certain CPU architectures. I initially submitted a patch to move that
counter to
its own cache line to avoid conflicts with 'nr_requests' and other hot
fields
(see:
https://patchwork.kernel.org/project/linux-scsi/patch/20260402074637.92417-=
3-sumit.saxena@broadcom.com/
).

During the review, Bart shared his work, which eliminates the
counter entirely by removing the fairness throttling. My testing confirmed
that
this approach resolved the performance issues and improved IOPS.
This patch is part of a larger set, and I have reported the cumulative
performance
improvements in the cover letter.

Thanks,
Sumit

>
> On Tue, Jun 09, 2026 at 05:48:02PM +0530, Sumit Saxena wrote:
> > From: Bart Van Assche <bvanassche@acm.org>
> >
> > Original patch [1] by Bart Van Assche; this version is rebased onto the
> > current tree.  In testing it improves IOPS by roughly 16-18% by removin=
g
> > the fair-sharing throttle on shared tag queues.
> >
> > This patch removes the following code and structure members:
> > - The function hctx_may_queue().
> > - blk_mq_hw_ctx.nr_active and
request_queue.nr_active_requests_shared_tags
> >   and also all the code that modifies these two member variables.
>
> .. and besides that, this commit message is still entirely useless
> as it doesn't explain any of the thoughts of why this change is safe
> and desirable.  While the mechanics above are totally obvious from
> the code change itself.
>

--000000000000700d920653e8250c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br>
<br>
On Wed, Jun 10, 2026 at 11:44=E2=80=AFAM Christoph Hellwig &lt;<a href=3D"m=
ailto:hch@infradead.org" target=3D"_blank">hch@infradead.org</a>&gt; wrote:=
<br>
&gt;<br>
&gt; Just dropping the fairness was rejected before and there is no<br>
&gt; explanation here on why any of that has changed.<br>
<br></div><div dir=3D"auto">
I missed the fact that this patch=C2=A0had been previously rejected.<br>
<br>
The motivation for this change stems from performance issue we<br>
encountered due to false sharing of the &#39;nr_active_requests_shared_tags=
&#39; counter<br>
on certain CPU architectures. I initially submitted a patch to move that co=
unter to<br>
its own cache line to avoid conflicts with &#39;nr_requests&#39; and other =
hot fields <br>
(see: <a href=3D"https://patchwork.kernel.org/project/linux-scsi/patch/2026=
0402074637.92417-3-sumit.saxena@broadcom.com/" rel=3D"noreferrer" target=3D=
"_blank">https://patchwork.kernel.org/project/linux-scsi/patch/202604020746=
37.92417-3-sumit.saxena@broadcom.com/</a>).<br>
<br>
During the review, Bart shared his work, which eliminates the<br>
counter entirely by removing the fairness throttling. My testing confirmed =
that<br>
this approach resolved the performance issues and improved IOPS. <br>
This patch is part of a larger set, and I have reported the cumulative perf=
ormance<br>
improvements in the cover letter.<br>
<br>
Thanks,<br>
Sumit</div><div><br>
&gt;<br>
&gt; On Tue, Jun 09, 2026 at 05:48:02PM +0530, Sumit Saxena wrote:<br>
&gt; &gt; From: Bart Van Assche &lt;<a href=3D"mailto:bvanassche@acm.org" t=
arget=3D"_blank">bvanassche@acm.org</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Original patch [1] by Bart Van Assche; this version is rebased on=
to the<br>
&gt; &gt; current tree.=C2=A0 In testing it improves IOPS by roughly 16-18%=
 by removing<br>
&gt; &gt; the fair-sharing throttle on shared tag queues.<br>
&gt; &gt;<br>
&gt; &gt; This patch removes the following code and structure members:<br>
&gt; &gt; - The function hctx_may_queue().<br>
&gt; &gt; - blk_mq_hw_ctx.nr_active and request_queue.nr_active_requests_sh=
ared_tags<br>
&gt; &gt;=C2=A0 =C2=A0and also all the code that modifies these two member =
variables.<br>
&gt;<br>
&gt; .. and besides that, this commit message is still entirely useless<br>
&gt; as it doesn&#39;t explain any of the thoughts of why this change is sa=
fe<br>
&gt; and desirable.=C2=A0 While the mechanics above are totally obvious fro=
m<br>
&gt; the code change itself.<br>
&gt;<br>
</div>

--000000000000700d920653e8250c--

--0000000000008948c70653e825be
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
MjAyMwIMdI2Nfq/Vk8dzZMUnMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCkloji
6Psi9zgrhimshQEAXKX+Z3yyQJFQIYG+6+6wADAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA2MTAxNTQ2MjdaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCYkSOlUjhevx7TwDrrcUikBx++JLOdmjvHvdLqiUSZ
LP/AHE+UOlhenxZBe0mJddO6A0cm4DvKbYBitK52BHvnPp5sayvbQwnmojWZ2FfXGtbLC3y2AQxg
y+kKRdIK8nqgue6aiI50ZGCY6BTiO+KYTWolTWPeSocn7DOEjYCU+F9EA+/c0znhteowRkfRGm20
O4IcrxtdF6hnqGNdMcHCQbDxfE5HGXqedqIrIW6Cc11hNiZRWMu8NmWUS8Jwes1GMNkXBUs97yWD
XLqB7veCg3bBdlewSxfBRoaM2zwl9AAisQpG7w81yThfEwDpilRp1b7UAWMNt9Tx1JluD3Zt
--0000000000008948c70653e825be--
