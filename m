Received: from mail-dy2-f36.google.com (mail-dy2-f36.google.com [74.125.229.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7AA38F929
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182833; cv=none; b=awBH9BJRRLfu6woG2W+HGe5XNHfSJFpBOJg6oMcnIEghP/a5S9JdOmIUZTZWkpG7hNylTNxWA23CJdHycxE7OFDKoXB3GXin3pfx2CHF8NA/jJVBAidI38QZvxKEWwfnnjiOfYtra+YfSNGcwZf69m5Jn51DisfboJLwc0hj+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182833; c=relaxed/simple;
	bh=H+Y672UGyX7i9aGfrUdJbprBuvJ5lNoRxb/xY4JsQcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOIoM2W31ROxGgylUaKHEsIGUi50UHzPLrN/MadM1TnHMOK7n35ejNCs2i1xszxaEum4l7zLjVBt5L3PcNjJYGo8f6McHH6vPMJJlq/tYTRenwFxODCXBtxOTb29/ICQvVQLgKTSipdGGyJ/s63YdmCbdmZHUt3B223z3VZXVxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YtMFpG0M; arc=none smtp.client-ip=74.125.229.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YtMFpG0M"
Received: by mail-dy2-f36.google.com with SMTP id 5a478bee46e88-328664c2da6so726748eec.1
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1790182826; x=1790787626; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mRvwKLba62SFbWcXd0MhiLWsEnujGMFI2luT5Kr139A=;
        b=YtMFpG0MW//CSOjSYC+2tYXMEzBf18mzAxyCX/J2pme6GdnpAaFblMGR6q5SHGOr1L
         byr+uEcWh3acVihq2zikKTdcxrRp6gxHEY19alQeqTQh3exknxSSfFgWn2IYAr8q9zXq
         THzIuUeLCtugPl4fxr8W+TgvBFkX3xo0BSNE9bueaCbDO1KhxptofZduICMIwbM3QvJT
         TuAMNIslvQKneR6M3T7qiAYYKUzAtO/tGwfdHNWpGgubZlF7bBEr6MtXnstiYVaWW9yx
         lwHp8a3B87EE9HLmojXlXuZwgSJHqhTNUz5vElSLTXi61yB3Hh4ElCsWiUY0O3P8gCd5
         +Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790182826; x=1790787626;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mRvwKLba62SFbWcXd0MhiLWsEnujGMFI2luT5Kr139A=;
        b=gtILDrlnmAfOjG8zyX9vx8FOudiZxp26+U5m1OzWojnJ+/zLmHJNfZ4RJh5yLYTkAY
         RLmSsVwBoQdNNs1/SNW8ofTCw1LjfHGJAdsqoiKtEMRiVnZClJhi2pimpBzli0sevovC
         wWCjGRt2oncqZs+ccWkgSiDDyv5+Pi3J+uDiFIWUrO+ls7J4xlgMFQOlZpEQac54GyCO
         nahvZ6JfmRu01pW8oxBIm8VtggXkP1DAkc6En1qA06w6utHI9zHO3AjFbuaN3jsWwAdQ
         Tvccwnz27yiijRGPBjv9Gs/VNbhH3ypxIWbuGBFA+meMCit5qIHBd/PBXJC/DholKXwA
         vwZA==
X-Gm-Message-State: AFuF++lfXAcnenzY1F6JOPOUVbxXZh3GhlYugo23J9hwOY9IEi8w4PZM
	qVjLh1s6qfyEtUja9xfxeRqvBSa6OxOdcKRfMfxBal19PrmFFMHDZJ44WntlZMkSXo0=
X-Gm-Gg: AYBFou2DzScmLG6vHjzRbP33VxWkwJDgjuPs7+Eah8dpMfpUAzkuIeCWPJ+MDZP5t+U
	8x+CshpztrDWqekQg7LI0Uo0f20W2MgIJTj0+Zbz0lI8p2Jzw5ptuQpOQNmrnIm8OsCuMrxjyZg
	Rs7zug4r37o8LzDyC9VKvqZnOaUxczoIV/J22RReTI5xOcQKvOl/OkLqwg7M3Tzi3gxgp/kPWvq
	wOlAKc0ntY9nFLCvURPB/ld72wAMO7Z0DdrO5EoNqNL5/8+04Lz0my2VgygXQKb98Mv4r2qWXQO
	OUnxA0mMkDwz6gL0nPSSu2WZQNgt4kl1pN6eQpfkAqbodpsYLsvFrVtDQzDpQTt+O5xEwa5nEH3
	A1VCgQsDpduGSAAVllCOsef4qxfR5I6BK65UE0hmirCqzxvUmUMYuDjVQngWacwsn9bXbSOqzBF
	CGi+LNqWEou4RXjh/NMZ4plVB5DndPc9CofsV8PiCg62xnKwJboCS7qoirQA2EubJMR2XjlAZ0+
	56ex6OWq0BlW7xVYu06
X-Received: by 2002:a05:7300:42d7:b0:33e:53e7:1103 with SMTP id 5a478bee46e88-33e8ba86133mr2950984eec.13.1790182825298;
        Wed, 23 Sep 2026 10:00:25 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e975223fcsm6836735eec.31.2026.09.23.10.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:00:24 -0700 (PDT)
Date: Wed, 23 Sep 2026 10:00:23 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Jesse Taube <jtaubepe@redhat.com>
Cc: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>
Subject: Re: [PATCH blktests 4/5] src/nvme-ghost-write-detector: add an ABA
 ghost write detector
Message-ID: <20260923170023.GG2931-mkhalfella@purestorage.com>
References: <20260917020752.1672578-1-mkhalfella@purestorage.com>
 <20260917020752.1672578-5-mkhalfella@purestorage.com>
 <CADRr4bdUDLcrV62TXimdhsXZ0GU=DPrBOXFJRix7BADw34TT7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADRr4bdUDLcrV62TXimdhsXZ0GU=DPrBOXFJRix7BADw34TT7g@mail.gmail.com>

On Mon 2026-09-21 14:38:12 -0400, Jesse Taube wrote:
> On Wed, Sep 16, 2026 at 10:09 PM Mohamed Khalfella
> <mkhalfella@purestorage.com> wrote:
> >
> > Consider a write X that is issued to an LBA and times out without ever
> > being acknowledged. The initiator retries it on another path, where it
> > lands. A write Y to the same LBA follows and lands as well. The original
> > X is still in flight somewhere in the fabric, and when it finally
> > reaches the device it overwrites Y. A read now returns X, a write the
> > initiator gave up on long ago.
> >
> > Add a program to catch this. It opens the device O_DIRECT and, on each
> > iteration, issues a series of writes of distinct byte patterns to the
> > same LBA, the 4k block at offset 0, waits, then reads that block back
> > and checks every byte holds the pattern written last. Because the
> > patterns differ, the value that comes back identifies which write
> > reappeared.
> >
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >  src/.gitignore                  |  1 +
> >  src/Makefile                    |  1 +
> >  src/nvme-ghost-write-detector.c | 86 +++++++++++++++++++++++++++++++++
> >  3 files changed, 88 insertions(+)
> >  create mode 100644 src/nvme-ghost-write-detector.c
> >
> > diff --git a/src/.gitignore b/src/.gitignore
> > index e9869e1..9673be8 100644
> > --- a/src/.gitignore
> > +++ b/src/.gitignore
> > @@ -15,6 +15,7 @@
> >  /zbdioctl
> >  /miniublk
> >  /nvme-passthrough-meta
> > +/nvme-ghost-write-detector
> >  /ioctl-lbmd-query
> >  /nvme-passthru-admin-uring
> >  /nvme-delay-ioctl
> > diff --git a/src/Makefile b/src/Makefile
> > index dd64694..92b4d0c 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -24,6 +24,7 @@ C_TARGETS := \
> >         mount_clear_sock \
> >         nvme-delay-ioctl \
> >         nvme-passthrough-meta \
> > +       nvme-ghost-write-detector \
> >         ioctl-lbmd-query \
> >         nbdsetsize \
> >         openclose \
> > diff --git a/src/nvme-ghost-write-detector.c b/src/nvme-ghost-write-detector.c
> > new file mode 100644
> > index 0000000..bd42dde
> > --- /dev/null
> > +++ b/src/nvme-ghost-write-detector.c
> > @@ -0,0 +1,86 @@
> > +// SPDX-License-Identifier: GPL-3.0+
> > +// Copyright (C) 2026 Mohamed Khalfella
> > +
> > +#define _GNU_SOURCE
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <fcntl.h>
> > +#include <unistd.h>
> > +#include <string.h>
> > +#include <malloc.h>
> > +#include <errno.h>
> > +#include <libgen.h>
> 
> We don't need to include malloc.h

Okay, will drop it.

> > +
> > +#define BUF_SIZE       4096
> > +#define ITERATIONS     10
> > +#define DELAY          3               /* seconds delay between iterations */
> > +#define WRITE_COUNT    10
> > +
> > +#define WRITE_OFFSET   0
> > +#define READ_OFFSET    WRITE_OFFSET
> > +
> > +int main(int argc, char **argv)
> > +{
> > +       int fd, i, w, off, ret;
> > +       char *buff;
> > +
> 
> This is a bit pedantic but:
> 
> if (argc < 1)
>   return 1;

See below "if (argc < 2)". We need at least one argument the nvme device
to run IOs on. arg[0] is the program name, and arg[1] is the device name.

> 
> > +       fprintf(stdout, "starting %s test program\n", basename(argv[0]));
> > +
> > +       if (argc < 2) {
> > +               fprintf(stderr, "usage: %s /dev/nvmeXnY", argv[0]);
> > +               return 1;
> > +       }
> > +
> > +       fd = open(argv[1], O_RDWR | O_DIRECT);
> > +       if (fd < 0) {
> > +               fprintf(stderr, "failed to open device, errno = %d\n", errno);
> > +               return 1;
> > +       }
> > +
> > +       ret = posix_memalign((void **)&buff, BUF_SIZE, BUF_SIZE);
> > +       if (ret) {
> > +               fprintf(stderr, "failed to allocate buffer, ret = %d\n", ret);
> > +               goto out;
> > +       }
> > +
> > +       for (i = 0; i < ITERATIONS; i++) {
> > +               fprintf(stdout, "iteration number %d, writing data\n", i);
> > +
> > +               for (w = 0; w < WRITE_COUNT; w++) {
> > +                       memset(buff, w, BUF_SIZE);
> > +                       ret = pwrite(fd, buff, BUF_SIZE, WRITE_OFFSET);
> > +                       if (ret != BUF_SIZE) {
> > +                               fprintf(stderr, "failed to write buff, "
> > +                                               "ret = %d, errno = %d\n",
> > +                                               ret, errno);
> > +                               goto out;
> > +                       }
> > +               }
> > +
> > +               sleep(5);
> 
> There should be a macro for this.

Okay, will do that in next revision.

> 
> Thanks,
> Jesse Taube
> 
> > +               fprintf(stdout, "validating written data\n");
> > +
> > +               ret = pread(fd, buff, BUF_SIZE, READ_OFFSET);
> > +               if (ret != BUF_SIZE) {
> > +                       fprintf(stderr, "failed to read buff, "
> > +                                       "ret = %d, errno = %d\n",
> > +                                       ret, errno);
> > +                       goto out;
> > +               }
> > +
> > +               for (off = 0; off < BUF_SIZE; off++) {
> > +                       if (buff[off] != WRITE_COUNT - 1) {
> > +                               fprintf(stdout, "validation failed\n");
> > +                               goto out;
> > +                       }
> > +               }
> > +
> > +               fprintf(stdout, "successfully validated\n");
> > +               sleep(DELAY);
> > +       }
> > +
> > +out:
> > +       fprintf(stdout, "finished %s test program\n", basename(argv[0]));
> > +       close(fd);
> > +       return ret;
> > +}
> > --
> > 2.55.0
> >
> 
