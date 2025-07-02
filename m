Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348EE25D214
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751454823; cv=none; b=Qa6nmfP/Bwx6ABxObR01rd2fI1liiGaxzkaGwjiTzvtbB/kKG+YNHIf5/7qT/feahJOMaEi5A9uXUDCFcaO4Gm2yr7zpCMd9MDRi6AooQrfMz40Zpf4zv2jnqRXC2mBR8/FRazOU3Dl373KkHH/luLDp/t4F9bAbEaVXpGXv67c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751454823; c=relaxed/simple;
	bh=ECQIgKQgmLkAZS4N9Ti4FHy94Ri32AkLWlYW2nfxpHw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bTWJSSdOZZykcQh6imRmeuEs9dtukssibiz4E2L+nT/+R/B4qWOF4cdSBngY6lgULqD+6sMr9Iuz9UUaE6AhxlPJgPdZmSbE7eSGDB87ABiWmeaXsavh4JDvUTwh4+8+h68VhbHJUcCDTaOuUzfz5ivPtPjgwax5YqX0x/AkSW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dd1rkXpV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dd1rkXpV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751454821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=MZkZRlr25YbPqB2HwXUZRwm4fw7iqNH9MdAMyL+S4cg=;
	b=dd1rkXpVtwbnlQr+iEoUh3a5vEkZnMDQzdrOuwkl1aHRrUox8uKT9dGT4ZXzjViiIB2IyF
	zKbu8qQ6T4LqyMXEDYZ/TPbwb8jxFHXfN+UDo1is+I7MZwdYFS+Tb0uJTAmeAy8eZVTA2r
	oQs0E2DKEkLizf8SsSC+t9RMTlHZSxc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-dj-UEGktNMeRy6rDSzMHKg-1; Wed, 02 Jul 2025 07:13:40 -0400
X-MC-Unique: dj-UEGktNMeRy6rDSzMHKg-1
X-Mimecast-MFC-AGG-ID: dj-UEGktNMeRy6rDSzMHKg_1751454818
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5550e237ad0so2370924e87.0
        for <linux-block@vger.kernel.org>; Wed, 02 Jul 2025 04:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751454817; x=1752059617;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZkZRlr25YbPqB2HwXUZRwm4fw7iqNH9MdAMyL+S4cg=;
        b=NlJoHeS+38QWUd9eTafak1xg4VcT25AtbP75MIdSEHThv2tXpCeu4qZsyPpx3/EcUb
         UBx7VNx4HCIsSXOVndQTN7aT9OMhFkTbPnKlQkqD2jbOG2WWh5g+HxDrL+8mDWtIoiAB
         mlL7PBw3Dfe+ojvOfrsxdgeHzDcJ/r66sGQRpu+zShgj6fkAbcYio6uhmFCplcNCP0t1
         67dNDcGA50qD8AfYRNpfnQQ788X+K5A6gLs5TUhk6ejFO4m1ZAWAQCtqGPTgUh32SILb
         JHMrWsP0CKlUYMF/dNCpWuPOAaL4J6JyVayr8aFcSXqnwm8KfRhpZ6BdpvqDluakt3iJ
         AkgA==
X-Gm-Message-State: AOJu0YxOpBe3a/BmJQezV6I0gnLJAO+98VnczBpM5ZxbKqa2EFEPq+rn
	TScdx5/E1Niem0J/0NP3LFlRDI/elDm0+eudkq4UhqA5FOBT+FM97qu8m+TV09Ym2y2MTxyNgUf
	cRRPVlIkZcdeAn+LdA3NCzDq1QeOSRejgYQC+81r601klJr9gAk1bI5rLdMX9/ot3MKP8QZq5zz
	nm6sHvUsE1fbEpDIGaGXqXZ0zW2KMvDLKqy6tvOvigPBBY14xIxDlj
X-Gm-Gg: ASbGncumgTcwPB2Je6BtaoziRrejzeixKqxeI5Y6SqqCE8pksRjH5XcnZb8hznx1GUx
	yM71UpGCLVZXrdyAfeff9PLKpc2XBm1n0c/GHLqe01WSyJy4Hmp+WnFAZB3X0er/eKtz5uNRyGn
	Ekufop
X-Received: by 2002:a2e:300b:0:b0:329:39cd:8d25 with SMTP id 38308e7fff4ca-32e0009b9cemr7172021fa.33.1751454816758;
        Wed, 02 Jul 2025 04:13:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGLgCNulf2JBPoF6IitYZrvd3Dqb+lhUMrHqbfYNPMJuW71OuJ6YxnkSlKEdWOuwrXbgMPj8GOIkJ+9uW0u9Y=
X-Received: by 2002:a2e:300b:0:b0:329:39cd:8d25 with SMTP id
 38308e7fff4ca-32e0009b9cemr7171881fa.33.1751454816291; Wed, 02 Jul 2025
 04:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 2 Jul 2025 19:13:24 +0800
X-Gm-Features: Ac12FXzxl_rJVCxsjww60zBQtZjiqEECF25ia06iPv4bvMa4hbQaNxYHeS7V0Bk
Message-ID: <CAHj4cs_Ckhz4sL5k5ug_Dc5XfjSo9QDRSrHMfBj2XYGm_gb2+g@mail.gmail.com>
Subject: [bug report] nvme4: inconsistent AWUPF, controller not added (0/7).
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Hi Christoph

I found this failure on one Samsung NVMe disk[1] with the latest
linux-block/for-next. Here is the reproducer and dmesg log.
Please help check it and let me know if you need any info/test. Thanks.

[1]
SAMSUNG MZQL2960HCJR-00A07 (PM9A3)
[2]
+ nvme format -l1 -f /dev/nvme4n1
Success formatting namespace:1
+ nvme reset /dev/nvme4
Reset: Network dropped connection on reset

dmesg:
[  751.872864] nvme nvme4: rescanning namespaces.
[  752.177475] nvme nvme4: resetting controller
[  752.221030] nvme nvme4: inconsistent AWUPF, controller not added (0/7).
[  752.227653] nvme nvme4: Disabling device after reset failure: -22

-- 
Best Regards,
  Yi Zhang

