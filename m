Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B821DF75A
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 00:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760403337; cv=none; b=b1acPWBWnXB9fAJy34vl4b4QnI6Y60KlVNCOVI0Eekx5u0KoLuCMzDmu/mdeV5N3G+BMok6eTPjwPqkHsa2dmQyKU4mUbMM4aN+FaL/dVGVEvfKSgOHhQiJ8DDPl8e76ZyUKQ4Zcp6VZ3xjfupTJx0Xjc0CTWY3ioH6atCuh6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760403337; c=relaxed/simple;
	bh=kf9j/5BzOVdGxyqzzdIuSEzvc4B6q5OLpRyAAP0moXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcIHgOpUk4Xe7Al4WbJ62KlcW4CezEJNbPb7111QqKLeLN+xy7c8qWJHvYdjdQLahC820IwXCbFTRF6R+QTysJ4ut7CulIgbVuyFiAUya9QTzvbs3jc4Pi+AsG32WD7KQoFmU4SdQgCfH6NxYF3jucsH7zSRyJ+dk91NGYZsTWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dp/nzGin; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp/nzGin"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b55517e74e3so5248098a12.2
        for <linux-block@vger.kernel.org>; Mon, 13 Oct 2025 17:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760403335; x=1761008135; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0qomT1ZkVPDmIuCEoNEUDG95EzuPyhJMmV7fO0hnOBs=;
        b=Dp/nzGinqJbErOFevH4DuXU7a9qWYxzk5/0egQDjyZVadUBAsgJX3zbARfcPqFRPc6
         6vLsn8lo6g1h9Hzm/mGCbM0im77mEO4xP4ZwihvtvGN4D1ZKR+nsCgIMYCVDj9e1PvTu
         ra9vlSZF0EnZxwO3iBfSa47CLPjZFSGU7ar+6rqn2Mepz772MNWmSbrOYtA2/tAEjeL6
         cJIkDbrr9oHQynV9qb8Zx/LBLvIFvty1RSetl/aniHjI9sgWC7hJ54gxGQhJlQhE2lK3
         El2HJ5iDBalYKuf2Yp7tfcmeu304xGPSdPg/RUSh4bQMYJ0ceW9czzLimlAmxvFxVesb
         UyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760403335; x=1761008135;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qomT1ZkVPDmIuCEoNEUDG95EzuPyhJMmV7fO0hnOBs=;
        b=bRhmJOjDzAd0KCO+zUhBnlseXqUzVbKb5TrPP/qHb6cZs7Eny8DN3KdFNFQbtizhBA
         S1P1cajs6qrxl017HXnKyS9v4cCU9eYYyQdz9Mk/K93BO6aZiyJyQqavKul/K1DCCfPn
         DYWiQ7/avxain/nhFSxEquTtHJFqA7yGU6iN2M0UstsucKdqbTLeO/w5prH6KSEVURjg
         WdfMlLJg2AqmYp58STHG2b1TOukpqfZFHRyMoyN8K6lSpySIDbA6oljRMnI1by+b0wvH
         IwS0tyXTNjDXh7kATtst4SM8P1Q67Pp+22CwoYpDdhXBIuOb50bhjUal+2TMkx5nIf/n
         LDxw==
X-Forwarded-Encrypted: i=1; AJvYcCVN56bx9DkNqeYaPZQeum7G6IRDk0yjOgYE4O78Ud5ohfwHFi4+UGNroqJCklOiSICVlsjriz8yQtZPVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfcfC1NdOaRsaWIJ2/ofH6wgf7CU8xdhjfAIQGeIloWCJTMN1q
	Py5uCpsSgFk2cq7XHiODh34qBxRwU4I2OO+QPLZxzZQLTzi7Sw88K9ly
X-Gm-Gg: ASbGnct0sR5fuY7HxTS0KC/qdiqAKQEd+yqgvXTOEyqW6QpFwRBAQAHXHpUxwx13XY1
	K6N8Te6VQcyB25mzaZ+Y/AxB0KUEN2Eaz+LTzduI0xescxs2dIS5TtSibsIbxgRsLFv9YOOkSyU
	elrk2sR0jY7lEpLQGzZdODledr/OJuW+EeVi9QGic28Kmr8hQvIG2kKzXtjTncDIWU07gfbYJp1
	2Bam77ienz/qY2RVj1jFezpoXAF2SjikEVnTNSBPgtBEF0tcsQbHtv6hk7qPGzNrSZXH0pwB7ZN
	oTvJ3wT2VodyjEP+aw6qhx9STyKSymO3xRJZXBfWb94TvMJuGiEj7YdN3PF+BVGQwDLs//jyItk
	8LQqD/DOaNrANVLzxRNED23PcP2BRGBgZrN6hysgF
X-Google-Smtp-Source: AGHT+IGniqk01IgDaiRJwaKVGBcopVfs/CxGUBowAuplH5VoT3lCcXuXMawjfUp7c/hF1vuAQ69KrA==
X-Received: by 2002:a17:902:e5c6:b0:268:db2:b78f with SMTP id d9443c01a7336-29027402c15mr322158845ad.44.1760403334516;
        Mon, 13 Oct 2025 17:55:34 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29040e02648sm112012925ad.116.2025.10.13.17.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 17:55:34 -0700 (PDT)
Date: Tue, 14 Oct 2025 08:54:49 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Genes Lists <lists@sapience.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Subject: Re: mainline boot fail nvme/block? [BISECTED]
Message-ID: <xfzcvv6ezleds24wvha2apkz5kirhcmoydm3on2hnfrxcwuc3g@koj6plovnvbd>
References: <4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com>
 <cf4e88c6-0319-4084-8311-a7ca28a78c81@kernel.dk>
 <3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com>
 <trdjd7zhpldyeurmpvx4zpgjoz7hmf3ugayybz4gagu2iue56c@zswmzvauqnxk>
 <622d6d7401b5cfd4bd5f359c7d7dc5b3bf8785d5.camel@sapience.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <622d6d7401b5cfd4bd5f359c7d7dc5b3bf8785d5.camel@sapience.com>

On Mon, Oct 13, 2025 at 07:45:05AM -0400, Genes Lists wrote:
> On Mon, 2025-10-13 at 16:46 +0800, Inochi Amaoto wrote:
> > On Fri, Oct 10, 2025 at 07:49:34PM -0400, Genes Lists wrote:
> > > On Fri, 2025-10-10 at 08:54 -0600, Jens Axboe wrote:
> > > > On 10/10/25 8:29 AM, Genes Lists wrote:
> > > > > Mainline fails to boot - 6.17.1 works fine.
> > > > > Same kernel on an older laptop without any nvme works just
> > > > > fine.
> > > > > 
> > > > > It seems to get stuck enumerating disks within the initramfs
> > > > > created by
> > > > > dracut.
> > > > > 
> > > > > ,
> ...
> 
> > > Bisect landed here. (cc linux-pci@vger.kernel.org)
> > > Hopefully it is helpful, even though I don't see MSI in lspci
> > > output
> > > (which is provided below).
> > > 
> > > gene
> > > 
> > > 
> > > 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b is the first bad commit
> > > commit 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b (HEAD)
> > > Author: Inochi Amaoto <inochiama@gmail.com>
> > > Date:   Thu Aug 14 07:28:32 2025 +0800
> > > 
> > >     PCI/MSI: Add startup/shutdown for per device domains
> > > 
> > >     As the RISC-V PLIC cannot apply affinity settings without
> > > invoking
> > >     irq_enable(), it will make the interrupt unavailble when used
> > > as an
> > >     underlying interrupt chip for the MSI controller.
> > > 
> > >     Implement the irq_startup() and irq_shutdown() callbacks for
> > > the
> > > PCI MSI
> > >     and MSI-X templates.
> > > 
> > >     For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT, the
> > > parent
> > > startup
> > >     and shutdown functions are invoked. That allows the interrupt
> > > on
> > > the parent
> > >     chip to be enabled if the interrupt has not been enabled during
> > >     allocation. This is necessary for MSI controllers which use
> > > PLIC as
> > >     underlying parent interrupt chip.
> > > 
> > >     Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > >     Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > >     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > >     Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox
> > >     Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> > >     Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > >     Link: https://lore.kernel.org/all/20250813232835.43458-3-
> > > inochiama@gmail.com
> > > 
> > >  drivers/pci/msi/irqdomain.c | 52
> > > ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/msi.h         |  2 ++
> > >  2 files changed, 54 insertions(+)
> > > 
> > > 
> ...
> 
> > 
> > 
> > I think this is caused by VMD device, which I have a temporary
> > solution
> > here [1]. Since I have no idea about how VMD works, I hope if anyone
> > can help to convert this as an formal fix.
> > 
> > [1]
> > https://lore.kernel.org/all/qs2vydzm6xngul77xuwjli7h757gzfhmb4siiklzo
> > gihz5oplw@gsvgn75lib6t/
> > 
> > Regards,
> > Inochi
> 
> Thank you Inochi
> 
> I tried this patch over 6.18-rc1.
> 
>  It get's further than without the patch but around the time I get
> prompted for passphrase for the luks partition
> (root is not encrypted) it crashes. 
> 
> I have uploaded 2 images I took of the screen when this happens and
> uploaded them to here:
> 
>     https://0x0.st/KSNz.jpg
>     https://0x0.st/KSNi.jpg
> 

This picture is only a WARNING from perf_get_x86_pmu_capability,
and no other information. So I am not sure whether it is caused
by this change. But from the original report I have, it solves
the problem at that time.

By the way, can you test the following change?
https://lore.kernel.org/all/2hyxqqdootjw5yepbimacuuapfsf26c5mmu5w2jsdmamxvsjdq@gnibocldkuz5/

If it is OK, I will send a patch for it.

Regards,
Inochi
