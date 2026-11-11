Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794372363;
	b=yxhGUhtWVUiezX/vZ7B+wC0g4XPAvkAUUtjjPn9k5B4FiMyTEZX2rLTwEJLa3whksYi0
	 uEhfWvF0QFlx+saMUtJZV+imgtb11xmlZ692XDS6FxB2kcDQB765RbK3/dQWvyS46dQpI
	 Q6F3wdQCT0dLRj0fAC4zdpFf5WIvH6neNf0eD2U5eYxCXMw110weCIoa/C3byfcEBLP9B
	 SaIrUqqCVgx7OOj7RexJBM8ENR06Wr4krcqkmIvmzmXOXCp3Z5GXPR6sDUD46vOEdHEL/
	 vYNFIkhu3QqHlV8jAgzl+ZW5iTauBzFhoqRxSyhF0R1BZredoDxQ5pwtqDTtYUWAlPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372363;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=tc06brEby95ail1F4lHOJFrAbzbjGxWAEQqRmICG19U=;
	b=lCgiZWEtzWhMMN+ecURtIDc8cXTpW3+qDqwaAeLgrMGRsX1Sci3uU1JlvmY+BNmNpMoI
	 EfeGDuguyj0RnO5baIciw+5/2bkE3d9OOs/LLuTllx/b8rPcbcQiGlwKaHXZizTJsT7BO
	 idSdjpyq2GKKDVaT+q9UxmG6k6ASG55dVjyBz2/CP0MDlWpA0PGQhSkIrVd4d6HUZdY2K
	 Vz79Ljl0uWEkN0b+Zq20tr7HZ2UpyXx7xCGuvb0KdszMpWMBUAoRX9TPEtr4VHxOOdeyt
	 crW1irfmkTzkZzECyg4R/DG71sfqIpyM5IP/SBMc36JO6D82sj6JY5rdSgEhF3+peAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCC360A3813
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 04:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FCC360A3813
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-847e2926d94so5590766a34.0
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 20:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794372362; x=1794977162;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tc06brEby95ail1F4lHOJFrAbzbjGxWAEQqRmICG19U=;
        b=Y+BYsi89IWpaMeSUnNz9ucTP/l9CgFcbd1dCi1s874RcUTTT+lLhQcDmk0NP50NlI2
         sdQP3TfZh92d3EVeD9M2Ye5gb+TbVbftPsRlVLnMaGPzbP8EQdzd0btYcsvkNbV5NAVZ
         eQ+gnGlim+3677l1gdwJJ2Zwu70z8az9SbWJNqZOQ02vamjF4p64r42SW3EkRKHgr3Lv
         AcY0r53FGAgmB/EU3ma0/fpZiN0Xr/tc53I/RgYdLtSo+KNN8TyffotEF4lZn/4c2W2/
         srBTpHULMTsUw5xpTwYLT22oZmd9efTvsKZEx3MQvwr7ryWMfEMlGhZSt4LUQQw7npF3
         RDPw==
X-Forwarded-Encrypted: i=1; AL+hErFstgP2zVxgTE5eSlhBKpily63Qe5om32VDA++uRBE5l53VZqCyFbiGbkg1JvA29xHST0ZugRTW6VR3yQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z++ZDpHK0YPG9jhfppoj8xyMG0RmJdJaYAhJSvIBYkEx7MAgcqU
	I244Oo7K6ArNN64NkA6KsBklmA3s0FFvmh0yiYN4QcV1GoFFoJMrH+FK5+5a2kc65ul9ACewZWq
	qdKcBSTAFnHnFsmlI97P1IGC50GxHiI8YLMbCVu1UUD9+hF2FqvO9hp6hfPM=
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c123:b0:4f1:a873:6efc with SMTP id
 5614622812f47-56b98c19490mr1069217b6e.64.1794372362344; Tue, 10 Nov 2026
 20:46:02 -0800 (PST)
Date: Tue, 10 Nov 2026 20:46:02 -0800
In-Reply-To: <20261111032743.549426-1-diasyzhangqing@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af3f30a.926a6ce0.263fd.0199.GAE@google.com>
Subject: Re: [syzbot] [block?] [ext4?] INFO: task hung in bdev_freeze
From: syzbot <syzbot+d4ecb9a1e5b3dcf8baec@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, diasyzhang@tencent.com, 
	diasyzhangqing@gmail.com, jack@suse.cz, libaokun@linux.alibaba.com, 
	linux-block@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, ritesh.list@gmail.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master: failed to run ["git" "-c" "core.hooksPath=/dev/null" "fetch" "--force" "f569e972c8e9057ee9c286220c83a480ebf30cc5" "master"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a58b6b4d667e7a61
dashboard link: https://syzkaller.appspot.com/bug?extid=d4ecb9a1e5b3dcf8baec
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f58b69580000

