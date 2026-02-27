Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE96213254
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772209936; cv=none; b=RjPh5GRoTEm2lk+iodXRCKQunvma50DiC3bYz0ziC4otrzGmWV6Z/yjHykwM9IPHqFPwR+X8uo7xCsE6UaTTmsFZgEnbgQ4Zo9azIeDQ6llhgDikGwYNy6nusKdTBWkO6J9c30YqE1X6REkf/u+oPwZRvbmCzWfn7H3J2Tga0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772209936; c=relaxed/simple;
	bh=/BapDNawBYTPNQtLFvcbjOBiOrdot+WMlSySdPCqGWI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Bi8aYyowhBLv1C0mkn0+oZzckj6tCTOA61S1bE9qISPlwwh8+B2wKrmUmjscHz+aRqGrRr3Flx1z6aFhVG3WoODTRsYOgXe5YBYMP6VLzMxfsN4YEFystirBr0Zvnb65QqvCHQchLFmPfk9eXe68Jw1C6nRQ65yvbG2n4fD8tD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=M5IwV/MY; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="M5IwV/MY"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb40277a8bso234283485a.1
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 08:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772209934; x=1772814734; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iyz+XFmEXxmNg1sViGIlwOnlw1Vth725+nqlUf7cGgI=;
        b=M5IwV/MYCNs2gxI0n4nWpGWrV+171EvFsovOEkxINUPx+UW7oCAI8OTdA91WmO+vN6
         PRAoEC0C/I1QAWYapf8xcjUW6aen/2w6CA7qpnsLK9l6SKLVmaZyrVOq8wtmu7Y7lc3Y
         bRjcnmnEIIrg1zemvZ32J63ZzL4oq97EZWyQz4YUeMMvTjeBMtr3mRAg48zhid4tAo+g
         Nn56DaTERg38ql3NAcvzVpsRJ16afubqbs5wZkkaosei7Y2uLhbcRmd+Pe7LeGDNTCMt
         KqASf3ZGdBR26xI+S8Fge/eEaN4m67MFluStj2WWXg4vdjBnRmIzZ0u3kLEo2V/kAyiU
         qVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772209934; x=1772814734;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iyz+XFmEXxmNg1sViGIlwOnlw1Vth725+nqlUf7cGgI=;
        b=mhP1chwsy745TjuelaOuiCwGoBL8JMsNAFhNes0k4cg1VttHiPkpF//ZUang8rGyvn
         9M7wxiiwBQU8qhKNz9Njm9RItBu9AwVhS7lUaBq7DGTpkyzxVgckj0L0Znzm7p1LPog1
         XZEvzQ7sA9KB5wkkFsS+Zh9pJlds2ThqXTraFaI70/bvQnuLYzAdTT/xq0BO+4yROvYu
         5LVI2xrjyzShf/xkLHAVLGILKAmn68ka8xbAJ+tcH6e4PT60XLbhdVvlXF/XX0lEny+F
         UJwjVO8xYx28XNzbuGLrhygGICD5wQfQT7iMvdrWABAsjpsUW6/GsqGSlXFU2gOwXqXg
         KAgw==
X-Gm-Message-State: AOJu0YxChDnX1P+sL7itXWSkfXlIaQou0N3hrvB5ZVCVjDqtdbAeCXbA
	r8vZRNdeWhUEx08D8OEsL+OcmaEJUz5YVTyEICOkMIktdoNC1ix+aMiXttNTRK9R+Ko=
X-Gm-Gg: ATEYQzzCagxk+TwO7zpoD9yV4US9Wb7Vj/MpKn5rhIsELF23+T4B2uK2R1qiNsSjPN7
	QF3QGsNrT9M3KSxGOwYd0XppMbq4llATO0oQxuqrIFXHbIwMpL//ojwJcRy0MEwIDudtnvSbib3
	ZHmqZQPPfLMua/eC0U2eaXJW38f7O692NYvmnuaC59a+GJw+kGt1JbVcL8n8PQE4iMuD3euB9yR
	4299SmhbDM2mDsYBnQggVycnXGI64lAO/KTaf+50HrISxl0KvZdzLT6S4ql7Pxu9q92VjMK1aus
	o7j4cM2gxoFWiA14JbRs/9p3AclogehBRb04Jkws75MiQKHpDr0N/+ZRLGKDf7BVzL8Y9xSTrNK
	rl2xR7TU9P+Bnx0tyHIkgvbV4YIM+agq1MPJ4Q04VWPOF0H0rq9SoU11DDho/qrvusiE5DSMaC3
	YUxAz80WZx1gwwr8Rjg+LZRgfJePG1+KJz4lmM4q5d/VghxXMUsGVVUqJdtu97hXLn5VxKr+Ler
	E2dy6WniQAvx0uh7s4=
X-Received: by 2002:a05:620a:f05:b0:8cb:fa4:7b45 with SMTP id af79cd13be357-8cbc8e7728cmr391357885a.60.1772209933684;
        Fri, 27 Feb 2026 08:32:13 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf66f325sm503765485a.16.2026.02.27.08.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 08:32:12 -0800 (PST)
Message-ID: <4cdfcc4f-2cf2-44c9-9365-a3babf9a05d1@kernel.dk>
Date: Fri, 27 Feb 2026 09:32:11 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 7.0-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

A few fixes for block that should go into this release. This pull
request contains two sets of fixes, one for drbd, and one for the zoned
loop driver.

Please pull!


  Merge tag 'turbostat-2026.02.14' of git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux (2026-02-17 15:51:14 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.0-20260227

for you to fetch changes up to 3c4617117a2b7682cf037be5e5533e379707f050:

  zloop: check for spurious options passed to remove (2026-02-24 14:50:18 -0700)

----------------------------------------------------------------
block-7.0-20260227

----------------------------------------------------------------
Christoph Böhmwalder (1):
      drbd: fix null-pointer dereference on local read error

Christoph Hellwig (2):
      zloop: advertise a volatile write cache
      zloop: check for spurious options passed to remove

Lars Ellenberg (1):
      drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()

Thorsten Blum (1):
      drbd: Replace deprecated strcpy with strscpy

 drivers/block/drbd/drbd_actlog.c   | 53 +++++++++++++++++---------------------
 drivers/block/drbd/drbd_interval.h |  5 +++-
 drivers/block/drbd/drbd_main.c     | 14 ++++++----
 drivers/block/drbd/drbd_receiver.c |  4 +--
 drivers/block/drbd/drbd_req.c      |  3 ++-
 drivers/block/zloop.c              | 31 +++++++++++++++++-----
 6 files changed, 64 insertions(+), 46 deletions(-)

-- 
Jens Axboe

