Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD9B768EA
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131325; cv=none; b=Piw0aXyZzJYf7ToRRbWqIxJyPojbUdLECYT75H76I9K2tvkxQtbd0tMLLrRjE+aAneUgTe66GP993Og+WB4TOzA6PiEKlrVzea7ETvDHYVK6Lhgqc6WCtPIEwyl0BO8i3CKl81yvfhp5NijFrlAVJVhAulzISQhdQx6jGfL0gEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131325; c=relaxed/simple;
	bh=SKZBPJWI/xxIhV4ugicProuWlf6hIcTeR3Yci9Qh/7M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=WsqxgFm8VrD4SJ58jcVLPMZV6QNo2ZoH4KRTTAH7UaLX2rZYQFKT4j/KfwX6PRtu3Up5glVxqAFO4zZyR8hNbY6UFxiJCz0iJWq/v0zCWN1RpbqGHeI8OiEvIjg/wxYQbKbJdkSlFpnnO9Eb6wDjiSf24gkw3o8VV83nWqyVZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e9e0e71e05so2551069a34.2
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 09:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784131323; x=1784736123;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SKZBPJWI/xxIhV4ugicProuWlf6hIcTeR3Yci9Qh/7M=;
        b=dfTShNIRFKnm2LoRxsQIfdzp4q53Odir6to3ctpJKLMt45Zrsnnl+7rcopaY6WE/BH
         Aa4AyTIdmpB5YcwtC3dpt/pwWoUYwpYBrDVaYHzw9upAcSRHqUBXkQUvZf0QdZkABfPj
         WEZs8n/sPjNb1VrKKkgfoP57TZQcNDhzXpzeX9jvTcHE3lZX9Z/8qt1/XlopWJ2G9dOZ
         gbcV9XRm7BXhFMoBBJLKhFZ5cV4hR4ZSHxL/NVJ4mmdagph6E0Q2NtV0esPJAC0frYN5
         B1EVt5ETaF00KBvjMOAZmAEh4jetNMtLMdosq4yuBiaIuW6aiYwSv3Tbu/LFuOGF+4zA
         7+Vw==
X-Forwarded-Encrypted: i=1; AHgh+Rrw4eQ9gSLRnaOiE0vmbyv4H23/aWsEfkBz15FHSId5arBgMnQUAZvpUal9xc31UmVFSDDbuMhpWQfCgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwacTq+NFMfS9mhZ9ZpgzP52vYONpnDjnAIqxIHd8sHhwXzaTB6
	mhMU+73V8OZwYw/Z5TIzjMQdh7DDy20luL52v55fT9gwcrTN913e475c1WJnFIFP1SGJk2CyjSI
	mQ1fEx3qY6OadYcdv3PJKoFPORBFu2NWgtX9flye35k4qLgBul3j5a0pIrJI=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:61c3:b0:7e9:b4d1:78ab with SMTP id
 46e09a7af769-7ec0980222emr10314811a34.25.1784131323163; Wed, 15 Jul 2026
 09:02:03 -0700 (PDT)
Date: Wed, 15 Jul 2026 09:02:03 -0700
In-Reply-To: <e1f2d5d3-6974-4294-a459-89a5f6c360a9@acm.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a57aefb.9d83364e.246513.0006.GAE@google.com>
Subject: Re: [syzbot] [block?] general protection fault in lo_rw_aio
From: syzbot <syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com>
To: bvanassche@acm.org
Cc: axboe@kernel.dk, bvanassche@acm.org, hch@lst.de, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: git@github.com:bvanassche/linux.git block-for-next

This crash does not have a reproducer. I cannot test it.

