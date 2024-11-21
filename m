Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27121CD1F0
	for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179773; cv=none; b=nNK5cukKWhl4AK+lLtiErCllyxGQWfJ+vU5o7iK9ByCBRYR2NBpiMDnn4VO9MiZDj+33wtjNw1URLdFZgc6XYHTYtIm2syeaotXTcxoHrhghTVdT5wgyvntLf0Tz8OWK++Nc6FuDNQIX8PZqnJXY1/3jneWYGJCt/7J+9PZTUKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179773; c=relaxed/simple;
	bh=Pn+Vw4M39HB8xnHadkFflrkdBCVzPoKZ9bHDcuhKRqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kObU4o42uALU6DTj4fJ1NPZblLQ/pDGcXcuOje4248wIQt5AQDJxR8Go5r7R+9ZSsQugqG1/enMmy2lXBF4KB6YKZEslESD43sh2cwzzDTOkMM82rO8srmoYvBPJrYgtQOMIqBt0c69msNiIU0Ett1TCifQhoimLtk9arv2B9GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzIsLx23; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzIsLx23"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732179770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xrHKfnvNAIlRkGRmgg4E6l8QK9ehO1whB8g67qiPv2k=;
	b=SzIsLx23NVbKpyQ8J+I2xJgzP0sB6Moy7kREHRr/JoYOusHVyVI7JD6fLhkVCl1X2UX95s
	EMsG9CH+2lBqZVDhui1rli/2Eh/FM/RhP+1x2Tu1M7hPGKL5N4yMVJzxnErmI2L86NCcsK
	pxsoQMdCP2mEA9ZM8SwCUzlwoI3h7NY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-ShYKq2pIMcGr4k8UdAz0TA-1; Thu, 21 Nov 2024 04:02:49 -0500
X-MC-Unique: ShYKq2pIMcGr4k8UdAz0TA-1
X-Mimecast-MFC-AGG-ID: ShYKq2pIMcGr4k8UdAz0TA
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d41a3c9c9cso10353346d6.3
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 01:02:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732179768; x=1732784568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrHKfnvNAIlRkGRmgg4E6l8QK9ehO1whB8g67qiPv2k=;
        b=Xz2P0QKAKadegvGmcTT4C6bGxFq028akJ0YDXj4f9CU1ijhZubZDzDL82H+A3E0s72
         vv3KoWIcIyoEav7yOmOtYgPxqEcWKfwccQ5e/rkAf1y/XEjmvCUnhdkqV+DDfjGDg5px
         D0lhQGnyVYtNyWkWVYNRsJ0isJKiZYyKw4DYb35TWxW8i3Q4kP/sp9VHGEy6T64Il91w
         tkeC4BTaoB67Yga5ci6fUTUUfd80oUazijpIEGDEY305kcLqA7M34hHo/ERBtDioeSTU
         zzHWyrqHpF1UtZfABpKnWm0bM/BCaGnhCPF4SgEuIJAoBFedxTOMGRMHlbl3D+0jJqS/
         s0Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXYsa0nY/SClHKitsHal/YTahAgsjwDTl/+GZPDcf//l8okhhEyUQyPA1E8g3x6wHevqekoDcqeJqYhxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4uDxES+gp6pTip7/Xi9QcEKlvIhI+ueeTKdLrEmwHubEUaDmE
	19z7dBgmeKXR6sX/PG1B5d5IQqUGHKm9W2cnc6mMAFRKkdmSbhewwYbQQfuBGZ4hwgcpdhBpfUA
	9FWIGNkidO4UPmOOcxW4MbI8mg0OxDQjYnJVkBX1Iq4wO0Qqohzy+FfRcRQEfkrPhDR9Nxf/KAo
	sH7f1KqmUDcpcx816rHUhiIJ53moP+LQxPEyg=
X-Gm-Gg: ASbGncuAAAhnYcn5PSxf31mgR30/f8etiDFQk7ymbdm9mAssnHYhih+ldNVNJhzQ5YY
	9FUdPcw91bhPJQGcspBGpfP76LVDFJKA=
X-Received: by 2002:a05:6214:27c2:b0:6d4:2044:e942 with SMTP id 6a1803df08f44-6d4377af7c8mr64395556d6.6.1732179768575;
        Thu, 21 Nov 2024 01:02:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs2HNG/V8SZ4UPKFfKNBtcIQX4/fQyO1j3EPx1QS4aK6692fKdWwIFKdKM8bhfXHy95j8kpbH7kTEw9q1CZr8=
X-Received: by 2002:a05:6214:27c2:b0:6d4:2044:e942 with SMTP id
 6a1803df08f44-6d4377af7c8mr64395416d6.6.1732179768350; Thu, 21 Nov 2024
 01:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com>
 <7f35cbe9-9e12-498b-b46a-be1f570772fc@linux.ibm.com> <CAHj4cs91daKS2Sexvs3y_m=r=+a+gJdk9=Z+76TdsE6=0nNcYg@mail.gmail.com>
In-Reply-To: <CAHj4cs91daKS2Sexvs3y_m=r=+a+gJdk9=Z+76TdsE6=0nNcYg@mail.gmail.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Thu, 21 Nov 2024 10:02:36 +0100
Message-ID: <CAFL455=-5a34TYdwva912prQd93p84Lq1YSebTCUUsuLjZ5pag@mail.gmail.com>
Subject: Re: [bug report][regression] blktests nvme/029 failed on latest linux-block/for-next
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, linux-block <linux-block@vger.kernel.org>, 
	Keith Busch <kbusch@kernel.org>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"

> 64a51080eaba (HEAD) nvmet: implement id ns for nvm command set

I am not 100% sure this implementation follows the NVMe Base
specification correctly.

The specification says:
----
5.17.2.5 I/O Command Set specific Identify Namespace data structure (CNS 05h)
An I/O Command Set specific Identify Namespace data structure (refer
to the applicable I/O Command Set
specification) is returned to the host for the specified namespace if
the value in the Namespace Identifier
(NSID) field is an active NSID. If the value in the NSID field
specifies an inactive NSID, then the controller
returns a zero filled data structure.
---

Now look at the nvme_execute_identify_ns_nvm() implementation:

static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
{
        u16 status;

        status = nvmet_req_find_ns(req);
        if (status)
                goto out;

        status = nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
                                   NVME_IDENTIFY_DATA_SIZE);
out:
        nvmet_req_complete(req, status);
}

Shouldn't it perform nvmet_copy_to_sgl() in every case, ignoring what
nvmet_req_find_ns() returns?
Compare it to what nvmet_execute_identify_ns_zns() does.

Maurizio

