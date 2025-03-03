Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A6E1EEA54
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999983; cv=none; b=SZroqxNutTei7OyHy9jhCInGFy/MgAlgo7YW7pPeTcaf6PP4myMZvimQ2VHwuYQYHYQ15tebDJwl4nlgaL5tMkUmgIA7b7drXlUjzlxzc02EALRJYJTYUObuO2QtEDWg52DdQpqy2EZHx41NHLPOvRWKaCNbqUF68rT0RO2q/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999983; c=relaxed/simple;
	bh=hvcbHwaQuQf8sN4Zz1GQfKiBaYv75lICfP9fOu2MRz0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JdAfC5ejKJm5XmW0kax97DlUCVxFnXWLYZ1NSQEDRMEF0dOy9N37+dbonoT6iOlhX83rZ3L7Slr5Db0kMCxn/NIZdXvq6Z2TJRE1RpsRXzeicDpTGvf6QLEmfHZEq7S7L9+Onyscnt4ghEIA1oUcHvHYOtI9ieF8isoGRIiQAng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KG9qhMp6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KG9qhMp6"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2575098f8f.0
        for <linux-block@vger.kernel.org>; Mon, 03 Mar 2025 03:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740999979; x=1741604779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kQ8cBKg5ej+Kp/w3MQ6nf2UTZ/6C1yGKdohploMEAJI=;
        b=KG9qhMp6QgQ7woppd+tdmNpjQxi6LRWMburqDMJe+gW38RuM4WHXEXAcyF69Jz2fV2
         IexmzneKY0O6xUbLOD/GAbJaGAYqyc8e2Rh/j8vOQCms37xyge5LBiXJyVaKjygaoWp6
         WikIvXs1ISj31WUQ57brEop72JwMOQUGHBtzgEzFtWDyapckGqL2MFLBBHGe2VBfPm2g
         rJdN58Kc2uGM96vJ1ylFeoWu+Egg31tGtnSwKNxzYXC6b05BuxKEOMAu7jWHEP4ZNmOh
         Cy6EcLY0SE16a0he+ZXP+Qnb977P0GlF2Dp7c3piBGCrOJqV3RppQfcXS879uUlRf9Ub
         IqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740999979; x=1741604779;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ8cBKg5ej+Kp/w3MQ6nf2UTZ/6C1yGKdohploMEAJI=;
        b=DivanmqW+9lxjWQMIuqzyg4SACP/ZZ88ruZ2MRugZFr+7Y1QUadaSv01z+m0lYy+sw
         unRppQqeaiMTpcaUrUZoVkzxJNWtsd82u5f00MK0lOwhRrZZySumxOwqlRzcK7x+Oacn
         yyJLxBX5wejZ1oVPOEelrNbJkeaYILC91twou3fS+rCByxINumhmHBdumEWQUmS057U7
         rNrTWsqdJfJvrJ97ra9hqVDn+WjCVepH6v1LgYDnIeskzeoE7s8nHJJ0y6AVJe6H1GIR
         ZIPDYDnBmuXljFsrXHQ3l7XHoY17I1j8d4oq6DwUlAP6xARSIy8eb+VEP0ljahZEG14y
         GICg==
X-Forwarded-Encrypted: i=1; AJvYcCWB39Ris6khZCiNutKYxxjc5nKZxTFbibTpz5eoVYs/8ewmvoOZMcU7OHCQ2xbbfKaSWGeEtc5/qdCziA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoVVKYzQ+nYwsF+e9h8EgXVIZlf0RpUq+/8/6sk7ae1Qa+LjmR
	F91PBrOZwLORjirDkj5uO/MIJYGNh8X59DAvfZlOpDZm4YK8rTec3e5FcEGcRhk=
X-Gm-Gg: ASbGncuYoSo4W5zldGoeFzGv5KqKyBCsQV5kJJ5YaBZGt6rrEV2CoWvNkx2+dGfK49K
	qAbndesaYB1Ba6II7vve9ytys2+d1G1WJbyrT869pjo6rxraao2LHcLOgYg3qbHdC69qewsQs6J
	y6l1IWBscdaUXUwB0oLFzqyV8Zinv/8sBo8U1OwOUTOk8hdiWrgr2D2d0zJG2QxsGPeLGWE0vye
	GY38dFp5bckte6p3tLNKai4JvDOb6mlu7dJBOOgB3vq9sR3qAaKxZj7BPomjR17PRZw9vHnuL8o
	FQ0H0lHUJJZTE+dusPFGRAQu/ghFWXGo4LCORIpZZ4sr1hrkFyp6hQMiTJw5QjFxjKjsnw==
X-Google-Smtp-Source: AGHT+IFXsUYLxm8Df30+KsC35vTZ6zstjg62rje6R1G9L3oOQ25nE/E4W1Oe3hkZUEWPeieF2m9H4Q==
X-Received: by 2002:a05:6000:4029:b0:38f:2726:bc0e with SMTP id ffacd0b85a97d-390eca138d2mr11479696f8f.44.1740999979152;
        Mon, 03 Mar 2025 03:06:19 -0800 (PST)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? (megane.afterburst.com. [2a01:4a0:11::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm13933050f8f.27.2025.03.03.03.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 03:06:18 -0800 (PST)
Message-ID: <913d3824-04c7-4cb1-a87b-01f9241a37aa@suse.com>
Date: Mon, 3 Mar 2025 12:06:18 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
From: Hannes Reinecke <hare@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Matthew Wilcox <willy@infradead.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org
References: <08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com>
 <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>
Content-Language: en-US
In-Reply-To: <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/3/25 08:48, Hannes Reinecke wrote:
> On 2/28/25 11:47, Hannes Reinecke wrote:
>> Hi Sagi,
>>
>> enabling TLS on latest linus tree reliably crashes my system:
>>
>> [  487.018058] ------------[ cut here ]------------
>> [  487.024046] WARNING: CPU: 9 PID: 6159 at mm/slub.c:4719 
>> free_large_kmalloc+0x15/0xa0
[ .. ]
>>
>> Haven't found a culprit for that one for now, started bisecting.
>> Just wanted to report that as a heads-up, maybe you have some idea.
>>
> 
> bisect is pointing to
> 9aec2fb0fd5e ("slab: allocate frozen pages")
> and, indeed, reverting this patch on top of linus current resolves
> the issue.
> 
> Sorry Matthew.
> 
It's getting even worse; after reverting above patch I'm getting a crash
here:
[  968.315152] Oops: general protection fault, probably for 
non-canonical address 0xdead000000000120: 0000 [#1] PREE
MPT SMP NOPTI
[  968.328747] CPU: 30 UID: 0 PID: 665 Comm: kcompactd5 Kdump: loaded 
Tainted: G        W   E      6.14.0-rc4-defaul
t+ #306 9ca11b70f9498982db3664c8471cfe00b0a16485
[  968.345747] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE
[  968.351913] Hardware name: Lenovo ThinkSystem SR655V3/SB27B09914, 
BIOS KAE111E-2.10 04/11/2023
[  968.362371] RIP: 0010:isolate_movable_page+0x7c/0x130
[  968.368826] Code: 02 75 3c f0 48 0f ba 2b 00 72 34 48 89 df e8 8b e0 
f6 ff 84 c0 74 20 48 8b 03 a9 00 00 01 00 75
  16 48 8b 43 18 89 ee 48 89 df <48> 8b 40 fe ff d0 0f 1f 00 84 c0 75 61 
48 89 df e8 ff d8 f2 ff f0
[  968.390698] RSP: 0018:ff582840034c7bd0 EFLAGS: 00010246
[  968.397354] RAX: dead000000000122 RBX: ffc1af3dcf400000 RCX: 
ffc1af3dcf400034
[  968.406145] RDX: dead000000000101 RSI: 000000000000000c RDI: 
ffc1af3dcf400000
[  968.414950] RBP: 000000000000000c R08: 0000000000000000 R09: 
000000000f400000
[  968.423755] R10: 0000000000000400 R11: ff4187a00d995780 R12: 
00000000003d0000
[  968.432562] R13: ff582840034c7d30 R14: 0000000000000001 R15: 
0000000000000001
[  968.441365] FS:  0000000000000000(0000) GS:ff41879ffaa00000(0000) 
knlGS:0000000000000000
[  968.451245] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  968.458488] CR2: 000055b303833c20 CR3: 000000005a838002 CR4: 
0000000000771ef0
[  968.467295] PKRU: 55555554
[  968.471120] Call Trace:
[  968.474655]  <TASK>
[  968.477804]  ? __die_body+0x1a/0x60
[  968.482521]  ? die_addr+0x38/0x60
[  968.487030]  ? exc_general_protection+0x19e/0x430
[  968.493115]  ? asm_exc_general_protection+0x22/0x30
[  968.499395]  ? isolate_movable_page+0x7c/0x130
[  968.505180]  isolate_migratepages_block+0x39a/0x1090
[  968.511555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  968.517728]  ? update_curr+0x19e/0x220
[  968.522725]  compact_zone+0x368/0x1090
[  968.527722]  ? srso_alias_return_thunk+0x5/0xfbef5
[  968.533896]  compact_node+0xa8/0x120
[  968.538720]  kcompactd+0x21e/0x2b0

which again points straight into the 'allocate and free frozen pages'
patchset. Something's buggered there, and I'm not sure if further
bisecting will be getting us anywhere.

Matt?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

