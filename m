Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EE6194AC7;
	Mon, 25 Nov 2024 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549502; cv=none; b=uhBtQtswvUSD8X786x6gciRK8VkFCGxliLWghNsZWPTHDPjiPWt1xC9X34ZVom1iFsbKfnlWMMMFdkflti+I8nC0g5/IQMvgT9Nf6Er/w/bDq0Yav04i+bG42JyXiDlrOLMp5oAaoLVimy90xfM+eIw5/IhvndiVl46y2m5qyVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549502; c=relaxed/simple;
	bh=dW01jml7QuWrxNse+HQfxhBK/wVmoY2rFUAU8U6VDcM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iiAh3xchsWDr1desKY0VT6ckB/SF8oZqX3OjyoHwXeUEIAzEWT/3VyISJku9Kt1RNujwNtoTTzE0+FsEG1Nnr/wzHTRESGSCgR9YauCn7m0GMy/J89XHdDAt92us+WkQnnFlBraN6q/+l1MyEWIyU5yMn1Yi5Cv0K6J/v+v0jkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fk5KrdNO; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk5KrdNO"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e382e549918so3829733276.2;
        Mon, 25 Nov 2024 07:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732549499; x=1733154299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oqwKGtah5W5RVxkR4Dn4jwhHuGxuiGBlO24hxYbYMms=;
        b=Fk5KrdNO3s3zo0Hxp55nXQoG8b//DkmzFvsf/uGtDp2Uvq11yCWguD4SqOP0Z6IPg0
         0Ji0MB8CyjfUesvGAYHZe7XZH8Ygy8ywF5CVZe64JmY8UAHKR5AGNizIRJejWqObBJ+e
         zBlxCszSR8annoWwqpsGQrSP3vsGt6Ig01n9DDZtcclQLylO03RQZbWI2zXGBMA9uJ3s
         cnUVReRkKNSkbsHa1Uj0ktd0X0XYwKL+ao3AQvW/kVFnwIhPiLMju/SptpW/6C0ceNe7
         EdyYJ4kSYLhgHa9vjFPg3x/M/kgiWQux3R0JNJxPfbzhD1qAZ7pxIy38Rd7nGdZwPm79
         xbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732549499; x=1733154299;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oqwKGtah5W5RVxkR4Dn4jwhHuGxuiGBlO24hxYbYMms=;
        b=eF9veb3eZhtNiGjmtlEQ/peQ+9eAoIg52jaKrz5S238FF6WG1XnsAK4bWdAWLzgela
         cTXYAB5qbTWwraVFICM8PA/ez3zq7ht4g8DpBQtkzSx8Ogu2ywdcrCJYc278HSFi3rE8
         YHvanaKklfeLMLYwEFh/eey2NDfIW4UIeKnlKaaBOErNUbkE6XGa7IWpAU3M9Cvn6c6p
         nB/IQibnTq1lFKagm7k9B/ZNhWTeAJB0qamFWeOsbXNzW8771Qwp+DOdGB/5C2UjeEza
         PYXPaAQpu4rW/TVFoO8oi4C/VlrZAoHLb0BIWBqJoLkuxtKum0+6WEPt1BQxJvhfeZ5K
         t/3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUweC/BwVDr2Lt6dCZPaJcVN1ry8CnaK6fzSI+6nSd7VFh/DpexCsSI1rYClsV0gyjAI4Y+J76CJtPOhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwD2kaGbiQt8Ib+03iLVB9gRbXLBPUNrWxLiaKQhCSXeNLv9x/F
	OFHEx5E8kfRiDrvgvYCwa8d0SvMLoqat6PTnV7Oe5RuofZbXmcocJXqmEQFuMUqQaBYfOr8UaHn
	lLALsPhsBw7KqHZI2bFSjr4MkrVc=
X-Gm-Gg: ASbGncvqxpLLSiZUY5fyMUXOmvl6TettTFPB+6jh+uqrGMBTMtEaLgoWrLmHSzT5a1u
	AePWQlGWMo4JwIp4VDkKT0tUt18Z/5Dg=
X-Google-Smtp-Source: AGHT+IF9w80ymL9NIEhURejFa82SLeJNTGDITpMHHMzFaSEyToD7nbmJEx/5xHyO/BxkrCQ6GTzUrBETxacbkqjx8zY=
X-Received: by 2002:a05:6902:1681:b0:e38:bcdf:c4ea with SMTP id
 3f1490d57ef6-e38f8b5435amr12294787276.28.1732549499689; Mon, 25 Nov 2024
 07:44:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Mon, 25 Nov 2024 15:44:49 +0000
Message-ID: <CAP-bSRbCo7=wfUBZ8H7c3Q-7XSG+SB=R4MHHNNGPvBoinsVSZg@mail.gmail.com>
Subject: [REGRESSION] ioprio performance hangs, bisected
To: hch@lst.de
Cc: LKML <linux-kernel@vger.kernel.org>, axboe@kernel.dk, bvanassche@acm.org, 
	Linux regressions mailing list <regressions@lists.linux.dev>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The commit 6975c1a486a4 ("block: remove the ioprio field from struct
request") appears to have introduced a performance regression. Test
case is the script /etc/cron.daily/locate from package `locate` (which
is from findutils locate on Debian). The script runs:

  ionice -c 3 -p 3965
  nice -n 10 updatedb.findutils

This locate script will usually complete in about 1m20s on my machine.
But, following commit 6975c1a486a4, the script doesn't seem to
complete in a reasonable time (I waited 20 minutes). `top` shows that
no or little CPU time seems to be dedicated to the find process. Also
it seems that this affects other processes too - once find is in a
"hung" state, doing `ls -R` on the affected drive will also hang, even
though the priority of the terminal/bash/ls process hasn't changed,
and is supposedly independent of the locate/find script. I'm running
btrfs, on an external USB SSD drive.

#regzbot introduced: 6975c1a486a40446b5bc77a89d9c520f8296fd08
