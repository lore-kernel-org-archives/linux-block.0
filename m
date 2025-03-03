Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AF17DA6C
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006665; cv=none; b=Kx572M5hvDZOz3j+8AtOfWkNYgklkSHLjHo4/UGD/yV7Mj8X2Ijx1MZ4EgesLbFffudlCT29GFv/S7lbmR/9d4zaaS8VOXYYXbnVGOl2eTy2eStDPD6veUqoAkdt5lmZnjcc8Yo/2XQfKppezFK4G+bas4BBFBldYJAgoVGYbXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006665; c=relaxed/simple;
	bh=XERU2Sc4sfELWvcKbJ1Tzzy5n1KaEhLwwr/tWq66Vk4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EMbcxfN9Ym4Q2YTnTEs7cAfS5WExtSJUJP4955ZlHAWGftg2KjzmiC+B663KRfimvKsYfT9GiPZO+hckDQC04XS79VW3iFEjQzSBNILzKD9nx0TYX6Xs3/LZJaauP5uO4zf6FAwSZquBgY02pvhuGK3B5Mz3OYRpDzUqu48oz2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KQuYkCG2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KQuYkCG2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bc4b1603fso4322745e9.0
        for <linux-block@vger.kernel.org>; Mon, 03 Mar 2025 04:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741006661; x=1741611461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7c5IluLwUn9XZcbi+gsxrgVSyKCV8Nuiw5SKDgtgpy8=;
        b=KQuYkCG2Ku69NoiEknPvzcNtbhd4FrjeGbI/PgBgzCnpCybJjnCnyajg0RDdlRWeEZ
         Y8gmLweqEVeGHgOfGx/9YuX3tBwtw67v62YmFTG0BFDUxT4FT3UAsEpk8EGQPya/99Bp
         0CBwClLgbj1ZeJZXbjXeFtcF+8vaJsiOJUlgRP9iwsoNN0dmY7M2MfABC7M0yjC3blEL
         qxYV0t1YP8cvc+JKgGawKJimxQUs3mre0RtQsFbNTX8ZKjhQ3yMo2h6VjG/rZZW59iw8
         r/GPzsE7IPrySic1J6x9iU1nTAlx2QWBezENouUek03VnlCOKxU0dtOHvFLeeG9BzPpb
         jFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741006661; x=1741611461;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7c5IluLwUn9XZcbi+gsxrgVSyKCV8Nuiw5SKDgtgpy8=;
        b=A6MKCjvif23dcV2IfAGgefPVlRbnGzdno5J8o6ZvqJDFzGsqdq4KHtVPbsLzP04gqV
         d9rnJN3KuiXbk7wVhvEnte+MwadI8CPNip2UUCDkIxZ8RaxuSFD0UAAsMxLYTeLMuDFe
         UHQ3wmq/DjFzbtA3CaRR5F/2SSQex4d3u1++shnsplUb/uov7QvinBaREz4Ub4kcF4B+
         1MeoB9j1SHBLM2F7eZthex+QXJu8iq9DOTfdYnH4S3Qeb5Szg0ausVFpkr0+3DZzc0eK
         EZrO8Bq4nUPCE815zQIXWyjAYFs7JIU9FVefXt+JZblQzpCY23sLETVm+WhmccFshZp3
         VTrg==
X-Forwarded-Encrypted: i=1; AJvYcCVOoTxms0nKxYQUYTQqant5C2VhQHfNpyKyQinPVUwpGfRolYuHzvqX2wXefYOGXAynoguFsf3dWUO4cg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3AoovmPUKjQHTy6zcXepVLqElpnLlr2peGzBUTiuNcxwOfMZy
	UC2V3TKhv+U1eMiIoq4ogAPpnmGJZgUxyLODpL4UBc74l3PFjf8ZZbGkBq4C1ag=
X-Gm-Gg: ASbGncumCKmdLs21/u2Z7O+3XvZXZuxH3niRdiCNP5aBoQJRyQPjNdz4iwRPIwGVI+N
	3LhW2PR3M8XD45jQMsA5YBKa+2IBYVGu71/t6XgX1awJiiX57ZAybKe2PyQSSIiI3N+aiXLB+mK
	olzlhkIoInjmsjXnhjNM2NLQrqwLleSzCN8VOeIkbzByMbVKSnkMObPM6HSSb1abXJCYI8SBrYG
	QzG9ZbZSsvc7MOJS2ua2wbMl7hIERCeH/06nWDUjQW/Bh4Gt9M1qNZoz3i2y3HjN7XjeI5EV4wj
	6i5nJ4yJI64cPGvql67CMNWscCl7jGlPp8qBlG3W1xL+iKs3m4hxz0ykfPZ/dHtVzO3hvQ==
X-Google-Smtp-Source: AGHT+IEU2Ynd1Axdm2Onf66zwpc3lqfrstpt22YuyOVgX5RS7ch0fh8GiVhPPpclTmGl0abT8uNphw==
X-Received: by 2002:a05:600c:4f0d:b0:439:9828:c450 with SMTP id 5b1f17b1804b1-43ba67082e6mr118647225e9.15.1741006661184;
        Mon, 03 Mar 2025 04:57:41 -0800 (PST)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? (megane.afterburst.com. [2a01:4a0:11::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844abbsm14296736f8f.70.2025.03.03.04.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 04:57:40 -0800 (PST)
Message-ID: <542192ca-6fea-4a3b-867f-b14d14a39478@suse.com>
Date: Mon, 3 Mar 2025 13:57:40 +0100
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
 <913d3824-04c7-4cb1-a87b-01f9241a37aa@suse.com>
Content-Language: en-US
In-Reply-To: <913d3824-04c7-4cb1-a87b-01f9241a37aa@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/3/25 12:06, Hannes Reinecke wrote:
> On 3/3/25 08:48, Hannes Reinecke wrote:
>> On 2/28/25 11:47, Hannes Reinecke wrote:
>>> Hi Sagi,
>>>
>>> enabling TLS on latest linus tree reliably crashes my system:
>>>
>>> [  487.018058] ------------[ cut here ]------------
>>> [  487.024046] WARNING: CPU: 9 PID: 6159 at mm/slub.c:4719 
>>> free_large_kmalloc+0x15/0xa0
> [ .. ]
>>>
>>> Haven't found a culprit for that one for now, started bisecting.
>>> Just wanted to report that as a heads-up, maybe you have some idea.
>>>
>>
>> bisect is pointing to
>> 9aec2fb0fd5e ("slab: allocate frozen pages")
>> and, indeed, reverting this patch on top of linus current resolves
>> the issue.
>>
>> Sorry Matthew.
>>
> It's getting even worse; after reverting above patch I'm getting a crash
> here:
> [  968.315152] Oops: general protection fault, probably for non- 
> canonical address 0xdead000000000120: 0000 [#1] PREE
> MPT SMP NOPTI
> [  968.328747] CPU: 30 UID: 0 PID: 665 Comm: kcompactd5 Kdump: loaded 
> Tainted: G        W   E      6.14.0-rc4-defaul
> t+ #306 9ca11b70f9498982db3664c8471cfe00b0a16485
> [  968.345747] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE
> [  968.351913] Hardware name: Lenovo ThinkSystem SR655V3/SB27B09914, 
> BIOS KAE111E-2.10 04/11/2023
> [  968.362371] RIP: 0010:isolate_movable_page+0x7c/0x130
> [  968.368826] Code: 02 75 3c f0 48 0f ba 2b 00 72 34 48 89 df e8 8b e0 
> f6 ff 84 c0 74 20 48 8b 03 a9 00 00 01 00 75
>   16 48 8b 43 18 89 ee 48 89 df <48> 8b 40 fe ff d0 0f 1f 00 84 c0 75 61 
> 48 89 df e8 ff d8 f2 ff f0
> [  968.390698] RSP: 0018:ff582840034c7bd0 EFLAGS: 00010246
> [  968.397354] RAX: dead000000000122 RBX: ffc1af3dcf400000 RCX: 
> ffc1af3dcf400034
> [  968.406145] RDX: dead000000000101 RSI: 000000000000000c RDI: 
> ffc1af3dcf400000
> [  968.414950] RBP: 000000000000000c R08: 0000000000000000 R09: 
> 000000000f400000
> [  968.423755] R10: 0000000000000400 R11: ff4187a00d995780 R12: 
> 00000000003d0000
> [  968.432562] R13: ff582840034c7d30 R14: 0000000000000001 R15: 
> 0000000000000001
> [  968.441365] FS:  0000000000000000(0000) GS:ff41879ffaa00000(0000) 
> knlGS:0000000000000000
> [  968.451245] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  968.458488] CR2: 000055b303833c20 CR3: 000000005a838002 CR4: 
> 0000000000771ef0
> [  968.467295] PKRU: 55555554
> [  968.471120] Call Trace:
> [  968.474655]  <TASK>
> [  968.477804]  ? __die_body+0x1a/0x60
> [  968.482521]  ? die_addr+0x38/0x60
> [  968.487030]  ? exc_general_protection+0x19e/0x430
> [  968.493115]  ? asm_exc_general_protection+0x22/0x30
> [  968.499395]  ? isolate_movable_page+0x7c/0x130
> [  968.505180]  isolate_migratepages_block+0x39a/0x1090
> [  968.511555]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  968.517728]  ? update_curr+0x19e/0x220
> [  968.522725]  compact_zone+0x368/0x1090
> [  968.527722]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  968.533896]  compact_node+0xa8/0x120
> [  968.538720]  kcompactd+0x21e/0x2b0
> 
> which again points straight into the 'allocate and free frozen pages'
> patchset. Something's buggered there, and I'm not sure if further
> bisecting will be getting us anywhere.
> 
And now it's even happening without TLS enabled. So seems that
reverting the patch is not sufficient.

Some guidance would be good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

