Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659763;
	b=Dnvoss0Yz/fv8FuQfGmcUau2eTYUmq+ODA6d7zQYnZphSBqKBx7ledN0DZTB30MdYrDy
	 q5eUemfw9GHqzHIkJBuHKVnvB9DR+pjVI0y+5rouKMB0Luv8G+nqofB8k9zeezcM3uMtd
	 75/+RU2jrQSrtvZthUl01ycXteCAhk9/HXHvhwWy+yV9VSnWQKeKlM5pIfvCXbuxu0UAy
	 aEMSw+qcL9ga9ljt+Lr3njGWsVNIkItHJ5sMmZqX1ov4EF6B+NwBNz347GlQxaj31er/3
	 pCZFdrcZDZ6yW1ZTidkmp60RImPLcqeaGXtwJ+sj5dy++ELbt0IRAGuQ4scv/Kd6jlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=gv/UHwOdoiY/ZWyR5F2VXi+8ZZs+7w0rAAbjggkJLZk=;
	b=BqJOLMVkdscfD77l2+5BI0ZI0eEBigIdRRyofrSVJ7i2hCLL7XfJoYNWBx8C2QsQ8CjZ
	 GMTw4nusjzYmgfjntkK+IfcZPD4hNebXjGmSzQMm89CUATtJBdpOGrjJ2prcAPmZe6NNq
	 J0HX/0hVqebexbOUHhtPwY3vUSabaingzkLGHGeMQDNTpBn38R37PQSqGB1iErvj0CY4I
	 DgHtv47Vxa7v7Ihs8sG+gzBx+F9KnA2mOHuI0WIUNu5aqHYKAMBLEUYBxj/ANCjLxv62L
	 pU1aF3mj5eG+zE/csHac0IgnSxOYxHS+yRJnTonqyjm7Ma8/J8+Tten2dWf1kiBxqKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Zf0x+Ads;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB82606A324;
	Mon,  2 Nov 2026 22:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DB82606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Zf0x+Ads
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jJRhy524Vz1XLktp;
	Mon,  2 Nov 2026 22:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1793659760; x=1796251761; bh=gv/UHwOdoiY/ZWyR5F2VXi+8
	ZZs+7w0rAAbjggkJLZk=; b=Zf0x+AdsvNI9qG5/IPIIO1x7k3FlKtFMz8QYn4ru
	pkF1CsWjxF6MbcHOUnErVR1m/jDT33Kp4+Ih61bmFh7vrL4TuHXaCcz6kBtZ9+u8
	ry8qUJ7B061jhg2GPCdYpdHVcD0CRqRpBUB5ap6sltRLwRTrrcLfcHUmFzTYjBTD
	jPTyuMRznADa0BZsAPwF3SAL7dTM3pnETNUEtJ8VsKdioe/LC7eVh2A115npQF1U
	P+k0GpsW1YKHM1RxIG/48Tqw8oEvQvXX8O1emtDpStbLd2LBAkMWfuvrC8GDsC0t
	0Q++dib3EiOpijnxj8CF2mNvM9byYEDkin9BomeTPBWpBg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zrVDU7ktNVGh; Mon,  2 Nov 2026 22:49:20 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jJRhw2mdLz1XLkt9;
	Mon,  2 Nov 2026 22:49:20 +0000 (UTC)
Message-ID: <6682f05e-3568-4414-bbae-44d148f0b979@acm.org>
Date: Mon, 2 Nov 2026 14:49:19 -0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: prohibit the use of sysfs as a backing file
To: Edward Adam Davis <eadavis@sina.com>,
 syzbot+a31cda410a4ccd419712@syzkaller.appspotmail.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6ae807da.c8ffc79a.e3697.002b.GAE@google.com>
 <20261102103354.427722-1-eadavis@sina.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261102103354.427722-1-eadavis@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 2:33 AM, Edward Adam Davis wrote:
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a3325ceab484..71647793a717 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -534,6 +534,9 @@ static int loop_check_backing_file(struct file *file)
>   	if ((file->f_mode & FMODE_WRITE) && !file->f_op->write_iter)
>   		return -EINVAL;
>   
> +	if (file_inode(file)->i_sb->s_magic == SYSFS_MAGIC)
> +		return -EINVAL;

Recently Christoph Hellwig asked not to make this type of changes. From
https://lore.kernel.org/all/20260601071058.GA7468@lst.de/: "NAK. If
people want to do these stupid things we should allow it. Hardcoding
random superblock magics in random drivers is never a good idea."

The minimal reproducer for the syzbot report is as follows:

mkdirat(AT_FDCWD, "./sys", 0777);
mount(NULL, "./sys", "sysfs", 0, NULL);
r0 = open("/dev/loop0", O_RDWR);
r1 = openat(AT_FDCWD, "./sys/block/loop0/queue/scheduler", O_CREAT | 
O_RDWR, 0777);
ioctl(r0, LOOP_SET_FD, r1);
write(r0, "\x00" /* x 4096 */, 4096);
/* process exit closes r0 */

A possible fix for this syzbot bug report is to extend
loop_validate_file() such that it also refuses to bind loop devices
to sysfs attributes associated to the loop block device.

Bart.
