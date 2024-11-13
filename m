Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA91F77B6
	for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731489906; cv=none; b=peK6cr3f54naPp5IbCHIP40APynd4fvjM0Wmo4vtP4gdSgMrrLjDgwsz1Gc6t/6YvEK3iOfzKz1vn3EvYGyJrc9TbJWd66+85a/n68JJirRdeZ2UiRX1Tq761dnrZaijhtpq7/CsG8OSGPhBMYnfFsDBDqzHcJOKDCcgMrm3ZdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731489906; c=relaxed/simple;
	bh=e3UrNK+8NPWtavtHg92BvMz6xoPfhy5/J5qU32bVb60=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gaeSWcjVLfZY5rDlKIyO9E265y/lDq1rPw8vl6UQP5gZzr8S80yh2IHzA8Xq40T2Bqf9Kql92oV15W6MsAlDAyKgciRYTFjZsD8IvS6GFdgvFSmXpIFFZWLB6jBFSPzmyxGiGuwrjqdbS06B4CV3tPsJ9qev+7PjMIAk1iWQ7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6f3a08573so59615545ab.3
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 01:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731489904; x=1732094704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayS9w16ckU16tbXa/VPShI2venzkxWB0dzj3Wvipfb0=;
        b=eMuvhYTfuD0o6EOjHwfqtSnqnRab6AGwGH6Qna0K8xTLkjdErEAar6PxD+6yBck2qJ
         ygtqG+PQk1Wk4tX5WHWpEa/Ua6WTvzHlcbQN4B5EHmo/n+cpFyDJzSHB+bLgL/vPnj9p
         lUH+Vd7H5vJB3VQYdpFOI7QiVf/BRo4kxnRV9ntdK1RloZpBaybRyLx7yE/Z3uFp8cn4
         IEB9YVLi1BwYN/tVMBx2RXrYMry2lLPlENJMVZrQ0Uzcsh83v6HH2U09scAm9mrBU4X2
         mv+8uGqrNCm9BJjIMWUPbiPnlRRALEM5GTWAI3XpCJckEHFYB2is9dheq/tG5+ljrT+r
         l/0w==
X-Forwarded-Encrypted: i=1; AJvYcCVSLzeSXZ/ATwwmuIHvrZ5mBd593IX9Yr4EjMkqdYNu6qs2Y7tHBZlHojfCxILj2+4W7FNE1uvMhqS63g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWFi04KLsNTN4jMz6zTCFNbA0/O/pTNhoxpyKrjxQOb5MGCRKO
	FiDEmpVPP4zFxBaG+jZVVKb/yq2kZPtWOBIOCfDlHArtHObvituv3igvIzB1oHNZX6z2d38Dqj+
	lBeGfN1vWdU7T+N5hh9zoXotZu60b24hZstV/LhtsMxIUoktY1Y8d6pQ=
X-Google-Smtp-Source: AGHT+IGuJj1OS2MF+6vk+YiGvRYN6Tf067M2YWDsI74/oewrrtGSF4Ccm7971A7xBXi/M6rdvPHJtthKe8IAJxKXq6PatAIRxB8M
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c03:b0:3a6:bb36:ac3c with SMTP id
 e9e14a558f8ab-3a71577274dmr23393925ab.15.1731489904585; Wed, 13 Nov 2024
 01:25:04 -0800 (PST)
Date: Wed, 13 Nov 2024 01:25:04 -0800
In-Reply-To: <CAFj5m9+j=KNhaRruRZ7p0Nnt6PiqOVQN00vhgcwEgfKji=rJEg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67347070.050a0220.1324f8.0009.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in loop_reconfigure_limits
From: syzbot <syzbot+867b0179d31db9955876@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

security/apparmor/domain.c:695:3: error: expected expression
security/apparmor/domain.c:697:3: error: use of undeclared identifier 'new_profile'
security/apparmor/domain.c:699:8: error: use of undeclared identifier 'new_profile'
security/apparmor/domain.c:704:11: error: use of undeclared identifier 'new_profile'


Tested on:

commit:         bd05b9a7 Add linux-next specific files for 20241113
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
dashboard link: https://syzkaller.appspot.com/bug?extid=867b0179d31db9955876
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
