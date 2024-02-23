Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE4D26B
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658644; cv=none; b=B1gxO66KHrWulMyVfwLabgaLomYdb19YIw+lAjvsNNVnFt2QScudbaFpbsGJrzwqb+uR6LGi3hBB/7iyn4S+ANf3LyafvPeeM2ivcjOYL7EwVzJ5+aTs+oDwYlWy1VhjU+G4rCO7Gtm2W8TLPRyL15E9ZGXN6j7Uw4U4dg5Qac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658644; c=relaxed/simple;
	bh=w4WLae38KckxJOJLv6EghJyvN0FC7uz14a0t+gIeRKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDsZss/JH5pYiqU0lQtTi0hrXCeLJZdvbYEhrm2RxheG2QOaYlon3t77fFbtAiv4g/4UsbDErVikK9sT5pMy/LWvkeO8H4GHfhaHEIMovo0BX8lwrAarjMWFxMK9TLa1lzOWq+q7T6YmDof4YArXT9obH7e5iQBOJLw6q9THGWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAzmppGz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAzmppGz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708658641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4WLae38KckxJOJLv6EghJyvN0FC7uz14a0t+gIeRKo=;
	b=UAzmppGzbgJo2ikOhJ3dR6Kc7wIm8rfkxnUGXNReg6JFKiZFfZzEqNxdCVJEI27pUWfIJ3
	05BYgEwrwFdL01HV+5BOAfKwfvsdbYHh96G9dBjrSao+w6Nh+m0kcIzvBrhEueahWG/+Ed
	OZrnOM06VKM6e1wclaj+SQOWYI61bVA=
Received: from mail-ua1-f70.google.com (209.85.222.70 [209.85.222.70]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-BVIOgC0bPqK5yyDZK6O2QQ-1; Thu,
 22 Feb 2024 22:23:06 -0500
X-MC-Unique: BVIOgC0bPqK5yyDZK6O2QQ-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7d5b124ac45so111934241.0
        for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 19:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658586; x=1709263386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4WLae38KckxJOJLv6EghJyvN0FC7uz14a0t+gIeRKo=;
        b=YMe6e+Zn2b9pHDPuZRMgYnnasDD7qfQkNLzvHTmDB4IXKUs4FdE/L2fcoCcUOKpJVU
         lMGizdk7NNYJeCBSOWFeW42JgBKmnD4fqXNrLy128WIn0YcPE778kDJIR4SW1JZLusX/
         Z1l+DCY6q23/+rMLzGAzH5uemNp0umTQMxCeHXt+ZPZS9BiWoEhtCjvgMGzIsNHjxH+g
         K8YJDR1qIkRtoEzUUo9PIWTaWdxJg7nTIRwAbc9hySJIZGE5vFCfTy199x7H6P5gneUH
         e1tEteRYmzR2whsgokr0H/87TlzRtu8M/w1dvukZSkJ253oo0MHbLkh0Xh14B2lyeJSR
         o/eQ==
X-Gm-Message-State: AOJu0YxRukTtqtZpHHGgEqv8UFOoah6YZ5ovOHSjIPdVrxMuAu6DFvZg
	jXfhfn6o5d1s0vqX5u7Iiqg2484UldfVFoMjSF5mxHhQLnk2XIhkCtCpV96tmrxaZTpDJW0o9IY
	61N1KR7D7whon7VJqbpqEBxpE9YkOdQ0v/9gRJ2A0/fsfI5SaeVP1+9w1W3BUhHO7kNuwuznoh0
	TWpfad3X70gWcfJ2dcAojXC33dTPAPPx4Own8=
X-Received: by 2002:a05:6102:3a0d:b0:470:535d:cc0b with SMTP id b13-20020a0561023a0d00b00470535dcc0bmr777311vsu.2.1708658586143;
        Thu, 22 Feb 2024 19:23:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/galynwST6Fez3ScJLIu3z8LEO5YQfd+AzlwLmAZcLbQrZyKxr8b4qFZgk/CzAYt+bZ9hy04w8P6syD55uGk=
X-Received: by 2002:a05:6102:3a0d:b0:470:535d:cc0b with SMTP id
 b13-20020a0561023a0d00b00470535dcc0bmr777305vsu.2.1708658585869; Thu, 22 Feb
 2024 19:23:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222191922.2130580-1-kbusch@meta.com> <20240222191922.2130580-2-kbusch@meta.com>
In-Reply-To: <20240222191922.2130580-2-kbusch@meta.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 23 Feb 2024 11:22:54 +0800
Message-ID: <CAFj5m9L7W-LWTxPrE2moas_L-q-eJ5ie_BoP8hd61Azut0qt_g@mail.gmail.com>
Subject: Re: [PATCHv3 1/4] block: blkdev_issue_secure_erase loop style
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.org, nilay@linux.ibm.com, 
	chaitanyak@nvidia.com, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 3:21=E2=80=AFAM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> Use consistent coding style in this file. All the other loops for the
> same purpose use "while (nr_sects)", so they win.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

