Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3542C15BB
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020743; cv=none; b=TDupEPKfprVxXlZrPeeZ0YOypBbyTg0/W9ML3XOQLaHre6mpwhR3O0Pq/lgKLyeHw0hzYHuoJ/K7IemYcqD3jLii47MujWhgvJ7skClIhhSyn4sGfLdfMPzqTqOmRp1Mw7QlRZfw+SsiDE1hPTLxVTTouz2e1ENFMuyesRr3wgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020743; c=relaxed/simple;
	bh=E+t1gFtcHDiraPPrfsroY+Aj4GCqUrp3X08deU2GKIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i1/2B2qvLImDoEj1/IkbhLLXXHpb9ffmg9GJIX5qSulvQhQdY80Ik6EAGI2Wapp4+/4tpnsK9cd6xXRecvWb92K3FcAk0HbQXAIL8okx3sRMTX0R7iOD0xs211c0zAxQTpo/psACqBR11TgnwtweXPOFmOSu3szrnTyO6tN5LQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=QJpPa04w; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="QJpPa04w"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e55b62640so112938485a.0
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 05:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786020741; x=1786625541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vo5x/LABgr4z5KWlM8OBLiF0UJfhkaG4qblmSgV8YMA=;
        b=QJpPa04wKEU93cVUT6IOHEoTbPdj1SLgqIogOrZevNcBUAQ4+egaELr2nW/8bkBY8P
         QEz/4gTs+dY30vIaqKCtk6FJeoTG7uYJ8Te8GJDPLJs+GsvvAGl+iWBa7WckxDks+nDw
         YUxNfptFq5UvWrSb2YWhxsPNYE7rIMrRe1ic5P7Fm9hcBNXrg6rnWjd9syuWKjTG3o0q
         QHkmWriyni3+mWGrQSrf1S5FcsaVVZvUKyzybfTu+gP38m2XkiJcarJBGX5y6FGm+YEw
         Qn98v+3MuEtBsSLGFM9qAQzZxolAsRE5FcgM9EzVu2zmcicsyDqMD0NYvor8/u8yxEZa
         R7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786020741; x=1786625541;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vo5x/LABgr4z5KWlM8OBLiF0UJfhkaG4qblmSgV8YMA=;
        b=mDO6QpGkTVPMnWYoeHQ1QHq0gPsSmUbceoDkPaEwGESaRly/PsNmbNHHylyohUnIER
         Hkyf++I9UZgP+LKDgsf7MY7Fh9JdBn1OHRep+3LXBnIH2cjfcc5zdChpBA9VRd6fQSNq
         rSFrOFUduQAwGfV1H1TJiL1lGUc4rmFLsfeMeHdLqET0TwLQmKfzvsi5u0UVeyywyAs+
         Paqv2SYyjePq5cQDeT45Al5/ZTp6/S3T2XYPLOvRkqFMLcyWZCCdiwVUDNNsfCG27kyM
         4JBSEbBdGKVOv9ayFSSyMmOetS1lUlFQal9Nx+Ynm3fotiPVU9+7Aml+ZqEHdjeAjym6
         NL9Q==
X-Gm-Message-State: AOJu0Ywo4PaCKajbLX8gcZDbak5oODppPYyrPYe/niY8iSJB+iLeMnvB
	6sshrlG8w9igpefp+IP4HS9unTjKVNGFrvvMjEfes6u7hbMh3C6REoC1O3uDjxw/QUPuM+9Toa5
	0Ib1XoYWknw==
X-Gm-Gg: AR+sD1092X7k8l92/Ut6jql0H5gnWqfEKcJUUcwq9fRXnLg8PzHprSJ4YDWeulKBl0w
	eT+IagiFHsMpSB60yNfFd2GlMLwQkqQ6szXyov7frtf/kZL7CfOt8Q3FyViWpkAqT3boR6S2j8j
	1YLQjQzPHx07xPa+fY0UQtjrZqJG+eX49ZljXbB8Sp4YiXTfmibHxH0Mb80G8v9Enui49EwWkzA
	t1B4FVwgh+4R6tsoyc/xh7RgBs92FMjB98TsVdXYxPUynWaX/QgIzt8AGMRRthpqmq41wcVuA6N
	dru3fauPFErqIe4+EABX1/q/ZQwY3amjObHV/YxeeHPOBh1cIQPUmfG2NTsL//USSlNm0bHjKoY
	VTyaRCKN/5YKB+p+rifZxg4HgWTfYPBSbj+CzTLut+kLsgcZ3mQ3Qig2+mFrkMX/IXZrX8p65wq
	L3wkprz5rV05PPoeSKSetPXuVgVMS/t2u5h1Gxg8lhctmjcHIe3ID2GN9Sg3qbeHwyYokpPx0WA
	KF6Ww9FlkIXp0NlVjVpng/dN5DcVssy02CftVlYldkxyuLG
X-Received: by 2002:a05:620a:2311:20b0:930:84d0:fd3b with SMTP id af79cd13be357-93648fafbc7mr1150209885a.7.1786020740525;
        Thu, 06 Aug 2026 05:52:20 -0700 (PDT)
Received: from [127.0.0.1] ([2605:59ca:42bb:f910:6d9f:8dfb:ae1:441b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9365ef833edsm123847685a.3.2026.08.06.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 05:52:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, 
 Dongsheng Yang <dongsheng.yang@linux.dev>, Zheng Gu <cengku@gmail.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, Hannes Reinecke <hare@kernel.org>, 
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev, 
 linux-nvme@lists.infradead.org, linux-btrfs@vger.kernel.org, 
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 ceph-devel@vger.kernel.org
In-Reply-To: <4e4c21858705a200bd8848ffe4080522e3eb5c1c.1786018753.git.asml.silence@gmail.com>
References: <4e4c21858705a200bd8848ffe4080522e3eb5c1c.1786018753.git.asml.silence@gmail.com>
Subject: Re: [PATCH 1/1] block: rename bi_bvec_done
Message-Id: <178602073720.2137920.17721545855702977301.b4-ty@b4>
Date: Thu, 06 Aug 2026 06:52:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 06 Aug 2026 13:19:27 +0100, Pavel Begunkov wrote:
> struct bvec_iter::bi_bvec_done is used an offset in the current bvec,
> let's rename it accordingly for better clarity. I also plan to use it
> for non-bvec based iteration in the future like dma-buf, so drop the
> "bvec" part.

Applied, thanks!

[1/1] block: rename bi_bvec_done
      commit: b539aeacf8cc5e9d8e5d94625d2d9c697a167add

Best regards,
-- 
Jens Axboe



