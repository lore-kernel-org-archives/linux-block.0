Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4020365
	for <linux-block@vger.kernel.org>; Sat, 10 Feb 2024 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524226; cv=none; b=ccKdUEBIrMxXTIbOeQwLmdbml/hEvrfVtIJa+2X/VX3/bHrLQNO+1V6NK0QpPyqxdvsp/Hjb7vhmINXfu4ji6EjaHgWMp3Q5bE7VK2AYNIXzh01Wl7i2GDxkDV1NuMRr9KfgYL5uiVI3+oZosL5rs0WDwzN0y8WsljH7rRN4lL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524226; c=relaxed/simple;
	bh=NpdXnujk8uz7fyDvZkKu93W5CtUqe0+jwrGTxj/TXPw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qhtmUCz15Z4BNaEggbhvDMnh8+cQzwmVAiPBN/HwIvpk4edMphIf06M8rcnoJ1JmnTt1xTHLIRDZc+yJKBGp913nXqa74KUzmLOaNryV9LZuNTEfEY+6HUy9ZhB0RqcG2U7bSCmtizMUzO1jNM5SoFlg8x1BsOxNnfGLeNsZE/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363d7d5821cso12399665ab.3
        for <linux-block@vger.kernel.org>; Fri, 09 Feb 2024 16:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707524224; x=1708129024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ho2u/4j61/FIneEGCKP7KoT1wGfcKHFvYYyBQNKibs=;
        b=Aah4af/Y5HXRAM6XJTqJY7//UkMDMwPeorVcz28lQQT5WegT3JqNaU4Y1PvMuSRI4F
         mID8/BMvztawe0DSLyLMPQBoHABh8hrOmoP8LTAN7AHrfyJj5vnFV8+BexS7BpICPdwI
         kL+JDRtu6kBf16SaBNDzSNIlFqBApeaIdn9BywmpGnZZjm4OZevNSOK/UCxf1DuXOS9C
         QHQWMdHuZjuAoRmsq0Q2fZbFinzeoZVGyL85PmU47CMksvX9ucnGEBZgkYzdUkY2+LMW
         PxBAtZNOHQw/dIrlzZSuIOG6qn0JNQgLruWzQA3/NsUjI8vudSRP4PYdPmzGkCyNgzKm
         At/Q==
X-Gm-Message-State: AOJu0YwZVZmkYF10a7Kkop30QWKGTCPehBLieQkIJVK3AU66Hh9MRwyd
	Qoq3zuXEvDJX9eTcT6FFhFxURhuRnTn3umF7uaKxg4xAMQIdX6hTD+ZOJiiKi5vg4seXjliOM/n
	6tK0eYnlWCy9uxV1nTVzy5xlVzk4wVktt6+0v+2Hm8dUGUsXERfTS9U0=
X-Google-Smtp-Source: AGHT+IHVwO1+Ok3Qs2xKgOA7VWr2yJxR61qKMQapUl1jOQtA/TDgElhaWMT1cLj+MV1sfU9WjvC3v/3ChfrWUnCgOgwH1ugEQChT
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a82:b0:363:c8ba:ea5a with SMTP id
 k2-20020a056e021a8200b00363c8baea5amr48953ilv.6.1707524224116; Fri, 09 Feb
 2024 16:17:04 -0800 (PST)
Date: Fri, 09 Feb 2024 16:17:04 -0800
In-Reply-To: <20240209-notdienst-watscheln-4ca4930cb089@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2f71f0610fbf6d3@google.com>
Subject: Re: [syzbot] [block?] WARNING in bdev_file_open_by_dev
From: syzbot <syzbot+96f61f1ad84e33cee93e@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git@gitlab.com:brauner/linux.git/vfs.super: failed to run ["git" "fetch" "--force" "81e322358ba96b4e95306c1d79b01e0c61095de5" "vfs.super"]: exit status 128
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



Tested on:

commit:         [unknown 
git tree:       git@gitlab.com:brauner/linux.git vfs.super
kernel config:  https://syzkaller.appspot.com/x/.config?x=85aa3388229f9ea9
dashboard link: https://syzkaller.appspot.com/bug?extid=96f61f1ad84e33cee93e
compiler:       

Note: no patches were applied.
