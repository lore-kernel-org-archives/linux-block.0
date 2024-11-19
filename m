Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684F61465A1
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014296; cv=none; b=GC95usXCLrvwGlBcPyfYnlVydhBKIoDf3ZH5WPCZhK2DIP8TFGESZWN07ghSDBEpSvWBpbJylrjF98SXLp54snjlYrl8/+Sq66XlynJOwPuo7snitkZ8mTIKZbaBYGN2mtBjgzXLg47p1p9HXX1JmejdrZSu2UXGVHQnrlqsmYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014296; c=relaxed/simple;
	bh=HI/XFCVFwmDJ+2jmuxBPQRvCD2yptgzO2BHN6oCb3Dg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ax1kcXSP2yj8kk0ZOP0c8r0loKYHRCTHPXdNhq3KKtS/80Kqxk0cL5EnFGxaUNrmbfXx3Fx5a8RbRV0avjdpheawJZawAKSvQCXfxJknInkymbBdAeeg72zACYApHDEILExBqZAEB/L+vW26vlttA993LXN18LfQf5W+OLJZBGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UnNIYVGc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnNIYVGc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732014293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=CVNQRUfkfoGYcoSAdMe73y6I/zgaSHZvc6n4x9QFnE8=;
	b=UnNIYVGcut6vFi09pVhtepv4dzcrG8/T+tdM7CVeG8HcI08FelJrBokGbzzUVmO8NrD38M
	5mpEYh3dBUO48VQWISqdp2/Ih+1uveVXtF34/1mWd8xva52ASAFJsMygkbMYM6I/g+R/2V
	ztTEtwG/eLn5P8JTa9XxKNdy4wjY1Q4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-_lKYbw07PfGCxbZPbjjrRg-1; Tue, 19 Nov 2024 06:04:51 -0500
X-MC-Unique: _lKYbw07PfGCxbZPbjjrRg-1
X-Mimecast-MFC-AGG-ID: _lKYbw07PfGCxbZPbjjrRg
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2fb51681ac6so28193551fa.1
        for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 03:04:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732014288; x=1732619088;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVNQRUfkfoGYcoSAdMe73y6I/zgaSHZvc6n4x9QFnE8=;
        b=n8Z6KeQ7h7oaKBUJwCxWRde293Ocx8++f87jNqkz41Twkcxo7tuyGoMvyi3yioX5lL
         1mQ1yO3fuCcePBGIaiOoT7QhtBgDB6K7C1yNzc/WaCrFnrJZt1JWH25Fi3Y/FNrzZ3fu
         dlcLQeYWgMzOS1ahC4ZskEM5So61tahcsxvKatHpyEAfwj/XybemepgKRyUiiM6ZLj8/
         u+dSQX7bZ4tmOOWyFQCP4F/jLfuVrHapMRnr99mFc7sbViJyeQnaoT6lq6lSIaC4E1kG
         WW+x0awQhcXoH1cykfHhUMzxvs8Qgh4MNg9NnDYm9a6NXcy/SF7Hmf/s48D2OjytTTOX
         xd4g==
X-Forwarded-Encrypted: i=1; AJvYcCV45fbmUgaN9r8ARgIrnmYAosp628VyBQ/QDuyJykieCJOBsFKxfFuy2aZwGj8rYLpQe/nJ7NpdLcJpwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTgGYtY5XATexdETniewXCh4eZC9sPP2R8jgnpVwhG44kTcJNE
	IRvawyg6KVi3CRUzvqiexJKxmwN6WxJeL4hX2yLOx4qLGgk2ZFp5NbpnhZsHHNJcuO4zPsz0ty3
	pFVc6zsHfgefXmiUnV2Yk0XtNQ2ztq2RMa8wjw78RsdwsWDja0WSPDEKgxjXiveAZWTpv3FPeL0
	FC9Xl9rZX4wwwUJE3WPz1uc1wKR2biA/YhA5H6M87hij0g9Vp9
X-Received: by 2002:a2e:b88f:0:b0:2fa:d464:32d3 with SMTP id 38308e7fff4ca-2ff83bfaa0amr8723521fa.20.1732014288062;
        Tue, 19 Nov 2024 03:04:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEw9hWtRQ36WeUA6tryuJv+7RFXjfeJ3JnkFd26jA+54+oX7BRyjUQCwmTZR/jdqpldtGgNTuRkY8B1R8r3T2s=
X-Received: by 2002:a2e:b88f:0:b0:2fa:d464:32d3 with SMTP id
 38308e7fff4ca-2ff83bfaa0amr8723411fa.20.1732014287557; Tue, 19 Nov 2024
 03:04:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 19 Nov 2024 19:04:35 +0800
Message-ID: <CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com>
Subject: [bug report][regression] blktests nvme/029 failed on latest linux-block/for-next
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"

Hello

CKI recently reported the blktests nvme/029 failed[1] on the
linux-block/for-next, and bisect shows it was introduced from [2],
please help check it and let me know if you need any info/test for it, thanks.

[1]
nvme/029 (tr=loop) (test userspace IO via nvme-cli read/write
interface) [failed]
    runtime    ...  1.568s
    --- tests/nvme/029.out 2024-11-19 08:13:41.379272231 +0000
    +++ /root/blktests/results/nodev_tr_loop/nvme/029.out.bad
2024-11-19 10:55:13.615939542 +0000
    @@ -1,2 +1,8 @@
     Running nvme/029
    +FAIL
    +FAIL
    +FAIL
    +FAIL
    +FAIL
    +FAIL
    ...
    (Run 'diff -u tests/nvme/029.out
/root/blktests/results/nodev_tr_loop/nvme/029.out.bad' to see the
entire diff)
[2]
64a51080eaba (HEAD) nvmet: implement id ns for nvm command set


--
Best Regards,
  Yi Zhang

