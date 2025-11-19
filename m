Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473E431AF2C
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580110; cv=none; b=cpgY4wKcBLRB1JggaNMJEU73OaiDpsp+lOZZxWS4Tq4S327Nwb5SBnUxxizPwKlc+Xlwy7KxkKtIemH6t0s/Wdr03XGEf9zOxMIuQL3YOFkPwqBgTd+snp19ANFk6nUb9YiV6sNqAdAr8Kpu8YQOOAVNlYL5X/5pvqih0zVOCNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580110; c=relaxed/simple;
	bh=WTED/YYDZWox+2hg9SHvLPbN2cHQFlAfv8SPK2SrDus=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To; b=u7nNNStqgrFz/6L+sm5CY4eS76UvgaXAPnX99NinvMU8Iw7FVuQgIIMGl5aaGoknkiL+br8L8qpsZAX8KDXhDGRV0wo61ooThW3Kc7v5Pen/lRU8BeedMA25rKQuECHsgRp8MMBm00HKnszmok9SfMFCDLjqbBB5RGzjzbCnihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFOZ8x9i; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFOZ8x9i"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so67103b3a.2
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 11:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763580104; x=1764184904; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTED/YYDZWox+2hg9SHvLPbN2cHQFlAfv8SPK2SrDus=;
        b=JFOZ8x9i4MhDaZi6SzOVgQm5qlSfIw2UZmxv1LWFB/3gw6fj5VkmBxkhTkvbxbn9LZ
         myNx0canRmmxGtn06AKMVsbFV7Ok3pH0g+wahEYXLhcF2AD3G8S1rwFth/LgUIGGvJaj
         cLS/QJTAqc3isgWv2r4v8n1yXOk6zt+Og9LPXtLPExQEUaJ4ULXqzOwUta/7kF3TL5t0
         vXMDRXXqRY7uNuIcINCx1q+dSvc3n7QmiNselafhtK8JEOmIZqmEkUJRpqM1ZjnIVTZA
         S1DqueYsoONfbL3SwSw4mlc8f1tOMhEG9OJDvLnTdRGcey20ZIo54/hmtOknaZB0SqGf
         MyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763580104; x=1764184904;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTED/YYDZWox+2hg9SHvLPbN2cHQFlAfv8SPK2SrDus=;
        b=Z3zisprHeR2vOdFVELvXdU7GOqDvvR83SoYmiP4cJyo+eZ0Dz0uCZFN6lnjvidpvmm
         1Lej8FK+RIYF4M7kDpcsOZ/F9N0vwf2aKbydGGXTOuUkMMHqTK7RkNzmHfaXlm8vRd8I
         7sZo4QLXljCMJtnYQpamFzvCb8liVJQotZW8f8plddJBDZJMNiPbpHkX970+q8C03VwX
         ZfvIS3vX/h0tkZ10YcbhAwuhfoSdVTZIF+LRcnnKMoZTNzJIvr3nKFKD5T3cyL6T4tpP
         cOcZbTbq5M3nu2LtGRiuAbgXrGruxUoKL172gsh0Bk9KOdQeUmTkiViR1BM1I9N0NJlD
         zGHw==
X-Forwarded-Encrypted: i=1; AJvYcCXROyYZL5bkImDonuRPE3tehABugzmWzLkWkC0uOTt1G6JfOwuOBzLGTJqJd2c3gFUuK3dzGdWCwjVtWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNlS0Eg87asnpvwL4OGB0tA2aDEAmMlgHI8xQFSsw9dKwPpLjD
	HYACDyqg8k4ic8M+/a14Sv6qekECNCXjxhIq8LSAj0gwPtjSDRT/fiR8
X-Gm-Gg: ASbGncuIA+ICOLRVv2gl5NU03ef/X8vjokYP6xWB5TuUeRFP6TvDG+b+GV6d/0gf6Mu
	QNWPw7N7+DAIJNTYny1qk5U8oXzK/VA8p32lv//tSHVqZqV2Zc1ay0/vzSMAM+Ux0yzUhcSzmJN
	UBxwEmjRfygz1IvEOF+7QI342YTm7wmRmL7MSthWJpznKrSxWqZGZTlRghtRtP07QVoJDImQGDM
	yz7+WtY/sXhJeABVp8f4iU892IEim7dCzfgMVZB+EhCMtDCeuwGB+GBp/gG5qxCAgswn6MSYV/3
	lKDprz9YGPdinjeQ2+q0s/HozvS4QI5NuvLUfr9+tR7jTPcPHrhyOYHNUejes2nFIM9yC5sxgtM
	brEGbsc8FuA1plyxJl1KnviMASvB8jnn4TKHwWZVOf8Q6iXqVGw4yvzDRNQF1s6UTXnL7TpCxQp
	TCdzJVgTVSWqjixX6RHpF3Swlgrxj/sAPYeDBaS3AoyJ09YXkiHg9QjWU=
X-Google-Smtp-Source: AGHT+IFLbC/rztisIiXYjC/ez7d9Iv7d5pLuzLJRTo4hY6XRNpZ6MEkTYf0tAhhUqPyepq3Nhwgexw==
X-Received: by 2002:a05:6a00:852:b0:781:c54:4d12 with SMTP id d2e1a72fcca58-7c3efb55cbcmr236128b3a.13.1763580103752;
        Wed, 19 Nov 2025 11:21:43 -0800 (PST)
Received: from ?IPV6:2405:201:31:d869:f90c:b1d6:a722:7f9d? ([2405:201:31:d869:f90c:b1d6:a722:7f9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b62e95sm117707b3a.49.2025.11.19.11.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 11:21:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------zqXZ6heSUwwpYluG4WpryJIn"
Message-ID: <b19fc9a6-61e3-4c1e-8272-ea63f0d074ae@gmail.com>
Date: Thu, 20 Nov 2025 00:51:39 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+905d785c4923bea2c1db@syzkaller.appspotmail.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000003d3747060ed5e859@google.com>
Subject: Re: [syzbot] [block?] KMSAN: kernel-infoleak in filemap_read
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <0000000000003d3747060ed5e859@google.com>

This is a multi-part message in MIME format.
--------------zqXZ6heSUwwpYluG4WpryJIn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

--------------zqXZ6heSUwwpYluG4WpryJIn
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-hfsplus-fix-uninit-value-in-hfsplus_cat_build_record.patch"
Content-Disposition: attachment;
 filename*0="0001-hfsplus-fix-uninit-value-in-hfsplus_cat_build_record.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAxMzM2YjIyYmI5ZjNmZjRlMTQ0YzQxMjJhNGI0YjEzYzUzZTY4MmE3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaGF1cnlhIFJhbmUgPHNzcmFuZV9iMjNAZWUudmp0
aS5hYy5pbj4KRGF0ZTogVGh1LCAyMCBOb3YgMjAyNSAwMDo0NDoyMSArMDUzMApTdWJqZWN0
OiBbUEFUQ0hdIGhmc3BsdXM6IGZpeCB1bmluaXQtdmFsdWUgaW4gaGZzcGx1c19jYXRfYnVp
bGRfcmVjb3JkCgpUaGUgcm9vdCBjYXVzZSBpcyBpbiBoZnNwbHVzX2NhdF9idWlsZF9yZWNv
cmQoKSwgd2hpY2ggYnVpbGRzIGNhdGFsb2cKZW50cmllcyB1c2luZyB0aGUgdW5pb24gaGZz
cGx1c19jYXRfZW50cnkuIFRoaXMgdW5pb24gY29udGFpbnMgdGhyZWUKbWVtYmVycyB3aXRo
IHNpZ25pZmljYW50bHkgZGlmZmVyZW50IHNpemVzOgoKICBzdHJ1Y3QgaGZzcGx1c19jYXRf
Zm9sZGVyIGZvbGRlcjsgICAgKDg4IGJ5dGVzKQogIHN0cnVjdCBoZnNwbHVzX2NhdF9maWxl
IGZpbGU7ICAgICAgICAoMjQ4IGJ5dGVzKQogIHN0cnVjdCBoZnNwbHVzX2NhdF90aHJlYWQg
dGhyZWFkOyAgICAoNTIwIGJ5dGVzKQoKVGhlIGZ1bmN0aW9uIHdhcyBvbmx5IHplcm9pbmcg
dGhlIHNwZWNpZmljIG1lbWJlciBiZWluZyB1c2VkIChmb2xkZXIgb3IKZmlsZSksIG5vdCB0
aGUgZW50aXJlIHVuaW9uLiBUaGlzIGxlZnQgc2lnbmlmaWNhbnQgdW5pbml0aWFsaXplZCBk
YXRhOgoKICBGb3IgZm9sZGVyczogNTIwIC0gODggID0gNDMyIGJ5dGVzIHVuaW5pdGlhbGl6
ZWQKICBGb3IgZmlsZXM6ICAgNTIwIC0gMjQ4ID0gMjcyIGJ5dGVzIHVuaW5pdGlhbGl6ZWQK
ClRoaXMgdW5pbml0aWFsaXplZCBkYXRhIHdhcyB0aGVuIHdyaXR0ZW4gdG8gZGlzayB2aWEg
aGZzX2JyZWNfaW5zZXJ0KCksCnJlYWQgYmFjayB0aHJvdWdoIHRoZSBsb29wIGRldmljZSwg
YW5kIGV2ZW50dWFsbHkgY29waWVkIHRvIHVzZXJzcGFjZQp2aWEgZmlsZW1hcF9yZWFkKCks
IHJlc3VsdGluZyBpbiBhIGxlYWsgb2Yga2VybmVsIHN0YWNrIG1lbW9yeS4KRml4IHRoaXMg
YnkgemVyb2luZyB0aGUgZW50aXJlIHVuaW9uIGJlZm9yZSBpbml0aWFsaXppbmcgdGhlIHNw
ZWNpZmljCm1lbWJlci4gVGhpcyBlbnN1cmVzIG5vIHVuaW5pdGlhbGl6ZWQgYnl0ZXMgcmVt
YWluLgoKUmVwb3J0ZWQtYnk6IHN5emJvdCs5MDVkNzg1YzQ5MjNiZWEyYzFkYkBzeXprYWxs
ZXIuYXBwc3BvdG1haWwuY29tCkNsb3NlczogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5j
b20vYnVnP2V4dGlkPTkwNWQ3ODVjNDkyM2JlYTJjMWRiCkZpeGVzOiAxZGExNzdlNGMzZjQK
ClNpZ25lZC1vZmYtYnk6IFNoYXVyeWEgUmFuZSA8c3NyYW5lX2IyM0BlZS52anRpLmFjLmlu
PgotLS0KIGZzL2hmc3BsdXMvY2F0YWxvZy5jIHwgNiArKysrLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvaGZz
cGx1cy9jYXRhbG9nLmMgYi9mcy9oZnNwbHVzL2NhdGFsb2cuYwppbmRleCAwMmMxZWVlNGE0
YjguLjRkNDJlNzEzOWYzYiAxMDA2NDQKLS0tIGEvZnMvaGZzcGx1cy9jYXRhbG9nLmMKKysr
IGIvZnMvaGZzcGx1cy9jYXRhbG9nLmMKQEAgLTExMSw3ICsxMTEsOCBAQCBzdGF0aWMgaW50
IGhmc3BsdXNfY2F0X2J1aWxkX3JlY29yZChoZnNwbHVzX2NhdF9lbnRyeSAqZW50cnksCiAJ
CXN0cnVjdCBoZnNwbHVzX2NhdF9mb2xkZXIgKmZvbGRlcjsKIAogCQlmb2xkZXIgPSAmZW50
cnktPmZvbGRlcjsKLQkJbWVtc2V0KGZvbGRlciwgMCwgc2l6ZW9mKCpmb2xkZXIpKTsKKwkJ
LyogWmVybyB0aGUgZW50aXJlIHVuaW9uIHRvIGF2b2lkIGxlYWtpbmcgdW5pbml0aWFsaXpl
ZCBkYXRhICovCisJCW1lbXNldChlbnRyeSwgMCwgc2l6ZW9mKCplbnRyeSkpOwogCQlmb2xk
ZXItPnR5cGUgPSBjcHVfdG9fYmUxNihIRlNQTFVTX0ZPTERFUik7CiAJCWlmICh0ZXN0X2Jp
dChIRlNQTFVTX1NCX0hGU1gsICZzYmktPmZsYWdzKSkKIAkJCWZvbGRlci0+ZmxhZ3MgfD0g
Y3B1X3RvX2JlMTYoSEZTUExVU19IQVNfRk9MREVSX0NPVU5UKTsKQEAgLTEzMCw3ICsxMzEs
OCBAQCBzdGF0aWMgaW50IGhmc3BsdXNfY2F0X2J1aWxkX3JlY29yZChoZnNwbHVzX2NhdF9l
bnRyeSAqZW50cnksCiAJCXN0cnVjdCBoZnNwbHVzX2NhdF9maWxlICpmaWxlOwogCiAJCWZp
bGUgPSAmZW50cnktPmZpbGU7Ci0JCW1lbXNldChmaWxlLCAwLCBzaXplb2YoKmZpbGUpKTsK
KwkJLyogWmVybyB0aGUgZW50aXJlIHVuaW9uIHRvIGF2b2lkIGxlYWtpbmcgdW5pbml0aWFs
aXplZCBkYXRhICovCisJCW1lbXNldChlbnRyeSwgMCwgc2l6ZW9mKCplbnRyeSkpOwogCQlm
aWxlLT50eXBlID0gY3B1X3RvX2JlMTYoSEZTUExVU19GSUxFKTsKIAkJZmlsZS0+ZmxhZ3Mg
PSBjcHVfdG9fYmUxNihIRlNQTFVTX0ZJTEVfVEhSRUFEX0VYSVNUUyk7CiAJCWZpbGUtPmlk
ID0gY3B1X3RvX2JlMzIoY25pZCk7Ci0tIAoyLjM0LjEKCg==

--------------zqXZ6heSUwwpYluG4WpryJIn--
