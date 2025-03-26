Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8C19CD19
	for <linux-block@vger.kernel.org>; Wed, 26 Mar 2025 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743015420; cv=none; b=mRA8RHdNErc5qO3DjkzjoV6O38QEVWnihwwh5159q3Ikn73OJMjTXve8YUv5TBePSkQoOal/qG1AkClRHaYHt9zbJaYX72aPFAqsDt66VeEugQJblD1ecP92tK+dx21sY+R0zbfLWZnIYvzN9d+T4jkkde+IAGGAdhMAU3FaHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743015420; c=relaxed/simple;
	bh=jGpiZ3lPuBCyjBbQjqjfHfoJjy55SOzqxjPMosf7Ot8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEVfqFNFmSrnfGj/k+DStnsPPzQZKL5+dzoRNBUuAFOJEwsPdgxuLwX8emBuWdxx6YIMMpPSHcabxpLrsyihW/ECIDBHULoYY2n9PusEEPPlYBqOithja4+AU1ql1koLy2GmUfiBHLh0o+90oC3dMqg1npfImS7Oyqs9rj6nHgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eLoz/+G3; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eLoz/+G3"
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-85da5a3667bso8089739f.1
        for <linux-block@vger.kernel.org>; Wed, 26 Mar 2025 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743015417; x=1743620217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nMSYNUtEXougJlHExQh8eBet5bvIJeI5uFDV0DD+oQ0=;
        b=eLoz/+G3BzzyNWtS6MMGQA9TZmjUWCr6TwBsq93oAoRAht4ZR9c1HzLyc0HyRtkfVG
         X8UYuaPODWt51YCJpAqb8W9p1jp0/v9wob52JL3qcnP9rQEua0asIpKPuyLwHPorzp/7
         Xsas89nirOm1+2L8cgDwX2oowCUW9kL4jB8ajkSjH/shOgFxGsAZdJ1mHMooe0xDMEOh
         Dnp8vMNPNZ0ZmGrTngsz/wOOi2yGbeBNKicRQeT+HMfl/uBz6Ao4b2QGCQ+cmVkAJqFR
         OnWNuSxfgoaIdZOy+vbi1I8tLN0xmZZ1eYa6CnHYJzKRFCENc5iCxF+wOh9kSR0SLnha
         +XmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743015417; x=1743620217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMSYNUtEXougJlHExQh8eBet5bvIJeI5uFDV0DD+oQ0=;
        b=tWk8eRQ7VF48mvHkVAYmV+yJ0HpMjUYaSssrBJ5Tw3p9+6822wVmPqBlVeeG8L+WjJ
         gtg5ubC9EjhRXc/HDRBU7Z5e1mM/DzU1Md12txqumrj8WwQIVznH82LYY4kxI9oQKuoR
         o4vM+MnGDjRR9BML0ke91pY1GQyvI7iICmf80P3nv1ESrWx+WnAXLc5s/4Xc+1+j4WGI
         GEo2n0gCR22Z/+mS6OxX6EaD6rzT75kedcJsOELn3cocpFBX6Yn4WQGvQdjgt6A2+tGS
         pM7l+pDCB5veUrGcFdbXOWnHnDk1ZfSiDUpxlmy2qg5gp5AS3r3DJ1JEbaNo8gUS7UkX
         Gaqw==
X-Forwarded-Encrypted: i=1; AJvYcCXne/do8b06pmj43W8OFg/CoWzktwmCNLs6tphxKA+xbCE6JNZhWLumFAvvbQLIxP9Dvfyp9IOpj+h3Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz09BRzZgxt5tviEtguUNK8ebh5f4ru2y+0/FQn+CC2Z9rgz7AZ
	LyXuWPMT3k3qTo7mz3GLga3m1K2X9fhzlJHq1Q+6FsQg9hMl1QopoutEeqOsAPmoR4cpzEC7xEf
	NFfM/2uOGjkXdFbO4yOOkzLiEexr0qTSc
X-Gm-Gg: ASbGncvXKIRjF0QRGop0PwKcbJWrNYZfqyG1UKFzBa+xJl0NOy9+42wmH6MlWl6oAav
	1q0SbLT1n4dC9NTCgUhKTmj76ey5GJsaOOEsuNG0C1ncReeRD5QJ3oYIR/cE5LOYz9Z2b2wNlHF
	g0QLpc+kgOtaR+/UEZ+LcxEje2xP+iEbXL2SHnW2ivRavQZIdOlUQNqFFhCIUaM9BtDhd7b2j5j
	tTvt0nCsAby9HihDqF2NzYi+xx1A67UFgKvxMyIT5zKUaDKsxbGNDEsDK892X9NiD8fw6jfFGbV
	Il126cczsO5+u2Bs1XmmFiKPmALwlTJf7yIjUBh9E9PEgxl20Q==
X-Google-Smtp-Source: AGHT+IFprfUQX7hl7ALwRYy+fGTAFCgg2CZhgcsHAI4AVmaA2YLgu/KYeOGvdhWmwZaou7Txa0q9P1fZ+A3n
X-Received: by 2002:a05:6602:7286:b0:85b:3f1a:30aa with SMTP id ca18e2360f4ac-85e82127fb2mr121287439f.9.1743015417329;
        Wed, 26 Mar 2025 11:56:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f2cbf03468sm574746173.57.2025.03.26.11.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 11:56:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6300234024A;
	Wed, 26 Mar 2025 12:56:56 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 6BAF0E40158; Wed, 26 Mar 2025 12:56:56 -0600 (MDT)
Date: Wed, 26 Mar 2025 12:56:56 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ublk: improve handling of saturated queues when ublk
 server exits
Message-ID: <Z+RN+CPnWO69aJD5@dev-ushankar.dev.purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-4-262f0121a7bd@purestorage.com>
 <Z-OS2_J7o0NKHWmj@fedora>
 <Z+Q/SNmX+DpVQ5ir@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+Q/SNmX+DpVQ5ir@dev-ushankar.dev.purestorage.com>

On Wed, Mar 26, 2025 at 11:54:16AM -0600, Uday Shankar wrote:
> > ublk_abort_requests() should be called only in case of queue dying,
> > since ublk server may open & close the char device multiple times.
> 
> Sure that is technically possible, however is any real ublk server doing
> this? Seems like a strange thing to do, and seems reasonable for the
> driver to transition the device to the nosrv state (dead or recovery,
> depending on flags) when the char device is closed, since in this case,
> no one can be handling I/O anymore.

I see ublksrv itself is doing this :(

/* Wait until ublk device is setup by udev */
static void ublksrv_check_dev(const struct ublksrv_ctrl_dev_info *info)
{
	unsigned int max_time = 1000000, wait = 0;
	char buf[64];

	snprintf(buf, 64, "%s%d", "/dev/ublkc", info->dev_id);

	while (wait < max_time) {
		int fd = open(buf, O_RDWR);

		if (fd > 0) {
			close(fd);
			break;
		}

		usleep(100000);
		wait += 100000;
	}
}

This seems related to some failures in ublksrv tests

