Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0485279DCA
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206920; cv=none; b=nF1S7+WnYwzyo+4h2qjTqRKUyyhB+1ZPOd01bHuK/qMC7KGdUMPZ5eOYAvybh5MAcsG+SevwQulkf1CuO3quVS3syFzrGSPz2A/uXMVG3sIBiCaSJAsBCjpREeMuE961wCKrw86kXrGhWT5msHqR0ByKKDjxfqDa4C9Cje6nQAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206920; c=relaxed/simple;
	bh=+JUCvse9/Q0h83pSfOVoqRwPa3cwg92XlBECM4wBwMg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=j+rd0uTA8o9q9jDkjOnOoVYRJfVYn0t/KjpWQ9EItyvjDx9vQGxVj2UKZp0Zq9vhGVxi4tuoa1ffS4IgqFoI5JusBKfgb7KdPLeae+ZgLUJU+JT2GEunqfiNAr4/nfEbMp/K1MtfHeDip5qVQJ97z2EphGpL63BYlPKh6DrH+dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c3902f73fso17943939f.1
        for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 10:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753206917; x=1753811717;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+JUCvse9/Q0h83pSfOVoqRwPa3cwg92XlBECM4wBwMg=;
        b=n/chN5vayqqEJNEwcYZlfUwLXVjJfkKW/vGD4VwbdinSloLNRLoUOpyXFvJiuWS3GJ
         m1+o/eI/f36nlxQOPekdj6Ldc/70ujkQRK05dzfgkE8yhzJn8EwBXk6ejFD/DbGeRl8R
         yef0Dn/geqKQCAVyNhf1W5ADKTniO9/RkHBx2R0eNN3pfHutoue5WpDOBMNGP2RZL2cP
         DE04j4EVNfNdKaAPepr6gMWzYnDEEGnb45bsZP3T1qo7YU0s6tXXrxfkXLuEGUD3/awO
         JAbZiXPcVvOfxafEIz+x8oeSgIv3uH717YdPj9Y0u8nDn32ltrjEAaNWjp5YCp+nnuBC
         5Jzg==
X-Forwarded-Encrypted: i=1; AJvYcCWRppWs3PqWajsm67qqXvl5WEQqUPEQsFoQp7o+Gb/L7C+gTGKHXXIDSuU44AkIfCd+p4Oq9obFGRVoBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YymwDX8GHaajgEnil4fVrzWYyU4XnhfZhDlgW8/NAIbg9eQFF9+
	Denc+pdDSGa64z2itjq5EP6rl0lcmXroiKRVOEpqVJ7RY57c3Gv3khZ49kb9ueviD+vl1KCaXzV
	vfT2s6Y9qyDgqgVrN4bIF62P5pll3tgh2qYODQxNVQlFmWmREzZgS071seE8=
X-Google-Smtp-Source: AGHT+IEnZCeH751BFdoEhmWWVC/2QU/u1JIWsR5UBGORLRUIn04iBieQDH4T7gcYQHSc9SnRnLic3XPmpo3B+yrD3wmrwVToKop5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4746:b0:876:b17c:dec3 with SMTP id
 ca18e2360f4ac-87c5389b0e8mr829314939f.8.1753206917538; Tue, 22 Jul 2025
 10:55:17 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:55:17 -0700
In-Reply-To: <xq4a62ukblverdhefpn3e43dkhaxvk2brdytqonrbzy3mud76m@srllmpvcv4e5>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687fd085.a70a0220.693ce.0107.GAE@google.com>
Subject: Re: [syzbot] [block?] [bcachefs?] kernel panic: KASAN: panic_on_warn
 set ...
From: syzbot <syzbot+4eb503ec2b8156835f24@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev
Cc: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

> On Sat, Apr 19, 2025 at 08:23:50AM -0400, Kent Overstreet wrote:
>> I'm not sure which subsystem this is, but it's definitely not bcachefs -
>> we don't use buffer heads.
>
> I think there's some incorrect deduplication going on with this bug,
> some of the reports do not look closely related, I believe they're all
> buffer heads related.
>
> #syz set-subsystems: block fs

unknown command "set-subsystems:"

