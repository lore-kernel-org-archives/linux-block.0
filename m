Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F4A1E2307
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 01:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764293617; cv=none; b=TQwCqOjuvWJBHM9mZC+rjgVdhfHgIzvuBCnnCsVZYBXqfbPU0hyPd6ukvfh1/C++kuDvzA+1RR2upYE4yKZN2XzTGHRUax8FUq6hyJiivQMFoVrUTw94OZGiOSyrjlwyRQnw3MNKt+mHuci4h88FOV/nUpFdGHghToUL0rXakts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764293617; c=relaxed/simple;
	bh=uW7r4RZeddBNz8cscDewEXSV9y5trmetenOT44ENLvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/oUFOBGF0D1llvJZARKXyJweJO1JQSHP1LNwefOyQEZ/82L7We3Bv0DjRZcj/L/bGb1wJyPQ8B02cXDVCmu1Y+Esx13OTam/egi984NWydNX9TLbxLKIp7hgx0pi/m6rZ+S6QWYv4evH/B/6X/KYffz8DKgf9kv9IZl5PGN9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwMHRMb4; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwMHRMb4"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ed82e82f0fso11398051cf.1
        for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 17:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764293614; x=1764898414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCmoVsJTYhvhdEhqnCuQdxLwDfWSRN4iQRhiwDtzkSM=;
        b=AwMHRMb4r0mGd3gA2xi7H5T4pl343UxVkWjPc+Gpb0Y53VB0zRTRoMLiEwL0P1xQ/n
         UPYEF+viyxrxa0E1x67z4i7IG9BZtNQav0AVMLsx+uhYv/nBs51FRYM9eUXHGKIPCg34
         QUuxLZ/0a9PAGrxqY/fZDOftRLYXM7GVBzGZggq0A8JOgCj/fd+f9AfmPLpeOE/UTrWw
         hG8xK/lpo5oXn0edVwdnxzIO7xmQ2t9TTUYlEwYlEM9gcr19iVEoU0dKGDVLt+chTwft
         PT5K+/5ZsToq4+QBzK4Zxx7pjn8p90upB1W2XH3ZM+k8WigXbZlzL4ew+kOV/LenFf6f
         dbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764293614; x=1764898414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OCmoVsJTYhvhdEhqnCuQdxLwDfWSRN4iQRhiwDtzkSM=;
        b=Q3B/3E6PTvQrqU7VXzgPjOxFgbmehM9xZQRV3MlJ9d4k10WDqoCaJTyKVfa8raauqE
         80K63wJhTKB5hmQLeDE3gFHJbmthBcnYvCPt908cvebyK3jHArseq7EQ+PSHy/tvqsER
         rhTsn10lLjyepMEBSVD02jkmFRz7RlOA86/LhwHuHmomO6Cc7Qhfl3vS02UklPe6flJe
         cIcM7nezT/l1QA5KIIMvl8PQ101gMmEBLuYBYncMMPT1M61N9U2wLzbtlgWgyVmpiJ5b
         rfmtJhFlAwxgMhosFrTd6N/3KEP583kFpGMSDpie+UXFw+rXFqZ1aSGkM+uKKpsUH9JH
         gxFA==
X-Forwarded-Encrypted: i=1; AJvYcCVrvPXBmvQe1FIkHS5sPifzdK2RSxtDgcVrmMBc3fJykxXJkSaNLQtGXqGvQQTOcqvw7qTD0haPcHcDrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ueymNFpmVTd2fhfr6KA0KxowUO+7kK8pMzomuKmP+Ni0JpaK
	2tNgAVX0irjDuAHMtKdToNqg3ONN0ZUtnPXI9W7V6kfUfAIoe+313nSJl4E9kXsh+xBcAZJTP6M
	0N/+jMR0/jnoHrx7HSP4z+erjYwXhZzIZEFPQ+j4=
X-Gm-Gg: ASbGncvmzqB3aGkaYd3P5brm2XlA7d8+gIVrX3u3Xt8mk7V/ses9s4LU6a0Oouewq0T
	4LDUfRBpfZWQkh+R1yFDI63LBpnHN1Z6m/y4bbYuaFwjikLR5XKgR/iWOD6SZ2vaCtiB85VtnYX
	ZvPvQMOA+V+m3OIi9iw+1UzBKyiESCXKMDK7GGDWo5puOP50HG53RMY/K9FgJYgAUzROD8jm5Hh
	GoAiVFuCJlMOygzx5brLz9WIqQWnasal6LFv6U3IbaGZOkj2zCwqae2KRz4JioWxskVhxc=
X-Google-Smtp-Source: AGHT+IE6nrHo52NkC3u4arv+NV93c/YfHBRAs+svXfCqzbJAogT20JAMk+GOCyu5yn5XMiOUt3k5WhNEc+/7Yy6kmls=
X-Received: by 2002:a05:622a:1a13:b0:4ec:ef6e:585 with SMTP id
 d75a77b69052e-4ee5894f748mr348305511cf.73.1764293614202; Thu, 27 Nov 2025
 17:33:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSBA4xc9WgxkVIUh@infradead.org> <CANubcdVjXbKc88G6gzHAoJCwwxxHUYTzexqH+GaWAhEVrwr6Dg@mail.gmail.com>
 <aSP5svsQfFe8x8Fb@infradead.org> <CANubcdVgeov2fhcgDLwOmqW1BNDmD392havRRQ7Jz5P26+8HrQ@mail.gmail.com>
 <aSf6T6z6f2YqQRPH@infradead.org> <3a29b0d8-f13d-4566-8643-18580a859af7@linux.alibaba.com>
 <aShkWxt9Yfa7YiSe@infradead.org>
In-Reply-To: <aShkWxt9Yfa7YiSe@infradead.org>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 28 Nov 2025 09:32:58 +0800
X-Gm-Features: AWmQ_bnqkcJ2TfUO_Hy5DulnmQrOor9Eq1r7gxzBzqTjOKvbRCKHxxHaYPQTzc0
Message-ID: <CANubcdWh0zZpOqhBhWtKf0uN1+8Ec-RsHiSCQUFrqYXoux2-TA@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Christoph Hellwig <hch@infradead.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B411=E6=9C=8827=
=E6=97=A5=E5=91=A8=E5=9B=9B 22:46=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 27, 2025 at 03:40:20PM +0800, Gao Xiang wrote:
> > For erofs, let me fix this directly to use bio_endio() instead
> > and go through the erofs (although it doesn't matter in practice
> > since no chain i/os for erofs and bio interfaces are unique and
> > friendly to operate bvecs for both block or non-block I/Os
> > compared to awkward bvec interfaces) and I will Cc you, Ming
> > and Stephen then.
>
> Thanks.  I'll ping Coly for bcache.
>

I would like the opportunity to fix this issue in bcache. From my analysis,=
 it
seems the solution may be as straightforward as replacing the ->bi_end_io
assignment with a call to bio_endio().

Thanks,
shida
