Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794657338;
	b=GSSBZLcXwKo1oLjH1XO0Z1CjjXt6THdO2/hZ4RYqZds/J4HodvVGyolzxE4YtHnak3d/
	 0oonCpXsj8nYvd58aavZbC0PfLZowAajfZjuE5UTjGRR+yG7wyiVCowCkxtUEUzEqcI0G
	 ZtnOkzD0kMuT86Xx3npWNbt354mDgNfohTNgSOCMUfot9vTbHWCkY3h6N7bUOOGtP3/Yn
	 vXf4OV7yey7m9HmbsRRl0l3Z9vuocrEKhitYx/iVdoJS7yK+Y7OuLcbAC9AemgnSrOURK
	 QD6zxGhjprYwgIvvQASKRbp8PWhwfkGcatbLQIO2NGK01hH7q740ifc8503P9koiwWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
	b=Dj0/x9dxWRP60kD29ess4+0rA/SgvFDoSUcdqe6yZ1QheqiY24puA2zC/VQEETXYSMce
	 Kc2cGYFRVKU2zNH4nBwceNmJkCPj0GZgfelGXU098Uy2VcVbssJjGpZ9dmtpvOgRwCi/U
	 OEyGkjBLStRF3/7PJX2prz35D+mPakSl9kmw9jvPIRD2zVYaiNd0kTouCUVYH8Le/bCaY
	 DgftJs0wj6wmxhUW6MfL1ZEXAx6C5sbfVqH50fGr+O45NpOCKRtcWlSfOdI98znGdkA3t
	 oRpdssaVsPVA98ovEFV2tCymJ5xkhth37JHU/tctH6McjPI2eVFWKFEs9jZekKuuGrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrTBjpIE;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65725606A32E
	for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 11:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65725606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrTBjpIE
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c50604721c8so370135466b.3
        for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 03:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794657337; x=1795262137; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
        b=MrTBjpIEXzsSZaANjc7oExJhwGnF+j3pBQoJGLV3AozjECewWnT/dOn8PoCfUIeYGI
         mRgldWBhVoyoY4kjpOu/TkcCPMpetn8bMN74Irqnk0JnK5MAQS777TE3iVfENO0qNvUE
         8qb82pxhdLikkA/6tATGUpByZMee1vHTbdl6A6vtosorr3+hE9wD/mpuH76lS1WAZqyn
         nUdTyabyG8UAyWqGnpYJGfY62DgpvBldD5kNADP5MARyaYxmHHJYDsQkr6qVKrnaldzF
         KHIyaxdpU8Pcl80WjVwUUXXw+yU81KD0D8RdN7wE6Dhf//BzElFXAKq/AgQBu3vGzFII
         7JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794657337; x=1795262137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
        b=o9AGfOT6wlH9/RVRYXfP6Xz48HqYJpqhsGvY65bzsHGJa288M/NaLDQbcmsxoeMKdO
         ZDr9OiUaBvpBPMbZBLhKxoU+uzkgBwbB++sIlhXA3wZvPZyYgQYVJ8euvSKfT2m6AjPH
         F2dyNHNHy3uiisdiuRYo5QNpGSzYxa+KcH32HpGEMyC0ljmi/wCziPaWP56tkXJVu6Jf
         KFpZxoO7ZyQh5UAoue22V2IzF5Y1fBG6r5oD4zSl//T7/GxzgHAX6HIdw45RQ5Lr3cVS
         4iZr8v9gN54z3R1uwATu5AE2vouU/CAL7a7VD/nTOoaQhHItjE1SaAriJ7otRYK9a/9n
         5cbw==
X-Forwarded-Encrypted: i=1; AL+hErF3iLXW8Wv0q6vlffpWGLl835SbgljFVCm2FeIIwHOlX5F9EMSC6WtCv1soqo6VdF1LIHPHoAo1xFfPOw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+o+nFdFvunyDFUL/eMdI+hun4fbqsj9F/00k9mePZ3ttNst/ue
	LQ5LSJwmGnO+0IPGcAP8gXtbtsz5GIWjWKuybesUrTxbHIcTIkJEqbH6
X-Gm-Gg: AYBFou2VxUmkzsIlaG8jaQ970odnnuUyOospNBlVbRK6bZaPVZ4jSrtXby3SNsZqM9R
	ElpC7fcpyW1zAUdKsdaRMF2fs8svJXcAf4owtONV8FGhGj1RyP2LWB1N5eZIXaXOD70FDXNehH6
	obyGJoRR1VegXgz+md8hg2S794R5FedJP9WNnDLc07XykmnEzAOXu/CnOzvpipAhdoRAZP322oP
	AHWIxCYaDmeBsegrNWJ+2AihBE0WWnYEiIrYqXopMRnpbGznP5gVGJ3bBecXfazvaWYSJ1deguy
	LUqzuzmYH/4s5Jb0k27Im7fdnFY8BkPQc53oINdlm3lKYvQAQXBEsg5YJiO28nVVBQuYNo2yNIc
	9B1HawGa49YLbwQomu7bB1v/VDH0R4FdBDcNinlES8jAlXE4aXMPvkyr402XuD2BBkH3V4Hruq7
	vONeXHYcy1apVwg05IsbM1II4NJPLXYKBXtMv/IlwwWDlII77g4rtvR9b9r9r7fo6yHh/x8fISF
	O6giWjIS9KsV6QdZ/VEpaQzO1ia54TqXog+FP/+TiwGOS8IlLQGq3MdqtVOZpnSdKGBjcKEdGxV
	rDcIir0+iBCMv7QMh9OHzzOgkzURf1U6S6Mn9/kTeXfDaRCjTH9jZ96AgmJ4hq0np8fDidiEln+
	3X41fgucMfho=
X-Received: by 2002:a17:907:3e10:b0:c40:231:6eab with SMTP id a640c23a62f3a-c5096370c31mr441592966b.16.1794657336589;
        Sat, 14 Nov 2026 03:55:36 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b41f44sm206223866b.31.2026.11.14.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:55:36 -0800 (PST)
Date: Sat, 14 Nov 2026 12:55:35 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Alexander Mikhalitsyn <alex@amutable.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
Message-ID: <avhMN39TECaur0sS@amir-ThinkPad-T480>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
 <20261111151202.GA11391@lst.de>
 <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>

On Fri, Nov 13, 2026 at 11:25:57AM +0100, Alexander Mikhalitsyn wrote:
> Hi Christoph,
> 
> On Wed, 2026-11-11 at 16:12 +0100, Christoph Hellwig wrote:
> > I've seen setups where people use fuse to mediate access to sysfs
> > sysfs in odd ways.  No idea if that's still around, but if so, this
> > patch will break it.
> 
> 
> Oh, that's painful. Do they use backing files for that?
> It's a relatively new feature in FUSE...
> 

Very unlikely that they use FUSE passthrough and if they did
very unlikely that it would break their filesystem.

The API for fuse passthrough is that the server requests to setup a
backing file before open via ioctl and if ioctl fails (as this patch
does) then server falls back to non-passthrough open.

The ioctl can already fail for many reasons such as MAX_STACK_DEPTH on
procfs as the commit message says, so server needs to cope with the
fall back.

Thanks,
Amir.
