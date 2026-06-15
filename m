Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756F353EC0
	for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528840; cv=none; b=GlgmDVIIipdRV+i0DxCwkCRVJQd97idXUxTBjTCo7JQ21hvR7Y5XU9BgjWvOu+oCpugNWMxhEmwwYeye6QeS+n3Rmdxo7k6aq9BVIBPCA8WVrQmMyOCXMwlP7cRVQTN75jbDSE80t45o+fiZPUq7AZY3YR698DCV6owJa5TMgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528840; c=relaxed/simple;
	bh=LwM6R1rbq7AdAL/BPAXh1rvftskyM6UJW23qH3xDUOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=krB7ZNiW0jvES7Lr4FR3pfW1E8pNFrOG3ULoSz64jbyqlJtnqQoLXXkqCte9PRAmHrzbl6nkMQIeBrAzKXqePthLA/jVLeNzwIOKutJlVVEb5MKRg1V7CTEffBTYEFr6MNgIru6w4GNo6QZAL2e3b4WENowu/65uB6GFFcyVTBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ccuy+R9q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oiTgC+yV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ccuy+R9q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oiTgC+yV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781528838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rro0lRZrX1p8ERhwndG34Xc1qvU6VJ/ms4ahQKnw6io=;
	b=Ccuy+R9qvX1kQqT4d8CNmSNEPet2awxzG8rF9aTDLHzD+bG0FlmpDpqIqM3BDFVsaTsA2c
	b+ra4mqCzWm9AJFYfgPuNywl9e7qE+JiUn5nYBSsgUAHOHWyb1GPEz1rySnogtVd+L6n60
	+l6EqNuR4XOzx8S5TsDEaHZtkq4GIjM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-W2fm0a5VMlmjMhW5RP9dMw-1; Mon, 15 Jun 2026 09:07:17 -0400
X-MC-Unique: W2fm0a5VMlmjMhW5RP9dMw-1
X-Mimecast-MFC-AGG-ID: W2fm0a5VMlmjMhW5RP9dMw_1781528836
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490cc1ae292so19507565e9.1
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781528836; x=1782133636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rro0lRZrX1p8ERhwndG34Xc1qvU6VJ/ms4ahQKnw6io=;
        b=oiTgC+yVRUY8QNtTaloWf7oPra2lqqXvX6QjvCqhD662tyIQa8HFkhacltmN/tBUhR
         YOiVY+g/DOPY32T4BrD4UA5NUvYpPRJ2X2ERlOBhDLMAv9nL+Wv9jqcDiNsqpKLDt/K9
         WaX39DtJ04ViEqXgXnlipuajGP95itRsSwyuosYd6jOvGvs4vJuj/PFR0PKXKk9NsSsj
         Ny9GQ6RtqayQYpSE1+YLbShV1yDDY4SJxIm/RQSBXhZs0t/XXtSH0Q7kkpMzFTv3DfST
         xJaqgjaX9acNcI8sTaoP38hL7/C5vUIKsZtMSWfOraiLtxNI04I3/+0NUIsM7JiZgyhG
         fx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781528836; x=1782133636;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rro0lRZrX1p8ERhwndG34Xc1qvU6VJ/ms4ahQKnw6io=;
        b=tYkz+Hkme4bgX4PSV4ZlkpEG4tn048jVWVuXy+TOpAy1Xl/Vp9oPG4roP6RZzxcQAK
         L6Akqh0EpZke1LYsq8O6ZutMo67v3lyrpWT2ajg0mTG8VKMG8TpBmRam7iyr5f+FDf/j
         WvkvDp5nxxTUppx2Ksv+emNOAbOg89JMe8ne7O/d+OpZUuXfeCrlqwTmo91vHhtXeVBR
         8jpS8sfwGblezEBmTb20Zlty+93zm1EL/mgkh8kYZkr62fshbwhsmEiv4iCshalaXUMq
         HorxcfA7J/YIr1ghdsQYtQBFCIw9eJSo3JJpJ9Sjp066e2TQp0dg4e6BE1wD3dXHC6Ij
         ArWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+c5FZ5maMkQFIBO2kPFSzvYUrQ5CZRYZH0yFh4hUIdpSW0ti3k6UoPIrl9su1ca8nZ55feIgw24R1ZDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7g2LsuXR1e03p+KCz+IpThSTkXcUxL+rpOfUt6rpwchGLLTJZ
	OKVPWR4dijxL5kkq+UZB6bA9Og4FlAbgKLVKUHhoLk21lfyHuDNb0712d83vq/z/tmV1m3TxKfU
	IT+kLAVBzRZSxUZ7yV3LfgFtyhjRWBBdUDembZ0clRIvlzE3am5gwz+lUagNNoVIN4Ll0Sp7/
X-Gm-Gg: Acq92OHuAwtZlnQbTaXhaAflThCswo2/56Lr3Zk2bdsDap5Gm3qiF12AeC7qX3oIj0P
	AVW94GQvwZOe+p2MucLOeuI3OdRbViNwALi0H1UIx1jQQ0ZzbS+aBvijsX7ACIEY7KCFERpvB9P
	T62WwEBYc1Nyw906Yd1LbXk3+1HTlEroXls1Ze7wGWxnPzFx2CkfYuVTnNbEV81ls1WYWJf9DHa
	6VjQjAQ4dgyPPFiNvkLhenqpJbhb6FpeThIhKqEK53EOTAGh8IAOxlXuaWegMtJkQRuLNvAL7n6
	/mR7yJ8zvZsKXqMUxjD0JMMCXKGsstY4piiC298TgnMlEqvDVxoArghfIgFow103pRq+Sua9OwH
	y23KBx5VqKSu4
X-Received: by 2002:a05:600c:c171:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-490ec4dfb03mr142701315e9.14.1781528836101;
        Mon, 15 Jun 2026 06:07:16 -0700 (PDT)
X-Received: by 2002:a05:600c:c171:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-490ec4dfb03mr142700705e9.14.1781528835510;
        Mon, 15 Jun 2026 06:07:15 -0700 (PDT)
Received: from [10.43.17.48] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea4a128csm342321565e9.0.2026.06.15.06.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 06:07:14 -0700 (PDT)
Message-ID: <31e178fc-ed41-45d9-9e85-2d114f4222a4@redhat.com>
Date: Mon, 15 Jun 2026 15:07:14 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Repeatable, raid1+O_DIRECT, hang/warn
To: "Dr. David Alan Gilbert" <linux@treblig.org>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev
References: <ai7rnH20IYeSmY8s@gallifrey>
Content-Language: en-US, cs
From: Zdenek Kabelac <zkabelac@redhat.com>
Organization: RedHat
In-Reply-To: <ai7rnH20IYeSmY8s@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dne 14. 06. 26 v 19:57 Dr. David Alan Gilbert napsal(a):
> Hi,
>    I've got a repeatable raid hang/warn and would appreciate some pointers
> as where to debug.
>    (I've been logging stuff on  https://bugzilla.kernel.org/show_bug.cgi?id=221535 )
> 
>    This started off as debugging a case where I'd get my RAID1 (on the host)
> getting a reliable 'rescheduling sector'/disk failure while running the qemu block test suite
> during a qemu build, but then I tried to build a smaller discrete
> test, and now I've got a simply triggerable warn and test hang.
> There's no errors from the underlying SATA layer on the storage,
> everything resyncs just fine.
> 
> I've got an existing LVM vg ('main') with two mirrors on sda2, and sdb2
> which are SATA disks.
> 
> # lvcreate --type mirror --mirrors 1 -L 1G main /dev/sda2 /dev/sdb2
>

Hi

It's probably worth to say here - the '--type mirror' is the OLD (historical) 
DM mirror target implementation - this target is now in the not so active 
development as users are supposed to be using newer (and faster) md wrapped 
'--type raid1'

So if you use   'lvcreate -m1 ....'   you get 'auto-magically' this mirroring 
target.

But this obviously doesn't fix the problem if old mirror target...

Regards

Zdenek

