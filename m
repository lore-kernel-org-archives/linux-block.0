Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB0228DB76
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586427; cv=none; b=guixziN6GujJiE6bbCwT0LWYf/737DI9z3DrHMnoz39W7igVu088dNyeqbBAPyL5NveZcgTB4+njEHXxg9gWzyh27rQqEShAU0xmH4aP4R7Sjf5vFaPuecUx5AMut4J+44ojPOU5WI+RK9P2tNfx7jo07XcUfmj8cKwnrCw34l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586427; c=relaxed/simple;
	bh=uex1c0ds+Zb4bDl7CTGX6d0B+XBnvSYsgkuD3L+8il8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hGFA7SuJfFMl/y/fZso2flSNhsUuUHTN8RKIeyFdg3fhkQyWdpmca9Hs9yYBEVcuhHaiEAcxk+63BAUPNW7nyjlmChcqCm+cK9t/yHsGf4M0Fez7YHpuPaZvfR+yrnVuS49jDQlFzHlTsEeKcaLt2i9EAeI8l5HcWl7PZ4URXs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-433270dad0dso16044435ab.0
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 13:07:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763586425; x=1764191225;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRvpK56UBvkhdyQ+HckP/WuQAeXo2E2UVLdewv7SW1g=;
        b=UxyFTp02nAVNSLZrjnbIfo6D/IctuJVs0zUFtOX6EDc+V32UzG/4thMKD0cL//UBi1
         2bn5bmEioA/NmPwBsxWiKyw/NLVfQV665paUWnYeiLhzrGZYpSVapNL2X7Vnz1NJjhiY
         kiTH61+7WZcS5cI1ksgyv7dABaostQjy6HGpyu9OgaArmt5EK2nvf9PIqncGxIOYw2UD
         IicBgCdyb8iJx+67Cw1gVfTBnCP8lX5ZGbKn/0SjGyILkYBhBKx7J++nUB9k8GV+VT4X
         ktoPb+XvcblkRlHIA3iVT7HiO8SHNwOgv+NhPp3um50YsPWDGsGQAuD+l+hwaMnlAXSI
         Bd6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpqrd9XMsHToCs2f1XVJhXFu6SthSLfChGIsHrkHlsBWnEYz53C0vlkzu/QAkRkdJyH1Clr1pUO78OmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgD6LdF8EKQJWKaloaNYVq1GDqENZaRPc+lAQ0Q/dEyVpIySGB
	DkCDvoFWI32V9mogQWEfncVUPdVhISbsNkiIycx47sWYU3VYZ+owD5idr/WWpRjnxMMKKv2xaco
	qdYWttl5hpwZ2P8SjmI3oljgiGXgwQP74zisvfyCSnLFoOJJ+YqgsdAotpFU=
X-Google-Smtp-Source: AGHT+IG01cTXVrrAxKN9f9Sl/toaKpeVdekFlawBxvO/He9h25fLOHaTk30d+k8jvbyMThJml+AgHv4G4UDwZrlQM70du6QnPAe1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1523:b0:434:96ea:ca18 with SMTP id
 e9e14a558f8ab-435a9653b58mr5749135ab.16.1763586425494; Wed, 19 Nov 2025
 13:07:05 -0800 (PST)
Date: Wed, 19 Nov 2025 13:07:05 -0800
In-Reply-To: <b19fc9a6-61e3-4c1e-8272-ea63f0d074ae@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691e3179.a70a0220.d98e3.001c.GAE@google.com>
Subject: Re: [syzbot] [block?] KMSAN: kernel-infoleak in filemap_read
From: syzbot <syzbot+905d785c4923bea2c1db@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ssranevjti@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+905d785c4923bea2c1db@syzkaller.appspotmail.com
Tested-by: syzbot+905d785c4923bea2c1db@syzkaller.appspotmail.com

Tested on:

commit:         23cb64fb Merge tag 'soc-fixes-6.18-3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15de1b32580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f874b4f2cfd4b87
dashboard link: https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a25658580000

Note: testing is done by a robot and is best-effort only.
