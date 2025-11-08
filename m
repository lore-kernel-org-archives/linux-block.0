Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71FF2B9B9
	for <linux-block@vger.kernel.org>; Sat,  8 Nov 2025 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762609216; cv=none; b=LpxD4SGFZayRsEyEmOfHWrxCEAVWrldcJZu7l7FPR1nvpB8xkuuokiRwEkBm1vTxsYa5I2Z58FQfm0CM9AHtGbCuG2fmUX+EzZWlTYftKY4HgkGHjwgKCyAbUq06R+DktAm5B5uT9K59RKkgB1npillF1cDgUZQMthUoXjvCpwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762609216; c=relaxed/simple;
	bh=VzJqVHLJEJbg4leZ+HEE6brhUMsbrS0i7/IHP2c6zkg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZuQ4uCMI5dJdZVUS6LmMdLPm2w8HvTmEqFh9pFlwY08RxG/x3WoNbI9ez3gP4gW+ZvfOn+DBpiVcRhyDp+8PIUxiZ9PTHL+ehO9F/olukgkbdwjoUfJDYqZ2nnYMFOwNbDTX5Eql9n7OIykMRlqj+7lOUJYKHncv5pZ26Nsp2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q5AhuKM2; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q5AhuKM2"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b25e273a8dso42867785a.3
        for <linux-block@vger.kernel.org>; Sat, 08 Nov 2025 05:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762609212; x=1763214012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ghd/ld/RtrgWoEpUX7jRCKlUQzzc8Yiprpw7/fUO0CA=;
        b=Q5AhuKM2N+j0jMPkruY8hrgaLIp3L2nN3tunwkgW5SH5+0+MooyUid6L/y31nxMMnC
         DnzXsIGsdrcG6B9+rJJcfRVuw7AgoT7eEqkpKFWY0+viAqPhfxs/gRKUGm/OeHmuSkuI
         boqNId4Ko7eVsaM9L22Ht1dVjkeUkTLl3pVzBgoYBxZEm5rOoLtfa1HFd74cqRCiBG56
         81L+4eOiKb0XBpIKZN7PsThOAFYmp6GzIfmuZOLaIjcQU5w6tMvzfzIYfVkh5h4AA6wi
         vYZhkgL/R/j3mL4kGXdas2pwVth5YUU+1K8sCEfkJhB6bp/4ymlfGHVZlGHzqlvNZ4Mh
         tuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762609212; x=1763214012;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ghd/ld/RtrgWoEpUX7jRCKlUQzzc8Yiprpw7/fUO0CA=;
        b=mnxS8W1ksw1p9qb7zLm2szz+q5pLDCSiGNp4Xq+BuyBks3mSLQr2eONpmkPujSoDMP
         oBpXhHlQPBHn/mXvnda98JuV2zt1OBaS4v/z9MAc30iP+w54fKSLCPbYngYfifxOfrAw
         dR9eczm5yDUnZhUTnM1e8C+RhsLS8AX2OJnzS2lrdD31vG94sZk1fYDYdSmIw9DGAlol
         2FBtLxvqB24mOqAv5HulyQFVnc/tHLQNtB+EUhCjvoJTG9WyRkRny43PoA610RrhRRoz
         y32ADwsg3cM7lf4KZgj2ITR7XvREoLzZXyfpeHDzJqaYplA/7sgS3tgiFtRM2wcNOFrJ
         KCjA==
X-Gm-Message-State: AOJu0Yze4WMftY8E7rEKAaFyRrTLxGDWYqj76Diw7np4wNvBNQSX9yja
	7TJ3yBAK+dbAhe4BnBi5dRt4p3262VsvHFv6i6HT4byv9JRx+XCj8/T4B+/jz488P9I=
X-Gm-Gg: ASbGnctsmHL/H9ABHFN2L1rsiTYXXhRwWRqL/j2KwVQL3pPbtyewCCTV0qDBG69pYoB
	mnwcbhIjT6GxLDcCKkFrbPMWvEypalMoawxoZV3efRXx7JUItap+atXba4A4WIfiO5lWkL8PYK3
	DUUQcPak4CGKzbnbJuizRrfJBlfKrmAcbsj8PCGoAH7SqSdcJidZ8EIXurTdBb6BfVmcigInwDx
	vbY8dZyKFS528MrKgNlR1fj7dWbLwU6BPtT25apObAPEdx3oK5sXSeEGatzsy+L+ycBH/b73cN8
	IhLYuJp4j2/Ek7cLHPi0UyuxFT14DjfCQucYNXZvJTO+NlwvtOPr6Y/iBgSKT0dzc7kBxV4EVzY
	uOFsDrU9f/ns8J2LAzvhaetw5R+cXZGf/Kx9oXzPBU6XaI88QZjwr9QEzt/kzd0NqUkbbl9uBIu
	razjDJ7osdybfZ0Yjy
X-Google-Smtp-Source: AGHT+IE7901mPN3l2lR6QHNGxnfEp8vN/UEu7mW6GuPxHqTF7pE1OXBkRGjJDXweFnxWIemAIHzkWQ==
X-Received: by 2002:a05:622a:88:b0:4ec:ef09:6b74 with SMTP id d75a77b69052e-4eda4fb0d24mr36342341cf.60.1762609211781;
        Sat, 08 Nov 2025 05:40:11 -0800 (PST)
Received: from [127.0.0.1] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b290eesm14808676d6.34.2025.11.08.05.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 05:40:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: josef@toxicpanda.com, xiubli@redhat.com, 
 Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
 houtao1@huawei.com, linan122@h-partners.com, zhengqixing@huawei.com
In-Reply-To: <20251108070202.1816004-1-zhengqixing@huaweicloud.com>
References: <20251108070202.1816004-1-zhengqixing@huaweicloud.com>
Subject: Re: [PATCH] nbd: defer config put in recv_work
Message-Id: <176260921037.52069.3327906711798432611.b4-ty@kernel.dk>
Date: Sat, 08 Nov 2025 06:40:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 08 Nov 2025 15:02:02 +0800, Zheng Qixing wrote:
> There is one uaf issue in recv_work when running NBD_CLEAR_SOCK and
> NBD_CMD_RECONFIGURE:
>   nbd_genl_connect     // conf_ref=2 (connect and recv_work A)
>   nbd_open	       // conf_ref=3
>   recv_work A done     // conf_ref=2
>   NBD_CLEAR_SOCK       // conf_ref=1
>   nbd_genl_reconfigure // conf_ref=2 (trigger recv_work B)
>   close nbd	       // conf_ref=1
>   recv_work B
>     config_put         // conf_ref=0
>     atomic_dec(&config->recv_threads); -> UAF
> 
> [...]

Applied, thanks!

[1/1] nbd: defer config put in recv_work
      commit: 9517b82d8d422d426a988b213fdd45c6b417b86d

Best regards,
-- 
Jens Axboe



