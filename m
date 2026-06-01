Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A988175A80
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 01:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780278485; cv=none; b=LBuARmYuLcz1bhaxBUD36+PPHRIJHV7MRECRlGNY0SMw0U8wN2nQUEq7h96i/itt+5GjG63V3p/cGFq+A0AoaozZBqaf8UT3ZDShyEZv6SzNBnwnKw9t9IKaMvDG46R2t4K5XlHz5r2MaJtSXbcKg5ieKTTvXwY1u8TweYHhpzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780278485; c=relaxed/simple;
	bh=WrNoHxJvvM6s001dLSGWe3dC6PRLGMD61IUwbr5AKVE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e5+InIvX5XoBjq5Q0TNiJYr9YRAsmc7b7ticeWW85XfColPTh+LeutZGr6R0fWhzGG5579RqGneNirtpnI/mnqOyE91iWo9abQTwmSYQf74Az9ccHLGiMD/nTMByqhBW82/ajXxZX6piPfxIJ+ec6ZgjWTuJzsTVdIMWP8q/YWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=MauDHxzy; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="MauDHxzy"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-48611ab8fceso662431b6e.1
        for <linux-block@vger.kernel.org>; Sun, 31 May 2026 18:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780278483; x=1780883283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yml48kmcFqsVjGuwhSwxdayEWSO5y1wDWTo47bTAUpE=;
        b=MauDHxzyPtPgw7WstncirmS7iepruDC6HmNikCancFTfhf8j1kF41BiG1K6st/0LrN
         vcEttuuz7oQpjygj/xHHirkdxnPlp5W6vR60weelHAf3ZW/T6pZdZ48o7bpBur6tVUvh
         88JQLbOTspnO/kdW/wGIQe1AI0CZX61ysEJDKSMXYtZCI2e1HG5GpJTckhJujeVooC/Q
         vItrN80EaV4OTwXSkSzz/d2LhDQzIZYvMTOPsB+ZF2Oq1MfD71A4CUMwzWOyPLCwhS/c
         HCIiOtt33Dkt3JgvGsMu3iR+blWuU3VTAGv3vrFIWdvio3Q3d1O5VWvIjA3O/jqWwUqC
         dCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780278483; x=1780883283;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yml48kmcFqsVjGuwhSwxdayEWSO5y1wDWTo47bTAUpE=;
        b=kJOU7DoVPPPqpoSxs47dTyfEOrOG4XG/fV9jsGBuZZUahFz7qFgm65us56TLMK2Et5
         0bOiMOX8s6Ui9uILxNc2Uc1jqKUaFV3LcJB/nrJo0INoCSlrmcsWjLGT8TOjgE6+fs4p
         kb/QRhjCSnL722mgKbdL9sHn5mPHnPUwpk8jzrNZAJr5Tvog36Haxz20OuwJ33XNhY7m
         eTOCo/hP7m7sf+8MTooEjPR/c43TB5HkRFr5MjX79El1YIqFKxo3EULHlOgGac2/1Vbd
         Hy8X5bfr9IzeLVw+r8+Sb9XMcVPvsj+xFhg8g3tzCWyaNNFE13QCUHVo8uCJwwcL7SK+
         1rWw==
X-Gm-Message-State: AOJu0YwnA3FdJzc300VNVwtZQfNjwRc9ktRe97O+hJmrXwKwoxHd6zZj
	NyEzxQXue+brEYS+ctLXYeqFs/JdYbCbz7NTBwlyit7wFK5jq34niMrneUwDhM2/HSw=
X-Gm-Gg: Acq92OGikV7sdFBOiF715f21nMyoSTxSskkLdq17A/Z02wxynxa6+0KPBIk2R5An0vC
	cUiFJUHrslZuZ0w/YuIn5J0OuCyqEm7iTcNl97Jv4b03W7Mv79OCZJdA+aRd1a36Zfko2wpbcQX
	y7z/GWyS0yVcE6oWvuMu/OElfMmuBRGuNZq05f+lZMa95WgUJH0l7A+KWmz8HZapOW2stnjYdzb
	3nHam7Tew9UTNKrCugQwUfROmerIKj4HQe5XTZdtaxH2bkR3c2RcWTItqeBTE1LXIpcpusUYprt
	CkOjR8+QePj4H78C54OwZQdQzIcnpfTlgugp2LQ9b/J+H6PHf70Fag5B84rhIvRK31wkW2+y6o9
	nIFcZEU5bkZGy311RWhE/Ehp6m4pG8hfYbp6+hbOT+0/w0BAGAdy/pXEXtnPdz2CE8CcoDPVsJU
	aGxb9IIJfrXvuPAxgGS8kDoLb4e6PCzVLSUsLykWAzm10aO/SqUFvq8gE8eBjI5vq0r7I=
X-Received: by 2002:a05:6808:1b1f:b0:479:d937:c4f4 with SMTP id 5614622812f47-485fb2ad84dmr5005420b6e.19.1780278483233;
        Sun, 31 May 2026 18:48:03 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.133.55])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48605f6a38esm3494847b6e.2.2026.05.31.18.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 18:48:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Ren Wei <n05ec@lzu.edu.cn>
Cc: ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
 daniel.almeida@collabora.com, tamird@kernel.org, sunke@kylinos.cn, 
 yuantan098@gmail.com, bird@lzu.edu.cn, royenheart@gmail.com
In-Reply-To: <b70aff9a920cc42110fe5cf454c3099561863519.1780063368.git.royenheart@gmail.com>
References: <b70aff9a920cc42110fe5cf454c3099561863519.1780063368.git.royenheart@gmail.com>
Subject: Re: [PATCH rust-fixes v3 1/1] rust: block: fix GenDisk cleanup
 paths
Message-Id: <178027846532.370486.3544820081108249434.b4-ty@b4>
Date: Sun, 31 May 2026 19:47:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 30 May 2026 14:11:54 +0800, Ren Wei wrote:
> GenDiskBuilder::build() still has fallible work after
> __blk_mq_alloc_disk(), but its error path only recovers the
> foreign queue data. That leaks the temporary gendisk and
> request_queue until later teardown. If the caller moved the last
> Arc<TagSet<T>> into build(), the leaked queue can retain blk-mq
> state after the tag set is dropped.
> 
> [...]

Applied, thanks!

[1/1] rust: block: fix GenDisk cleanup paths
      (no commit info)

Best regards,
-- 
Jens Axboe



