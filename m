Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2F1A7AF6;
	Thu,  3 Oct 2024 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990046; cv=none; b=a1O+25POw5WY57np7G24liLvkdQAIxjv1qNN+dj65EV7ItQdVGghVhuoiRrxGLtx9hZ7Wwi2CCr9leeNhSdmgYo2qMliNI8OW9WzIFdvSG4QYJ8XbL4O9NSqy9t+wvNSweERdkENM89RfSIkjLcKoWZH4udwcsgAqpJDabfLkZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990046; c=relaxed/simple;
	bh=azsOB2pmahUnI+fEcqJQeBQfkC+qKR86a6BpgWEGw7o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aY+yzze73qSEQEvOqfk7Jbr4KWgTzcRfOSad03iT8UWSE3ZFTtf7kubQpxGg05puML2exCASKWCY6Tqe0yIi32S+PMDqi6usHEHColhqz+w56RBhySlzTDyc99BH1uVn45i5jGLmNKNioCBtA+G95+61ZBjviovO9ANDTFrICf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koHtHqal; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koHtHqal"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6dbb24ee34dso12679027b3.2;
        Thu, 03 Oct 2024 14:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727990043; x=1728594843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=azsOB2pmahUnI+fEcqJQeBQfkC+qKR86a6BpgWEGw7o=;
        b=koHtHqaltKH4VzryaD62Qwq/cYfGToSvnceYQeEF72Tgelqd6nJLdHNaXrlx+x03F8
         9uBuMpj0dn6hzc/vXglWP8YhdWrErq9EhZyZ3chf5UCgG1LBZoO8oVcC6R1nETwWQiGd
         cDskTbynfsGaqeyNk1ZSzbafq4gjG7W3uXXY9eo8XsPhN1DRdHlhQtZMmdZEw5rpSMjC
         w1/U6lciswPFRw2ZudsbqkiEQaKXj5wHx4vQFH0OYBA1QGgzJ8dpL9NbFay4AZXuwJjw
         qFTqxwSwL87YImTS+YXlA30sE6AUe+okuLd5AHEsLrc9VFrfTUl0OqRz3wLX14ne+Q4C
         f7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727990043; x=1728594843;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azsOB2pmahUnI+fEcqJQeBQfkC+qKR86a6BpgWEGw7o=;
        b=FvMVlgdGu1jZRvq3agbq6A0EQ9EE0Dp3UTvE97p5QPv4xrxBi+oiJhCq3TIP9pZX+w
         GWQh0RGx9Z7oCiLicRQPHDKg4LSx5w+XLviyoL5fUr/+h3gjKFF2DMVKdUejFQGuAinX
         NqobwfUreM6IbGujvsNLg8J1dkO4IaGo06ooNUIMdPLOoai7YGPnejwEMLZImKHk06r9
         mI3wzfTLijRoS4e8pVZZWtOhr2demPlH0u8fl+19RCuSIsdA6dCsCq8Mami4LY28aHaK
         aAwXDIUpiyNPZHnjmPWJQpMai31cK2bnuhKczFo2Qqf/Orpghem6YvT4sPJfkGTrEUa+
         P0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWX7x5Afibk0n00gd9lAnnHgCYdhWRB0zQSa8VeLILc2VvGv7BwdKwhybt+m8LEpMyUEa0P/ugRIfEt6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQragI+/5cUGXr7LeDAcjkn326AhIwpmvhhIpDpLX1DCNnZ22
	jKpHXUcBtMrmLBYSi9/SbKBjb3VTHm4J1sly3TgC7htQam7fwMd9zDyBEL98360/X3kYvmQwimP
	3Ub3cim0bzIQ7CsfPYhB91mWeX0EcOeLXeLk=
X-Google-Smtp-Source: AGHT+IGcneqJ9ltwhLiMpfZVG0K6YZJ9KUKekp5V92hfQXzHDQTQO5L0v78OARWV5WBQI88UHTe6w66PodJyncuncj4=
X-Received: by 2002:a05:690c:6610:b0:64a:f237:e0b0 with SMTP id
 00721157ae682-6e2c6fc38dcmr6435097b3.5.1727990043470; Thu, 03 Oct 2024
 14:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Leah Rumancik <leah.rumancik@gmail.com>
Date: Thu, 3 Oct 2024 14:13:52 -0700
Message-ID: <CACzhbgTFesCa-tpyCqunUoTw-1P2EJ83zDzrcB4fbMi6nNNwng@mail.gmail.com>
Subject: read regression for dm-snapshot with loopback
To: stable@vger.kernel.org
Cc: axboe@kernel.dk, Christoph Hellwig <hch@lst.de>, bvanassche@acm.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I have been investigating a read performance regression of dm-snapshot
on top of loopback in which the read time for a dd command increased
from 2min to 40min. I bisected the issue to dc5fc361d89 ("block:
attempt direct issue of plug list"). I blktraced before and after this
commit and the main difference I saw was that before this commit, when
the performance was good, there were a lot of IO unplugs on the loop
dev. After this commit, I saw 0 IO unplugs.

On the mainline, I was also able to bisect to a commit which fixed
this issue: 667ea36378cf ("loop: don't set QUEUE_FLAG_NOMERGES"). I
also blktraced before and after this commit, and unsurprisingly, the
main difference was that commit resulted in IO merges whereas
previously there were none being.

I don't totally understand what is going on with the first commit
which introduced the issue but I'd guess some modifying of the plug
list behavior resulted in IO not getting merged/grouped but when we
enabled QUEUE_FLAG_NOMERGES, we were then able to optimize through
this mechanism. Buuuut 2min->40min seems like a huge performance drop
just from merged vs non-merged IO, no? So perhaps it's more
complicated than that...

dc5fc361d89 -> 5.16
667ea36378c -> 6.11

6.6.y and 6.1.y and were both experiencing the performance issue. I
tried porting 667ea36378 to these branches; it applied cleanly and
resolved the issue for both. So perhaps we should consider it for the
stable trees, but it'd be great if someone from the block layer could
chime in with a better idea of what's going on here.

- leah
