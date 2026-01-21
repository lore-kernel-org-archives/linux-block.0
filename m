Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE442982A
	for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007183; cv=pass; b=Yq6Vzni/dQ4+jkJw6E6L5ihfnwAfZbEthpLDkmh0phAk/tncawqElWOWGFe/CH/40DEKKkClFH1BzDoQ5AmLAXn/Tl3myovjF7wI3VJQfRlI9rYumvwlYQpweU/AFhQzziGWAV8OKDbYjSiMuUYn1z/jciqTHO0lEGQITFUXBFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007183; c=relaxed/simple;
	bh=HSdY/oDCC56KEO8yOQKdMOLfqUnp8tGTQL85wqnmnJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYgb+6qv08n5YkDcqSfNNyXPT9KLCt1jb55znx7FpH+nO0cn442PQhKAjOG7FENF+ZBBoX+YnKHbRgvm7FoYhN6AOdFzbSELMxyFF4JBQEPjvLf7UI2LsdSP5iKEIPE5ypdxIUhwctIbvbOIRIFqwPfJjWUd2yOSNZOFB7AuYOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ScePvGou; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=An6porFC; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScePvGou";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="An6porFC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769007179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bymOHXXWa3ti+0JtpL8X8fDmC1PdoR58XRE3ITRpl/A=;
	b=ScePvGoultPsbkONw7petAIRpPJPXYYt4HVLptHRJZSYArt4Uh8aFnHuopKEqLNui6nSY1
	np6185WY4/B4+rt1RXefqUS/xE0nU26MA7CSlAMvY7kHjPNu9nPxtWJZpVygmoVasQohzX
	2hTgusQ41eeqaWf7wNmrv7BiKUpMgrs=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-HetiKavlPJeQeUEklxmq5A-1; Wed, 21 Jan 2026 09:52:58 -0500
X-MC-Unique: HetiKavlPJeQeUEklxmq5A-1
X-Mimecast-MFC-AGG-ID: HetiKavlPJeQeUEklxmq5A_1769007178
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5f178054150so5790520137.2
        for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 06:52:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769007177; cv=none;
        d=google.com; s=arc-20240605;
        b=iULoFVoFms5yLYJnGIHuQMOYIEmJ320p44g2EYJaiRXT+lwGrB+2FaBECIirm39QmS
         +IxHLUaECGec/kn+197/fPiboBAEkq+5vNKizUDVcy6UXjLXeTwtAoyw47KCCcE3/MPM
         fs9cEaAkjY2P4urtv48R6eiKLD1efPoRbC18acGh1RtSPWChn/VCI5/DpZQti9ebYXup
         EdYG3J6t9SX/CtOk6AWDJmZKgMognTMEaypzudL8j77ioNs4Pvu8kATgw/XxJ80UdsyO
         ywIuLDQ5VoFkVjW45GHiqevTpja8/l+u4O/afD2BdRsZaMC9rTn0olFoiX1sENR4jSXt
         K0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bymOHXXWa3ti+0JtpL8X8fDmC1PdoR58XRE3ITRpl/A=;
        fh=t2MoEDfJk17aa/4JOrMcC+x2dTftOryVtuftf3ZUTNs=;
        b=HMt2htoWHb8qSKuCkxglRGM4WinxeBYDJ0MbNT+d+pHMbp+I+Y65yAAXkVXBwuWEyF
         KSVUEG7xTfuuN3YuMHDxFcRjDbWiNEyYgfqQDbhQ7fH9ybF1A0iLQxINOdnucpgxMLLg
         8vWHfp/MoXa0R5tC4B8Lb2uMHsshp7hkn9O/FUri2F9sOG9DyFECyQyjjwRMIvteTMX5
         AE+ugnyXoDfceBBg63pC2GtNYQSwSYKnHHPVLjl85ECnXY8BOVQDd+r3YwEplUJy1R/e
         BlB3zm4KkGYkOJSv2lvckMa1ZGcB8uXz3qFRG9nMfs6K0vSat3JBSCvCObOgpx8J8fU1
         JQMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769007177; x=1769611977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bymOHXXWa3ti+0JtpL8X8fDmC1PdoR58XRE3ITRpl/A=;
        b=An6porFCS0pIWB+6TnxIBXsG2CFuGqfaKgmtsyt4/Q8YIGbYtrpuuuTxhGbBi1Qosj
         eBYfJdwOpMeAux43CULZrHd/dkpiBAnV98ofT5Pi5VmE+7RimqU0EbRVLmEu2dRSo0cI
         euakrNcw686Cmt013xEiF3u+32I6GLntxUtu33Nd+Fe2nf+qyNpB/b+7T61TXuPXcCqQ
         kYY2G2zS2YA1fgHj83zJbcqSEi15fzl+7G4qdLP2JgwCGGKKqAalKV1wMTafebZkAGrk
         YlwyHyDZEPCbxHb2ZkHvFpgHn7bWIjoGnNF3GYfpW1G7WdF5mownluGZhRWKKwH9Z05v
         522Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007177; x=1769611977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bymOHXXWa3ti+0JtpL8X8fDmC1PdoR58XRE3ITRpl/A=;
        b=WhJBC/e0Ga0x3RsWPBkuePM7/i+c1Klm8hJf4jh065IlgoecKUTdLBJ0TPUzT/KZI2
         hLS2QfmhHoVYVpLBTGdweYOFVyXG4WZD7f995UBh0bOW3bOLSV2ysxzPLcOZmKQ7oKPy
         rq/j/5tztn65lcXGwQejK/tUjs7qXIB/Rc2MEKQqYO29h2yWmf+9JZihyTAHZ9/AsTPn
         PELVuvlTaozcoJHcM07x9fSKyEd3NI0fQeIZptUuNA7l0eH/VL8hfCbFgoS+4eGTQbS5
         rSRMjKUii59g2jyZuSpbEyeqcbFFAT6oWTehscqlDmCPl2gBGm0svloZy9EBWkk0czV+
         sL5g==
X-Forwarded-Encrypted: i=1; AJvYcCWrXawiSS4nuW6acyMgJeKreJzfmegeIn8HyHRjbjOW6iNdPr6DAbNnU7ug6yT8QEkZMX47/VkVd0CzPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU1rTj1CEct3DTP4tu3+MQRAodEwfomyrg+hX2ZHY16QblbTxI
	h3LA7FExUKJgOdV5uO2wcpmF5Z6C87WPAIr9K7BIT8xlADyRkxNkHESmLnRwbQ8S0vHmu8HcBk5
	wnkDuounYQ5MOzHpQZZ2yHcUimvvbHudX+Doeso6EhmcVnqEAbLI2Tnt9jk1xiikV/wR0wS6D1b
	OIQsSZrgWC+ZywCotYznrXgWxHSe1UyqteK8v5wEw=
X-Gm-Gg: AZuq6aINbz9ZjNWo5Ya4Q8jxWfVWo51RfYCHqk1ivH/E9V/o69NDhHJpajVG+L3ah7S
	+Eu/mmfmXx9P/eMkauxZGpfALZ39c2KMOzv9rw2YLy9VSbt+qwPLwSiUc2IzW546DqyJ2dkfo+Z
	Iwho9m/M+ssRivwAhwVhcGWqcEhggKFqWAjjhpEKq2ler4Cf/izv2NoFssqG7WX/DO6WQ=
X-Received: by 2002:a05:6102:cd3:b0:5db:eeb6:812c with SMTP id ada2fe7eead31-5f1a72200a1mr4876350137.43.1769007177616;
        Wed, 21 Jan 2026 06:52:57 -0800 (PST)
X-Received: by 2002:a05:6102:cd3:b0:5db:eeb6:812c with SMTP id
 ada2fe7eead31-5f1a72200a1mr4876346137.43.1769007177273; Wed, 21 Jan 2026
 06:52:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113085805.233214-1-ming.lei@redhat.com>
In-Reply-To: <20260113085805.233214-1-ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 21 Jan 2026 22:52:46 +0800
X-Gm-Features: AZwV_QhVqSvDzacrVyx_uBFuVj2hBWN396C6UbBfajrWdJ5SyaFD2rvUBmNsZkA
Message-ID: <CAFj5m9LW-L7iQQg7czmGwZ1j9B48fxMXT8-5re+kpV2TSGgjQw@mail.gmail.com>
Subject: Re: [PATCH 0/3] selftests/ublk: three bug fixes
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>, Uday Shankar <ushankar@purestorage.com>, 
	Seamus Connor <sconnor@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 4:58=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Hi Jens,
>
> Fix three misc issues of selftests/ublk:
>
> - make sure all io_uring commands are completed before exiting from ublk
>   thread
>
> - cancel in-flight uring_cmd in case of failing to start device
>
> - logging fix for avoiding segment in case of logging & garbage output in
>   case of foreground
>
> Thanks,
>
>
> Ming Lei (3):
>   selftests/ublk: fix IO thread idle check
>   selftests/ublk: fix error handling for starting device
>   selftests/ublk: fix garbage output in foreground mode

Hi Jens,

Can you merge these patches if you are fine?

Thanks,
Ming

