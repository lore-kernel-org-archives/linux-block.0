Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61972E1732
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781603; cv=none; b=KwDaT81RcDd54eSVWiz4QW8GaCZo5lYpaqBgfujkjXBWI7ff56aGr60klDy6yZBb8NU6uxT1hDmSYIjbqYE5DA1dFMtRo0biT/F1Fnd+DYx1Y9A5Cq9hFsNiQURPvZTPcbJcGgtpDIYC+cFCtcBVBjHGHD2IfyX8O7ubdxMJzqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781603; c=relaxed/simple;
	bh=tYG5jTcIc6lkYrhz7J10TtWJVbsSBH0IkVNYKqBZoK8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gvViJEmQitManBldsRdP2ho9ttHYl6Ng8gJA8sIE3AmZluNM7S9CF9p07bjIN3QfTS6ZyHYKseYRkWveayMCX5ejypVfn87CcRl8UZzaFclrrussFu80MEnpDU+dA1vrGF/hPxJmXP366zBNCfPjMIMiX6D8pUsZYHVUD0gxlD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Emmll7BP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Emmll7BP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750781600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x5R79lIc79qw+LwnY8ZeG/QCJ7Vln6rRrb23eTtbbts=;
	b=Emmll7BP/s/EWG9ZbnDcggqM2oNkeE0wYY8fy1YYQ0LTUmwTYV+/OeMx3X1dBDk++jwByC
	CaYJexQ2gpIhbM27ZMOaPsyeavDTTWZkdlX4OF071Qm89/jbntZmB9CKiqdurN4VOPjI9o
	6Q0t3t+PhplKfXfbmhrc/Fp2Qn6ayNI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-qNGgXgUqNq6CkPTlecmtgQ-1; Tue, 24 Jun 2025 12:13:14 -0400
X-MC-Unique: qNGgXgUqNq6CkPTlecmtgQ-1
X-Mimecast-MFC-AGG-ID: qNGgXgUqNq6CkPTlecmtgQ_1750781594
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c955be751aso75924385a.2
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 09:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750781594; x=1751386394;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5R79lIc79qw+LwnY8ZeG/QCJ7Vln6rRrb23eTtbbts=;
        b=JfLvCOtmNckJ5vKhgZekfjAOnlT3BLW7+7mwzD3IPvrkYLj7AHXgqGTHvED+xY+2kL
         nHdHPYsRKs09U+CEErYE7RY4CQ/r+fQXwaCJcsX/yaYmZrkI1XbP+uSl4fgTgym71nwv
         V1Q0+bxFKvwX31GMRWoxVpzJiua3kOOgzCXaRBxz8sRklDCq5h+zEqCmJeEJR6N/uxdp
         iXmgvOMRKplSkca5+3MYddRaYe5jpEYrbHnSH3hG36uKdSN+41RVT3Bd/lhGEZKRfXfA
         /urMdJIVOkXf5pTzq0tD9i/mKUNWBHYJL+j7as4AdOj8JMB1waf2RwopL9Gu6Cisiohr
         o+yA==
X-Forwarded-Encrypted: i=1; AJvYcCW9d4UYWB91WzLTPwJ5RLL8TsFidSfTUQeueOkYBA+z2hcpfarnOqKREgKrgNmMyIEa4uXIqSUvSziNfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNVCAgEaekHFdULuuobeOsx3L7z236LhIoJO4lncQcUvXITW/4
	giqNfofmiwoVbpgSu2ioYuGhukK6hML3xFQDKGPJr4F1QnmBvtji6rbzvtevwaxj5hjBUw4i8hf
	MnqtnhYSZlOyPWJxHvhjxAuHHYSkle+E5bA1qYDD/oiruIiPzVjjI6vcAHOKzVQ3H
X-Gm-Gg: ASbGncsIZ7hZ6cUCc/q5qtv5qvVu8I0PkoqzBthITqZ8+tUY9JE9XjIu7Pt45czXoFY
	Yq3UptbjfaZ9EcvQqN6mBCPip7OPTxo976dYP62hAoEI4qNPOL/CUbCNxyIbE2N7WtGh2xjhVut
	lmr4o7zH11NwiUc7qfE3u4Gb8mGgg1RJJ0tpuEaVEHHENL31axkWbuq4R8aXxpChGl63vq7PicE
	E7Cx6JUHc3ps45pgL9S0QkRsunTyK5rcmtnugU7eO5lGyZl4XuRtf+BtJoURwN8fRdMFZndQr1j
	xR0n277VlFqPC2H14+EK2Qha/hW0vkTtA5bzNtTyICIqvQnSU7RK66UD/4nhbGip5Y2CPtBBg83
	Kqzfa4LVBjPdbHhGn
X-Received: by 2002:a05:6214:20e9:b0:6fb:f10:60e with SMTP id 6a1803df08f44-6fd5e0c0c8bmr3725166d6.40.1750781593492;
        Tue, 24 Jun 2025 09:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCm31O5u32zNkqCRW8pO6mkfdRgGmr0pw1SUCu9UJ/KjZ0LHdt89nkuXO+YjDtpESggATGMg==
X-Received: by 2002:a05:6214:20e9:b0:6fb:f10:60e with SMTP id 6a1803df08f44-6fd5e0c0c8bmr3724586d6.40.1750781592875;
        Tue, 24 Jun 2025 09:13:12 -0700 (PDT)
Received: from syn-2600-6c64-4e7f-603b-9b92-b2ac-3267-27e9.biz6.spectrum.com ([2600:6c64:4e7f:603b:9b92:b2ac:3267:27e9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd0945183dsm58565886d6.44.2025.06.24.09.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:13:12 -0700 (PDT)
Message-ID: <017f14924a49b76148fb4cfd9c6107d423e6cb2c.camel@redhat.com>
Subject: Re: fix virt_boundary_mask handling in SCSI
From: Laurence Oberman <loberman@redhat.com>
To: Christoph Hellwig <hch@lst.de>, "Martin K. Petersen"
	 <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>, 
	"K. Y. Srinivasan"
	 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	 <wei.liu@kernel.org>, "Ewan D. Milne" <emilne@redhat.com>, 
	linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-block@vger.kernel.org
Date: Tue, 24 Jun 2025 12:13:11 -0400
In-Reply-To: <487a4646387595383bf8ae24584c5b54ec6aa179.camel@redhat.com>
References: <20250623080326.48714-1-hch@lst.de>
	 <a665dead67bf4f3432cf1bddf29d2c573ab71673.camel@redhat.com>
	 <487a4646387595383bf8ae24584c5b54ec6aa179.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-11.el9) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2025-06-24 at 12:11 -0400, Laurence Oberman wrote:
> On Tue, 2025-06-24 at 10:21 -0400, Laurence Oberman wrote:
> > On Mon, 2025-06-23 at 10:02 +0200, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > this series fixes a corruption when drivers using
> > > virt_boundary_mask
> > > set
> > > a limited max_segment_size by accident, which Red Hat reported as
> > > causing
> > > data corruption with storvsc.  I did audit the tree and also
> > > found
> > > that
> > > this can affect SRP and iSER as well.
> > > 
> > > Note that I've dropped the Tested-by from Laurence because the
> > > patch
> > > changed very slightly from the last version.
> > > 
> > > Diffstat:
> > >  infiniband/ulp/srp/ib_srp.c |    5 +++--
> > >  scsi/hosts.c                |   20 +++++++++++++-------
> > >  2 files changed, 16 insertions(+), 9 deletions(-)
> > > 
> > Grabbing latest and will test tomorrow and reply
> > 
> For the series looks good.
> Same testing shows no corruptions on storvsc for the REDO so passed.
> For SRP initiators generic testing done with fio and passed, unable
> to
> test SRP LUNS with Oracle REDO at this time.
> 
> Here it is, enough reviewers already so just the testing
> Patches were applied to a 9.6 kernel because I needed such a kernel
> for
> Oracle compatiility.
> 
> tested-by: Laurence Oberman <oberman@redhat.com>
> 
> 
> 
Nit, fix my email, dropped an l should be loberman@redhat.  com of
course

