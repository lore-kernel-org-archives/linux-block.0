Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EDE1ABEAF
	for <linux-block@vger.kernel.org>; Fri,  2 Aug 2024 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722627462; cv=none; b=hq4uyk6qNZi7j9BeBco4seWpvHsjAJVv4UtxpxWCtU46xEW4y3CLubdFLlIjw9YiT+n3bF1Ul7kFp3WGag93Ss80/UqoNkJEGcZwxXVMVaemZsAvXspf5caYThfQuUTpeCCbhjqpU2plP4CKYBsxz3rKZXALR7SddphPG2e380A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722627462; c=relaxed/simple;
	bh=CV4GXsYsfgo4q6hKJxBuFlLUCtWcIZ6hQ16Fz+Sbo4k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kTAFj/aGIUOIkAELOAhfwL04HWjOy9Pt/JNMLL3c0E9awVZrzSSbRb+odPZn9Xjt/TsMaDEmg8POPJ+BxEKxbA4p9ScN0W3CzSKQWJ2DcLYWRr/TBpQmu4i4sFjGBHINFVGUFUP98E4ZZYuSSI2AfJzISyWpop5C8Iby5/nCOKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lfvmRb15; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lfvmRb15"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39b26410e0cso540375ab.1
        for <linux-block@vger.kernel.org>; Fri, 02 Aug 2024 12:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722627460; x=1723232260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aq0OPmiAfzDwBhbEkdc5d+5HiIl+Llio3iq8YdlnX14=;
        b=lfvmRb15Yoch4WtjVBrNK2iXfM/nrtA568MImD+etDI3CSkQvjs0LEkggzbO1Z+veN
         WGyBRtZY0Jc1b0YC84MA1mPkdkb5K+HUdacqq1KY1mpp4I0DJ1RTyli1fw5aV9mPYjUn
         zcCMNS6WYhavncVEjkip6hwGopM3BbSAUDj+/AfdJ7Sh4X3xcZuo1evye3AqKpC4/0pY
         Xs0E713zp+8Wvn92Tm6jElT+EnbNXkEwcfOiYLY3uAOUcZS08HWj7snG4UXceELnle1Y
         e6lsCIGN59pJEOJE01U4mZy7WmCVUnhyugl15FA+UvfHkZLW/MbLEL7CaBrwp1c+72nk
         R2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722627460; x=1723232260;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aq0OPmiAfzDwBhbEkdc5d+5HiIl+Llio3iq8YdlnX14=;
        b=hWVS36DpXb1utC/FolgCQobFXbrofjGudDuHO+dLHbDl0vLv8w1HPblWtrXmM9wzGg
         0ywBzi/Sn0AA36eGlLwHC6hd0q7vurrT4VpZ0IqPLj6ibNWEBqmVQGczt1X0bOLSJUK2
         UgjfON/FMIXD8NniFeapj2zaL0z6krkI4o+deQE6gppIbAem4p1XDmOhyl6NmgreDR7S
         RCy7qAoxXkz+J52Ggy0TYITJpp/YbIzs9dJ3lcnoy34zR+k+UbELR92/5jU5d9jS3Bum
         +P+ln8zlCEVzc1wdS1DW+qcceqfoj0lQhYDLrW7+pprb7MQA4v4qN8U+LNBaiNZs2jvY
         NFRA==
X-Forwarded-Encrypted: i=1; AJvYcCWlp/VLZXjSfVvBt8ZrHyz1Cpd/YRlWzCa5zBtGrEBempgZmtdZTrV6xnxJU5xRryc2Dc9mikXBUnDCsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN5DU4W0gYVQPYj7RFTKjY2O0w7RRqfIY7Bkg58m0B9sfhpWRf
	gcxpEwDDMULUyUIBVCf3XuFkLEMpoV+n+9sWT3hP/k7vEjIUwb67rEDuaxopIPI=
X-Google-Smtp-Source: AGHT+IF38B2WBsg1Z9PGLO03sa2FOioYxYdCZ030WghdBOYn5rYnHGGG2VBaYVKz14EzsjdIgN7zTA==
X-Received: by 2002:a05:6e02:1c21:b0:383:297a:bdfb with SMTP id e9e14a558f8ab-39b1fb736eemr34987515ab.2.1722627460233;
        Fri, 02 Aug 2024 12:37:40 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b209d833esm9710825ab.0.2024.08.02.12.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:37:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
 christoph.boehmwalder@linbit.com, brauner@kernel.org, 
 Yue Haibing <yuehaibing@huawei.com>
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802095147.2788218-1-yuehaibing@huawei.com>
References: <20240802095147.2788218-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] drbd: Remove unused extern declarations
Message-Id: <172262745942.170878.5478919565358638351.b4-ty@kernel.dk>
Date: Fri, 02 Aug 2024 13:37:39 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 02 Aug 2024 17:51:47 +0800, Yue Haibing wrote:
> Commit b411b3637fa7 ("The DRBD driver") declared but never implemented
> drbd_read_remote(), is_valid_ar_handle() and drbd_set_recv_tcq().
> And commit 668700b40a7c ("drbd: Create a dedicated workqueue for sending acks on the control connection")
> never implemented drbd_send_ping_wf().
> 
> Commit 2451fc3b2bd3 ("drbd: Removed the BIO_RW_BARRIER support form the receiver/epoch code")
> leave w_e_reissue() declaration unused.
> 
> [...]

Applied, thanks!

[1/1] drbd: Remove unused extern declarations
      commit: f48ada402d2f1e46fa241bcc6725bdde70725e15

Best regards,
-- 
Jens Axboe



