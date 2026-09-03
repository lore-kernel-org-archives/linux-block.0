Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1418B378838
	for <linux-block@vger.kernel.org>; Thu,  3 Sep 2026 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457301; cv=none; b=tGbE48jf1Mybp2qiFWXoB1vxNLPJHkB1uzM3sUFadjzr+VK8rU+0LcT0NozTEjefTCahP+v/2j3hu0vbjyPhNV3w/vYeKQGhdqjeJO05NdGemyU+DGxzTsnUCJELFM4bDvSKwcFgt5SlaQHn0FLXy6YKobw0FPNUo3KHR4xaXCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457301; c=relaxed/simple;
	bh=pWSElYc8vth469p/p45Q3vrajNYvKALRapQG0DOJD5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDc6YQm5FVLlCAfgo9NKYIe1iFoexVJhVo8riARmKaJzrfkcwrGCP757uqHuzEdXVGI8lWOIXMYIY3OYm9csu097nU3Pt7NvIMNKg9ZvMoi/CadmRROqCBotl4M5QLJFFqJZkBt+7DKubyq9fWOrW/88AdEQdIbQKtV2kk3Z7Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VW0pjsgA; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VW0pjsgA"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6b1c75f0049so60764eaf.3
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2026 10:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788457299; x=1789062099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ykwTaa6ygXsfYqfQ8E8HUJuFa56MBU+sp0H1tR5irQM=;
        b=VW0pjsgAhOnEXoABdJX0LSb+sMnJDPixNllCbrjJD3bhhkzVdNRHRjyM1jfBc3LC1i
         DHfmAzoJiJ0nrxX/W6glocopx6Of4VNS+MQlUSJUkDSYF0yfuXyscS95/FJ20eITF9/e
         XjUU3dm4Srj6zHaxx0hKVhLQ3liXe4lpKyD5GSVles3RR6NUc+H+jRFZH65s+xw86r3p
         RkIlFqGZSaqjS4crqChPYj3NJ819/1yScIsOEhRLIIev8pXLeF7w0hDCfL8LdPYDpPNo
         Bau6wQhsM6ZHCuPaKKLuiITvUc7hXh1490Hlacq1rmcZIzSgid2ShitqkhaynLQp0rFE
         0wJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788457299; x=1789062099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ykwTaa6ygXsfYqfQ8E8HUJuFa56MBU+sp0H1tR5irQM=;
        b=eYEKFbcSWR/GSbov6Gdpi8Dc71I5Vaq6xzrHl6c07VLZQlU4o1uTw0rKLl3bznAwxv
         29PkqencOOwDDVaNkEDO4FJl9YZwrRKPoZqFdYk8T+wQMl8pfUhNcKB6vv9ieacW9Ba/
         AalRiORh1PudtkrlqgcQuSQ4ywbbBfCQGTDBVOS3h0agOHxoacypSMClZec9oY8rAGL/
         CQGgWsatBW3pVk9wKpIlCTXoG5GtAt2gZXDkmI7oGzYthBixlj5V4gukjEN5rRrEsrFe
         s7INm+s6RDF99Z/P0AxaNPQTfIqcabQHzT78Krnn6G1ezfbFKihC/GTMHpFUd50fjO9P
         ncRQ==
X-Gm-Message-State: AFuF++lRd1QS+AV0Ry8mZ8jpa8Q2BkjhqVI8sQv6iQEO66mPPdqltwNJ
	cCkUFkgjhcIp49H1nb/PejtuiErNZl4iJN52Fkzet0iC+Wheqfg5IpQQk8CPya/VfflZaw==
X-Gm-Gg: AYBFou2I7nfzjBpDeFf+zpxhWvwsO/YY/850bYDIQO7lU1p+8Dy5iDEq3gmQOZCyRcf
	EyaSyGlbd2/0no60yPw2Oec+tl7HwGf/ZKJVjHhBMMGbgLqztFEFZrlcgL0T1DusfOpJeONUH+g
	serRA7na+lVOqlIS1yl3rimg3bIfu+P6kg3JhWOR/3Kpn5koVfUoTH3FmUv0CSRjM8k88Jjg+CS
	UGWlVNPSh2snqzlfZJa2HTOXDwqgJhCmO+TRKIABKEl+CuEnFbkfyzRNTqXeMsspokhX+G9UXfS
	pPOmWKODqoBx93zerULph0EVDcjJy7SEDxb8npAstaR0h64nncJEFt3bla82XkxSCHrSU8mHoKu
	Uqaz4QCGGt6LktzvV8mVZCge1rrspDkwPtB4kNNWWwjyxopN2PkQ5qCsqPnEnCGjG1vjYW12y0T
	HWYnTvsYCY6L7xv3+lKSTgEvcnJU77pWXlYzTdvE9f2jh/EDAucDrhCXbivw==
X-Received: by 2002:a05:6820:1524:b0:6ae:a950:9fb4 with SMTP id 006d021491bc7-6b6fe0b8574mr263503eaf.33.1788457298656;
        Thu, 03 Sep 2026 10:41:38 -0700 (PDT)
Received: from debian.lan ([172.245.89.240])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6de522bb0sm568133eaf.13.2026.09.03.10.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 10:41:38 -0700 (PDT)
From: Maks <mi9992828@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: block: zero logical block size leads to infinite loop in set_init_blocksize()
Date: Thu,  3 Sep 2026 20:41:24 +0300
Message-ID: <20260903174124.51009-1-mi9992828@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I hit a soft lockup in set_init_blocksize() with a block device whose
logical_block_size was zero.

I understand that logical_block_size == 0 violates the block layer
contract and that the driver which allowed this value needs to be fixed.

However, the generic block code currently turns this invariant violation
into a non-terminating loop:

while (bsize < PAGE_SIZE) {
    if (size & bsize)
        break;
    bsize <<= 1;
}

With bsize == 0, the value never changes.

In my case this resulted in:

watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [(udev-worker):...]
RIP: set_init_blocksize+0x28/0x60

Call Trace:
  blkdev_get_whole+...
  bdev_open+...

Is this considered acceptable behavior for a broken driver, or should
the generic block layer defensively detect this case and fail the open
instead of spinning indefinitely?

If adding such a check is considered worthwhile, I can prepare a patch.

Thanks,
Maks
