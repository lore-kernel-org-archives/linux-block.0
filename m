Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1638077111
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962526; cv=none; b=ovRbgP8CjpscwZmARxlaIMcDRV4OTbmVbZoibrq5zpH5AGmVAg19eO3O0+wPtH+z5QXDiKqzSYnOHQC+xHkVk301K0T279sGOwaavEIhm0iAUlwWVbgpEyNJ8AQ61eBJWdEPLt3hRX0rJTe2wPTFmYDL5Y48BRpOy+af4Alr0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962526; c=relaxed/simple;
	bh=Xqu63g49oubRpsWjwsnfClI07X5l6m7msQPsWmmgxC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WL5+hSNe0xK2wwbAU9S5kHYg9gyOo8Vjc7Yvsm2dWygiAv8/hN0f6xwI+B3sLI8Sa0vItznQAIhXhU8ainM3iWZidbbB8UxV7ik7TbN2z4hKALGUFxELuSDTLH+m5hdoDl1kaWnBUV9WInaTb13Fa6WpDMjtd0Kpf6AjPPWZ3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dE51/9ZE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dE51/9ZE"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-31f255eb191so788072a91.0
        for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 04:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753962524; x=1754567324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hkN0tI9B20gWFLyUHNfhvSFfOgY2x76YeStrLafG1M0=;
        b=dE51/9ZEucG1sLW0XyvpfYNMcuGl1NmqsceW7DOSnTkj7s0DQQrG39ywJhyBlJp+4N
         2M25APBOsD9kivcSG/+Gzlkl+wnJcWG6QRgKDPTH4sPBqn9VKnA5hQoHI0f1w4TpbTP/
         EGv08vu1Ivk2DJLDALwGmuHhysPxcrFBoe6euwpnzmjljTf9uwHqCJcwZGtts1RrKA+E
         T9+FpJ3AEP0pqi9iOCNO/7b/9D40wBlfSoNVp1KOqaGATzsWwZMLFiHd5t2M0I1+pTYb
         K6L9Dnmh3Ecd4GFCofD9vk1d7SWMKhhO8RGT2htxKIBrVHR/QCjpGjNMV67G0ZyjEPjf
         sFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753962524; x=1754567324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkN0tI9B20gWFLyUHNfhvSFfOgY2x76YeStrLafG1M0=;
        b=Av8fsiwIITcjLNTBxnwl5kVInqz4zfBj2AUJgguVkbhBRKDspmMh3gsXlG830HbtxO
         +T1sZyAbYKZL5Rq46AkqmdWYt8+a9hyTjNFXQgmVCs7CbEKqt/B3yrVnsk40sf3X98LB
         hJp6avjENQJBpMohp3QJZFAVTfjByuvii4W+TDMCHvgBOYbXltzaL8hYSCZU9oBZDh4w
         kVkhBOIVgtuMVzGGgtlPxg4lks/qpHQI5GQ4Nn2QJiVjz+f6O2iwggd8jNhNxrS9HPnz
         9qi/+wdzTu5TZnqpRwWsHGAjFgARQb1ezAb6r4Ldk+7hxf9isxSB+GpYEILtwgzsrHpH
         40CA==
X-Forwarded-Encrypted: i=1; AJvYcCUD6EeopPFHivW/S0g5EgMTW3L983EAW1t9O0RI1pBJ2CFv04EE+b3qr+wdHaWwqZzhSC96hkSrskc8wA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaed7d9dJT3lRhfbGD/pKc+PXrTDvd6plBy8wuVvLaygiG6izQ
	xvHrY9FpeThYosFchHiztc1k0mxOQTUOc0VlYPxHwMP0jkG3BuUPUDzIh15H+wB1Eew=
X-Gm-Gg: ASbGncu5NJoXs69Oe9iiyKOF+z8CgyqvnayXir677g7xn2pT4T7FwM0IMDjYmLVhN7v
	E1HUCHa+sw8B1KwADD9Pw+UxSASQKVFPVVQPzgEkD23tB/JFVTYxXAOrjQggdR1vG8qYqrjBRLd
	Za5rmHkV5S/NkRRWuUYOGAQ9dNAxLgJFX0kLr9ypNIefBd0Bx06IpahkcHsRxyBZSOOyggpdPHN
	fi4Jbf/oA4aLeaDovqLX2MkAVbd//Z20X0nwZb6K6SF1PRY8qmmpec2u2PrDpc0uUaJ1RNGTKAi
	C1m8GZew2E2LXRTaKpHDFLmM5CZBUfXCmBtOCDrbCtyBLK2pVTt2iP4qwiiJv/HkVX/6SIFx+tq
	l7oUNpJGDbckdduqvT5EEeEl0ZXhId3y3KhSWzbs+Vsov
X-Google-Smtp-Source: AGHT+IGrG4jwWLL+fMJTai+FsxthmxLYiFBUGHsgwdEYcHLxx+ldiinVCD17Tcs33DG72yK/NKzseg==
X-Received: by 2002:a17:90b:57c5:b0:31f:12d:ee4f with SMTP id 98e67ed59e1d1-31f5de6b9b2mr10171787a91.23.1753962524306;
        Thu, 31 Jul 2025 04:48:44 -0700 (PDT)
Received: from H7GWF0W104 ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da565bsm4597298a91.4.2025.07.31.04.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 04:48:42 -0700 (PDT)
Date: Thu, 31 Jul 2025 19:48:32 +0800
From: Diangang Li <lidiangang@bytedance.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Friedrich Weber <f.weber@proxmox.com>,
	Mira Limbeck <m.limbeck@proxmox.com>,
	Niklas Cassel <nks@flawful.org>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-block@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH v7 08/19] scsi: detect support for command duration limits
Message-ID: <20250731114832.GA97414@bytedance.com>
References: <3dee186c-285e-4c1c-b879-6445eb2f3edf@proxmox.com>
 <6fb8499a-b5bc-4d41-bf37-32ebdea43e9a@kernel.org>
 <2e7d6a7e-4a82-4da5-ab39-267a7400ca49@proxmox.com>
 <b1d9e928-a7f3-4555-9c0a-5b83ba87a698@kernel.org>
 <a927b51b-1b34-4d4f-9447-d8c559127707@proxmox.com>
 <54e0a717-e9fc-4534-bc27-8bc1ee745048@kernel.org>
 <72bf0fd7-f646-46f7-a2aa-ef815dbfa4e2@proxmox.com>
 <3b2a6cfe-5bf3-4818-8633-c200d8e6f122@kernel.org>
 <4cb58e56-d9e2-4868-84ad-8b7253148228@proxmox.com>
 <75412b1b-3f39-4f6a-93ce-823c15a19bf3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75412b1b-3f39-4f6a-93ce-823c15a19bf3@kernel.org>

On Tue, Jul 22, 2025 at 06:37:50PM +0900, Damien Le Moal wrote:
> On 7/22/25 6:32 PM, Friedrich Weber wrote:
> > On 14/07/2025 04:48, Damien Le Moal wrote:
> >> On 7/10/25 5:41 PM, Friedrich Weber wrote:
> >>> Thanks for looking into this, it is definitely a strange problem.
> >>>
> >>> Considering these drives don't support CDL anyway: Do you think it would
> >>> be possible to provide an "escape hatch" to disable only the CDL checks
> >>> (a module parameter?) so hotplug can work for the user again for their
> >>> device? If I see correctly, disabling just the CDL checks is not
> >>> possible (without recompiling the kernel) -- scsi_mod.dev_flags can be
> >>> used to disable RSOC, but I guess that has other unintended consequences
> >>> too, so a more "targeted" escape hatch would be nice.
> >>
> >> Could you test the attached patch ? That should solve the issue.
> >>
> > 
> > Thanks for the patch! The user tested it on top of a 6.15.6 kernel and
> > with the SAS3008 HBA, and indeed:
> > 
> > - under 6.15.6, hotplug fails with the log messages mentioned in my
> > first message,
> > - with your patch on top, hotplug works again.
> 
> OK. Will post a proper patch then (tomorrow).
> Thanks for testing.
>

Hi Damien,

Are you planning to post a formal patch to upstream?
 
> 
> -- 
> Damien Le Moal
> Western Digital Research
