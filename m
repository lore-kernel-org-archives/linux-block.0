Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DCD146A8E
	for <linux-block@vger.kernel.org>; Mon, 13 May 2024 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586977; cv=none; b=jbyVZ5q5Zex7qWedhCuvyTdu9KWzuBAN565Cv27hJNAxeXfY5SUbgvOCW/FELVqzoX4nkhQC6sXcRm/MWJNpsiYWLPVT/hjSNBOxhLW9o4+9DnsYhtSYFx3NSJPDXwQUKIxQh+H7+33iZonuCGzmkGD1vXkw21ixuc79aHfIo5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586977; c=relaxed/simple;
	bh=+NfTuLoyCy1Yv4Yprr+1A2C88Z3gWZRIHA1QRY27WJ8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=f/Ii//kGiwtqMfFzlC7pPMbsy9TrKKszfe+EON9sH9zz8ytmPGnzr2L/GyPpqGqoNxcihysl34I65LXcnqGKksMIeHKBYUGra37FRn3JgrLe7nc9B1lv5ptinKVnfEPPwu8b7wkR4ZXJxlHDfWWivIH0TdbTW3PLMeulcJeb48w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=glK5PY+P; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="glK5PY+P"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f2ebbd8a7so4303388e87.2
        for <linux-block@vger.kernel.org>; Mon, 13 May 2024 00:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1715586973; x=1716191773; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2aBVyXOGbrF9auKs6ByOQwcNRs+3jorXoRoVF5GtPk=;
        b=glK5PY+PQ3XjvwfbS/ta0XZZt27vUyrjYpbOxRjtU3DBmMkkCaOoWWdVJa1ZjeENvA
         QUt3+rl7JK1YYl0ncubTCtEitYVH2bnP2094V6AUyMsc1vS7ppbxWxEvW1xON1vfFG2a
         yLgqDL2DsEOcnJ7g79rncqCB2+mNIYMLLKB+9JH3l0tRtjA1u0yr8AdunwHChGSNriBK
         2W/PwpXUEMcvS7JRAJLfDaLhFppChLli762Ly1bIsQCrGNX7VHHnK8T4WBHuVCx3sWqh
         a6cIdTcGhTFo96FhNQFptbZlWzsQ0WsnSgBIuRFH1KP1n/2sYRyf7s5+uQsl1In3DO+7
         Oh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715586973; x=1716191773;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2aBVyXOGbrF9auKs6ByOQwcNRs+3jorXoRoVF5GtPk=;
        b=G/cibvxame18bjYduxdAz7uwe4a663t3Jf08Qop0ef+9lqFb4Gfs3LMXduQQgyMQtU
         EfiqrV64VqSs8D1mX0EaZFS44CSIqF5bECJ+XlN/fXWIk2rJKYhp8KbLXK/1WYF3eG3b
         i2hn6qcvPJtvjdIR3hcqEgHrAZtZY+GJn+FsMcg+7Dg5bqfRhux9Vc57P9Jsc22LtDYq
         z3r9lsFY/2+EEMx6PFHQvVxGgZNubBNWIwS9vZyYXZRgdiAzzDoky/PVzYMOu96N7H37
         1Kz4Y8xvtJ8Mg7UDGzibZ+V4DFxPr4sCCHqOqq9lkPxx613hOu3leowsK71cYjOc/Lu0
         j2rQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3ASFTid4J/QwKxL+qbaRMyqnmpJSGwkzBD4oIvZNdDjNONhIR0HRM2oiRA66ovXaeOKXZlgjTA2BXVJhAOVTPNF5/TlUYf6TZSMM=
X-Gm-Message-State: AOJu0Yxhb/xLL6Bk4AajX42sBDXxtEbjwJbOuOFZ7WX81Cgs+B7TmhcH
	jOfj3nBcO9jfqD7n9TYBYEBH7DBCV/uozgzQj5iGPPKg/4/LWvT8gb9rDTPMzUU=
X-Google-Smtp-Source: AGHT+IH9NQ81vMx06YFNFVIVRfcKDZxFq6dwLJk8OwUfJ0OF9CcoN8SGQZ8xcNVh3StW6pzPJZEhJg==
X-Received: by 2002:a05:6512:1105:b0:51c:dc6:a1cf with SMTP id 2adb3069b0e04-5220fc734ecmr6493470e87.34.1715586973191;
        Mon, 13 May 2024 00:56:13 -0700 (PDT)
Received: from smtpclient.apple ([2a00:1370:81a4:8e0a:5846:8eb8:305d:fbad])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52202d30a39sm1475729e87.178.2024.05.13.00.56.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2024 00:56:12 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.8\))
Subject: Re: [PATCH] nvme: enable FDP support
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20240510134015.29717-1-joshi.k@samsung.com>
Date: Mon, 13 May 2024 10:56:00 +0300
Cc: Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org,
 =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
 Bart Van Assche <bvanassche@acm.org>,
 david@fromorbit.com,
 gost.dev@samsung.com,
 Hui Qi <hui81.qi@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>
Content-Transfer-Encoding: 7bit
Message-Id: <CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>
References: <CGME20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41@epcas5p2.samsung.com>
 <20240510134015.29717-1-joshi.k@samsung.com>
To: Kanchan Joshi <joshi.k@samsung.com>
X-Mailer: Apple Mail (2.3696.120.41.1.8)



> On May 10, 2024, at 4:40 PM, Kanchan Joshi <joshi.k@samsung.com> wrote:
> 
> Flexible Data Placement (FDP), as ratified in TP 4146a, allows the host
> to control the placement of logical blocks so as to reduce the SSD WAF.
> 
> Userspace can send the data lifetime information using the write hints.
> The SCSI driver (sd) can already pass this information to the SCSI
> devices. This patch does the same for NVMe.
> 
> Fetches the placement-identifiers (plids) if the device supports FDP.
> And map the incoming write-hints to plids.
> 


Great! Thanks for sharing  the patch.

Do  we have documentation that explains how, for example, kernel-space
file system can work with block layer to employ FDP?

Do  we have FDP support in QEMU already if there is no access to real
device for testing?

Thanks,
Slava.

