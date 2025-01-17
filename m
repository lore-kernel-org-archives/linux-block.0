Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD5D187550
	for <linux-block@vger.kernel.org>; Fri, 17 Jan 2025 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737125995; cv=none; b=BzyW7+lLxeZtiagcNI8djvUaAdl1XyEgS5g3nACG+AF3/X6un4EyQk2Egy9h9+hAzIR7ovLy+R2ucvUn3wyXcTvLF1qeK21WY9qvSWrYTjo4s+CB81XS5v7fVtXPfRe+awcEEwA2cTBRXvL6uYdSa7x6fu+KXAmhRTEGAKP6MQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737125995; c=relaxed/simple;
	bh=FYIdVyLJ1VEZanD40elISQhj8UBKvnUmQ14RDqI3Rcg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NscKcXuxu7onCaCOzWfX/gDxAvNrtSLg3XbDoIev4PSvt9fzF592VkA4RT33qn66ZbJd0yQ7AGmiADf48DsAbudsP6vPmq00jYKg5jkg0ohuSxtyIOJWXXSKbDqeDohpeTo/XWRErd3jz83FH1p0QIiDxNx910xiU18xh339/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dA3skjkt; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dA3skjkt"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso1223821f8f.3
        for <linux-block@vger.kernel.org>; Fri, 17 Jan 2025 06:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737125992; x=1737730792; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XoY2CmYqDhwCjr+LTaQT1CEx+jVsjk82eanBRDuR1qg=;
        b=dA3skjktSnO+ewKKOne+ZBopa1eS5wgGVcJKpt9Cb3xR+luFftABtf2wPU+VpwaHee
         IeUkxlNYzimWj202H6HiFJo4D0sgEw2Q/5YLCtprzNAgh5ucIROD7jtGNJ0XXY9IV5FK
         fgzDaBqg/ueKh4za5lgOHOs30D/MRLWViJQvDemnYuEBT6KZk3MG3kq7tMxaVnDTSi6k
         IQueHPh/rrdus/yQ+YmMhQbvl8jORP477NL0DrGDMIMf67OS/hHQqHDCa5EoiFjvntrp
         zKHyYS2OopY3HBtKcjTVbCHPfy1mSuhSdM85iUdiBDPxxDWLx03p0TQZM2lsIPRR9ZNe
         gcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737125992; x=1737730792;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoY2CmYqDhwCjr+LTaQT1CEx+jVsjk82eanBRDuR1qg=;
        b=LI7I1+PDCdnbTGqTX5FJJdU6de66ITlPY4hdyzgCeKqNDS5ItRLeaSaiTi9au7yoMq
         l58Z4dG5YwrZvCs1Xk5OLhEfKrO2g8tTEj54nt7s5Xxgv6KIiqL1AuuZ+7+KE3jxl5Ye
         sPInuvM9OWwj8f3JLw+/tL/T81v9KshIWWa0WjcDqOqtk+H3JUYKhNgnyIMS8Rm/lnap
         oxP8FWb6NgK849hVvlRCtaJZTLGMe2hNZ08QsxIz62iOvyX5yBjAbsC+DvPBiHvaKrD5
         P1RTUfA1o5vD/1XCzxuBYe4vaaXgFOl/Xw9cL1Xa6qH8WUMbvMjg67Pca9IoAyMAPvMe
         D8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAgztKKtASjdSZPB+DnfCZhXoN7zebqQXWwRPnUrMYt6SSSmWv/BRWUcT4rX/GwpmAyArpagQjYxL7XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQ4GMAppk7pRJFZ3enxvKIU7sz7x7QgdTfeK/tznVqEeFYBBh
	eT6VxM7BagAKmSaiNsMfPbFGNCpNsN4zXgIvjJZaOzDrA+q7x8pJpys8HO9iAzQ=
X-Gm-Gg: ASbGncuhQ8ubtcQo78exj5+7iFcQu/rr/Jtd3B5nRn90HPrLieI4KoZDGDNEIOAZUdW
	6afA1A3DeAGkyuSjUfLySkXa0IS7mU89syG+oTuZfPRTFLxcZPWa8cTljPw9HllvLVGMGYyahZ3
	PGJY+c8FYc5s9sXMqGLopq/6I3yO3pBP5tgLB3W9N4g6g6QMZva+lvF4RoTX4MvI8qK6PzzgBxw
	a3oenGtPqeMU9Iwr7L2k0IlNDODNT9etoefC/M3cGjgVLQXKjLProuw0QeXjjG7w5103Q==
X-Google-Smtp-Source: AGHT+IEeRJ9cpKeNPyOpv6YqDFfsJM6JExhw0J3WkruNYdK28qTCi2QUozVixRXMXz9wRrk9NPLQtg==
X-Received: by 2002:a5d:6c6f:0:b0:38a:9ed4:9fff with SMTP id ffacd0b85a97d-38bf57c070bmr3026621f8f.51.1737125991738;
        Fri, 17 Jan 2025 06:59:51 -0800 (PST)
Received: from localhost (109-81-84-225.rct.o2.cz. [109.81.84.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275556sm2751940f8f.72.2025.01.17.06.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 06:59:51 -0800 (PST)
Date: Fri, 17 Jan 2025 15:59:50 +0100
From: Michal Hocko <mhocko@suse.com>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: REMINDER - LSF/MM/BPF: 2025: Call for Proposals
Message-ID: <Z4pwZkf3px21OVJm@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
this is a friendly reminder for LSF/MM/BPF Call for proposals - you can
find the original announcement here: https://lore.kernel.org/all/Z1wQcKKw14iei0Va@tiehlicka/T/#u.

Please also note you need to fill out the following Google form to
request attendance and suggest any topics for discussion:

          https://forms.gle/xXvQicSFeFKjayxB9

The deadline to do that is Feb 1st!

Please also note that we have decided that there will _not_ be virtual
attendance option this year. Nor we will be streaming sessions. We are
sorry if this is causing any inconvenience but we have concluded that
we will use our constrained budget more efficiently this way.

[1] https://lore.kernel.org/all/Z1wQcKKw14iei0Va@tiehlicka/T/#u
-- 
Michal Hocko
SUSE Labs
