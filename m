Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098C11C8600
	for <linux-block@vger.kernel.org>; Wed, 26 Mar 2025 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743030503; cv=none; b=KHDVYP6zUq0AAfSGVuVcvxj3YSi9a6EFeAa/dcXMEVkcxKKTfKuKKke31aWjhBYGNYAyXcFU9ZTp+IOAc1rUv7FkH6PPjnYlyWdoRjzz3J3a8XJYcYYXsNsVkOBCn7LJF4Ncq00z54YpT/e2BfUPdaBWMVKWfYbDMTm0lHtpWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743030503; c=relaxed/simple;
	bh=UIucPY8Hw6s1pIjj0T40L+yyxKLaVSlySiCPpLn2cd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZaxbWpH3cB1/KATEK+TP/O9bIcHmt2UJdX3GlSWDzF9VFHbHXorJ4oCSFy1hsonbPFCiu3xUZjLIXjqY8p6a0W9NiRW1PjfzZgjnd1XKM/NaV08TRjpUh/V+AQWpxZ/9r1AsjFoNip51s2KoB0YeOs3ldFDIC4t5/ziXPzfHA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=S+CytnhC; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="S+CytnhC"
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-2b3680e548aso807943fac.0
        for <linux-block@vger.kernel.org>; Wed, 26 Mar 2025 16:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743030501; x=1743635301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8rVT5gyP0OGTon/Wq3WnQYduId/TZ40NupCn3Es6UaA=;
        b=S+CytnhCujIqDOAGDu6jJWVwbefFUYR5QQE+QDd86pIuWCDioun9cgd9ZiHBxLEvmK
         9QG3drlbcLV6Ce94OMqta6qurINg8+hLrlu+E9+j9Kysi07LevrA3aUwVRPbL5jc8/Jp
         qPDoPa+bC9dwblkw/thRI11KCLH84Jvw7SdOrdvsRo88uD7w003kqNNHFvMEZoiDzImu
         YFD3LZJTrIDJcfBPq8sIFf9vAwRmSbDnzCcVNOVceBnNxny1JWpJZr1J2JaeNRjxw/3f
         jU7SH/Kd2nR8bbPSUwl0cuvZVjIQ8XyDosUPYl2/fDPOO4VOaJEondV5GCn/1ZS3zapb
         9Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743030501; x=1743635301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rVT5gyP0OGTon/Wq3WnQYduId/TZ40NupCn3Es6UaA=;
        b=FvC+gRUGMiMmA+g/HYxm1mGGEbNE+lovgft4xA6fJixzzRWIC1GVzzSS5cXOljJ9eE
         yrs6Q68lF1Q7QkTe680kHgOfjoA2IzSWoOLzh5B/lcF+KrfI+53pQzCvdlmnSSCFjcKz
         Rme5Yi5eh3JmI49BfSm/rUSiiJYnQkvf77tAXdACVKN0S0pq+SDDXqVAa0clgR7vQBtq
         4+pWsiPhnurUSAvd0BwQa3ZeAVIK4uEFJRIp/DlnD+ZeInQmZKeXnXIm0a7jt461zyR2
         2jc7NVxy7GefUFtV33KuhrbycN4iUwC2UDKB9OViZebzao9ELH0S6B73Hpp7tOBremRp
         g/0g==
X-Forwarded-Encrypted: i=1; AJvYcCVI5xZpBLiH26dLsx3cHc1jBEYgKuKv8tIbF9xsRyBBt1Dr2X3xeYJD+2tPfTSZMA8Lm0IvhX9KU2FOXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+9/f+bLZdmVQjlIX4IJbibpamqxO+j+tLm5xCiHBwvET1XfHV
	tNt+qcM5Enrl0cXKA7l04pan49OY0uQqPQJMaDnz3msDmJRH9NcTVk86GV5JT7HcE7EJY4iLGuT
	cAcndFNkeLCpHFWeuKAK5d2LtNs8UMtRo
X-Gm-Gg: ASbGncveySRnXEPmuIuQ5nFswyM2mh4wVybUMhqDnBBe6ruf5df2xnJeH9HvFVFLGW4
	uGyk8CuZgvvww0Yj0J3eaKaoKPvaBQHBOCcOp4NvJvedthVsnfCVWXcpWDANb7/MEoYP7NkOKS/
	1DXDyIlMNa2LNoWHedfPJLdJhALHmQFT/3zqOzJkU69K8lcCehHkMFnt792iMlpOkFqz1Gzlz2i
	UUoOUGRgNHLT480xYIGZ/48nlOcJYNN31gldb4TuAH2+g8YmluKbeO1XdYI2qmgBcAgf1nG4Je4
	5Vyyx7ZVTh2/l5/qi234xSO0XzHMLk0UYzq0I21zZKd9pPl3Aw==
X-Google-Smtp-Source: AGHT+IEPeX5QO7+np0lHt1JqQH6URXpDSCirYyHJkWTJBvVF0t+eQSx2Y6evgmmZSMAjZEj8DhgivwD6H6cm
X-Received: by 2002:a05:6870:2a45:b0:2c1:d516:66c1 with SMTP id 586e51a60fabf-2c826ccb975mr3678918fac.12.1743030500879;
        Wed, 26 Mar 2025 16:08:20 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2c77f0ab523sm496151fac.37.2025.03.26.16.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 16:08:20 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 25C4C340199;
	Wed, 26 Mar 2025 17:08:19 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 153F7E40310; Wed, 26 Mar 2025 17:08:19 -0600 (MDT)
Date: Wed, 26 Mar 2025 17:08:19 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ublk: improve handling of saturated queues when ublk
 server exits
Message-ID: <Z+SI4x+0J52rCJpN@dev-ushankar.dev.purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-4-262f0121a7bd@purestorage.com>
 <Z-OS2_J7o0NKHWmj@fedora>
 <Z+Q/SNmX+DpVQ5ir@dev-ushankar.dev.purestorage.com>
 <Z+RN+CPnWO69aJD5@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+RN+CPnWO69aJD5@dev-ushankar.dev.purestorage.com>

On Wed, Mar 26, 2025 at 12:56:56PM -0600, Uday Shankar wrote:
> On Wed, Mar 26, 2025 at 11:54:16AM -0600, Uday Shankar wrote:
> > > ublk_abort_requests() should be called only in case of queue dying,
> > > since ublk server may open & close the char device multiple times.
> > 
> > Sure that is technically possible, however is any real ublk server doing
> > this? Seems like a strange thing to do, and seems reasonable for the
> > driver to transition the device to the nosrv state (dead or recovery,
> > depending on flags) when the char device is closed, since in this case,
> > no one can be handling I/O anymore.
> 
> I see ublksrv itself is doing this :(
> 
> /* Wait until ublk device is setup by udev */
> static void ublksrv_check_dev(const struct ublksrv_ctrl_dev_info *info)
> {
> 	unsigned int max_time = 1000000, wait = 0;
> 	char buf[64];
> 
> 	snprintf(buf, 64, "%s%d", "/dev/ublkc", info->dev_id);
> 
> 	while (wait < max_time) {
> 		int fd = open(buf, O_RDWR);
> 
> 		if (fd > 0) {
> 			close(fd);
> 			break;
> 		}
> 
> 		usleep(100000);
> 		wait += 100000;
> 	}
> }
> 
> This seems related to some failures in ublksrv tests

Actually this is the only issue I'm seeing - after patching this up in
ublksrv, make T=generic test appears to pass - I don't see any logs
indicating failures, and no kernel panics.

So the question is, does this patch break existing ublk servers? It does
break ublksrv as shown above, but I think one could argue that the above
code is just testing for file existence, and it's a bit weird to do that
by opening and closing the file (especially given that it's a device
special file). It can be patched to just use access or something
instead.

