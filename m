Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077C144C652
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428267; cv=pass; b=ceCGNjRUsagBECTzh4L0zZyzS3E8NfGz53dRKQKJWSiDpeUz4KD5HGveasbBiXpfTun4aGQQZavHu1990wff/J9JIz08yo/2TTHhJ7rhPTBMFs2Adl7cKHDQspW97txTcu/CbNSIOgQUMlmDAv6Ggh9TRlmikCzpb4rPXqSNa2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428267; c=relaxed/simple;
	bh=y9uL8axv/bSBp1hJEk9/5EREqK5uThhZ6LCPv7JfjT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjUKAFxKyQff/YqcllRibFAwd2WEYDxHDgauwOWWgH3eiY/tBIc2UICZ2BzEBAPIi/UhzyglUCVFcP2wG/pZHpreo3cCqXYiTOnwC2MMUmpNIRY10U7qc5sUB2eGw8qlz0rTDztEz9BUPZUvZ3UzSdaEQy0D9aOZZiznEXTNMxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MqCUIO9y; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MqCUIO9y"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4485b31257fso6996fac.0
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 09:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785428264; cv=none;
        d=google.com; s=arc-20260327;
        b=pYHwgnuwPQf4Z5vZlORe1sfx73POps8/R3Bqh7wOmfOBm7OQsNMC1qMp/elUG1MW7d
         Q6txQeN1njn+NK7hAhHzsr5tLkmVSu8Kx1nSyrZfftyaAMY6tt3G8vhMxNmt/2qS0AwE
         lqH8F/Xudf8GN3+K75ZLUJdw3TNhoVAQA4HYmfmgZLcDRkiYWhd+VnOdLMACeA/oiZrE
         DMMhn+SRjor9ekCZ/Cdgy2BHxz5nRipnToyyQMKc7GfNGyJMT4y0b5uPmIxzsyr539p8
         Sbc7LsJxy3Jjrt84Wp+mxJ/Lqyg/iPLmP1jUpD/W3Aqwdo+gHBTggYezbtUwNfR2gUO/
         8I1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y9uL8axv/bSBp1hJEk9/5EREqK5uThhZ6LCPv7JfjT8=;
        fh=ieOQmw32Pk4UZgSf4e8pJGZNECxPkx7w8lGuk7Gd+As=;
        b=DuR+NTKmBR9JzvcvIK/mYwHKUQGfAkSBJ6AdLUQi4VTNZcS2SEEZvJrP7xJZaFws2U
         4wZViwF8kXjn4u+01+Ssex2V6p108SDKul+G0YUCywHvEJt/bah3GR+C/Sm/Y0GsV2Nn
         zQLMNbgzCBZfxgg5vl/eoOXDhFiJk7NCXnb48sCfT1GxgRWh1aqT/vuw37FY5F4wD64e
         ri8AIM44OJ482UWVJeb+0lJBme/LpGPVtH4EOzXG1EJ0wwMWPLnnfzpQTHYpEJLdYwaw
         GgTdtsC3vOWR9AvUOHRASkxATSfvLbK+HAJO8adHBleZy+HWKonB1hQjhdRhHqDIeV4L
         snTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785428264; x=1786033064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y9uL8axv/bSBp1hJEk9/5EREqK5uThhZ6LCPv7JfjT8=;
        b=MqCUIO9yyYJwHrMDdiejiNqcDHA+nR86bfqK9iKWYUvi4dsxosqLK1HYtjLP+5hW70
         k5P3caMtPDuMcCd+Q73b4jXiKqkWofjW7ZGye0Gp8XbL+MuQteuqTWNusN4S1MOtLD4h
         f043KR8DclrbfQVIx1LIlJafF4mkqxY53CJGgcgKSlzzpPwATxfWrBB812Z2bO/xO5EC
         elYoFSb15ifUMJi3Yt6rGgvVTnyac4gvXe8Q5aNLZI3twpMmhH335Lq9BUPv5Oxu/My9
         v6K4aHa0gm3jyf/WIJFeYkP3hvhEKOXplgljdRIOV2CPW6euwywntOV8pDIXxSVXpgaz
         L+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428264; x=1786033064;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y9uL8axv/bSBp1hJEk9/5EREqK5uThhZ6LCPv7JfjT8=;
        b=E/VjTBgL4kQcgc2rGHfFKFYSBS5QVmi2FY1UPBIrXgjKGmhFglOUx6iZRllRi/ubP8
         k8JiKlEKRv4LyiAaRzACpJcaFEQhIo0hHB4KGMP11NBewQPExFisqP5liBpAVk/Xs9aZ
         ppwWPGW6YWw0urc/LeBUb64m6NbqEjSbg6Lkd7yTMUQLtBYZ+sYOT0dwLgKGDhmfVBsP
         Vsayqq+wdR/FcgxwMTPaAZE1DzHmrhOfac67pwEuY4pEKLgLwXLDG+FEeWjLA4E3++zU
         xD/cYWB4Ikgle/y/RFr0wNWXboqlfoMQM/R1s5plIVAM7iitr4wgESeDR1ijK80uKJzb
         c9Fw==
X-Forwarded-Encrypted: i=1; AHgh+RrIYkpSU59DdT9eQRz/9kMKwCe7vg3wTiTWRsoJDk1KE/DyAccZ35rNN+2vgqbaUUtZIubVHWtazxMANA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPLvYVa8W0hvQ3WFEn9aPbs+YHSUesuNZ7ybzzT2e/M9I93TTb
	0e6LI1PQHcXFhPW65BGn5G146RU97QV5ZFe1h44/HtKDb+sbgBK8N4dVq6ZVwhWU9PIJl0FUDCY
	dzfWrHuu3NfnHzV0/S1kos+NrOHPmYiN761V+lImDlQ==
X-Gm-Gg: AR+sD11nA28MtnPmdm2+73B0YWZnLWFWMHUTTwNA3ypEML2GXRjMcbE44gp7F/TBN6y
	TgEkb73FFrcOLb60xQ7u1kb3MjReQ70zkEJ0vbdi9iZIQumhJxzGr9AcWq7gBlkBUbibK83PbbY
	WQl9TmwGApAUybRBbnvowrmZFI5Xt4/+Q9kqWdIHP469PqGgncaZyPyAm5yhv8LTrKfTw6zZfxf
	7+xeng4tJSe05ZavSp5qI+sc9QmVau2Y0/bC5Gef7EvkVBZx1EOh7aa9X8DoiMZS9Bm2yZQ1ghN
	Nf0/V1Y4cfmugMhm6HPfqBEKWSSYr+Yak64aZ9Lo7KRA
X-Received: by 2002:a05:6870:610c:b0:448:8595:1e8b with SMTP id
 586e51a60fabf-458dd203cc6mr828125fac.4.1785428263717; Thu, 30 Jul 2026
 09:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785274111.git.asml.silence@gmail.com> <19e5c945ea8114320c10f7951d19197d48b59249.1785274111.git.asml.silence@gmail.com>
 <CADUfDZpwF0jp2e=+c3w_NjWPbnQ858bkSD731M6+x27jzgcJiw@mail.gmail.com>
 <CGME20260730104131epcas5p4b52720519486f7ac774c317923a79c81@epcas5p4.samsung.com>
 <de4ec386-42ba-41c3-bcbe-1fe8b2f71ba9@gmail.com> <09134617-6d9e-4963-9319-1855e88a4df9@samsung.com>
In-Reply-To: <09134617-6d9e-4963-9319-1855e88a4df9@samsung.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 30 Jul 2026 09:17:31 -0700
X-Gm-Features: AUfX_mzVuCLkHKoQjKU1BgpL-X0Ty4OF1wEt1trnCKGouEKw-m3DZTMxHTHiuQw
Message-ID: <CADUfDZoVUHMWK0KBnznB73o6Vg+iQBBzJE2NmF1Tf22Zvh4=Yw@mail.gmail.com>
Subject: Re: [PATCH v4 08/14] nvme-pci: implement dma_token backed requests
To: "Anuj Gupta/Anuj Gupta" <anuj20.g@samsung.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>, 
	Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 4:36=E2=80=AFAM Anuj Gupta/Anuj Gupta
<anuj20.g@samsung.com> wrote:
>
> On 7/30/2026 4:11 PM, Pavel Begunkov wrote:
> >>
> >> I wonder if it's possible to perform the PRP list page allocations and
> >> initialization in nvme_dma_buf_io_map() instead of the I/O path. The
> >> NVMe dma_pools are per-NUMA-node linked lists protected by spinlocks,
> >> making them significant CPU hotspots. If the dmabuf registration set
> >> up a contiguous DMA-coherent list of PRP entries for the pages of the
> >> registered buffer, any command using the dmabuf and requiring at most
> >> 1 PRP list page (i.e. length <=3D 2 MB) could just set its PRP list
> >> pointer to an offset into the dmabuf's PRP list.
> >
> > Possible to an extent, predecessor patches tried that, I left it for
> > later to keep the series simpler. I guess chaining won't work in
> > general case.
> > I mentioned this to Kanchan, Anuj and Nitesh before, they were up to
> > playing with nvme optimisations in general, and since sgl from Anuj
> > is ready, maybe they already have a prototype somewhere for that.
> >
>
> Right, I have prototyped the PRP list optimisation before. I will send
> it once the initial version of this series lands, to avoid adding new
> review churn while the rest of the series is pretty settled.

Sure, landing it subsequently makes sense. Glad to hear it's already
in the works.

Thanks,
Caleb
