Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E0E1369B4
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564889; cv=none; b=KqWRJl1ZjKLGbYDc22KJz0y/TmOU9sCOvEY/vjzAbhh9JRBFWa/2v+UG7ofJht8Wb+C5/SZX2jjXG1Y8RLmC3ktY6NzZIaXw4OkTrFNLQMJ6OeHIsokf/nv6LRG1lMKnEVKbWjPM0jPVEVQtO+RqNcgBXLseZzHLlU3dB4I4qqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564889; c=relaxed/simple;
	bh=ElrmiGqTx7/N7CJCWhfGbBGOcno7083buOeiege24Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGqwpjWVYFIFB3b/3zYU72pdA2IyburSff2wnqc1hOfMRpJlferRUTT42mmVQ/pJQ8RavJv7ArE6uJ+d8BaMpcm0orMYRWHf3poZ3LjEjZb+uyS6q2EtpQXAnaD8ZFHLcPsgETvk+Nj+7hNPdooEzISUvTJWeV7Q9WfUgCAn6Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZuuwZ2Y0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuuwZ2Y0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751564886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXrn0Lr79Xx4WaPYsj/Z1OBljINiFe8PiX2x+MR8c2s=;
	b=ZuuwZ2Y0D1eDZAcJ6LZqrsHhLNu0Z0dorhMaGDvqBPHFw6xEVLz7x+SZuIkD39XAiEAb8a
	OvqMOHCMdKVZyUBXQhWd1vIYRmP2u7wCwPsRoMmsWucbUjXx3hnX2J0KWAVmveRg7XEhGS
	XiwximJhUhqXsFtsZBU4WiSfY5K7Lfw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-GMP6n60ePfmZlU1hzssVMA-1; Thu, 03 Jul 2025 13:48:05 -0400
X-MC-Unique: GMP6n60ePfmZlU1hzssVMA-1
X-Mimecast-MFC-AGG-ID: GMP6n60ePfmZlU1hzssVMA_1751564883
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-32b4a06b780so762591fa.0
        for <linux-block@vger.kernel.org>; Thu, 03 Jul 2025 10:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751564883; x=1752169683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXrn0Lr79Xx4WaPYsj/Z1OBljINiFe8PiX2x+MR8c2s=;
        b=gpIAPBfQLHshrjvhd3gg8HnlyQ9yZaNSccwPyWuGb6M3U8YktDqRBeHyOF5t6aGyoH
         lX/7hXli5nFdI/UL31vNHhT/18AiqGYAyuZwGrLVBJB7KMCgTbBf480LzkOsUoEs9Li3
         gB2Xj0Gl/k+i4LHM4tmjp4n/Yv1fvCsbcaxVXHR8rnTAyd0JR/jGIOgNkvtVbALO1GRM
         HWbpc18l+Tv6XAhAu5G5UxHk+DxusN7P2Zo/vGb7HMC2plfJaYSRN/Bt5ESsD4iwtBdj
         05KHouPfh4bZa26Ap6kdrpxeiQwwy1DX3Ayn5gnYb0VIHPVk6sfnhvVs91QrUUuKVvV/
         YUHQ==
X-Gm-Message-State: AOJu0Yx+Xaa/Q5eiNdnJCrAlCgVODyGcXLkAUXrVVyrtOOeUGOKIY6wQ
	oLplSRDGMAKqVBkKBz0zso6TO6iP0s+3V/asOlYSCUpGdAorYHEgg/f6Ojh1zB9JFPMsj5U+Fry
	+FAWXlXBQhlkBRLj4gOAZUFU4k52OncO8xkr1au0AsAoDJi5xJSCOf3lJVhe7VJei6fYpcxmEb5
	hlVU/xNSQiMBJthoBgngZtYKPlg7fyTb1as8K0UE4=
X-Gm-Gg: ASbGnctQzhbrwKxs3G4GL4aZm2gHHl03WMgVqNGOAi4WADd7gTmy8ZrSI07YpRPG5hm
	OHf32bL/lALEqsd/iFf1SLlLIXS3QgrlIemN4Qar3cW1LvrBe9iDc6y/n+KPS0qNsQj8oE+kz2v
	y8AX+8
X-Received: by 2002:a2e:7214:0:b0:32b:585e:30bd with SMTP id 38308e7fff4ca-32e0006aba2mr24225011fa.21.1751564883172;
        Thu, 03 Jul 2025 10:48:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuvVSz8tzXtJu5+PFQ/r3o6wJcqxkoU3DjA9mvAGAU2k/HNhldxr1s2Gm5hXdkuGVL9X/RNdgi1jJHXUcHjgw=
X-Received: by 2002:a2e:7214:0:b0:32b:585e:30bd with SMTP id
 38308e7fff4ca-32e0006aba2mr24224941fa.21.1751564882741; Thu, 03 Jul 2025
 10:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs_Ckhz4sL5k5ug_Dc5XfjSo9QDRSrHMfBj2XYGm_gb2+g@mail.gmail.com>
 <6e74e9a8-2dbb-4ad4-a48b-9af40d6af711@oracle.com> <20250703080359.GA365@lst.de>
In-Reply-To: <20250703080359.GA365@lst.de>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 4 Jul 2025 01:47:50 +0800
X-Gm-Features: Ac12FXwYGPoZMFiijA-eK4zGwljz6KFT2iLdmeRncVvmIltAxq0IUgIFYHpG788
Message-ID: <CAHj4cs_pJDR-VH7-RzGwt9KmNCdTnQ38bejeB72280e9ke8ebg@mail.gmail.com>
Subject: Re: [bug report] nvme4: inconsistent AWUPF, controller not added (0/7).
To: Christoph Hellwig <hch@lst.de>, alan.adamson@oracle.com
Cc: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, John Garry <john.g.garry@oracle.com>, 
	Ming Lei <ming.lei@redhat.com>, Maurizio Lombardi <mlombard@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 4:04=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Wed, Jul 02, 2025 at 09:33:32AM -0700, alan.adamson@oracle.com wrote:
> > Looks like the device isn't reporting AWUPF after the format/reset.
>
> The other option would be that the format changed the value.
>
> The mess NVMe creasted with the totally un-thought out atomics is
> beyond belive :(
>
> I wonder if we should just back out the whole thing and wait for the
> working group to come up with something that can actually safely work.
>

Yeah, the format operation will change the awupf value.
Here is the reset operation pass[1] and fail[2] log
[1]
+ nvme format -l0 -f /dev/nvme3n1
Success formatting namespace:1
+ nvme id-ctrl /dev/nvme3
+ grep awupf
awupf     : 7
+ grep nawupf
+ nvme id-ns /dev/nvme3n1
nawupf  : 7
+ nvme format -l1 -f /dev/nvme3n1
Success formatting namespace:1
+ nvme id-ctrl /dev/nvme3
+ grep awupf
awupf     : 0
+ nvme id-ns /dev/nvme3n1
+ grep nawupf
nawupf  : 0
+ nvme reset /dev/nvme3
+ nvme id-ctrl /dev/nvme3
+ grep awupf
awupf     : 0

[2]
+ nvme format -l0 -f /dev/nvme5n1
Success formatting namespace:1
+ nvme id-ctrl /dev/nvme5
+ grep awupf
awupf     : 7
+ nvme id-ns /dev/nvme5n1
+ grep nawupf
nawupf  : 7
+ nvme format -l1 -f /dev/nvme5n1
Success formatting namespace:1
+ nvme id-ctrl /dev/nvme5
+ grep awupf
awupf     : 0
+ nvme id-ns /dev/nvme5n1
+ grep nawupf
nawupf  : 0
+ nvme reset /dev/nvme5
Reset: Network dropped connection on reset
# dmesg | tail -5
[  597.973393] nvme nvme5: rescanning namespaces.
[  598.292285] nvme nvme5: rescanning namespaces.
[  598.584937] nvme nvme5: resetting controller
[  598.626440] nvme nvme5: inconsistent AWUPF, controller not added (0/7).
[  598.633064] nvme nvme5: Disabling device after reset failure: -22


--=20
Best Regards,
  Yi Zhang

