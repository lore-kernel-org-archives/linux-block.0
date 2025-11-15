Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A49514A60C
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 02:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174253; cv=none; b=tu0k3LVaALl/Oo+5psa7myHVdKWofEbkk8DQSssamIJvEadcpqi+NMN/4396kGNLi75EGqKwf4rjTXfqVEWewVn+tAtGSPvONB9JRAzWGFGLYdG6oqQbIAYvK6e4pIsC9EdjntqUp4XNxF6+CS4ZrxgiH4ZMRAGJMgU3E9Sl35w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174253; c=relaxed/simple;
	bh=HePIT3yczan3hTWI74USDCto/HNVdgpcjZbVU9ifQog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUiey2uEe3hQ/29uE7rcUbY8Q+iRZSmH/RecTmTwrorLFeTAOFLoRx/gjiazUHHbcJPOE3XihZg4rMSfuZmFKd9on0eN7t3qe7EAY0sfrC2lpq975Nm5eFHzUY7lO+oq4pt4j7d78ZJeOnLxTBEzoO42bg3QYjaAIEdhgY8Pe68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Go55bFZd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Go55bFZd"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29845b06dd2so28240665ad.2
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 18:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763174251; x=1763779051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Medgtts3GbALKGd7rnGlqiSFg3iMYy8R/qbPdHzfI5c=;
        b=Go55bFZdPaL6U/bvbMV8NXxbRF+OvS/yhJLU6ixtAERrBuEXExff2vZMgJJI6cS84k
         9bGFOqTPUa3haop/6DJ1lxE91XGm/XBgvVz+dtzuQc3NjSSLIFU7sC4R9CO5KMnci7hu
         j4ZZwAeDSgTKVVMkw4CnznENYhmHZqZA6fuxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763174251; x=1763779051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Medgtts3GbALKGd7rnGlqiSFg3iMYy8R/qbPdHzfI5c=;
        b=vrq+wd+BLpc1AKT43kaQSanX5SjqhV9jAfDabn8TuBSi3UiPUBeRKKFUXIRBFPKrgO
         LxYYoug9t3gfOewXN5utBSphdw197xcoo5GVRaF6mdzS2DR1SWMp5EUNrqFUq37OjIyh
         jTRzcvz8w2lPWAkFm/u7TS4kAeqBeNFucT/9bMyLc+zQiRlzEH9fjBnhmqrxpNeVeT3u
         HNuE5SERuP/kYbQjt9ms3MJC7yqZX76gzjOz3cs80FH/BvGOz8nXc0reKDiqazLeXY48
         R4u4VhowS/NkUPOVTiVidgG4JAjoedpTBV8s4NeARNtjaaeWbH3opVPu96Eccdo1cuQ4
         sltQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU7oeEPnk41OvLhhQ8TadEPpKYS7rOkiST7Sj/HQ/pYtK/rTngVQmsw9Y2z7Kk40GG0iaAwn5krsFWPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk3sZPHYbslUNaF05VDzfa1F69XG50cniC5naC3SU9J+Q43JJY
	6Zj2YgYXi1u57ImPxis5+gS3xf6hJVEzArh49+4tUbGqpq185p8GJPdh4je3VK61wQ==
X-Gm-Gg: ASbGncswzOucgeZD9ARL2OCqokN0H27nRTOo5dKgy57ZuoZVbfv/tqRojkhn57oveTX
	kXS+6XwLMKmqspuE651lHArC2KF2psWFzlMKaVfQVhbu45OIc7lTeTxaZbeTCJolzWTfZzRHGr+
	06BmbK9ocRSPq7MROTaWyQ38f/E+mppKZUSo2el4n7zRYX5mnKsaajNO6GmvKZ1aL/JVyjSnMdi
	wCIVxNwAM+5hl5MuCTwkKnAVN2w+W3m7izLXc2s3fLuUl0wto1KpOPe3ELO+5ClRUO5qvsFLGp1
	66VGUgADUvgRM6wLklbuAvcr/I6z/NJrIvUCIzRjnG0rkIMH4SvGT8zuLRN0XIC5AJ6uDKffFe5
	MRjMSIlKLCevOLAbFPQqH++vms30H2Ro2Av06QMPY+OpvnMQZGacWLUaYTrttyujg+RVwM6laBA
	ueBpOoLyeU+ChXKFA=
X-Google-Smtp-Source: AGHT+IEZLohcVNFDlEFWacx1LqPJ3ulORLXL0fBBkAiZi5qrk7eL/494WR5aZ7WWOpQhM/vhe3ZEjg==
X-Received: by 2002:a17:903:2a8b:b0:295:4d97:8503 with SMTP id d9443c01a7336-2986a72bf65mr58841065ad.30.1763174251419;
        Fri, 14 Nov 2025 18:37:31 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b069:973b:b865:16a1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346b8sm68715835ad.16.2025.11.14.18.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 18:37:30 -0800 (PST)
Date: Sat, 15 Nov 2025 11:37:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: syzbot <syzbot+16a8410141ca18c0d963@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, minchan@kernel.org, senozhatsky@chromium.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] general protection fault in zcomp_stream_get
Message-ID: <7ousgnpwrsdzbpp7svqzkkvse752pz5djhfl4zxyf2kwwyvoyt@axtbbqp6vnvu>
References: <6917d919.050a0220.3565dc.004b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6917d919.050a0220.3565dc.004b.GAE@google.com>

On (25/11/14 17:36), syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7a0892d2836e Merge tag 'pci-v6.18-fixes-5' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12152914580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=19d831c6d0386a9c
> dashboard link: https://syzkaller.appspot.com/bug?extid=16a8410141ca18c0d963
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.

This will be difficult to understand w/o a reproducer.
I'll try to look at it, but it doesn't make a lot of sense
to me right now: raw_cpu_ptr(comp->stream) should work.
