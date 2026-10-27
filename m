Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112509;
	b=vdKbx/ZM+pm0d+FJzyRt1dJx3S+OmuhE4CfxxmjOGer8g0fiaddJf5goD4NOsCrX8ltb
	 LHUU/asvAkUryEXslNUN+O0N4XBKU4Bg2SF0aEc7rOB4aWlN+n7SBf4PiCONFZD7tV8RS
	 LF1clxFY96c1nRIEsuvItZora+RLiNj2Ae5S+gospzB+4/xPdsUuJi/pjNb8s6APUKYmf
	 w94dcT12AARMFJSSpdupQz4OjUoudARORk8120e5Bdx9DSmW1YcMoe7A8RQSR6hruSCWX
	 unEDqouZ4RXsi2bMb8DV2Yo7PiYHNjO/2lqb2MUd93i3dlh4o2IHmuKKHd82e2OgCfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=MEiRPp/pL8so3hVAnWGeWML+/0EXaeyWeTfYNMG04wo=;
	b=t9Z3+DaYszlfC1XZRbzhcidOK3WWijy1OmvRPhEABk+Sh4LMUuECIYCxwlIsykrVXz38
	 +CdyN0sxyHqYPah7pTYbmKAn6lU7LbHI6oF6dlCWTl4B3jIutl8qCUAzIilO9wQ+qQ96a
	 nRIVEZS3WpLnfzBkDVeRFWCYCgCygJygV36puFxeJPgkk+rdb4I14rFCre9uZfNsNNc0N
	 c0j0/MeJylUIMfXN4Q7pwZCDhFFHET/OH1436W+Ajvqn+cX4GzEH0ZMM1rxWTPc18UGTZ
	 u2BFHCpvt42N9IiysrH9n66X+LIM44O9c+4IGCunUee20YeWJ4EIltms35Ug7M/up1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RfY8hVBC;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602F6606A31D
	for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 14:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 602F6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RfY8hVBC
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-181516de561so874676c88.1
        for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793112506; x=1793717306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MEiRPp/pL8so3hVAnWGeWML+/0EXaeyWeTfYNMG04wo=;
        b=RfY8hVBCjcKhEKK3OsTKO7ouiOvml/yqpF8RHd0oV8s3SXu9vXzpUg22rbvoQmQmKX
         BM6lcEttC5lc2oFdtkISeSN41VJg6Yo/gda8MILB1/sQkeEwASMtxs3o7xvcOpc04MsR
         2A0o36yLlDsNhEL1hijEiyWPTMBLVOcx/4sfHui6wcVTqkGxYKjZaGSeCDGajkLSHXl0
         uDimUsJe8+wb3Rcpo06RR1wLac/p3RXgpJRcbpl1b11gNQ30JRpsyspcSDNEZs6k6xRh
         kQx/I5UOxC5Botole/6qMqWknEBW//E440rIn5lR/KoB0x+GQ9vWjR196TMo/9T2apJP
         Vt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112506; x=1793717306;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MEiRPp/pL8so3hVAnWGeWML+/0EXaeyWeTfYNMG04wo=;
        b=yyKg5y2nVqwumVgMb8uNe1laDp5WvxEBwfIwIvznnzCpKzhQW5zGaCq4wOs/TJxFDy
         PmZqYU4IsDGYqfQ+Ye/9Qw3pnOFAl+Igf1dw7uPOmP2nn4+IvdHC4GQGIuDKPYFkf31p
         IWbUi35TS34sxqHFQQzJt1JWvowU6PWmD4RC4G7CisJQCXY+vKw7+gIBlegGKg0mDLSv
         qYXCOYUu0DZ0jFTEWysxBYARBOCqkTj/X5QxcktxxESXZJoVeN20rNxtZOj57n4JsFyJ
         AfJbuV+ezUjBagjCDNuThsfWth+5TjKCIHalHjr1N2XDGNCMCoGdY9vFA4Jx8N8SHbS4
         38mQ==
X-Gm-Message-State: AFq9FYJ4Ygi7JvloFbyO9RnL+9vhN2dXa7MgBGJ5QwbP0r5lyxMmx4QV
	s+F+ah40i6LreUZWNhVTKSB+LM3W8DPOZGutfMBiXJnxPj9GojBSngiLb1z8PUwsdU4=
X-Gm-Gg: AYBFou3AR1E0pfQZoi/MLy/clImUXNp4vhxlQdG9emhXlfUsRK3LSn531XFfIJnqxNg
	j4Sb+ylKwjPWXQf+56/M+PUrS2XKBnxZa15VhPOpRl7HHN5p3VW/KTv6WXfdHsZy9xjzwsDhjIQ
	KKB8dz4Y1BYbBdTlqCiTsPCBble8N4iITInlZ50TBCNsI2Z5+vzLRWAwSp0tkbeFaEYzvqeal+N
	/I/q967ZMKXmXWLWwgkd6mZ7AzBOsGuCXYpSCLV8ShU1G3UyCv6jV91IuXwt+ZXsVLBHGOUFHNm
	dlz4BQ6H+yatmWuDKT6CzZEekT6DV/vNXaWfMa/5SjBfp6yJb3Uj/IAhTyZwm8dH8QSWe+lkkub
	Q3lScbMh/fa0EpO4IzHR8UdjEbxGuY6ezU4YZ3s/IlDU7V3vAc+VNCIX55Y1EphTt+rSWWllHVm
	bjwaTl0OUQZAkEqLZ1aYqwBB/JUQB4JQSY0cATMavYwFg39ei3aNwwB+6oO+T32ul6EDvRATIyD
	1O+cXpGx5ssE3JuTg2cuYeaCyEhzF4RksRcp0ps4wKIiMVFKRw7JHS3oYGmJSK3BVgWCf/OPr0a
	M4W/QQwrJKUmX37T4a8XBIEBhuhGtdTgJW87kUuAngqtLxwsSkLW9FV514Be
X-Received: by 2002:a05:701b:2214:b0:19e:3464:ce40 with SMTP id a92af1059eb24-1a3c324036emr3558035c88.1.1793112506136;
        Tue, 27 Oct 2026 07:48:26 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm30808559c88.21.2026.10.27.07.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:48:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Zhenxian Ma <mzx199711@gmail.com>
Cc: hch@lst.de, bvanassche@acm.org, 
 syzbot+bd975ef54294bec73f0e@syzkaller.appspotmail.com, 
 Tal Zussman <tz2294@columbia.edu>, Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <20261022062513.77372-1-mzx199711@gmail.com>
References: <20261022062513.77372-1-mzx199711@gmail.com>
Subject: Re: [PATCH v2] block: fix recursive i_rwsem locking in
 blkdev_write_iter()
Message-Id: <179311250504.921557.2007100010116005195.b4-ty@b4>
Date: Tue, 27 Oct 2026 08:48:25 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 22 Oct 2026 14:25:13 +0800, Zhenxian Ma wrote:
> Commit 2fec4fd97cc3 ("block: take i_rwsem for the direct I/O write
> fallback") takes i_rwsem around blkdev_buffered_write() in the direct
> write fallback to close a race with set_blocksize().  Commit
> 1b1be9ea4e34 ("block: take the inode lock for buffered write fallback")
> fixes the same race by taking i_rwsem inside blkdev_buffered_write()
> instead.  With both commits applied, the fallback path takes i_rwsem
> recursively:
> 
> [...]

Applied, thanks!

[1/1] block: fix recursive i_rwsem locking in blkdev_write_iter()
      commit: 21b88cc8bafceee6c6c82503e3b2cc6f1d0c78bf

Best regards,
-- 
Jens Axboe



