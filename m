Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A52BC148
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720508609; cv=none; b=hKPBsRxNw+xEVRxSyGkL5SuRK420BdlG/Ols34SJ2wcZag6RPZAJPYEFfGXoOJC641DgzCkX0MjWNq/e+SNh3CGnMmTx1gMYSZrEPwoKVcoSXbNinUgbA0LdVXm0/45tB11KI07ASbrnu3W96KXfauY6//fcxHCbFUV/xqYqk5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720508609; c=relaxed/simple;
	bh=XbhqKWzVg/ZgN+a8WlCuXkQoeJRPZn3Hj+Pq7HeZT5M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rv7LkTLWaApL4LS7/JJmgEvwAtq7lEdN01mmgWTJL6REGRcSL4i58g0zjDoNkkyme//oWJ5UIdH2UDtJzXupVrke4pT5HOxSCfE1UL6ImhRmLgyBdOdXMNtdWo2dAvqutgfVnP2sk4Z0kkNstQCZLZr4HaLkCnjx/kujPjSZ/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=v4zmx4Q2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="v4zmx4Q2"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e994be1abso457025e87.2
        for <linux-block@vger.kernel.org>; Tue, 09 Jul 2024 00:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720508604; x=1721113404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0ZRCN9ejRvx04CKJWiC+6hK7QH1qSf7dSj+kzoO1/I=;
        b=v4zmx4Q2oiyDpN2U804ba3yAiYOk9aIcKQlyXGUG/h/4FotLMPPy+1vziiz3N+mlTu
         +qJc3EabuFfD8CIgfwYuNlCw9b2sMHGZHrgkyuQFa0GhsZqxdYD9eQEpRRXB/o/yaXWF
         Ix1W2AqddZkEZQaL+NT4TRMwvaiwGyCQor92XhXMuitzI7Sc8+hn7uuOz+vHmHkCmlNB
         gUoG2wbgo0kvDDkR2Wz8ieDCbqZmi+nIcPlsN0Vh8m5MbwcUDdyKJAUy9UtDSELdy9nd
         F6VjwPIqVeynPE6uMm4WNa/WXGZlluUnfwAEKZQrwlaUmN8h1xYjwBbVnLXS55SflMAl
         N6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720508604; x=1721113404;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0ZRCN9ejRvx04CKJWiC+6hK7QH1qSf7dSj+kzoO1/I=;
        b=RNSBeJalYkAAwbydtJyYXWER189kbfhmvbyaR1OC69OjVT4Z5btG8M8moBhyz1o34p
         qcoXPWJghzp7kITgS46VuRO7k6CG/irhbTKwLbGYUELYe6atymG7IWEELm91iP/syAAL
         8Vf7vFwx0Re23WSaJpYtyrsEsDenAAHk+wXzZXH6L2Z0xulJSJ3DR1zzar0UyLyfNkG7
         Au0t4t1AudWwyIXSgX6RKdK7rJwt+wG6D6dqvsVoxNK2TeVHFQ8Yax/12vfV/RYKjO+l
         ak9Zv7qVU5LQP20au5bWOj2NTgSlZxv9iXVG/QRZbZ30xKmkrhGZxS5mhFjTDC5zOuhO
         p4sw==
X-Gm-Message-State: AOJu0YynfqYz+sPylNziv5qSMKmJWzBcKRPSJGmilvv71dnRPQCLmH31
	tcyMGWUvVSr2t7eeOD0Wf9Fgn0kPHnvm9KCWKJoxDDR0cMRtSWdbLhjEz+QAt+30VXI9ERWkdQd
	W5hlL6eP2
X-Google-Smtp-Source: AGHT+IEuZaB4A/bhhhRsLPgTVxSvrSFAK8GxALJdpCDoWxUO/NHPw8MUapYudi6JQKkQl3nJMM3N6A==
X-Received: by 2002:a05:6512:b27:b0:52e:9daa:25f4 with SMTP id 2adb3069b0e04-52eb99954e0mr929212e87.2.1720508604589;
        Tue, 09 Jul 2024 00:03:24 -0700 (PDT)
Received: from [127.0.0.1] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb9066781sm161319e87.190.2024.07.09.00.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 00:03:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>, 
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
In-Reply-To: <20240709070126.3019940-1-hch@lst.de>
References: <20240709070126.3019940-1-hch@lst.de>
Subject: Re: [PATCH] block: take offset into account in blk_bvec_map_sg
 again
Message-Id: <172050860367.370954.14089502876284998064.b4-ty@kernel.dk>
Date: Tue, 09 Jul 2024 01:03:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 09 Jul 2024 09:01:25 +0200, Christoph Hellwig wrote:
> The rebase of commit 09595e0c9d65 ("block: pass a phys_addr_t to
> get_max_segment_size") lost adding the total to to the offset in
> blk_bvec_map_sg.  Add it back.
> 
> 

Applied, thanks!

[1/1] block: take offset into account in blk_bvec_map_sg again
      commit: 61353a63a22890f2c642232ae1ab4a2e02e6a27c

Best regards,
-- 
Jens Axboe



