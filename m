Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4809D1714BE
	for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744151; cv=none; b=KAERdKITwDaTOLfrjbBFJctyolEcyeWrT6+rEE2WNea++TtTJiV7603aefGkIKCy5ziTu+f68Zrunsc/geqS3Wksc2VLeRqaTbuFAWBWi8Kzmhl2+Y8trgUYfxGtq1Wz+jCwXhFWV8GUu+HfXRkFeSXEhVcCgq+GajjZeQuO/l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744151; c=relaxed/simple;
	bh=rB0ckiBv1RX+5vNc+Mtr6fHkNRXErazAw2m5iMS+Nv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSqxT74q8lHF3x8Eg+L2nuaazl/GDPdDHiGSDYCIY4ITCJCFdTDTexflFKLtTS2eoOTIq2G6l/cm9WLW+odDMGST9nb0VxMOLphQffv2MsrwX5V3TsNbOUCYEkflL+f07N2eSkSU+e2zUGkYgf3Bf2NBs4anIWTuXD38+mXKv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6WFgnsE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6WFgnsE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724744149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02dk6NMMcpkIDMHf2jaQRB/DcSut0WzixTzX5tb12v0=;
	b=Z6WFgnsEC/EJhAg4m549N6R3vZlfCZ5ymNa8QhbiF2lilbhi1T28VQyROLGggkgrEddsDS
	5Cm0LWl5aV7yCz5B1jt/n+HKkLFlAG3I1T/rShepqOjDNaf/K6YqY/jU0mtAttxLa8jgMC
	LWEaui5ZeTDFgktCINDPhy6+UX7qVrk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-5ln4qJHtPWW1290E7BmEJQ-1; Tue, 27 Aug 2024 03:35:46 -0400
X-MC-Unique: 5ln4qJHtPWW1290E7BmEJQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d3baf38457so5514200a91.0
        for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 00:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724744145; x=1725348945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02dk6NMMcpkIDMHf2jaQRB/DcSut0WzixTzX5tb12v0=;
        b=lb8iVEPHbBRw+dNXIskqiAkNjvgNfGqNALqj/hUDaP66cl+1xbcCD/pQ41dFZqfh6C
         NeBhrk4IeQz5aDn550ZDt++DO6oFU+MyOE4ulUpwcbTo1kAjPzZtXKDq7+hoE5PpomSb
         QrmCUEyqQrAEIYEimDd4mGjQgCQ3rI0UsP0sf5pjCUV2vCJJhNQ3ph1mvfCZpiBwQ8ar
         Srrp2CQ/OGv7pEMroARWpGYG2Bu64wCokaDn/SG3JKQhuX+7qILjZK22S6xd39N23PdF
         ++KxRQ+JeJL3bVMD5vI4pPd+Wyyp0mqgaEgV3SubxDyhbqha7E28DKLwo7eWi3RheNeM
         BKag==
X-Forwarded-Encrypted: i=1; AJvYcCUeLBLmiPI4bSV/zqEuezk7uHqsFvmIhUAQjDOgVa+1+bl1WdXNvTp118DjRMhOK4i/A9KHZLqnAxc7Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiJ3aK/KV8Xtjt8leTiQf7wf8cYsnf0xLSXts4iE7QOfWqZPPI
	iG4JfNznNKT6PIzdjvik2Cw0K/YKkewAWT8vVTMDS/VhQ6oL0CY1ou7GTGw3I1P9U39nL/EP0BG
	GhBiQN7fTtjXdQgB+MnQ9yehU7xGmoi0TSJM2uYvbST6CAYFTE19gxCQ/FFPR/RrBDd9oVwk7vn
	7fuOCp64gd/LFvWX0vYU2zw41tJKDHOvjZIBw=
X-Received: by 2002:a17:90a:d347:b0:2d4:902e:ca3f with SMTP id 98e67ed59e1d1-2d824d0288dmr3096349a91.19.1724744145342;
        Tue, 27 Aug 2024 00:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0OSblcWUdxuv087XjvF/81nCSFwqkvcum8/J4kLvynjY/Hbxh1qtdxhnJbYOqU0yqhBuXNtqzORD896PQFj8=
X-Received: by 2002:a17:90a:d347:b0:2d4:902e:ca3f with SMTP id
 98e67ed59e1d1-2d824d0288dmr3096327a91.19.1724744144979; Tue, 27 Aug 2024
 00:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827032218.34744-1-liwang@redhat.com> <8694fd51-67a2-45e2-bda4-f6816e1d612c@oracle.com>
In-Reply-To: <8694fd51-67a2-45e2-bda4-f6816e1d612c@oracle.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Aug 2024 15:35:32 +0800
Message-ID: <CAEemH2djkWMtuTN2=Y5MXZVOACeCm32_Hh0zAJxH7X4Ss1MSuQ@mail.gmail.com>
Subject: Re: [PATCH] loop: Increase bsize variable from unsigned short to
 unsigned int
To: John Garry <john.g.garry@oracle.com>
Cc: linux-kernel@vger.kernel.org, ltp@lists.linux.it, 
	Jan Stancek <jstancek@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 3:20=E2=80=AFPM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 27/08/2024 04:22, Li Wang wrote:
>
> +linux-block, Jens
>
> > This change allows the loopback driver to handle larger block sizes
>
> larger than what? PAGE_SIZE?

Yes, system should return EINVAL when the tested bsize is larger than PAGE_=
SIZE.
But due to the loop_reconfigure_limits() cast it to 'unsined short' that
never gets an expected error when testing invalid logical block size.

That's why LTP/ioctl_loop06 failed on a system with 64k (ppc64le) pagesize
(since kernel-v6.11-rc1 with patches):

  9423c653fe6110 ("loop: Don't bother validating blocksize")
  fe3d508ba95bc6 ("block: Validate logical block size in blk_validate_limit=
s()")



--
Regards,
Li Wang

