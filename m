Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71BB173
	for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729350711; cv=none; b=ULblkpWH0ThtECeldADA0nBBNvqGFPjgPz3AfB6LU2IAAa/Eu4ndNCZ0TTRNpbKi4AghtQ1qzTLFUkoO5M6Vl6c37iB4L1ctYt6Fd8DKWM8PPjJbaSU5KQNA1FjYVX7dc3dUefM8ceP/za5G3IJHPH3VopaayitiPxc5UvSd740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729350711; c=relaxed/simple;
	bh=mOqgCXtUuNMShDpeT+UWb4IYGud/tns4vYCaP8j+FUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2N10YvuS6fg/gug4RfEAOxZg+MvSXwen/omgn5pvVvcdxmfFIEGSzgifU3EjyARb89gWU/wDVzLqselTWgslEpO+bK1oqq2ZAQlm9diIX5rP2DEOhTUuJk2gLVGvpeAooUQcQVRDL0rEcp++w37N7Ki33DxQ7D8fA1+J33gFAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B7WmUWIZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B7WmUWIZ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c803787abso24155145ad.0
        for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729350709; x=1729955509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RVWMwrT/RIJu1cQuotlyhISjDRsmwt4LeeJCzNtXcXo=;
        b=B7WmUWIZ/FYgv1Synmv8flwbMjHFrp3L98NZIPP+UeXd/PSdU95REIzk1uksgLRCE/
         BY78rIWuIRtipIMVKyDZrWuZzpOfWTMvcYv4gB3dgfUq/wA0cqvBAlZp5NngZxk6JKY3
         xD2dnK1mR3XgwsUHdpVcpB/ApV0APjuJaEi4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729350709; x=1729955509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVWMwrT/RIJu1cQuotlyhISjDRsmwt4LeeJCzNtXcXo=;
        b=rby7WtNgkel0jiY+SVaqVHK9JKhEasrNpo9jr1/Dm8AKCKhxyGD4xCQkmX1JGPhsvs
         hgAzH5MAniCmYD0cPYWL4cUBBQk21GRo4ACoRinrmePO40or4H87i4T+MqNgoeV37j4Q
         48KTKFuLfitkiBXAaY2wmky4s2BKX3dM3gvhgteIvD/lHgnO0giU9nAa9LGblYq5+CIk
         dWQrzWuv5z/iJn2LdOc96fw7dj2vwppkS+WpLp5+3mcZhpvYfnMt4SJxtcF0bjFdtVVN
         131mL5U+EiBltTYNf5VzujTVD1e8xo6Ri/s0Ol5gmg4oMghOsMftKMVkPT0rF2c4yr4l
         BCaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnXhHnSiM1Szv+Mg3QDKGCkG62TZy+qKNhMXSgHaosS31x7U3sI9R++jZRWpoIUevLNBoIc4q/CpmIfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YycdWg83HG+bM+BgpDxpjyKkwROXQXhqi9QskgRnvl2+AeKEEOA
	H6/sm2N3CkaxO1n4Y5nLdSAiySKsUIKfoGYLtcRokU9GWywYVTbbqAb3bkvYSw==
X-Google-Smtp-Source: AGHT+IFAmAlsmY+0aXFNN5zYIiAIUkM3adeVmWGpBgrbKyzlLsnaq9zbPssymL74nv1Aezz/gcHbHw==
X-Received: by 2002:a17:903:244c:b0:20c:f39e:4c04 with SMTP id d9443c01a7336-20d471ec6ddmr165961315ad.2.1729350708750;
        Sat, 19 Oct 2024 08:11:48 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:4f31:a9b3:f4ca:dea7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a7475b1sm29156805ad.72.2024.10.19.08.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 08:11:48 -0700 (PDT)
Date: Sun, 20 Oct 2024 00:11:44 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <20241019151144.GH1279924@google.com>
References: <20241009113831.557606-2-hch@lst.de>
 <Zw_BBgrVAJrxrfpe@fedora>
 <20241019012541.GD1279924@google.com>
 <ZxOmzVLWj0X10_3G@fedora>
 <20241019123727.GE1279924@google.com>
 <ZxOrGeZnI52LcGWF@fedora>
 <20241019125804.GF1279924@google.com>
 <ZxOvfpI6vgH5oXjg@fedora>
 <20241019135010.GG1279924@google.com>
 <ZxPKP8SEb7Y4ceOq@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxPKP8SEb7Y4ceOq@fedora>

On (24/10/19 23:03), Ming Lei wrote:
> Probably bio_queue_enter() waits for runtime PM, and the queue is in
> ->pm_only state, and BLK_MQ_REQ_PM isn't passed actually from
> ioctl_internal_command() <- scsi_set_medium_removal().
> 
> And if you have vmcore collected, it shouldn't be not hard to root cause.

We don't collect those.

> Also I'd suggest to collect intact related dmesg log in future, instead of
> providing selective log, such as, there isn't even kernel version...

These "selected" backtraces are the only backtraces in the dmesg.
I literally have reports that have just two backtraces of tasks blocked
over 120 seconds, one close()->bio_queue_enter()->schedule (under
->open_mutex) and the other one del_gendisk()->mutex_lock()->schedule().
