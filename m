Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0546727FD59
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869285; cv=none; b=F0TFnrtNRFzkFEHArdQQeftHbEvtFPqMSwsTr9IF8OXma48Mj8e5dV9MbcziaKAKYip03BP4q6ARDoa2/kc9RZC2MrhqhPSd8JBL3vvNfuVyw+LocLVAInwC0FOY8F0B6wcjn0rN8Rd3Mxd0qcmwsgrxjpDeAD2oHytJ0Clvq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869285; c=relaxed/simple;
	bh=X1J9JFfrl6Va9rGwEZpEAcfvoR7nNJU9J6zUJwJpRWQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Marvwo6gvVF23a+dxaNyPck09mFlTpwVXch1xWyZ77LS0tmT+1yXLJOqQrocVYd83GFV9YYACtcn56ABsv3p9i2tEA0jivC9JI/qGjH6gdMuM+NOLCoFmEsf0UFzJkc1Fve5K7MB1k+CYFBa1Tk4sq1oMc6aIfcaMao4JeSxPFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-45033344baeso2575120b6e.1
        for <linux-block@vger.kernel.org>; Thu, 04 Dec 2025 09:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764869283; x=1765474083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eg88QLnpbQGqCmDqs8aHwn8d8fh+Yxp19+KXKS3AaQU=;
        b=hT/NWc3z+H2amW+QBUnDPmhT/XeY4lh5y8bxeg/UUhLuxX3LP8fbysSekotlvS9T/Y
         rjwn6Jc5DxB039hVldGzhrgVGStDh9WQlhjtdw35pJJuArRVQF0Fz4xm6dLMH/9g2Dla
         u6ckP9kXz4yrNsbtRA371TjJ7ywQOBENK1+nyCYkoELaw7FSxcYzU9kbN9CBjDZtCtvX
         opJwgDkE7J0DsJD/md8js7UJfSuJ17d/iLNyQf8jLkmCRFM+hk7Qz4Y7TGxp6DcB5j9M
         dP/CGI6OjZY3Y+hC9HYFdx9VSNDS4DDox/31CQc8Pq/gmnFEk2R2rKhTG9Rg2NjAggcy
         IgHw==
X-Gm-Message-State: AOJu0YyHbeO8E00Hdgp1Q9ibsO2XJWW3wMAbQ+4ysYUuXxhV9/lz2Zee
	zci/Aj+STctjgYpbSDeio9gbTtrYIi624giFJjh8drilJ59YaCIFdD0pFC3yh0iocHJWyo1zavD
	/16IWZu7ay1aic1YnmHfhxhQMS2qJIx2qzVVLS1LwwoNyZxs09qQ2rvVOI8Y=
X-Google-Smtp-Source: AGHT+IEp5P2A/cN1vti5GA8ZDFc89JmA/iG6HXO876ErJESnVci6BYb3eFuYV2Jb9bwv1THxhQUrRoDImxERS/swe4E3w9hVeqph
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6a94:b0:450:bcc7:18d7 with SMTP id
 5614622812f47-4536e391ff0mr4105903b6e.2.1764869283224; Thu, 04 Dec 2025
 09:28:03 -0800 (PST)
Date: Thu, 04 Dec 2025 09:28:03 -0800
In-Reply-To: <23fde58b-ef8f-4420-b0a8-5ae87dfe0bc4@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6931c4a3.a70a0220.d98e3.01d9.GAE@google.com>
Subject: Re: [syzbot] [block?] [udf?] memory leak in __blkdev_issue_zero_pages
From: syzbot <syzbot+527a7e48a3d3d315d862@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ssranevjti@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+527a7e48a3d3d315d862@syzkaller.appspotmail.com
Tested-by: syzbot+527a7e48a3d3d315d862@syzkaller.appspotmail.com

Tested on:

commit:         559e608c Merge tag 'ntfs3_for_6.19' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1787eab4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bdbe6509b080086
dashboard link: https://syzkaller.appspot.com/bug?extid=527a7e48a3d3d315d862
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f2301a580000

Note: testing is done by a robot and is best-effort only.
