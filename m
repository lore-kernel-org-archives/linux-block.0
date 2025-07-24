Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D72226D03
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340828; cv=none; b=fGmU+9JYbKBmSUscUyc+8Zi2YdeD3Z+MdgOJao47GsFJHYngbu58/NIYF/lJQg+LzhL7jRCUU+4Grm4L9V6Ny0cC2cYfqXZ5yYUHZXH+TQpK9pmdBMOzt70+cE23W0bCtO+D9XWQlgWkUtIORotBS7Wul4+NMwDxrZsHMp1yQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340828; c=relaxed/simple;
	bh=iWK+A0yndAcCi87CdgUDVZ42kgSv/Ah+s40XKuWQn+I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FI1DXN0eJ2QkYLqCqNukh7Totrqs91gyRAuAO8eOpkL/b5ffBi9A++phqZ+i0Yh3a5FMVzPd925yElogilGoVVK2f+PfLzqnP2Nk1pk4Abz8sLCdeFhS4mjzXxkxXEFuYvwFQ9kH4Ivo6m3jVn0rEXcs1QSVE959wtd9FhTCbjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaqeahZn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaqeahZn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753340825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qhRjed6D5yywdnqVu+M//WAdRaN5hUsBxAof5Q7IU8o=;
	b=GaqeahZntEkYuYhejO9EpuEgrrm40cJgcpXJXgcnuB1JRkpBOglOJ3d9ovKSS5zLMwts2Z
	XWi13TDm3ySSfFsx+nVovsNac0THC9xBEe71IXTgSemq0e9NgI18TMkaCHrLZe7ZvR5Q73
	eApZZORignecdZ+QFfjprs2iAsx5sCY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-ikFwrm3MMCOHqXzDM-ba9g-1; Thu, 24 Jul 2025 03:07:04 -0400
X-MC-Unique: ikFwrm3MMCOHqXzDM-ba9g-1
X-Mimecast-MFC-AGG-ID: ikFwrm3MMCOHqXzDM-ba9g_1753340823
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3122368d82bso1150462a91.0
        for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 00:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753340823; x=1753945623;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhRjed6D5yywdnqVu+M//WAdRaN5hUsBxAof5Q7IU8o=;
        b=qR8U/Rh3mG3PjyttKR1QZMAAcTpRx175XwESpSQQDFv5qWI3cY5jAyV9xnR0n2D4e/
         c6ZrmXMX8dUFMdDCuELnIOGlJ0kYsAZJwMuf1TIqZNOFnRmDIjXeZVJj10p+sbrtmyOq
         BZv8eAnNlgTc03xz95qKvHc3wUMmI+BvQ99a/x7FR27OFLizRMORpLuBl7F8RoQCGps5
         unaJZvp0MLlljNThmSqccGBpxiMdcgU/aFeBSd+1U8DoxTiCvaZekCvGfV9KON/sHCyR
         HhBklFqpw4SPLZKnNT/7te9So8ywQxyn1+HlfRQPD4HWT7U2qrCosm1IKFOJJclufw+D
         QtpA==
X-Gm-Message-State: AOJu0YxZTsWIx5H0IhN+ZTvnIjhFqIO/3AZtvOOD2UdwmjqcaFUTUfNd
	zU0fZGhXhJjZFjSMZPYbIq5larsyBJbDLUxh6BklXLi9qPAMhotQPKcFxjy7B/FLNSFLJJDGgy7
	D+HlxbSQZdfjhguDQlqxFQRpIx+hR4z0Q4gPij3zDPto0bjMTuL7DwjVmJpMSp/KO21kt9cWQ7S
	bILY/wH1RGIeIhkiGi4Vl2EJQJmZH0pRQjF8oT7RkOQBiEGpS4JA==
X-Gm-Gg: ASbGncsatUPgVP9u03fwMt1iUp6J4nfIedqZbvD7yYQbPdQBMVbKCavyYZlP2Dnyj/w
	5+tCH50o73s/jIkHNk2Y0AwVHUBBCk4VLbaK5EN9Xb8UPm3nESq2RKgGCAUJXvSQEzki1sCdzVd
	r6ZI5Z9wcsF24+9oVWYtgm+Q==
X-Received: by 2002:a17:90b:1dcd:b0:311:baa0:89ce with SMTP id 98e67ed59e1d1-31e506fcaefmr8748873a91.12.1753340822879;
        Thu, 24 Jul 2025 00:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsmkCwqD0jVfuCRMThIvqqKSimGvVlrkXKRaXUXNS9QyAlhTLIiGKNTHsEEsFUUaFB6NjrzlgDmrfEKKEzRAM=
X-Received: by 2002:a17:90b:1dcd:b0:311:baa0:89ce with SMTP id
 98e67ed59e1d1-31e506fcaefmr8748850a91.12.1753340822497; Thu, 24 Jul 2025
 00:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Changhui Zhong <czhong@redhat.com>
Date: Thu, 24 Jul 2025 15:06:50 +0800
X-Gm-Features: Ac12FXxqPnaU8Nv7QqwLfAJm5zSb3CC_n2SYuAR3EBnwy9SGK6fyqb9qTVvZz-E
Message-ID: <CAGVVp+X8GYS7yKkq-qxJ5hpTL=vHMBgG=wuSsNJZ0VrjQeMA6w@mail.gmail.com>
Subject: [bug report] mdadm: Unable to initialize sysfs
To: Linux Block Devices <linux-block@vger.kernel.org>, linux-raid@vger.kernel.org
Cc: Xiao Ni <xni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

mdadm fails to initialize the sysfs interface while attempting to
assemble a RAID array,
please help check and let me know if you need any info/test, thanks.

repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
branch: for-next
INFO: HEAD of cloned kernel
commit a8fa1731867273dd09125fd23cc1df4c33a7dcc3
Merge: b41d70c8f7bf 5ec9d26b78c4
Author: Jens Axboe <axboe@kernel.dk>
Date:   Tue Jul 22 19:10:37 2025 -0600

    Merge branch 'for-6.17/block' into for-next

reproducer:
# mdadm -CR /dev/md0 -l 1 -n 2 /dev/sdb /dev/sdc -e 1.0
mdadm: array /dev/md0 started.
# mdadm -S /dev/md0
mdadm: stopped /dev/md0
# mdadm -A /dev/md0 /dev/sdb /dev/sdc
mdadm: Unable to initialize sysfs
# rpm -qa | grep mdadm
mdadm-4.4-2.el10.x86_64

and not hit this issue with upstream kernel
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git


Best Regards,
Changhui

